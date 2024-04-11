Return-Path: <linux-kernel+bounces-141077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684FE8A1A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A831C22DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E41D8EA1;
	Thu, 11 Apr 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x7iqr8Yb"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2D1D7807
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850005; cv=none; b=ldJ1zqPimsWNQA5FGJy8VS65oFkYEReh+nBYNaElWBXaps9XW4mTPOOA77mBUdtG15D4jB9vPQJtAip5vcI3HK2gYGuVGHY0FZe1y5GgaekP7OZPnubnu/ryvvc1Wd5aPTGVps1pqQwUq1lPZ0cvvMVrvw915gteiUy+YdUwbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850005; c=relaxed/simple;
	bh=hXwDYhwj3YSZzWtjDd4fd9DrBed0R4EhaNgf27PusW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFF7uKDy/uQdzwTCP+dIdScsc43r7pm5ZqoUgxHWFlK3TnpQV9tA++6Kc58+qLjmkYG2ATjWtIsZWqPR1Gqfg2JkGIV/3PxumER+6OMMlX+3TCtCYG0jKM34s3CS7wNpwwlrYY4mAuL+q5aCOPwbwTnPkxpVFe/Qd2Khf/fDzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x7iqr8Yb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9870939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850003; x=1713454803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QUhAUeMX/r2Id0WBJRretvoAUZBcP0M+PInid6//Ks=;
        b=x7iqr8YbNv38HMiY2eTr6bpY590zUC+90I1uCMBg6QncLLurqweRlRiwQooWFWJGoo
         YPNMAxPo89tOU9TS/XzMa/dWDn2ctZNOf+90qCF67RKQl1G5+AdD7dR0O+IlBoMm+AY3
         DfNunysgfY5OpFtex5fsEIi5yW0UEsYOuIpLU8DcViKtjqq7T51zmA3c9pjJbuUnF6wS
         AH7ONNIpMoayuGmIzevHZWRCmEUL3tpjQYAwrbU8M/ravW6Cxel162tH1ARFenbdKI39
         UpL5QbhzjWLtXopq334IRfK0Ms4XBhKc/UiXzXjVkd5YRaEygpVY93VCo6CcFM8Efv8K
         GmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850003; x=1713454803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QUhAUeMX/r2Id0WBJRretvoAUZBcP0M+PInid6//Ks=;
        b=AfVPE5OqqobCzRhqU+f1iG4YDD/s7xVTel6K+pU4gF78xRGyRmEmYi/LLKJ8BdKikY
         Qw5qkWVZKoGKPZ/B+dZJbzXV2+V7WDveZIDe4myy0r0dF4q95znfb/7l7viAMVp1PNbb
         Ng07wX3sK3suq6Reha/vAOuAYk6HzBkEpQHzXpeehByRCAgFjq4HgaSx7ocf4PkAnM4O
         /91Btbic6Us14PkTIVMhB/lF60dM1kFLRY2jl4RsdL76yQ7RyziM1MmkmDH/LNSqho8N
         VITROWnqQmkdVIp7DXca8gITEa8t4O09yAh9E+OL+9aqw6f9LHe21D+0oGWsOnyQ9Seq
         F9lw==
X-Gm-Message-State: AOJu0Yz8v3JB2J6Qfr8sWaaHIlpBOe7I1EkHVFLX7jNfVvToKfQphjan
	fSMDxmMRd6FRkPlP6MHCyimZSH7dF5Y+EwUcdNG4Jmjd8tkOSTllez9MKs/jDQDb2QdzPPskLHs
	M
X-Google-Smtp-Source: AGHT+IFgpGWmQvaLTfrMew8M0fZrXdYSPPpFdq1PYyzzmuz2UTURF13wZvA/wVOizk+PlmNr76SnKA==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr229139iof.0.1712850002746;
        Thu, 11 Apr 2024 08:40:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 301/437] drivers/net/wireless/ath/wcn36xx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:21 -0600
Message-ID: <20240411153126.16201-302-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/wireless/ath/wcn36xx/debug.c | 42 +++++++++++-------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/debug.c b/drivers/net/wireless/ath/wcn36xx/debug.c
index 58b3c0501bfd..9dbfb831c0fd 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.c
+++ b/drivers/net/wireless/ath/wcn36xx/debug.c
@@ -25,10 +25,9 @@
 
 #ifdef CONFIG_WCN36XX_DEBUGFS
 
-static ssize_t read_file_bool_bmps(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_bool_bmps(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wcn36xx *wcn = file->private_data;
+	struct wcn36xx *wcn = iocb->ki_filp->private_data;
 	struct wcn36xx_vif *vif_priv = NULL;
 	struct ieee80211_vif *vif = NULL;
 	char buf[3];
@@ -46,14 +45,13 @@ static ssize_t read_file_bool_bmps(struct file *file, char __user *user_buf,
 	buf[1] = '\n';
 	buf[2] = 0x00;
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t write_file_bool_bmps(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t write_file_bool_bmps(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wcn36xx *wcn = file->private_data;
+	struct wcn36xx *wcn = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wcn36xx_vif *vif_priv = NULL;
 	struct ieee80211_vif *vif = NULL;
 
@@ -61,7 +59,7 @@ static ssize_t write_file_bool_bmps(struct file *file,
 	int buf_size;
 
 	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	switch (buf[0]) {
@@ -92,15 +90,14 @@ static ssize_t write_file_bool_bmps(struct file *file,
 
 static const struct file_operations fops_wcn36xx_bmps = {
 	.open = simple_open,
-	.read  =       read_file_bool_bmps,
-	.write =       write_file_bool_bmps,
+	.read_iter  =       read_file_bool_bmps,
+	.write_iter =       write_file_bool_bmps,
 };
 
-static ssize_t write_file_dump(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t write_file_dump(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wcn36xx *wcn = file->private_data;
+	struct wcn36xx *wcn = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[255], *tmp;
 	int buf_size;
 	u32 arg[WCN36xx_MAX_DUMP_ARGS];
@@ -110,7 +107,7 @@ static ssize_t write_file_dump(struct file *file,
 	memset(arg, 0, sizeof(arg));
 
 	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	tmp = buf;
@@ -134,14 +131,13 @@ static ssize_t write_file_dump(struct file *file,
 
 static const struct file_operations fops_wcn36xx_dump = {
 	.open = simple_open,
-	.write =       write_file_dump,
+	.write_iter =       write_file_dump,
 };
 
-static ssize_t read_file_firmware_feature_caps(struct file *file,
-					       char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t read_file_firmware_feature_caps(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct wcn36xx *wcn = file->private_data;
+	struct wcn36xx *wcn = iocb->ki_filp->private_data;
 	size_t len = 0, buf_len = 2048;
 	char *buf;
 	int i;
@@ -162,7 +158,7 @@ static ssize_t read_file_firmware_feature_caps(struct file *file,
 	}
 	mutex_unlock(&wcn->hal_mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return ret;
@@ -170,7 +166,7 @@ static ssize_t read_file_firmware_feature_caps(struct file *file,
 
 static const struct file_operations fops_wcn36xx_firmware_feat_caps = {
 	.open = simple_open,
-	.read = read_file_firmware_feature_caps,
+	.read_iter = read_file_firmware_feature_caps,
 };
 
 #define ADD_FILE(name, mode, fop, priv_data)		\
-- 
2.43.0


