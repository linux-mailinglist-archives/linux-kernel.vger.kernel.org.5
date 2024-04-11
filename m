Return-Path: <linux-kernel+bounces-140783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091E8A18F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF819287212
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345051026;
	Thu, 11 Apr 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FMILJu+C"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F150243
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849536; cv=none; b=ubieO1+1k14EaA40ZnjRPMPSMKrMhUpYMv/JGq8qNp5/sNAfdB9UncV4e0h6gQdcZFeqjBk1x5ZxTE+G7ffAznbif+kQYL10xPVtnsUA8NY8DHZoX/fy2Dn4KQhg838T0DvklE2I1vZoSRnIg5jl/hL+UIM12+xEgBFK5oCMx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849536; c=relaxed/simple;
	bh=1Ne3GYTNmD19frt4WVZrUXPlca0CwwIPoNwmXUgiDAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caooodLncrY/chHvhfHYE7Ha/GZUhuWQ0QoruQLyyB2l3BDznRTIKSOAfKK+RV1YoMGuScOWuB3Q7HfZxr+XP9B4KZL04RrYFtxbPTKBopldYCrcjWCDwRtSLsvxjv1YRb+OfjBgD5nWsTRIhjqG0NEq2kRHU2RCS9A1LLjDLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FMILJu+C; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180592539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849533; x=1713454333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1303vnIG3Y/o3u9Ot8CcMYe7zIKBSqHSL40+rHCxfA=;
        b=FMILJu+CGQSfnUE2iVRQmk43thJxFR7ijlE4ooEnjME0V7cCU4pKDt3jrMKqHHtN3V
         Oy8SPdAW5XmhKwjyP3r9Ny3UTlSclRqZwbinV9LqTGwniFbFoq294hGQxfTEUHaHod1b
         ZVY+gNEZMjLeNidWdmZs/xXcjOTq0Ybw/XaZAFcy4a4czvgCCNp4xihmMYOEK9P0XPYR
         O1sx2XGjAhlAnwEklvQntoJdgVxG2hnFeH3PdopgbeSCVXF1+864qzTSRUDgVsCLKQ7m
         ISjLykiycGBWOo0r6xbYBi4/NN48dRD1qVSlz6my8NDIZm3iaiXHS2YvWR7KAtKNEtlf
         1nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849533; x=1713454333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1303vnIG3Y/o3u9Ot8CcMYe7zIKBSqHSL40+rHCxfA=;
        b=ho4oJWadZkKvkjXhy2dw0ChNH9vEYPfRAoxE9a4DtpYGTeihdtwvVhTX678O4OC7eP
         E9emGSuWIfHkKhO/YKJjqinKo91gSR3kPZD+a6ac+jueWBQ3xvejRFNStq34lyeViiz3
         JR7OX/SdORFtFnJOXa6U+zCGlFUaTexR6DBTS23YbdGmd0S8T6E+/mIrrE0Y1h9+2giM
         sMNpNLmbTyB/nsBoHtQU3kQ8I0soqW9I8wLEySR5qbNjb9SHzoquCAK1EOGL1DvDQKUO
         HiGq6JUAr5PdKLJsmJHxwlfFZ4EpgbQRPt3lwRj5Aq2lcke0I1IsrMivDeQCPcAqm1ex
         4dxQ==
X-Gm-Message-State: AOJu0YxPrU+osoy3TDnmnMRoHHnlSRSJOIRWIpIGkK3Z6XrH31VZKzPc
	DV4e7FMqQPQNc3hajs9+IHTplm1+oDHJXX5UETrX6RxtaBHMdPYz4i3R4VSIT1AvEtrouKxnGj6
	7
X-Google-Smtp-Source: AGHT+IFVELhPTvCgr8COf/cZdsQM0+iMN9kXfCZhTAsdkg5ZzNco8D0vZW8yge0k6MkE0IidQLnWzQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr173425iob.1.1712849532856;
        Thu, 11 Apr 2024 08:32:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 026/437] char/nvram: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:46 -0600
Message-ID: <20240411153126.16201-27-axboe@kernel.dk>
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
 drivers/char/nvram.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index e9f694b36871..911370aa2a1a 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -225,29 +225,29 @@ static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 					nvram_size);
 }
 
-static ssize_t nvram_misc_read(struct file *file, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t nvram_misc_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	char *tmp;
 	ssize_t ret;
 
 
-	if (*ppos >= nvram_size)
+	if (iocb->ki_pos >= nvram_size)
 		return 0;
 
-	count = min_t(size_t, count, nvram_size - *ppos);
+	count = min_t(size_t, count, nvram_size - iocb->ki_pos);
 	count = min_t(size_t, count, PAGE_SIZE);
 
 	tmp = kmalloc(count, GFP_KERNEL);
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = nvram_read(tmp, count, ppos);
+	ret = nvram_read(tmp, count, &iocb->ki_pos);
 	if (ret <= 0)
 		goto out;
 
-	if (copy_to_user(buf, tmp, ret)) {
-		*ppos -= ret;
+	if (!copy_to_iter_full(tmp, ret, to)) {
+		iocb->ki_pos -= ret;
 		ret = -EFAULT;
 	}
 
@@ -276,6 +276,7 @@ static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
 	kfree(tmp);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(nvram_misc_write);
 
 static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
@@ -490,8 +491,8 @@ static int nvram_proc_read(struct seq_file *seq, void *offset)
 static const struct file_operations nvram_misc_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= nvram_misc_llseek,
-	.read		= nvram_misc_read,
-	.write		= nvram_misc_write,
+	.read_iter	= nvram_misc_read,
+	.write_iter	= nvram_misc_write_iter,
 	.unlocked_ioctl	= nvram_misc_ioctl,
 	.open		= nvram_misc_open,
 	.release	= nvram_misc_release,
-- 
2.43.0


