Return-Path: <linux-kernel+bounces-141110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F68A1A88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262901F24E97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B971165FAB;
	Thu, 11 Apr 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sRoG2GjS"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC81E5A86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850054; cv=none; b=Hvve/pYKAzvIRS3rTveV4xizyXgSfsu/pmEIhEinWft4AIUKwIljgFFWSfXD0zpBuG3+CyiaeP6lhBmmdwzqxcPATWtomWtQ6VyI0WADu+rph++jXdUB+6BJehQjEv0fru0OJ+C1TCJQ1YWZjtU6qX8fFScCM1aTyA0lcmhYq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850054; c=relaxed/simple;
	bh=6y6PZ2q5JqnN3xLPEoJio6juGz7vkx5/cqsd8Nmd/Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVw8pEW49r2Z/hTUe8Qulikf1drTrTrpVp6Lkpc86igrdNtbrw7LYxgOfFvuH5BcsoyWOOhOxcwVYRb8gT53YDlMnIk2hB5Oup5E8IFgKrc4tildUzud0acja4UtYyxFkDjuuo40gcvyjPEkB6pzPrNcRnpkOU+ifshwIY1NynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sRoG2GjS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170614939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850052; x=1713454852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYo9II18kKi6UUjE56d5jU18dIdhCJ9lo6geMH0YCOc=;
        b=sRoG2GjSxowfQlBNkkDi1CdNbQLt+NjTOCvX4f/WlXYCuhN8Gl4ARccvt506FFet1a
         33WTR1DZzGnmT1NoDgViMXbejBHpDaqsk/uoC259E/hy5laJkOrFvfOwuD/r2Vj66Wzt
         Ea5luWzDCp8qUlvdjMTomkNLziaG0Mz+te1IBmF51AjXOJ5JP82ZuDWkTeCez758cyxP
         C1FPGQJWTQdCswVZA+SUcy3Badn36rZzs3Z1RH52kPk3pmAAlfgqFGlhTMDXRfj7qOH3
         0XuMHGlzo/Lwdqq/MCuf/6BJ3qSx7MLWfCoyx3Gfyclzckuyx+6Ba6qnR8Spw0tJ74e2
         JZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850052; x=1713454852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYo9II18kKi6UUjE56d5jU18dIdhCJ9lo6geMH0YCOc=;
        b=C9nMRwXdymVxKWXy8KQ3tIybehex8Zr4Hf5b+5z9+VwzakgkNmbr20NsCfMpffM3Lp
         w7TcetroZ/XjpdIK+d/5NXGhEF4jwgQRmBRuvJ2eXwpNn72cPQq1kFV6qlPki0/Zm+L2
         HdqSR6phxFrvsTx9dy1/7IoFq/PFqFaLgVhS3v/2aKqaIn4gxjRgxX1+uQ538eTpt+tX
         5ZmsK61U1J2I26ly43t0zCbn/zzrMZosfDuGNbvjnHNWLmMr3pvFDrIPehKY30hfbGAT
         vjtBvPc3vFO/g2zfInNwgWHT5iNojqmc+6GUfHLcsohBbfi0g5cDGy9CgOaotMqUzZR/
         p44A==
X-Gm-Message-State: AOJu0Yx/mT36jUbIeKsT5SbilpJLLKLviGWfZoIRVZ0DUGKsSuqjNm+T
	GYypYOzKvfcka/zL9qNFLRoPum8OoXwwfeZVmtZlpKnXdB5NoopfG/hN4jdBKiO4j12YoUaNsbc
	V
X-Google-Smtp-Source: AGHT+IGktqNyKJqZB81EY0XOQbyaQ3RLkdIS4bcGOS+OTPmX26qXWOMLtklIpwOe+vvS5ZTGupzGAQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr193018ioj.2.1712850051871;
        Thu, 11 Apr 2024 08:40:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 332/437] x86/mm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:52 -0600
Message-ID: <20240411153126.16201-333-axboe@kernel.dk>
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
 arch/x86/mm/pat/memtype.c    |  2 +-
 arch/x86/mm/pat/set_memory.c |  2 +-
 arch/x86/mm/pkeys.c          | 15 +++++++--------
 arch/x86/mm/tlb.c            | 15 +++++++--------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 36b603d0cdde..46f1d1966f96 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1194,7 +1194,7 @@ static int memtype_seq_open(struct inode *inode, struct file *file)
 
 static const struct file_operations memtype_fops = {
 	.open    = memtype_seq_open,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 80c9037ffadf..ee1888fbd218 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -186,7 +186,7 @@ static int cpastats_open(struct inode *inode, struct file *file)
 
 static const struct file_operations cpastats_fops = {
 	.open		= cpastats_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 7418c367e328..7f084e4f6bd2 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -127,25 +127,24 @@ u32 init_pkru_value = PKRU_AD_MASK( 1) | PKRU_AD_MASK( 2) |
 		      PKRU_AD_MASK(13) | PKRU_AD_MASK(14) |
 		      PKRU_AD_MASK(15);
 
-static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t init_pkru_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "0x%x\n", init_pkru_value);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t init_pkru_write_file(struct file *file,
-		 const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t init_pkru_write_file(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	/* Make the buffer a valid string that we can not overrun */
@@ -166,8 +165,8 @@ static ssize_t init_pkru_write_file(struct file *file,
 }
 
 static const struct file_operations fops_init_pkru = {
-	.read = init_pkru_read_file,
-	.write = init_pkru_write_file,
+	.read_iter = init_pkru_read_file,
+	.write_iter = init_pkru_write_file,
 	.llseek = default_llseek,
 };
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..97edf3026036 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1303,25 +1303,24 @@ bool nmi_uaccess_okay(void)
 	return true;
 }
 
-static ssize_t tlbflush_read_file(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t tlbflush_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "%ld\n", tlb_single_page_flush_ceiling);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t tlbflush_write_file(struct file *file,
-		 const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t tlbflush_write_file(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	ssize_t len;
 	int ceiling;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -1336,8 +1335,8 @@ static ssize_t tlbflush_write_file(struct file *file,
 }
 
 static const struct file_operations fops_tlbflush = {
-	.read = tlbflush_read_file,
-	.write = tlbflush_write_file,
+	.read_iter = tlbflush_read_file,
+	.write_iter = tlbflush_write_file,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


