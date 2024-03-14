Return-Path: <linux-kernel+bounces-102707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA487B641
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5965E1C21B30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6674A0F;
	Thu, 14 Mar 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TEK7mYk7"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933A8BF6;
	Thu, 14 Mar 2024 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381698; cv=none; b=VfJvF7XgYorXAL2WT2RqROlcXxLBIoRxCusPvbtZr0AeaSDOwwUmvEQKoAw/wDY7i9nSAsv4VUwib5Lr0oeksA9AUbNRhcPSKVye5iBNUqTYNMHD/LmxPFPbSHJ3mrcN62iskuoK0HyDW0iFBjuxes5YfaH35I6Ub012XkNG96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381698; c=relaxed/simple;
	bh=pxcpcwTfbFsfUItt+ykCc/VYphrHU3mue0r1UeBb5wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgQt3LZltrRDl+Yi2h7wQ0dySdxJ8r1ZcQlQnB3bj85JrnwRydtfwJC4VoyZEZy4GOkJMxmlFIsNbPdL1r8d+RUj9vFreGOxyMNSLjekm34/Z5FS3dMg64jY1P5FUVuV7AzMVRVpXSPwpg6uWB42OzQR3Mdy/6bMEhhftHIIGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TEK7mYk7; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710381688; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z+CSv3eg/NpNIO4EaSM8vb+XofrayaHTtWX6q3MT5QQ=;
	b=TEK7mYk76i1o9zsdAWKfTCY4/mrFK2zVS3XH2OD4mo/tM07ZWKyqhUt9gFHk3o6lGJYgQJ9BbtVgnuE2iGPq4GjyD66BlUmT+oSrw3OoAK5Y+7bMuNWhnnMxuLs+UeJlXog5VZ0GBTvoDACpkG855j3NQv56PN7T9fwGW6OY5W8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W2QZc12_1710381664;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W2QZc12_1710381664)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 10:01:28 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: isdn@linux-pingi.de
Cc: ricardo@marliere.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] CAPI: return -ENOMEM when kmalloc failed
Date: Thu, 14 Mar 2024 10:01:03 +0800
Message-Id: <20240314020103.54049-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is using -1 instead of the -ENOMEM defined macro to specify
that a buffer allocation failed.

drivers/isdn/capi/capi.c:154 capiminor_add_ack() warn: returning -1 instead of -ENOMEM is sloppy.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8522
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/isdn/capi/capi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 3ed257334562..b6764313fbdb 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -151,7 +151,7 @@ static int capiminor_add_ack(struct capiminor *mp, u16 datahandle)
 	n = kmalloc(sizeof(*n), GFP_ATOMIC);
 	if (unlikely(!n)) {
 		printk(KERN_ERR "capi: alloc datahandle failed\n");
-		return -1;
+		return -ENOMEM;
 	}
 	n->datahandle = datahandle;
 	INIT_LIST_HEAD(&n->list);
-- 
2.20.1.7.g153144c


