Return-Path: <linux-kernel+bounces-141051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE28A1A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098041F216D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA69E1CFD2D;
	Thu, 11 Apr 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vVYowf5K"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53F1D06AB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849963; cv=none; b=RN9VDRShyGt48SvdwIQPzbZK3T4MS2mjURTr8kIuihvNJJj1Kvz5O0Yk+oJVj0/yfEbhV9wnZt8RWaecqZxLom4CH6cv2GdP4Mnqd3eyZPAM2fQ9Foy5uLAe2s4mcSZpXTsPugRvaqCVMJD8ApSOKPmoGlQ5m0Spoa0VupMoYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849963; c=relaxed/simple;
	bh=XBEHWph1C6KPFL4Qb85w1TmxaNAE9JgrJtvz1hAQ2ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcbUSVY2i/zR5lsXDCN8opsgU95ATVzeTkw2LdluqaSC37rZQ5NENpB/B7HXAhNz4MJYLO6eC0zNEeUvO3h5h+PcZX6PHqlSMtg8QevqfVF6MikrnJRSfplT8JH79hsV9hGTYkGfSUrSHkhHREpobd93WPxICxQs8dGjTiKzP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vVYowf5K; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a34b68277so115465ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849961; x=1713454761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Izb7L2YwoSWL1quYfYW4ZlQuCKzQgWxxQVekCns6Fk=;
        b=vVYowf5KNfWIIjPxGUrBRRS9+1FiwbCBRrMhT0CSmdRHYHGQPl+RjEQnuSkJs53o0L
         2Ald2ik81hversb40+9rJ3qcLkDmtOyeBH/2e9QVuYRZdMCkEmXcErEEponHwSafWLvG
         bHltkn/2E/IMEGrw5yiJ3TkECqCKY6YWpVj+/H3cEqDBd0G1nLZ4AHhpN17/dBLgwzzG
         YvuqCI9C8eN4ADDrSao/D4QCRPMk3k9rRFAGQDLkSu1CpYjNzyGozcGNqyFdHBX8Q1hq
         QliWgJ1Ss7PjfWnlKnuhy5FKPOSTrxl+/0Ls3+2F3cQTgrRyOJfJQpoJFFPwt0BgjsnA
         CSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849961; x=1713454761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Izb7L2YwoSWL1quYfYW4ZlQuCKzQgWxxQVekCns6Fk=;
        b=Mjp70xZKjQ0gek6x+IRkZRd23JPpj8B34gqKB3Y6uLcFuXKmxXgy9c/2UV449FTP1I
         387dudkmJLzvoTk7EgLwlGGf4mupwGhTKiZs2dQbNvtPBcp+75EbBpr8mE6U2hJ7tVTF
         US4damtj40chrt+jtgghieo/DMFW+RWdG/0mLD3WsYyC5gIee8JHkGsC0GxTgwGq6v1s
         lHTOyHIsoNnXymEC7xozrrwpSUM5Aac3Yz/QrybvFg1rXmXtFhwMHAQ1+nG/MMMlGSp2
         rwoovKV6piLqmestpBiAQ83cv5rsBbn5CBM0yUvrJQfp/sOORWcrpmy/MYj5JIZHmPEU
         FVgg==
X-Gm-Message-State: AOJu0YzS9lN5xnM4PBrURzfBaoEZFduyhzTYuIW9KYtyKOn22U6ajn9+
	aHGiBciV1/o41EKWfnuaXeQbgIEbIMtkwCbU+5HS4rkg0Lg0/XqmchsRY/6RLUsY6mjAN3X9+Az
	5
X-Google-Smtp-Source: AGHT+IFUMhDd+ATrzSUDh7lZM9EEk3Q36/nTPmzcKwFmsA2tBhrW6ijoVHARw2V7h3i6f8nx+wpkDQ==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr195728iob.0.1712849960215;
        Thu, 11 Apr 2024 08:39:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 277/437] watchdog: sbc8360: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:57 -0600
Message-ID: <20240411153126.16201-278-axboe@kernel.dk>
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
 drivers/watchdog/sbc8360.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sbc8360.c b/drivers/watchdog/sbc8360.c
index 4f8b9912fc51..5d7042c85988 100644
--- a/drivers/watchdog/sbc8360.c
+++ b/drivers/watchdog/sbc8360.c
@@ -234,9 +234,10 @@ static void sbc8360_stop(void)
 }
 
 /* Userspace pings kernel driver, or requests clean close */
-static ssize_t sbc8360_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t sbc8360_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
+
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -246,7 +247,7 @@ static ssize_t sbc8360_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -302,7 +303,7 @@ static int sbc8360_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations sbc8360_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.write = sbc8360_write,
+	.write_iter = sbc8360_write,
 	.open = sbc8360_open,
 	.release = sbc8360_close,
 };
-- 
2.43.0


