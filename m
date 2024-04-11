Return-Path: <linux-kernel+bounces-140996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5C8A1A04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE491C215C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE43DBB2;
	Thu, 11 Apr 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1zgtg6GR"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79241C1241
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849879; cv=none; b=oFJkNQSTv1CfbnXQfCHQNZO+Rc1WySeoefWeaAUjOO0WbtUi1Vq7QvQEtMSXujoZL4DGRTxP611TaV2ISCkWRzUCpwKcMTGWHKAa63qIH2tnm5C+XtxpB66XoxZwYa5YOdsciunZzA5MPL+T4zesLGrH2tdGfzot59OmcGo9g0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849879; c=relaxed/simple;
	bh=eBQ5PolULrG7X1JocqFDWqUH0cPAdjxu60/Hv9y8eeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbK2OmTadFID55DSTvIV7sH6Zgb6gG8hZEg8UnLod0w+qiby/J7H4LuLsInbySAMTnjIRKP1T/t6PmDy/FD5eBuNf4Vrhq+oAE9wSiIzkr4ebXTE9lzoTWmSdvOw7iavhJzJjRfETDJevCAkXc6VoNqZKw3K7orjVkvaRxmUDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1zgtg6GR; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a34b68277so113465ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849876; x=1713454676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBG0Icemg3I1csuXuhMuMpuiVldFWp6vm8d9fo6GTjE=;
        b=1zgtg6GRoHaSTWDkF/2pl/IhO8zq0SysCWh75SjJZcepZN6ROAcsonmQXqSgDA0GPG
         DhAzBjJG3V2NWhJiIfpHFGKevLkSJ+8DnYXCya3gloQFEouSYwspsDsPHysQFUzLgdiE
         55rZxlIi0R36riEYFMH2W9Xww2YFTYvoxtfrgBlsgz8AHoAXpskvGFrJgHgIbIbi6x4T
         aXmJzDsm784+5R3i/dFndwJgY7yynbQikq4KbwTn8Ca0uL3COiWNUz4F3hlVN4b0yU71
         i6gwspU+CXlb9sMkqzO68IcKgm2mewh1NGc4Tygcy44VyduMWOsskzXNu7YXLuFM6n3R
         LHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849876; x=1713454676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBG0Icemg3I1csuXuhMuMpuiVldFWp6vm8d9fo6GTjE=;
        b=X+inUqjSrYkavwJUvEA5uRyoI7JBYgJ+jFeoY00pXcaor23U/XUCjZbKK0tx3Lqf6H
         eBvjkUpLZXiCjQr3qaQG6RnuwijHrt2MpZzh53nvdYoMmZdRW19ix2zL/pIPcYpVb8bG
         2qDgEyqUi7U1XL6ahXsF+PpI6VdcNwMs+BSjOlSUhPekNVpcDSSGpHDa528lAOXkP/+V
         UXFGl6XYeZ7MrwSdajaPaqKDkAoYUqbW+Cd7loKtfR+7dSWWcEAl4k/2oVsWhPcXH3TE
         5LwLF0nMrFA9EHUmetLxjtBCEQZOyUqNMIO1o/tXOpkdE6lQV6aV6nNuOioVPNIIgW4a
         n+3A==
X-Gm-Message-State: AOJu0Yz7yrmUcpJglAjYbVG31ABMnq/0pfsRuT+ExXXuLNt5H3DuxnTQ
	+CHBed9WJ3yWPsmAJVGGqacLwQeJkr+iPBKvpjyD+kkBG1b+Eh6RUOFkQ1YiGehZedR5DaO+Qnc
	T
X-Google-Smtp-Source: AGHT+IFwjYlOkkCwuMKp/loKt26xX8GHZiCPqI3W6/dL9QRd9qRU17Nak5JAWlOnGaPP/xK2LG7jbw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr192286iob.0.1712849876517;
        Thu, 11 Apr 2024 08:37:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 225/437] drivers/mfd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:05 -0600
Message-ID: <20240411153126.16201-226-axboe@kernel.dk>
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
 drivers/mfd/aat2870-core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 2fee62f1016c..78a8809908ff 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -248,10 +248,9 @@ static ssize_t aat2870_dump_reg(struct aat2870_data *aat2870, char *buf)
 	return count;
 }
 
-static ssize_t aat2870_reg_read_file(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t aat2870_reg_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct aat2870_data *aat2870 = file->private_data;
+	struct aat2870_data *aat2870 = iocb->ki_filp->private_data;
 	char *buf;
 	ssize_t ret;
 
@@ -261,18 +260,17 @@ static ssize_t aat2870_reg_read_file(struct file *file, char __user *user_buf,
 
 	ret = aat2870_dump_reg(aat2870, buf);
 	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+		ret = simple_copy_from_iter(buf, &iocb->ki_pos, ret, to);
 
 	kfree(buf);
 
 	return ret;
 }
 
-static ssize_t aat2870_reg_write_file(struct file *file,
-				      const char __user *user_buf, size_t count,
-				      loff_t *ppos)
+static ssize_t aat2870_reg_write_file(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct aat2870_data *aat2870 = file->private_data;
+	struct aat2870_data *aat2870 = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	ssize_t buf_size;
 	char *start = buf;
@@ -280,7 +278,7 @@ static ssize_t aat2870_reg_write_file(struct file *file,
 	int ret;
 
 	buf_size = min(count, (size_t)(sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size)) {
+	if (!copy_from_iter_full(buf, buf_size, from)) {
 		dev_err(aat2870->dev, "Failed to copy from user\n");
 		return -EFAULT;
 	}
@@ -314,8 +312,8 @@ static ssize_t aat2870_reg_write_file(struct file *file,
 
 static const struct file_operations aat2870_reg_fops = {
 	.open = simple_open,
-	.read = aat2870_reg_read_file,
-	.write = aat2870_reg_write_file,
+	.read_iter = aat2870_reg_read_file,
+	.write_iter = aat2870_reg_write_file,
 };
 
 static void aat2870_init_debugfs(struct aat2870_data *aat2870)
-- 
2.43.0


