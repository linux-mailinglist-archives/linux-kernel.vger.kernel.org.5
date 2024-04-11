Return-Path: <linux-kernel+bounces-140863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ACB8A193E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504E91C21B46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA013A888;
	Thu, 11 Apr 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VHNZffyv"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277113A401
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849674; cv=none; b=fTlLBgUMhVsaawzjgPYBivoVCkRbx8rNkp07Bz4tI+QZXis4pyt0Gn05/Knyfz/eYUrYgLQu9kyIHZ0CpOjneYAaQMMNsT1ezsTLejJG+Gg9GmJiGIOo/y/Yp+uC+MOXtZjfGDisWsV5D4hbGEJKy+bksoWA21E10UZkPAOLfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849674; c=relaxed/simple;
	bh=i8WZGkK1Xrc1Ds405kONA9j4KG27U4Jn+3Qr5PpUI24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WguZliHsiDhRR05en6pgtYVRoTvH2TNq44eAbKKhTyLeyrq0PHQKSlC8IPzqTGDaijSmomVeMLr8g+RCl79zIbnxr/3BGwcMWlMaVkRZexXntzDBLQFL2t999Sl08jgp0HAEdly1mcijHrOaj6xQjGk3Z6nwS5x4CZTSgonLd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VHNZffyv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so108165ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849672; x=1713454472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnDRn6e4WJdH+640WYFjzIyIME2FivwUJbPuYAZrbUg=;
        b=VHNZffyv4L+PQ1miPIq1kuJy+so7Z9pxUn5ezjYHc29RBOcX//z/2erjzsA3H3Yk6k
         zK+zErG6szoLoxjoKoKgds5DgksKSar+No/LZl6mrPZditxcuwBLmQw4CrADqTb8S9D+
         YPnCipw+CfehTTr0ECBuOHBt8sK9MiJLzcvcaXkcb+AvLHG3lCogtE65zJsl6sD/2gWx
         Z2FCuG1b374B0XaXa2d8zwOd2+WmWbIW1uPTIVT++R5MwwSkOCehxe9dmk9r8eMeqDKg
         em0JJoAnUweADLB08EG51VkLQ+88csUfT+e3vP2B5LkuWxijniX0dNvmHO1YumP9C1VB
         OFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849672; x=1713454472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnDRn6e4WJdH+640WYFjzIyIME2FivwUJbPuYAZrbUg=;
        b=YQC1oo3SRFl/W9ajOnVg5j9FjpjVtSWBYNgYyFTrSUZW/lQtzV8h3cPtBpHJwDiN7k
         Q3+uOUbuTZxaLgQ88sRP7n4wyg5sx3HvI3UDjFqTD/mkGcQu30ApQTNzkf517tDADQkp
         +Qp6jYrdxZlDwbUuiH6NdEyVDULPD9mzqmEr4p1auj04ENELTIOgQiKWaIYBVNiegnEL
         zAI9V4wspVELHaXF2wx3rCDNxBayxqlprE6ypD5T+xiTOg789wKQ4cXPdtoByTlWfsJT
         3zFpfGzJ5776hLjuVlZHW2H25xdyOruGVU8Zr+4CkUbQYlFfZRyZifGjvK99uW+spTyx
         5TKg==
X-Gm-Message-State: AOJu0YzBuLkLOWKk2R3Mta+xr5ksRo2P9b1S95nLw2MLesARujQERFqu
	Pl6JlXzzltqOip+atVr6FgIrQqVQCGZPZKgmZ5cT/eEcYFd/m38F9kCDXm/tSMIMOhTwYjdnyH5
	H
X-Google-Smtp-Source: AGHT+IFGk0IG7LpoGDPJCVS1h7XsTnNP8GK+MvNIJ6kPuNDxil7Gy9mvjWsH99mJELxB94ndHBOn/g==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr184478iob.0.1712849671737;
        Thu, 11 Apr 2024 08:34:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 100/437] zram: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:00 -0600
Message-ID: <20240411153126.16201-101-axboe@kernel.dk>
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
 drivers/block/zram/zram_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..eac46889b4b2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -850,13 +850,13 @@ static void zram_debugfs_destroy(void)
 	debugfs_remove_recursive(zram_debugfs_root);
 }
 
-static ssize_t read_block_state(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t read_block_state(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *kbuf;
 	ssize_t index, written = 0;
-	struct zram *zram = file->private_data;
+	struct zram *zram = iocb->ki_filp->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	size_t count = iov_iter_count(to);
 	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
@@ -870,7 +870,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
-	for (index = *ppos; index < nr_pages; index++) {
+	for (index = iocb->ki_pos; index < nr_pages; index++) {
 		int copied;
 
 		zram_slot_lock(zram, index);
@@ -898,11 +898,11 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		count -= copied;
 next:
 		zram_slot_unlock(zram, index);
-		*ppos += 1;
+		iocb->ki_pos++;
 	}
 
 	up_read(&zram->init_lock);
-	if (copy_to_user(buf, kbuf, written))
+	if (!copy_to_iter(kbuf, written, to))
 		written = -EFAULT;
 	kvfree(kbuf);
 
@@ -911,7 +911,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 static const struct file_operations proc_zram_block_state_op = {
 	.open = simple_open,
-	.read = read_block_state,
+	.read_iter = read_block_state,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


