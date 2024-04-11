Return-Path: <linux-kernel+bounces-140859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B8E8A1969
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E057B23750
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37F1384BF;
	Thu, 11 Apr 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Uz0Zq+MF"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D50139CF1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849669; cv=none; b=uby1Zc5aTA/eYITQpHM2pr8jILPPnZd8im2V16C2Cb3vuXz2t0EMsuLX077/oVlzjYT5JvrxQQ/P8RXaWLwk9PWKD9IsBORv9vS5hdhHJ8mbA9AZg3v0Gg5loklQ4d5YIjVeuqnl+M0fwC+twIcFFwqr/JQqmgJMhzEMwMJNylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849669; c=relaxed/simple;
	bh=Pn1GbBTsc5+QbTJB9yYgUfJldUjlFuMP1hnlhAGYRuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpFJVe6y29sTWjNxiwViWj1tacUD7oSZh9n32fVoNq6c8AnuEeozJ5wrbzB5LCkGWXdlshUsICGWFYfZZkoNk+NySkTgjluG6a7O/rOhjCJTNKUXt5zRQmlbxvj6Gb3hjsDDGL13pGSiXQachDxm4BOBjWJHrPnaFnSyMMHocGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Uz0Zq+MF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58021039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849666; x=1713454466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kkl4RwyrP8inBrF9H+XsQ2Koi0yW0jbw9hT3/G5miSU=;
        b=Uz0Zq+MF8+byas9O0kpqOabzIF/AqDWcblP0vgnvPxG4qIWuVHu9EZjAl5jDCrzcO+
         hlyl5sRZR0kKOaLqo/9ZqrjurfZd02ZxHj76V+5tI7T617tkui+dMQda1RySHgiqFIvG
         o9SDZQsmTUt4rDtopZN4EqKScPtzZX9G7ubUp/n/6KYO52JzJw2lo7WOXeOTcSKc9lsP
         Qw/YjlpsYZtZ0pRrrrnx8HEQ1kzFP6hNFBsrqZBlWK0a5u6WjuUndooR/LZTwgNT4wW2
         33OSQesag2phc/nDszlYRljkcBT5FdaBOH5wVkvh9QLyhv4CsqE/0oCRJ7VZfaNJYE+b
         k1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849666; x=1713454466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kkl4RwyrP8inBrF9H+XsQ2Koi0yW0jbw9hT3/G5miSU=;
        b=UHhXWbUsRsrwlWt4WcaMCC03q5116YCQ0rBIraLYkUykbpwyVveXh9ymNSfh0f+X9S
         raRVsn1Elm2GKizfR2L43D2G8rjeNiZXarfWL9HsCCsrjg1hNONABSIe6yzIdXefUHKl
         DPIlb7nvYao5HtM3AP7uQYd2k9F8UcJAt0373y0GcAcNE5ZbYceLGIRyfAciiyG7lF0X
         K7MlSWInNRtRge6tvs3mDUgr+hAPbfHVIlYxyEm+7yuxK4uqs5lVxuTlgaM6v8RtzRJo
         q9uX7zpLcZS81tptGwat+AoJtOSh8MDy6lKSTXHwZwmePj8PAP/7YbJ+VnrZkZ/20hAA
         RD8A==
X-Gm-Message-State: AOJu0Yy12ctxcA7ZnxzoTepq1Uj9sEn4dBF/3BqZJwBdHXVHhaUvu2hF
	AIJ2W4qTWmw6XnySXQNOVaWxrUBoNgfP0Ri10O+GfqPu1dZESK2VVwHkCIhJew1o9MkNH4khEg9
	E
X-Google-Smtp-Source: AGHT+IE7a2RcTazEzex2rXdA1dTn33zIoA0OXywFgv3QGLsCj6qYNZ+0hzEA4RZ8YtZEoNVh/JWFDw==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr178401iov.2.1712849666613;
        Thu, 11 Apr 2024 08:34:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 097/437] aoe: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:57 -0600
Message-ID: <20240411153126.16201-98-axboe@kernel.dk>
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
 drivers/block/aoe/aoechr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index a42c4bcc85ba..828499156a5f 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -192,6 +192,7 @@ aoechr_write(struct file *filp, const char __user *buf, size_t cnt, loff_t *offp
 		ret = cnt;
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(aoechr_write);
 
 static int
 aoechr_open(struct inode *inode, struct file *filp)
@@ -217,16 +218,16 @@ aoechr_rel(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t
-aoechr_read(struct file *filp, char __user *buf, size_t cnt, loff_t *off)
+static ssize_t aoechr_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t cnt = iov_iter_count(to);
 	unsigned long n;
 	char *mp;
 	struct ErrMsg *em;
 	ssize_t len;
 	ulong flags;
 
-	n = (unsigned long) filp->private_data;
+	n = (unsigned long) iocb->ki_filp->private_data;
 	if (n != MINOR_ERR)
 		return -EFAULT;
 
@@ -236,7 +237,7 @@ aoechr_read(struct file *filp, char __user *buf, size_t cnt, loff_t *off)
 		em = emsgs + emsgs_head_idx;
 		if ((em->flags & EMFL_VALID) != 0)
 			break;
-		if (filp->f_flags & O_NDELAY) {
+		if (iocb->ki_filp->f_flags & O_NDELAY) {
 			spin_unlock_irqrestore(&emsgs_lock, flags);
 			return -EAGAIN;
 		}
@@ -269,14 +270,14 @@ aoechr_read(struct file *filp, char __user *buf, size_t cnt, loff_t *off)
 
 	spin_unlock_irqrestore(&emsgs_lock, flags);
 
-	n = copy_to_user(buf, mp, len);
+	n = !copy_to_iter_full(mp, len, to);
 	kfree(mp);
 	return n == 0 ? len : -EFAULT;
 }
 
 static const struct file_operations aoe_fops = {
-	.write = aoechr_write,
-	.read = aoechr_read,
+	.write_iter = aoechr_write_iter,
+	.read_iter = aoechr_read,
 	.open = aoechr_open,
 	.release = aoechr_rel,
 	.owner = THIS_MODULE,
-- 
2.43.0


