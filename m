Return-Path: <linux-kernel+bounces-140960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D118A19D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC9F1C20446
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9A1B75B6;
	Thu, 11 Apr 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="REDQC9SD"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5CC1B7588
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849822; cv=none; b=g/xF8HHMVcgfJlfxRLBU3ibH23KqDWzmF/G6vs0t6LU7iVF9BFafv4428hlOojm8C4t2LF7PTWTpJlhzqkgAXRo+ycYrgBGlKhFhr7iDY6rEOYvgdNwghE1Cpsr9r6h32C1+w2ovHX7E1G2zudoKbok+FJcbhOguauDQ99hdQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849822; c=relaxed/simple;
	bh=6H4AO/+hVC4jNHTfKQw22NU+CT8ZW7gHfHKvbTTwlNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrL/jV9swscjJWGti2Ll0is3BqNhmtMG3Vk93sVkC84LKGBxZjnVA4EEdhka2bq0NpxGdo1lrY+ArUwmFWgaGiQqV2ivSKdxQTONPE5cW48DB5ur0UXU8KW9Dpkh6wawAlE94Gj5eGz9oQXWt1xSgfQpCOYfjtX/IxtWaJnuAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=REDQC9SD; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a34b68277so112135ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849820; x=1713454620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnhOCVhHdtXmxDG6By9cE26ggBLF3GM0L2GicunETu0=;
        b=REDQC9SDkrsWQ9iGlXrShm2Lw2Hg1tt6FEk3olHdkF0YSQtjpi7657zkRToHGI9OV2
         Tq6Q7I/GoE8P3aH/pH75gTJt31XWb1QtCd6BygJvVvDxl+QHu9uo4Oanvj3YoAo0Q/2c
         CeCg2BmgpSPgLqJvX9PjNsheGrOOu8VqLrr7RsuFNzeMqZwJffL1uaYBeJb6Ra0m5vV+
         yG9jXTkZKXQxoMraOHywYe6aZ96fdo51GzChVsgcfygYFNcD0mjCJgPZ3uY64GRCYOga
         tmGF8pYZPzBpoD+Z40FiTISfME+G6KBMBTjbEujs0HkVsJmdCLyUQcar969H/VDo2u/R
         8kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849820; x=1713454620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnhOCVhHdtXmxDG6By9cE26ggBLF3GM0L2GicunETu0=;
        b=rVveNF+y2b5lKcr/AaE4gwnDhCTOBPRma2NwT/wdBJlzBK/C1UJT3K07S3zU98wWVY
         8tJmTkq5UG6qUf81Z2CU77Ez04BFx0O0ymZpVRYPkzBg2zZmIIsRC86XU/WUsBjvDn1m
         hJckuJUIUqr4LKtl9Vp3fFTMFLYCjLAaYzZ/6L4X/aaAWrRSuOKw3jo7dzXb/xKdZzE/
         NELSFso+O7Re9BDCFrP3fJcpQHQMdjZKnK2/37PySawkHP7dPrYCUY++gEywIGyq5dAC
         +h4JsXiuVz6ZS+DKOktlS9rl6niK0EdWTTAdQVEaBVH1RSCmdRugH106xQJ1NKpk47dP
         RXsw==
X-Gm-Message-State: AOJu0YzqUJ8M0gNuCKfuR8zF7t2N2l13fJtuedFTDIOXEG2B4sN/RzW3
	Zo61qHqA2IRQyiKX78dlPtULhEKPiWfvlQIHRAng6cbdPFM1TZuBW3aDMPVyfN5MOaH97oRjnmR
	5
X-Google-Smtp-Source: AGHT+IEdDQ1i8fkevz6KK31iKoqlzOn6MpAqkriKwmkSlRTHWkqNqOgGVt6EM2GgwKX/jbERUgDdCQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr189296iob.1.1712849819949;
        Thu, 11 Apr 2024 08:36:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 191/437] scsi: mpt3sas: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:31 -0600
Message-ID: <20240411153126.16201-192-axboe@kernel.dk>
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
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index a6ab1db81167..2cb768bcf5c2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -36,17 +36,15 @@ static struct dentry *mpt3sas_debugfs_root;
  * @ppos:	Offset in the file
  */
 
-static ssize_t
-_debugfs_iocdump_read(struct file *filp, char __user *ubuf, size_t cnt,
-	loff_t *ppos)
+static ssize_t _debugfs_iocdump_read(struct kiocb *iocb, struct iov_iter *to)
 
 {
-	struct mpt3sas_debugfs_buffer *debug = filp->private_data;
+	struct mpt3sas_debugfs_buffer *debug = iocb->ki_filp->private_data;
 
 	if (!debug || !debug->buf)
 		return 0;
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, debug->buf, debug->len);
+	return simple_copy_to_iter(debug->buf, &iocb->ki_pos, debug->len, to);
 }
 
 /*
@@ -89,7 +87,7 @@ _debugfs_iocdump_release(struct inode *inode, struct file *file)
 static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
 	.owner		= THIS_MODULE,
 	.open           = _debugfs_iocdump_open,
-	.read           = _debugfs_iocdump_read,
+	.read_iter      = _debugfs_iocdump_read,
 	.release        = _debugfs_iocdump_release,
 };
 
-- 
2.43.0


