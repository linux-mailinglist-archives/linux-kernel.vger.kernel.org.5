Return-Path: <linux-kernel+bounces-140890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5C8A196A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9DA1C23C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC015AD99;
	Thu, 11 Apr 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sMsFZIB2"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4A15AACD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849716; cv=none; b=AP+a7d1BnVxft15jj4pdl6cDnLP6frE44AJdMEHIa0icvs2AudAUUXTWUTeYPYh+mGpAsa1xrMDnO78QXG7PEa6Tu7ZspzXs7HYMBSfBsyWcwe9Cf2x7MYa+Dn+rXnGZffpfelw8NKlR+M7pcwJVj+x0D1sZOinYs+5HxVIzaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849716; c=relaxed/simple;
	bh=BKU7jof+OLPW14KMY7IUBGAnl4D7CJ5njhnuIagmstA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBUeF5BWL4kxR4uFZuQhTcNmObENwo+qN1M3oWnRkHrO/u9Xh25E4NSpN/ATlxqiq8vt5TsA+sGMgkZCBZGI/+Ptu06XkHh4Af9mpAQvkL/PpwKYDtQ9NnLZsqZUKgH6As+3fEd6akecByOsIzcpgipBlxUqknGncpzDklCaPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sMsFZIB2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a224d7414so180795ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849714; x=1713454514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaP4jRALl7uM/aiEEtjEUM+QWpiHHwuYIJyLofUvW+Q=;
        b=sMsFZIB2AZHZPIBvJ/Ist+F/Q+awIJWmzY+BuHwyFylVpmRBo8zgMhMYdeJIk66sdH
         oFpHiFl8sL5YDsYwwqeBoYAvqIOcVA14KuG850zl8wiqbozxb41wm+RN7VAyXBduKe/u
         237t3NHwi9CALBaR+W4UpW58nU+Qkx9fjQCu1733O4O9ihWJ2UzPnUA9dhtPX4QF9fRE
         YAScuQKc156CbMP3QXPmGP0gt/RtpCjS02JX765XmdfVt50SgTOIbOshfnlfMQ1lQ6p9
         f/YckfPObIONBKKLup2lBaRrCUfmA1skSYzB7xluAz54LRBARkITdLeTTGb3hVTTPgm+
         HzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849714; x=1713454514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaP4jRALl7uM/aiEEtjEUM+QWpiHHwuYIJyLofUvW+Q=;
        b=GExldM1E2CF6rNy1gquMjSRsUfHfFNna2UnMhlnB2L4a7Y4rW2qUCTKzqyqP3vo6zI
         i2YS/p7BlzDt42xpCFAG4z4WOGOMPsgeXhbeuf7oGgkxrXBlc/JQ5X8sjf4o66QJOQGe
         LqsWw7ppsQPMSn19//qvgVycbzSz48JODfdMvvvaiEcuaEVNN0IXT92s8+w072N8DAXe
         q0xmVv70IKV4levE6V3QO9H8qKn6/O4BZEQQxeAioRV29SeXoF7XCIBVkgO0R+zvcEU2
         xlZsEVcH6zl/54lLh2VbB3RG8B8Qk8dw7GfUlfkxevzi3TDvGGz5W0IR5kVc6QmJV4O1
         Ui9Q==
X-Gm-Message-State: AOJu0YyuAlpOT7bps37+835kqecCwvYzVTJ6n52OAct6finI4uHyGUGU
	OY4MLlo6rdBOI7wfMyChuUv943MT/B/iNTDgrHtzQQgS9U+inTv50mmmvSJzaF63WzfgdWzwktM
	z
X-Google-Smtp-Source: AGHT+IGI4Hiat6KzThSe7lYDUcFVZjVO8E/QRRg2id5JzH/Naow20qyWfGR6lmCto4fro8Xk/4dfYA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr186123iob.0.1712849714247;
        Thu, 11 Apr 2024 08:35:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 126/437] firmware: efi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:26 -0600
Message-ID: <20240411153126.16201-127-axboe@kernel.dk>
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
 drivers/firmware/efi/capsule-loader.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 97bafb5f7038..9b1d143a64f6 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -149,10 +149,8 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
 /**
  * efi_capsule_write - store the capsule binary and pass it to
  *		       efi_capsule_update() API
- * @file: file pointer
- * @buff: buffer pointer
- * @count: number of bytes in @buff
- * @offp: not used
+ * @iocb: metadata for IO
+ * @from: buffer pointer
  *
  *	Expectation:
  *	- A user space tool should start at the beginning of capsule binary and
@@ -165,11 +163,11 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
  *	- An EFI capsule header must be located at the beginning of capsule
  *	  binary file and passed in as first block data of write operation.
  **/
-static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
-				 size_t count, loff_t *offp)
+static ssize_t efi_capsule_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
-	struct capsule_info *cap_info = file->private_data;
+	struct capsule_info *cap_info = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct page *page;
 	void *kbuff = NULL;
 	size_t write_byte;
@@ -202,7 +200,7 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 
 	/* Copy capsule binary data from user space to kernel space buffer */
 	write_byte = min_t(size_t, count, cap_info->page_bytes_remain);
-	if (copy_from_user(kbuff, buff, write_byte)) {
+	if (!copy_from_iter_full(kbuff, write_byte, from)) {
 		ret = -EFAULT;
 		goto fail_unmap;
 	}
@@ -307,7 +305,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 static const struct file_operations efi_capsule_fops = {
 	.owner = THIS_MODULE,
 	.open = efi_capsule_open,
-	.write = efi_capsule_write,
+	.write_iter = efi_capsule_write,
 	.release = efi_capsule_release,
 	.llseek = no_llseek,
 };
-- 
2.43.0


