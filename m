Return-Path: <linux-kernel+bounces-140822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963198A191C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0311F21DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF583CD6;
	Thu, 11 Apr 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0xD3yt7J"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3638288D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849610; cv=none; b=TEDwbodb0m7PJqKJx0JpLOhUXCLmtaRx5Np8lMIsiz77W3a2wun6wE4W2zfBqcdwbsN2Lh9EBW+lMmWBX70w1dsAW9hYYvQvE8RWwCURM8suFvAywO5kwnU/FVs5YFLKmGvE7flvdNuc8d5mQh3XFBhQd0mBN0nSKHGGvnjAMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849610; c=relaxed/simple;
	bh=P9LCpYNDUrfSgkEJutV3KNxBX7V/yuQER6JDcw27rng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6qi+k3YMPHfr+2AdPStiwzNGwRhL/zR67s6ISmHQUzAKnz8QZjwwt7lX9sML/4arb9JcIsDDhuONmW4XCl19nEpTiJbFdPkKPNKd5S2zqbcc6SA7NzH7ErCQ/+8BxmoNFXWSiWmz7nU1bcXVgsM/0/jEOTR4nZ6Nbro9/AeItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0xD3yt7J; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57976839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849607; x=1713454407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSvPK0G0eDQL3w1EYvX8m8KP6rjYZG1rNj9rSoFDx7g=;
        b=0xD3yt7JuZI3ICrFXq4r8nW8/joo/EtHutmsRGl2jL69KnlpMidRu+jBG9r7K86T/p
         A0M96Ox2MgiBtxAisYeR3isw1HBTspgBSHaQW1W8PEvf/AdLaCdLuwf0LzOTXDPwfFX8
         qfQAHg4iWPgwUY7xZEL6Rx2nna+oVJSfrhtcE1akObVBbNIoxSycqzZwqAMUDBnBJtoj
         6hkaJod9OB1DrLoJOzlTYJPtKbCVY0yIkG12WjxjyYnCYV7qaklV8fW2h1+ClPAyWK7B
         cMJdyuoaqTWzo3MwnsT/+syawKQ6DtDSrIqbyJKTMwRI2liqyG9wfRavefAFW5bgIkKb
         N9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849607; x=1713454407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSvPK0G0eDQL3w1EYvX8m8KP6rjYZG1rNj9rSoFDx7g=;
        b=qFI9WO/gw0+u2+i/mQ2mvNv6bXB/w5wOcuReHUT6kMmTFjiiJAJesnuydBYwiM3K4J
         HFEsK4OPWeczeJIZfarsNEQ5LJMMpPOZgRfjjTpVfQDmzbmW24Xq5z+++8kmhcxCKN2o
         mnWsLa0aP+tRW+dm6XkjXUmNhPxkgi2fr1cx1Ayu5/o61OEy6mMxARvQ43MwMwhp9iVR
         m9TGG/vYxuKgr4lkunX1xDERAy7BWhhjsLTduI2K5rsuVR8hm/F+Rr0ZjohH6ZglEcGD
         8Uky7zsEJykcnoiU11cJQ1UDcydgb8aoeKwdKvC2KJCYDg3Ra+EiEjn07byzL8jg3OUW
         /yig==
X-Gm-Message-State: AOJu0Ywqqw2C6DZaqB8rnX+dyvg2UyWMrdxBuKLeNTQOLxwWWh73deW8
	imh8BrMmDAR0Axtg7OlDzftUKPfCTEguCsPrI7RQ2Nx+p8SAAGTYMdjd2bV15P9uMJcE98fEDrH
	R
X-Google-Smtp-Source: AGHT+IFPrnPGabwgQ0UGRa0TXUh1IFXFUbkGOsWe1wg/O5K4mlkgiBnO/diUjdPcLdGXtpPb4mfOag==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr174370iov.2.1712849607649;
        Thu, 11 Apr 2024 08:33:27 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 062/437] ALSA: pcmtest: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:22 -0600
Message-ID: <20240411153126.16201-63-axboe@kernel.dk>
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
 sound/drivers/pcmtest.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index b8bff5522bce..8a09d82d2207 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -646,48 +646,48 @@ static struct platform_driver pcmtst_pdrv = {
 	},
 };
 
-static ssize_t pattern_write(struct file *file, const char __user *u_buff, size_t len, loff_t *off)
+static ssize_t pattern_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct pattern_buf *patt_buf = file->f_inode->i_private;
-	ssize_t to_write = len;
+	struct pattern_buf *patt_buf = iocb->ki_filp->f_inode->i_private;
+	ssize_t to_write = iov_iter_count(from);
 
-	if (*off + to_write > MAX_PATTERN_LEN)
-		to_write = MAX_PATTERN_LEN - *off;
+	if (iocb->ki_pos + to_write > MAX_PATTERN_LEN)
+		to_write = MAX_PATTERN_LEN - iocb->ki_pos;
 
 	// Crop silently everything over the buffer
 	if (to_write <= 0)
-		return len;
+		return iov_iter_count(from);
 
-	if (copy_from_user(patt_buf->buf + *off, u_buff, to_write))
+	if (!copy_from_iter_full(patt_buf->buf + iocb->ki_pos, to_write, from))
 		return -EFAULT;
 
-	patt_buf->len = *off + to_write;
-	*off += to_write;
+	patt_buf->len = iocb->ki_pos + to_write;
+	iocb->ki_pos += to_write;
 
 	return to_write;
 }
 
-static ssize_t pattern_read(struct file *file, char __user *u_buff, size_t len, loff_t *off)
+static ssize_t pattern_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct pattern_buf *patt_buf = file->f_inode->i_private;
-	ssize_t to_read = len;
+	struct pattern_buf *patt_buf = iocb->ki_filp->f_inode->i_private;
+	ssize_t to_read = iov_iter_count(to);
 
-	if (*off + to_read >= MAX_PATTERN_LEN)
-		to_read = MAX_PATTERN_LEN - *off;
+	if (iocb->ki_pos + to_read >= MAX_PATTERN_LEN)
+		to_read = MAX_PATTERN_LEN - iocb->ki_pos;
 	if (to_read <= 0)
 		return 0;
 
-	if (copy_to_user(u_buff, patt_buf->buf + *off, to_read))
+	if (!copy_to_iter_full(patt_buf->buf + iocb->ki_pos, to_read, to))
 		to_read = 0;
 	else
-		*off += to_read;
+		iocb->ki_pos += to_read;
 
 	return to_read;
 }
 
 static const struct file_operations fill_pattern_fops = {
-	.read = pattern_read,
-	.write = pattern_write,
+	.read_iter = pattern_read,
+	.write_iter = pattern_write,
 };
 
 static int setup_patt_bufs(void)
-- 
2.43.0


