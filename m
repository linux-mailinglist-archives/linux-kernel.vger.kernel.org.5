Return-Path: <linux-kernel+bounces-140835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01238A1982
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EE8B2CDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0A12FF75;
	Thu, 11 Apr 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SP6jd3EV"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D412EBF4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849630; cv=none; b=eD6LGRQb7yfgVN6Ls2irIa8i4H1egv07J8V8I7J+vJr/D4iltsbHTKSGOd36fwUAVeVJEFFOQi9KU6KIsIeH66/wPNjzeCiS2ja3tVYB/wCsV17t0ZCMku7MnGP/vcoicL7UFDO8gih019YRpGGTNe7ofjtHCQHD9euoIEp4gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849630; c=relaxed/simple;
	bh=YaXL7R/re/cuSaO+9vhK+h1YHWJ2OFOsmnkNoMlPCIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skY8eRV4WAJiKfByfRTSShx0HxTX7dlPtnmYxdJPUjYYHfVEJODLxtLbrpbFy1dWQCQY/k9OBZBK9O9/PVBlHr5t8fNikognKHm7f/VM2qgBLj/hf4wRnsyTiPrScP7xaOHsv3iYttm9kBPyri7b6ISCWc5nAiDD0jlYhDj6sVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SP6jd3EV; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57998739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849628; x=1713454428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2XUTX/v1t1d8uE9fHr6uqwTYiAOVABEhQF2k4Vu81g=;
        b=SP6jd3EVPnAFLEri4jVDQnEwebtMtR1bCG71NHAJsNZBs3e+Z+bgEbHKH2jWrGXbdI
         Sf/tS22GiB+mP0yAM8lACGDYKClJK11e3qVuhxQKaevmQ/p4C2nt7JqUSmO8iuL5xguZ
         sEgnNt3aG5SDvxkcCnQdq5g5xuRQtf3jy/uzhzt99qhJ2+26plv6Mb3EG7hEuh3J0ZhO
         IUqjNLTqParVhSfjkN460f/f4nKWLrSaWJRs8XUyS6tWyRTxSPZwLHWo3qtIXyIDhpct
         DKT2JDQj9zXuPfRui+srBLX6uPIB1a0cTvnuFlSdUqa+2MtdMt2TdHhdQ4sjZHc6dvSj
         v9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849628; x=1713454428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2XUTX/v1t1d8uE9fHr6uqwTYiAOVABEhQF2k4Vu81g=;
        b=sBoIfV+871ndC3dike+SiubRJDxUve+83/S0s1khIhTSVuVtpuirsiyhdFJWx2B9R2
         v4JbAnahcFgE4EZZuh1v1GU5QSB1mikQ4iINJQ4ctZpT3FJWxi5oIYUpMSafegOyrbaT
         NxG1TKrublTdV1JDNXSlJ6Sp0CqfIKcNNkp2Du3Jn7Rm011wC+ifV0TLdwufRgZxuRby
         LgqmFvSfHjztD/X01QsG28PX99/dGzMAxZtmSWw++vtbU+lVoGKGlD0JBvqphvCZ9gX4
         apaSXQ5qCWcW97fvuNhC1E14I2wcqFRJQTlxj57Xfc2a1lhBOZ36h8LMTUIvg80zLmnX
         Yn9g==
X-Gm-Message-State: AOJu0YzuMwFZL2Pt6Z0QC11MuEBTk1KC26s4g+Kz2/hHinJ1WVG/t88+
	XqWAarYlyQ6r5K+5BJ3MChEzJtmfuyhM4q89Hf5B5XAo7qq/baZcLd4wMP6UVa4qU0yVidRMfrq
	2
X-Google-Smtp-Source: AGHT+IFS9E43fpzufL++jo3ktnLH+JjOTV64XkehFkEBXOPfqpTq0sjwTy1xXr1mlpXyt5NealU/BA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr154237ioh.1.1712849627970;
        Thu, 11 Apr 2024 08:33:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 074/437] module: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:34 -0600
Message-ID: <20240411153126.16201-75-axboe@kernel.dk>
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
 kernel/module/stats.c    | 8 ++++----
 kernel/module/tracking.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index 3ba0e98b3c91..42bb95beb834 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -270,8 +270,7 @@ int try_add_failed_module(const char *name, enum fail_dup_mod_reason reason)
 #define MAX_PREAMBLE 1024
 #define MAX_FAILED_MOD_PRINT 112
 #define MAX_BYTES_PER_MOD 64
-static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_mod_stats(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct mod_fail_load *mod_fail;
 	unsigned int len, size, count_failed = 0;
@@ -391,16 +390,17 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 out_unlock:
 	mutex_unlock(&module_mutex);
 out:
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 	return ret;
 }
+
 #undef MAX_PREAMBLE
 #undef MAX_FAILED_MOD_PRINT
 #undef MAX_BYTES_PER_MOD
 
 static const struct file_operations fops_mod_stats = {
-	.read = read_file_mod_stats,
+	.read_iter = read_file_mod_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c630c..a163944f609d 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -114,7 +114,7 @@ static int unloaded_tainted_modules_open(struct inode *inode, struct file *file)
 
 static const struct file_operations unloaded_tainted_modules_fops = {
 	.open = unloaded_tainted_modules_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
-- 
2.43.0


