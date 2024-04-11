Return-Path: <linux-kernel+bounces-140966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2338A19D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B640F1F21D06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E81B9D9E;
	Thu, 11 Apr 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JS8kAWo2"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF41B75BA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849832; cv=none; b=RpyMB7rPv90vvp/Yk9ENkPBVVfTFH6BXRjrTq08NA3dDACpWyH29JB1GDcJIjPKZdtrggiCF1uUSD45mNo1RJnQD0NseBzJUV8UNf24Bagw/Rg2lxg0pR6cl1vB/YAHhWKJJYWGpYUbn0OILLPVT4vxBOQKgAEgIEA7K+JfIPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849832; c=relaxed/simple;
	bh=Z1y0a7cfsKbXer9bxnTMnhG06Lav3WsujhBEpbb80wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBamwYMafCLwh/Ge3lR1wLTt3rP4aY3AdLuBgAc87vSJ2uDkBEkvDIuOeIkaQNw0/Tz2FOWhxmqeVinoe4uYJbbem4RrNDkno8QFazA8kgFeE4D85KwFWwxCmoKnAcWH8oYD3VoeOCqAHWqDX8YKPIW3AAoNUPP4wzFzvDzqi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JS8kAWo2; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69590539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849830; x=1713454630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzwRV6Ub2+8MLLvL1YevSUMEghNhZwcC41fBUD5SWfU=;
        b=JS8kAWo2gxHNr9etm50+7NztwEDLxSgIu8ojzWIOj1fa5bK3JTAKlqqkVn+5MylfXW
         5NIjprOJe0sCIHKhC/FjhkjSI9Jjlg9/wo7bJ9N2XSpkxjDCpBg8uwpeI0D2UfyN22yb
         B+R/KxsSS7UQBMMbxTQGlTzXpOpPyLve65LIiJyS7SiB8PS4c/KceR1ZwcOFah1GNP//
         2uTSlEsZP61+g7Qpdor2lol+noSkEI0XCPB7E6VN4K29kpEihj0feVteEX8JWjC4B/Y9
         bUfy8gf0XXcECQSYdzw3tcJztZR1dHYf72FLzwyGRVDWdWzk54e6Ln0PBfxUR7rAW41P
         MsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849830; x=1713454630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzwRV6Ub2+8MLLvL1YevSUMEghNhZwcC41fBUD5SWfU=;
        b=f8Mwn6fZw0Xl09eVacCDVhrtxCtO78myC0OPZObPJFEx9KGznxhceD8K8MXlWzdsnQ
         Nr7gIHN+WUqCpA1/YpzohXEVJq8VW52WZPiD4UZF1P4CXy9ildROo6y5bi7d2u9sox6S
         ZXIE7vuLLZjKCzVkyrNM45xUqr+f66vl8xVXr0y6117Itn3tpMHBblCmnZ9EI6h6LGn5
         Pc+KcOfv+el6rMDjnNKdeFFPi1Li6mDW3/S6jYvIfYx3x9gRtTQm0c2VEePa5oYFLRTJ
         auwXXVv4+DLVyoMKeuNajHV2llOetyfSTifb7gig4RRpVPNEtz5aHr0qdI3rJfH0j41Y
         JItA==
X-Gm-Message-State: AOJu0Yy4wF47gbKa0tpXgckXj3hMQLvlEn0F6LLLrIppZKTO1qnrNb2T
	OQprU1tjjNRTjQh7VsnssvbwgNHXrzHkbMmbe1VEoplPZnKOo/du5XbtEgwvLnLymxY33LpR3/i
	T
X-Google-Smtp-Source: AGHT+IExF+UDHQROeA9N8YwCQ87ISmEhAnJ2pxxVKNnconvOMCw792lB/YVctPBK555e2kyufxMh+w==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr220739iof.0.1712849829786;
        Thu, 11 Apr 2024 08:37:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 197/437] scsi: scsi_debug: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:37 -0600
Message-ID: <20240411153126.16201-198-axboe@kernel.dk>
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
 drivers/scsi/scsi_debug.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index acf0592d63da..0ce291a5e8fa 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1022,19 +1022,19 @@ static int sdebug_error_open(struct inode *inode, struct file *file)
 	return single_open(file, sdebug_error_show, inode->i_private);
 }
 
-static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
-		size_t count, loff_t *ppos)
+static ssize_t sdebug_error_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *buf;
 	unsigned int inject_type;
 	struct sdebug_err_inject *inject;
-	struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
+	struct scsi_device *sdev = iocb->ki_filp->f_inode->i_private;
+	size_t count = iov_iter_count(from);
 
 	buf = kzalloc(count + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, ubuf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		kfree(buf);
 		return -EFAULT;
 	}
@@ -1095,8 +1095,8 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations sdebug_error_fops = {
 	.open	= sdebug_error_open,
-	.read	= seq_read,
-	.write	= sdebug_error_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= sdebug_error_write,
 	.release = single_release,
 };
 
@@ -1117,17 +1117,17 @@ static int sdebug_target_reset_fail_open(struct inode *inode, struct file *file)
 	return single_open(file, sdebug_target_reset_fail_show, inode->i_private);
 }
 
-static ssize_t sdebug_target_reset_fail_write(struct file *file,
-		const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t sdebug_target_reset_fail_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
 	int ret;
-	struct scsi_target *starget =
-		(struct scsi_target *)file->f_inode->i_private;
+	struct scsi_target *starget = iocb->ki_filp->f_inode->i_private;
 	struct sdebug_target_info *targetip =
 		(struct sdebug_target_info *)starget->hostdata;
+	size_t count = iov_iter_count(from);
 
 	if (targetip) {
-		ret = kstrtobool_from_user(ubuf, count, &targetip->reset_fail);
+		ret = kstrtobool_from_iter(from, count, &targetip->reset_fail);
 		return ret < 0 ? ret : count;
 	}
 	return -ENODEV;
@@ -1135,8 +1135,8 @@ static ssize_t sdebug_target_reset_fail_write(struct file *file,
 
 static const struct file_operations sdebug_target_reset_fail_fops = {
 	.open	= sdebug_target_reset_fail_open,
-	.read	= seq_read,
-	.write	= sdebug_target_reset_fail_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= sdebug_target_reset_fail_write,
 	.release = single_release,
 };
 
-- 
2.43.0


