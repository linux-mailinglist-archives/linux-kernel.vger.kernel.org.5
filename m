Return-Path: <linux-kernel+bounces-140905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31F8A1984
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3AD1F22018
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1C15F3E6;
	Thu, 11 Apr 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3BYZrZOL"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB715E5BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849740; cv=none; b=eXyEgSntfDMHeo7teb5BaXjKS60482AMHN2T+TlTRn0uh0uLwFwEyItht+yua4k5LkFo233liDeDgqE2Pl4CaoNm6cDHXSlbZs7Rv7sIQ5hdgCLzikvQTk2xfsFQaGh9Hg2JT8LCMYDwzjiAj7K/mOrtEY7WdmbR2FRgM3Vl1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849740; c=relaxed/simple;
	bh=h9v6LGVsUN0NcMB2y1najeyRJA7e64TNahZQqt4k0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA4TO8zfyKzF8IZFeilvU5/A57pP4LEljve4ucxZxfRWuHB4cIdIiJUCuxvQE782/AmYgYgygwab2KIU183YTyk+SPo1XxK9sE1LXrQ1VQcf+E+3qU+MNT9nLEiR6FUqLnlKzlLVKBMOcdT9nJboMyRqBRj64uY7FqR6KgVTeY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3BYZrZOL; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9780339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849737; x=1713454537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDUGqnxkhmlDGwUvK8EXWXRvkiQ2buHmxw8/4ZOnwi8=;
        b=3BYZrZOLdBKWTmFqvmzdS0aI55fi1D35WD5nkgI1KLo9Cb3ZO5TKyaDONiIUY0VpVr
         +paGHrOHopmbTTA+SLVkKGMkvWJSYPMEzOzNbMfYBS/3VGkk/V3uKdKtM48iN0ZYtb3x
         hNmKFVCnDpG1sOmg7EkolDixPGm0BaEGM1a3afWKx8VGEs74vzLmnSpYcs+ualckB4R5
         52QYKNl3VbiVGfDFSNtHyHBO6jTh7Q1rMXFQdovXaxEKwqpoZd80jsGT3C8JMsBWaFf+
         DBCiaEF9EO+JRFdLkEULR1iUbuc8TH7+kQMSjfXD8a7Zzvbc9RWvSryIkeANhcyFvC25
         AOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849737; x=1713454537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDUGqnxkhmlDGwUvK8EXWXRvkiQ2buHmxw8/4ZOnwi8=;
        b=lXV7Tzl7IYS/G1oVcRhDt8cMO7oQj1UV0nY78ulbudz8V2g1kVaWEeTAZjgtE/tjiO
         j1CRpLBGp/FSM434yAfgba3q3F9wuqy/5xqJrEJkBZpI8n8GyHIcZweIp3oZUX1AwKIL
         4hhx3yPgFIbCLyUiHyy9bCdUMxLRLKsjxSHP1ForVifHI8SevPPLNgM+Oke0Hvj5ne67
         3Uuev67q0Cs8D3FoAd+LolLidC7OObewG2jXKg2CTX8o7VvoxvsDuIo5K7gjolzS/Lv5
         gGQrJZSuKdXvFqn+M/oGEfuo+e35e3cEPqlUM3hGbVkHX2cR/ae81vexo3FcyRsDOex7
         fFag==
X-Gm-Message-State: AOJu0YybwDRENteOTVhS8dAEB7PLrJFoNd4L48eEIvVKfzyc29cWWzO+
	Y4YdJnzgAgUeFmB9+LpV7u846nwMiWPgXGYrDcjhJazbD2q/sP+xIMMVtGaZhur71yvMyT26ZHt
	e
X-Google-Smtp-Source: AGHT+IEcjbLQhCYbITWp4WDumfGGyWhg0X3isPIF12BwWxxF5zc1NKHmknFXGoXD8k/HQZjEDC5Zjg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr215513iof.0.1712849737654;
        Thu, 11 Apr 2024 08:35:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 142/437] drm: mipi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:42 -0600
Message-ID: <20240411153126.16201-143-axboe@kernel.dk>
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
 drivers/gpu/drm/drm_mipi_dbi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index daac649aabdb..43198c3b2eed 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1332,12 +1332,12 @@ EXPORT_SYMBOL(mipi_dbi_spi_transfer);
 
 #ifdef CONFIG_DEBUG_FS
 
-static ssize_t mipi_dbi_debugfs_command_write(struct file *file,
-					      const char __user *ubuf,
-					      size_t count, loff_t *ppos)
+static ssize_t mipi_dbi_debugfs_command_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct mipi_dbi_dev *dbidev = m->private;
+	size_t count = iov_iter_count(from);
 	u8 val, cmd = 0, parameters[64];
 	char *buf, *pos, *token;
 	int i, ret, idx;
@@ -1345,7 +1345,7 @@ static ssize_t mipi_dbi_debugfs_command_write(struct file *file,
 	if (!drm_dev_enter(&dbidev->drm, &idx))
 		return -ENODEV;
 
-	buf = memdup_user_nul(ubuf, count);
+	buf = iterdup_nul(from, count);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto err_exit;
@@ -1446,10 +1446,10 @@ static int mipi_dbi_debugfs_command_open(struct inode *inode,
 static const struct file_operations mipi_dbi_debugfs_command_fops = {
 	.owner = THIS_MODULE,
 	.open = mipi_dbi_debugfs_command_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = mipi_dbi_debugfs_command_write,
+	.write_iter = mipi_dbi_debugfs_command_write,
 };
 
 /**
-- 
2.43.0


