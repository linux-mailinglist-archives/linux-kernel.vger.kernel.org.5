Return-Path: <linux-kernel+bounces-140845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F88A192D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E431D1F2118B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5213442B;
	Thu, 11 Apr 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j7u7F3H3"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E81332B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849645; cv=none; b=C9tty8EFYi/GTGMfP4sL26ajYr5CS/gjtRHPmiwPVOPKMQP9vfxMwv0elZwYg470ctxhY/EfkZJxBxsChj9yu+eaIVCqBV7WuRuwz+hxdEbO0ofJ4BNGPe/2bOZ+WESaIIcFjCOpHpDmrG+yq9m3IOfDHLPZWNOg8o3x4mhUFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849645; c=relaxed/simple;
	bh=dhvFxfup7smCS2tY0UKeEOj506EogbS1zmag/Nv+yHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEZsLhyBi7akJbPmQnh2D5jjfOX58Do4WKpSCoIUaYTuVzhlaVHr2i/9gblHezcpvR+w1t7aIBAT2RUYROfRw6Uzfchqwbt58RgHiq0XgVx/yF9IkGU3spO66g4ydORPPl8h/RRHfaAHwyTKPGkJcr9aHcy1V0vBdwR94e+ukr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j7u7F3H3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58006239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849643; x=1713454443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pav+Q6I1FDbUoscEArc8DWkYbazZgyALLdsNa2Zru1c=;
        b=j7u7F3H3SphrJ66LTS939OYmZY2Nx+/UNOMZbjhRDrCormeTdtABP1FiBiyHt0AmvG
         gfJF4EQyGVmZQjsOhce6XPqaSiIOho6qNZhaqrWi8CQ+il+MeIy4bCrWDIenUd8dmo+U
         tG5J/91VYo5T/eI9OE/9IQZ6jNYhOSjj0b8Rv8CgYI6lPVKIL9RhL7JvtvO9fsskvfjz
         +VsaX3zlAIX8oWrkMvtAKZgWmpCQksjjcyJgmcBzlUieLXIRLe+qCs9+lM+WWFXz2dlm
         fLab85tgRtOyhAA8KzCnf17TmpiD7XVWqQ+ViNAFdAozpXnNa/oGNAinmtnG2g/pTG0A
         X+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849643; x=1713454443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pav+Q6I1FDbUoscEArc8DWkYbazZgyALLdsNa2Zru1c=;
        b=GjTkcS5F2HFX4gHBuQLhz6TjDf+6xLQkwTYHkd/n3o8nDx8ul2ZM/06JiD0zfoE1TK
         IOQeoCcEnwJHYnPk38/MD9R/UGxytzebkgcrh0e/n1xiiaPHAmS+05NcT4h9vTmYIfhe
         h2g3rclkmdu6C0jpEBHzjdmswwHuviAQ0f9K9TLjEna1xRApmpidSABrsJryaWuKgh69
         hXLIR2q7yiZDmKXMGodVK6LphhEV1SlLqWqPK4laozKhQgm1QV+5wRgtqYhGtUEskAXd
         4emk7YzPvd5IkzR3ualOCiK56lfMJBV91D/X6uouD456zQp1oDHaawvGywenU6oubRfb
         VeCw==
X-Gm-Message-State: AOJu0YyhP+q6dh9rE24SgFBjT9I/sHGIX/jPPDzQvzMu0YpMHJ81IeBO
	z/ZEtdQ72WYCm7VBpVxmYCVuVzDe94AkckiWrZinUms8Eg9SMYOg5mS0ym6SHaD+NgCKonTtOn5
	D
X-Google-Smtp-Source: AGHT+IHPmk0EoEqYBAmduTCKkLviXpLSmrSXJctjdcBvX7gh/dy9P29SwDSGoDH3xgn203MTNHsBYA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr177064iov.2.1712849642804;
        Thu, 11 Apr 2024 08:34:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 083/437] kernel/irq: convert debugfs helpers to read/write iterators
Date: Thu, 11 Apr 2024 09:13:43 -0600
Message-ID: <20240411153126.16201-84-axboe@kernel.dk>
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
 kernel/irq/debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index aae0402507ed..addf000046b8 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -193,15 +193,15 @@ static int irq_debug_open(struct inode *inode, struct file *file)
 	return single_open(file, irq_debug_show, inode->i_private);
 }
 
-static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t irq_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct irq_desc *desc = file_inode(file)->i_private;
+	struct irq_desc *desc = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	char buf[8] = { 0, };
 	size_t size;
 
 	size = min(sizeof(buf) - 1, count);
-	if (copy_from_user(buf, user_buf, size))
+	if (!copy_from_iter_full(buf, size, from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "trigger", size)) {
@@ -215,8 +215,8 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 
 static const struct file_operations dfs_irq_ops = {
 	.open		= irq_debug_open,
-	.write		= irq_debug_write,
-	.read		= seq_read,
+	.write_iter	= irq_debug_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


