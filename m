Return-Path: <linux-kernel+bounces-140877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B348A1955
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4332E280A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF4152E05;
	Thu, 11 Apr 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bTIiqSpn"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9F15099E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849694; cv=none; b=jzQ2zNdH+RlY2FwhOxdYoW36eI8uRQ4+msQza9YDFXx92u7qoXtXzM1wQdKXrYHkz9juIQlpEd7HdUDp8weIGpfSaBmad8ie07WhcSusZreOjye72JQbcDU3xb2vKPKpr8aAzs4BIZ/lH4EqdwyYM92S282F368jGerGOG7keD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849694; c=relaxed/simple;
	bh=y/ce69/aqB03GY2bHy8Ji+jTQsVf4bClC8FWgbEE/JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+SwQkXzcDvdgI/N42naCpqGjjzygrRziEdcqXGupXKJP7Bmp/JTTUQBpqpx+wuz5vrkv7cxgCkVU3NxSktopxKBltxnaAEypL+A3GcUjiaqNUCbYw7M4Lz1vyfRSBvTNVb9PHTS5fd6nZsqAIl1vqB6xAbltfKLlck6R5ZA0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bTIiqSpn; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180631939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849692; x=1713454492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGm/2J6ZZmvwgdF1bJyFmOUKKVur6y6GQM+waBhkNb8=;
        b=bTIiqSpnZqtEK4QgYW1+/VzsPvY7PLSz50RWA19XaBpsLPifa4d4srPNe0IFJOZrHO
         8CRq90563183cw95Gpce7XQEgoCJLgCiuEBuypn4NPSCGokRr6XBEocERguC4XZazhIM
         BZBMTWlTh0Xw0xmC9gQZuKzitXWrri4KeklP5V1Dmi918tzD3D1u5XBAoYaI9lnAWlHb
         ycPtRq2rSatgH+rzKffSXcM7EAoxYfb8XVo08gLtmaaDErJYoAIeH7RxsspcwTMadq1h
         6XDSoKbwVzIo1Dzn1Lideeh4bAj9IHSlrjuHgbhTX/GOWcrv6RWd7u4Q7oZzngDK6HTu
         ZWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849692; x=1713454492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGm/2J6ZZmvwgdF1bJyFmOUKKVur6y6GQM+waBhkNb8=;
        b=WPOh0LOAUidSVF/uqJgjwWeY/EhVNCJVsy5lpWrYVPZE83iko1DdBGjJk4Gkhp4uvF
         vWAtRLNa5jlPm2spRLhchqeM34MkGN3LTbd30BCnrmWzDFFhW4H3BuxmUGeH6WG1zsu5
         OV7NXJTXaAea8z064FrTtpzQvJYv+lnFrg4hZVHHWe6TxjiGCk0Wngrk9OTiuX452G+6
         5y2F2PX76PCFMSFJX9FCCpH5XabwqjW+RsQ6aKTHwhIk4z3+/BH4wcfQn7aCciQ3gn4E
         SQH5UC2J8BIdYu1PB9WaIbtjIpCFvX0CIjGTK6FCaxD4lseTySkx1XY7+CKWWQAX1KPo
         QVZA==
X-Gm-Message-State: AOJu0Yy9a2+y+1htt4vGD7shzzGwbeTZAiVnRtv/YI7xHRLgx7dMKrE6
	3m07c/8Gj34zJvH7SQmgbjWBN0ZOdz5R2233m5QFr8KYtwl9b1zkPJgVhpQ+ncuTHzpHYukGanP
	+
X-Google-Smtp-Source: AGHT+IGVbWguojWtF2juk5DdqKfejkp/j2GAzgxWFyj6UiCp1PkYFLQrsTEFQ+HrthyeXA26+IXlAA==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr182443iob.1.1712849691884;
        Thu, 11 Apr 2024 08:34:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 113/437] drivers/ras: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:13 -0600
Message-ID: <20240411153126.16201-114-axboe@kernel.dk>
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
 drivers/ras/amd/fmpm.c | 2 +-
 drivers/ras/debugfs.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 271dfad05d68..8e0a89491170 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -944,7 +944,7 @@ static int fmpm_open(struct inode *inode, struct file *file)
 static const struct file_operations fmpm_fops = {
 	.open		= fmpm_open,
 	.release	= seq_release,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 };
 
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..e71046472cea 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -38,7 +38,7 @@ static int trace_release(struct inode *inode, struct file *file)
 
 static const struct file_operations trace_fops = {
 	.open    = trace_open,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = trace_release,
 };
-- 
2.43.0


