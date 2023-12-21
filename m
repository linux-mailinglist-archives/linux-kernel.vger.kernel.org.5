Return-Path: <linux-kernel+bounces-8168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2AA81B300
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4931F23630
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22450261;
	Thu, 21 Dec 2023 09:58:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D64F5E8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyxGrK9_1703152663;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VyxGrK9_1703152663)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 17:57:51 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH v2] uio: Fix use-after-free in uio_open
Date: Thu, 21 Dec 2023 17:57:43 +0800
Message-Id: <1703152663-59949-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1703132808-14322-1-git-send-email-guanghuifeng@linux.alibaba.com>
References: <1703132808-14322-1-git-send-email-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

core-1				core-2
-------------------------------------------------------
uio_unregister_device		uio_open
				idev = idr_find()
device_unregister(&idev->dev)
put_device(&idev->dev)
uio_device_release
				get_device(&idev->dev)
kfree(idev)
uio_free_minor(minor)
				uio_release
				put_device(&idev->dev)
				kfree(idev)
-------------------------------------------------------

In the core-1 uio_unregister_device(), the device_unregister will kfree
idev when the idev->dev kobject ref is 1. But after core-1
device_unregister, put_device and before doing kfree, the core-2 may
get_device. Then:
1. After core-1 kfree idev, the core-2 will do use-after-free for idev.
2. When core-2 do uio_release and put_device, the idev will be double
   freed.

To address this issue, we can get idev atomic & inc idev reference with
minor_lock.

Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/uio/uio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 62082d6..2d572f6 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -466,13 +466,13 @@ static int uio_open(struct inode *inode, struct file *filep)
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
-	mutex_unlock(&minor_lock);
 	if (!idev) {
 		ret = -ENODEV;
+		mutex_unlock(&minor_lock);
 		goto out;
 	}
-
 	get_device(&idev->dev);
+	mutex_unlock(&minor_lock);
 
 	if (!try_module_get(idev->owner)) {
 		ret = -ENODEV;
@@ -1064,9 +1064,8 @@ void uio_unregister_device(struct uio_info *info)
 	wake_up_interruptible(&idev->wait);
 	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
 
-	device_unregister(&idev->dev);
-
 	uio_free_minor(minor);
+	device_unregister(&idev->dev);
 
 	return;
 }
-- 
1.8.3.1


