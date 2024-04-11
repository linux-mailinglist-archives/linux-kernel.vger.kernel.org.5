Return-Path: <linux-kernel+bounces-140933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D35E8A19FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E7CB261BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280D1C8FBE;
	Thu, 11 Apr 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yDpHxBcx"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5B1C68AF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849781; cv=none; b=QZrFVHOPF++v0AoVdgSKVI+Cinb6eJmSwHTMOTS7vMWZly8B7pWa9qIfs2ZcEcNBJpIT/VndrnoHUqIcKRZRQ0846LrTITRogouDkR/CUWQ9MfR4x+OV2mnwPi+0ZM2frGMiE381ZdfQbiE+x5sBz2PekbiUyzIeHGJNxMAA0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849781; c=relaxed/simple;
	bh=5Hl9sJiZmGzN48insGBMoPhuJNAaYBfMCPiCdS5O2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkFkxF7N2s7T2z5UPm2lwbiT4plZVNIytIj2mBDfn7rq1KKSZFyXf4kb5dfoe4KuCRI39WfolukvzdLQpbT1mDpbopWPVvulPnHI/G6/+niVs53TjMhtdYCZ/kq6QJvulnJ+DcWknE1jGv/nfrsuBdLeTSItzn3mCzrkWALi8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yDpHxBcx; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a34b68277so110805ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849779; x=1713454579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZXUWVzjzpqSSPI9h+Xhjlak12CvKdLC3cnm3Z7bVEM=;
        b=yDpHxBcxOd6+r/zWJydBMspXTCrpZHiukOtv+modBJIQaTNgZIvxRNPFUPE21VvUYr
         4xfaF5SPbsm7koGoTq1S9ukk1USn7qqdnLAip17khyKg+PFQ8Tk0NY9TWLjFMxjAhwDh
         6cnnGJmvj1UKY6PCkVn4hpb9WcelMR+GLT23LCqh6ND5nL1jZ7W7exshmtSsC7dLk6/U
         KbngjncK2c56F5Jb4cZ/TF3+hDuRnftNiUvRn1Tr/Sjx/juN0h/yb3P5Y8NSrfsWShIO
         7KYmJi5Y30Lln7LSS3ZK7SyKEXYEWER2GXCVbOLpP52Wty5r+56/55hq0h7xoHWlIBET
         6tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849779; x=1713454579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZXUWVzjzpqSSPI9h+Xhjlak12CvKdLC3cnm3Z7bVEM=;
        b=gKeqamdzEvJzota4OX7N1ZEARvb2QDWy9oUJrgEqkwchoB4DNDOUpQnJYf4vf2nX+8
         ggk9LU1MMD3nUu929ZMnvp/jYXg9YfR4hSpcGrC/1fPHnBRbtU2sedNOsotmW7/cXvnv
         BICNlXQ52WKj0EGchuHKgJ0LwWSieJSDulz68t/8f7xOQXnP7SSkPIAh5TF8Nufb3+g7
         us1A2DENKG8IFvxvwnO7ANc1M42iCBFL5ai9WdcvujOnLaWzf8+kTaFxvJIdOiigzLsz
         sfgiRcp4MF8SLhqllEpgFDxc89ZWrfRSYlXcrjBr/6ok+WJosV0G5LZFrYOMaGgA78kA
         O7gA==
X-Gm-Message-State: AOJu0YxCCKArjG5W/rOchE6L3bdnt84QoXG996Oj33AAaU1PfcrOG9IG
	3KCpYmTPpg6rANHULKEA/y6x4xEgMhZo213u3C5jyy8vO0JE9bsNfpfgB/NNGT51omryvo/6IRs
	u
X-Google-Smtp-Source: AGHT+IGYcPN9OPc29KKgwUslmpYFbPG+9iq3sMjJNXiONb+oVDgol7ElIAo08r+wuwvPvOOgTD3u8g==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr149589ioc.2.1712849779247;
        Thu, 11 Apr 2024 08:36:19 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 165/437] usb: host: uhci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:05 -0600
Message-ID: <20240411153126.16201-166-axboe@kernel.dk>
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
 drivers/usb/host/uhci-debug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
index c4e67c4b51f6..e8329c44db59 100644
--- a/drivers/usb/host/uhci-debug.c
+++ b/drivers/usb/host/uhci-debug.c
@@ -589,11 +589,10 @@ static loff_t uhci_debug_lseek(struct file *file, loff_t off, int whence)
 	return no_seek_end_llseek_size(file, off, whence, up->size);
 }
 
-static ssize_t uhci_debug_read(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+static ssize_t uhci_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct uhci_debug *up = file->private_data;
-	return simple_read_from_buffer(buf, nbytes, ppos, up->data, up->size);
+	struct uhci_debug *up = iocb->ki_filp->private_data;
+	return simple_copy_to_iter(up->data, &iocb->ki_pos, up->size, to);
 }
 
 static int uhci_debug_release(struct inode *inode, struct file *file)
@@ -610,7 +609,7 @@ static const struct file_operations uhci_debug_operations = {
 	.owner =	THIS_MODULE,
 	.open =		uhci_debug_open,
 	.llseek =	uhci_debug_lseek,
-	.read =		uhci_debug_read,
+	.read_iter =	uhci_debug_read,
 	.release =	uhci_debug_release,
 };
 #define UHCI_DEBUG_OPS
-- 
2.43.0


