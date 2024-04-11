Return-Path: <linux-kernel+bounces-140833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440958A1926
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2661C22795
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333B12D74F;
	Thu, 11 Apr 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="frxRPBpC"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779312C7F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849626; cv=none; b=mOxbfDNTwUVs55zJirUMkZni3LhESRNTUZSoDys3az9y6WO7GB3cppvsM3d+p7b+ssi/I2aCh77bVtsZAsrl+XQeczhIDls1QwlaN9F4pGncBa9nhKSyH+3LC9hX1mmUHLy5VGK/CbG+H+yktcqNvPxU+yZMIDdvfm5Ev4F3FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849626; c=relaxed/simple;
	bh=Ich6G6QlJx/rjzryB2hxQOjP/7GKVsFXtf/eiYMd87w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owsEBlyNnVLQOpj6EqAdhoNvC9oflgcjBKP4rkdD+yJ+CL0kK/D5Y5hFwLcgroAk9vkQZ9IPQBAQjxFWQgja7AQDGCcz3YUzYfRAmVMU0mmX0de2S/BDjW+Lw0IJb8Pfw5iUuPsIWGfM6qJRWFju3SBq8PZR3lpHu4fyLMHV7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=frxRPBpC; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69519939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849624; x=1713454424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwAnhxLimpOC/Oa6gKiQq/Gyze8Nbyqzgu9dCQFe8rU=;
        b=frxRPBpC+IMiULhgFBtkX0H30DYfTvw/pShp/PB+UEoIbC38sKgA5Oc4QmI2CEtmUv
         liHnSAz6aFTYbblzPudRglJCozmXyBCI62PC+BQyw2ujt0O+z8AYdmqeUkMdnBNwO72r
         PIQDv+aheGbaQhwr3v1TFz0OP1h0cvsR8ZNXPe9gSvh+K48QtDA9MUxvDCF7TqJ6J5RU
         VZyrd5+BSTihag5wc381CAFKbNemij5A2d2l9cTspcXtoVxURoyioKT2ludmuHg27tNJ
         xQxIkhpXvAEk/eNCpyWDSaY+8lcTSOxV3nDLcBK891Epx/w1+309FIuJfVe0VEneNBF8
         XXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849624; x=1713454424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwAnhxLimpOC/Oa6gKiQq/Gyze8Nbyqzgu9dCQFe8rU=;
        b=QiB4ul7rN0P3erW5u8FSwxg1WKHSpAM3r6w2SNzjMW4e/S3qV6ZABL/WwmrzS9XuP7
         GFoGOiYhaZBOyAnihIS7RJrEsmTe6f6wg7MWB7A6JFItYtYxtuKfvl/JHT+ZPE2xUBEk
         ASRr44UFrNAeaBKHP4dNSWxM0EiYd4rxLnSUEQnJzOdrtkQPmk4svag5HRpWPj+ypYCe
         fGJVY1OmM+kYLQlxFt7oKnGVQZOelF7Cdr8CnnF9g4CHhBIF7+RJLM13uMmqdnAMxDQF
         ntaBKquw2nADeREbTlR2PHUfUhEfGSqDtWgyMGIXXPA+nv8XfZzE+UkTucttBtU+5mZ4
         QcnQ==
X-Gm-Message-State: AOJu0YydTfTQRFQVmgsAnUEa01MQZoLWI8K09KvIEsa83hKitjBKF3Hv
	SdK4RPvpdn1b0gQXH+1lYD2gkLmEaGaljEZjnGrbCL7FaFWCmJLo3wYH7txhBRJfnW+gXmTojvx
	u
X-Google-Smtp-Source: AGHT+IEoszV+iZjsHhGgzNwgbsNsZgTCX1WHZ7mA8m0wICGMvsZ8eo8KRlYG/SQRuSzV1mzrtDSApQ==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr208918iof.0.1712849624255;
        Thu, 11 Apr 2024 08:33:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 072/437] kernel/fail_function: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:32 -0600
Message-ID: <20240411153126.16201-73-axboe@kernel.dk>
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
 kernel/fail_function.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index d971a0189319..de35a346899c 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -233,9 +233,9 @@ static void fei_attr_remove_all(void)
 	}
 }
 
-static ssize_t fei_write(struct file *file, const char __user *buffer,
-			 size_t count, loff_t *ppos)
+static ssize_t fei_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct fei_attr *attr;
 	unsigned long addr;
 	char *buf, *sym;
@@ -245,7 +245,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 	if (count > KSYM_NAME_LEN)
 		count = KSYM_NAME_LEN;
 
-	buf = memdup_user_nul(buffer, count);
+	buf = iterdup_nul(from, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -306,8 +306,8 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 
 static const struct file_operations fei_ops = {
 	.open =		fei_open,
-	.read =		seq_read,
-	.write =	fei_write,
+	.read_iter =	seq_read_iter,
+	.write_iter =	fei_write,
 	.llseek =	seq_lseek,
 	.release =	seq_release,
 };
-- 
2.43.0


