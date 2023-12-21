Return-Path: <linux-kernel+bounces-7834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246C81ADED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DF6287D38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAF8C18;
	Thu, 21 Dec 2023 04:27:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46802846B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VywPfvR_1703132808;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VywPfvR_1703132808)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 12:27:08 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: baolin.wang@linux.alibaba.com
Subject: [PATCH] uio: Fix use-after-free in uio_open
Date: Thu, 21 Dec 2023 12:26:48 +0800
Message-Id: <1703132808-14322-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

core-1					core-2
-------------------------------------------------------------
uio_unregister_device			uio_open
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
-------------------------------------------------------------

In the core-1 uio_unregister_device(), the device_unregister will kfree idev
when the idev->dev kobject ref is one. But after core-1 device_unregister,
put_device and before doing kfree, the core-2 may get_device. Then:
1. After core-1 kfree idev, the core-2 will do use-after-free for idev.
2. When core-2 do uio_release and put_device, the idev will be double freed.

To address this issue, we can get idev atomic & inc idev reference with minor_lock.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
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


