Return-Path: <linux-kernel+bounces-140769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADA8A18DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD0C283B23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CF4122C;
	Thu, 11 Apr 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dKVzgqzC"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27043FB1C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849512; cv=none; b=r6CPGJ1mcgxCU9/OscYo8h0b544yqh8hoJyfPurO3yvk5jjmDTyvye5A4yLXxfkhMp52nlqJOJmfCESpNtvf0xU2oCa2LLS2EjaGSIPe5GlAON2MnOIlANakXgwKY+nW7+54aBoxE5tFNf+olwakmXqhxTp/fZNqDcsTYbNGEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849512; c=relaxed/simple;
	bh=cHwNtPSO4l9UcgbnVRkBJekVjoSEK2X5F+I523oZ65A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9Ey0uVGO6m6aikDSc3JAlX/niwZGNSJpYXkYgRP+NSO57d9LmUxSzWPnYxO1E08rEyUkj+1WHxHCAw6uEdXXeiIUOcX+ON/xpa1acBZEp6ca790DayPQlhhqmKwjzdZFG/b8w8P3Pc9j3ezY4EMbZUeOgUYN3k8BBeO04KT9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dKVzgqzC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180585339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849509; x=1713454309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewHA3RTUIDnyZGZEA9VPS2PhyM7qn+xOwc2x/PdL7Ak=;
        b=dKVzgqzCsh/6gU3VET4lRxgR6XQuR6BxZQnGtkiqV4RmjU/NP+5FasiNqtdFe9cPcn
         4JauJZYac2uwZRuA2ha0MjGdTDTgyKmhJuaQbqpY3DKU4B6NO68Gm9cKhfpLeH58+Cxz
         ZrTQZlVqkpAORPTgwouxX0a33bRwmagQbSZH4VqbGxgTOjTLbE2hNFXeE3YWWJfFcrsd
         VOaQeqrE0HIhW1Yb0qnXru6IjM2IflXUz8LW/rLOlkeJf6ybV+v/mrQKgev0ViJcSffJ
         5tKvXXQKcyF2geupG4UrN8kmhjiiYYr1B1sEuSRmvvJASIAOJgE6jd2vk3sii389Vq/a
         HuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849509; x=1713454309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewHA3RTUIDnyZGZEA9VPS2PhyM7qn+xOwc2x/PdL7Ak=;
        b=PwdBxl0G4YsR9vppa/37L+ZcV5lv/7ROogQhPPpJAbOtPf5gTpPzsTYlWfDna555Qy
         6VFwy+KmpNGCV0jz0wapJLttbA6k3rhq/t31kKQfbpl4OiS8kv/V91exrVswqS5FpKDj
         2SMIH+QedulrLh7z2cjMhEahhG8UUc7DAKEMl4vCuBCLH1Ezr6JV7gSIMj5y/S5IjnSS
         PjNoEAbpeYopC0Co6v32z4DSSyldhHyUhsa0S0vniA7x/rh9UHwZCmDs0ZtGfjlOIJ34
         OtPGTqF3d2h7Ap621auocKx/C6Uqb7VY3EdUc2V9UD01BUnvfsHLEgNin3D1xF3zj2/W
         r09Q==
X-Gm-Message-State: AOJu0YxTvdcrUTk4/Dtj86Vpnq8B+wehwAkZqkSaBedtly416Q4N576k
	acWygz09QAHJr1V5OdoDsAusXXJtrVxMAug9ruXVzvUHOrOikf26Gh2VQ/bTns5SKlryfjq4CHr
	L
X-Google-Smtp-Source: AGHT+IHPNClr/AxM+RpUvIM8DRJoCqBmVgVIiH9+RuPt+cqJusK0mX98D86/OawZ3vXByIRgfVJO+g==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr176643iob.0.1712849509392;
        Thu, 11 Apr 2024 08:31:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 012/437] char/adi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:32 -0600
Message-ID: <20240411153126.16201-13-axboe@kernel.dk>
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
 drivers/char/adi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/char/adi.c b/drivers/char/adi.c
index 751d7cc0da1b..941188be2385 100644
--- a/drivers/char/adi.c
+++ b/drivers/char/adi.c
@@ -51,10 +51,10 @@ static int read_mcd_tag(unsigned long addr)
 		return ver;
 }
 
-static ssize_t adi_read(struct file *file, char __user *buf,
-			size_t count, loff_t *offp)
+static ssize_t adi_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	size_t ver_buf_sz, bytes_read = 0;
+	size_t count = iov_iter_count(to);
 	int ver_buf_idx = 0;
 	loff_t offset;
 	u8 *ver_buf;
@@ -65,7 +65,7 @@ static ssize_t adi_read(struct file *file, char __user *buf,
 	if (!ver_buf)
 		return -ENOMEM;
 
-	offset = (*offp) * adi_blksize();
+	offset = iocb->ki_pos * adi_blksize();
 
 	while (bytes_read < count) {
 		ret = read_mcd_tag(offset);
@@ -77,8 +77,7 @@ static ssize_t adi_read(struct file *file, char __user *buf,
 		offset += adi_blksize();
 
 		if (ver_buf_idx >= ver_buf_sz) {
-			if (copy_to_user(buf + bytes_read, ver_buf,
-					 ver_buf_sz)) {
+			if (!copy_to_iter_full(ver_buf, ver_buf_sz, to)) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -91,7 +90,7 @@ static ssize_t adi_read(struct file *file, char __user *buf,
 		}
 	}
 
-	(*offp) += bytes_read;
+	iocb->ki_pos += bytes_read;
 	ret = bytes_read;
 out:
 	kfree(ver_buf);
@@ -128,10 +127,10 @@ static int set_mcd_tag(unsigned long addr, u8 ver)
 		return ver;
 }
 
-static ssize_t adi_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *offp)
+static ssize_t adi_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	size_t ver_buf_sz, bytes_written = 0;
+	size_t count = iov_iter_count(from);
 	loff_t offset;
 	u8 *ver_buf;
 	ssize_t ret;
@@ -145,11 +144,10 @@ static ssize_t adi_write(struct file *file, const char __user *buf,
 	if (!ver_buf)
 		return -ENOMEM;
 
-	offset = (*offp) * adi_blksize();
+	offset = iocb->ki_pos * adi_blksize();
 
 	do {
-		if (copy_from_user(ver_buf, &buf[bytes_written],
-				   ver_buf_sz)) {
+		if (!copy_from_iter_full(ver_buf, ver_buf_sz, from)) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -166,7 +164,7 @@ static ssize_t adi_write(struct file *file, const char __user *buf,
 		ver_buf_sz = min(count - bytes_written, (size_t)MAX_BUF_SZ);
 	} while (bytes_written < count);
 
-	(*offp) += bytes_written;
+	iocb->ki_pos += bytes_written;
 	ret = bytes_written;
 out:
 	__asm__ __volatile__("membar #Sync");
@@ -207,8 +205,8 @@ static const struct file_operations adi_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= adi_llseek,
 	.open		= adi_open,
-	.read		= adi_read,
-	.write		= adi_write,
+	.read_iter	= adi_read,
+	.write_iter	= adi_write,
 };
 
 static struct miscdevice adi_miscdev = {
-- 
2.43.0


