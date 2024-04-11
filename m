Return-Path: <linux-kernel+bounces-141172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A18A1AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0046F285FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0552F70;
	Thu, 11 Apr 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tLbzhEqR"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72241F63B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850156; cv=none; b=ugKmk7Xam4xeoc0uDqByY1WE1awIiLmvQhxATNNEBVYGssPYC2FaVaihLij4sfbi2CQ0PSoplbLRBfr+3+35Qw1ALgTr9PWy3HAiERTBAAGkaBcepnHW1H3zgC0uOf8KQ2wYOMWVzcpLEzkoJGLoVasNTHZHcl9NsmnlP2Zr3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850156; c=relaxed/simple;
	bh=QzT97jcs7LvwDa9GfHQyS6Z4ENz0HdIaPZHjnl1Ltk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0MOVtNxtduQEoy66K5uWltXht3TP/IJamihC7vi7gBvmfA4V1H5CavR4kIwDlNmdKgfvz7OtR+45eIAIGL92zVYDydWpENb7bVIHochDLNNCakezoPs1DDCTgqKnwtMapCMXFPCKqOcUsfGVOmFbhbqDxP1XJFEjouir3qPWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tLbzhEqR; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9094839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850153; x=1713454953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Xvz/UDRr7/EpD2nY4uoaZN8CL3TczLBOcQ0vJ5qaA=;
        b=tLbzhEqRDgQc01IAvzlwlUlaK0cIouF59Cq+ZDddIh7nwNWRHQ8y3CZt0uDNFhy3zI
         bPS2+F3f0C4jCrlIBlOtUKyuuXMoP4NsRmosV1EZI3XJKi4zAOOmIgLqNxFUdPtJhlB+
         oFv+mFIBm4sJ3pqfvBeXgNTMFsKSeyP/UikBuwq4OsrttAKObm0rF0KDJnCxI/ts0+BX
         gSot5Qfxo03R/XvjR4i411qNCYh/9ppUgi2nUK6TG3EloT8EGAyC9PEkgeoxywj6WrPG
         xlo3CvBU4K2VkSsFsRgB84ybERhR4v1GgEpgS/YRZofK6lx0K//EYqaANCh6rG9g/wwf
         pNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850153; x=1713454953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Xvz/UDRr7/EpD2nY4uoaZN8CL3TczLBOcQ0vJ5qaA=;
        b=sRWkZZWvKumHdwBewO7YH6lidip+VnAyiJtP+BKud1EqPqd3/Ko6KXdNXnP3BqdKzU
         hGZigUoGjGJy7+3p+HzVx1gnYQ6Bf/jYlEXQ3j3gYkZQ032zWMzrBi2yb5/KNMZg+EO8
         WkDFwIdsFIWXDGIm1JQPBqH/a9ePjA4VY/rwP3PNb/vSgjFBETV/vwZeR7g2k6JC9V12
         j1UA6bpAOGV3xkN5lR+qW9mBjafm2YYe1U+SwKbzmh6dCh/I2+SMj/6soUXbqlXLIhWA
         adHUMNp3XJf08Pal/rxYvH/VsWa6zLHw3+owBYD+SLezPk3/symtxutjBpzsCA0x46+a
         L63g==
X-Gm-Message-State: AOJu0YzqpAPXWSeMi7EdaaBkhgneSPch/ocaXLpWlrA0E/FtPP71fiZN
	iYLugfGgKY9bYfKEf2UtmdRY5aMtsf19zWEPCZRYv6hld0jojqvp12OBiY/elaBBccDGPpniTEO
	f
X-Google-Smtp-Source: AGHT+IHl0bur4OnSw6GCYS5F/K0c+WHDD2fn3Dclmfj165S2QjKbNs5JwA3cpFtCRAvgMKGIyC3VBQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr238970ioh.0.1712850153486;
        Thu, 11 Apr 2024 08:42:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 389/437] EDAC/thunderx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:49 -0600
Message-ID: <20240411153126.16201-390-axboe@kernel.dk>
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
 drivers/edac/thunderx_edac.c | 71 +++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 90d46e5c4ff0..54edd310c6f0 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -219,33 +219,32 @@ static struct debugfs_entry debugfs_##_name = {				    \
 	.mode = VERIFY_OCTAL_PERMISSIONS(_mode),			    \
 	.fops = {							    \
 		.open = simple_open,					    \
-		.write = _write,					    \
-		.read  = _read,						    \
+		.write_iter = _write,					    \
+		.read_iter  = _read,					    \
 		.llseek = generic_file_llseek,				    \
 	},								    \
 }
 
 #define DEBUGFS_FIELD_ATTR(_type, _field)				    \
-static ssize_t thunderx_##_type##_##_field##_read(struct file *file,	    \
-					    char __user *data,		    \
-					    size_t count, loff_t *ppos)	    \
+static ssize_t thunderx_##_type##_##_field##_read(struct kiocb *iocb,	    \
+					    struct iov_iter *to)	    \
 {									    \
-	struct thunderx_##_type *pdata = file->private_data;		    \
+	struct thunderx_##_type *pdata = iocb->ki_filp->private_data;	    \
+	size_t count = iov_iter_count(to);				    \
 	char buf[20];							    \
 									    \
 	snprintf(buf, count, "0x%016llx", pdata->_field);		    \
-	return simple_read_from_buffer(data, count, ppos,		    \
-				       buf, sizeof(buf));		    \
+	return simple_copy_to_iter(buf, &iocb->ki_pos, sizeof(buf), to);    \
 }									    \
 									    \
-static ssize_t thunderx_##_type##_##_field##_write(struct file *file,	    \
-					     const char __user *data,	    \
-					     size_t count, loff_t *ppos)    \
+static ssize_t thunderx_##_type##_##_field##_write(struct kiocb *iocb,	    \
+					     struct iov_iter *from)	    \
 {									    \
-	struct thunderx_##_type *pdata = file->private_data;		    \
+	struct thunderx_##_type *pdata = iocb->ki_filp->private_data;	    \
+	size_t count = iov_iter_count(from);				    \
 	int res;							    \
 									    \
-	res = kstrtoull_from_user(data, count, 0, &pdata->_field);	    \
+	res = kstrtoull_from_iter(from, count, 0, &pdata->_field);	    \
 									    \
 	return res ? res : count;					    \
 }									    \
@@ -255,27 +254,25 @@ DEBUGFS_STRUCT(_field, 0600,						    \
 		   thunderx_##_type##_##_field##_read)			    \
 
 #define DEBUGFS_REG_ATTR(_type, _name, _reg)				    \
-static ssize_t thunderx_##_type##_##_name##_read(struct file *file,	    \
-					   char __user *data,		    \
-					   size_t count, loff_t *ppos)      \
+static ssize_t thunderx_##_type##_##_name##_read(struct kiocb *iocb,	    \
+					   struct iov_iter *to)		    \
 {									    \
-	struct thunderx_##_type *pdata = file->private_data;		    \
+	struct thunderx_##_type *pdata = iocb->ki_filp->private_data;	    \
 	char buf[20];							    \
 									    \
 	sprintf(buf, "0x%016llx", readq(pdata->regs + _reg));		    \
-	return simple_read_from_buffer(data, count, ppos,		    \
-				       buf, sizeof(buf));		    \
+	return simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf), to);  \
 }									    \
 									    \
-static ssize_t thunderx_##_type##_##_name##_write(struct file *file,	    \
-					    const char __user *data,	    \
-					    size_t count, loff_t *ppos)     \
+static ssize_t thunderx_##_type##_##_name##_write(struct kiocb *iocb,	    \
+					    struct iov_iter *from)	    \
 {									    \
-	struct thunderx_##_type *pdata = file->private_data;		    \
+	struct thunderx_##_type *pdata = iocb->ki_filp->private_data;	    \
+	size_t count = iov_iter_count(from);				    \
 	u64 val;							    \
 	int res;							    \
 									    \
-	res = kstrtoull_from_user(data, count, 0, &val);		    \
+	res = kstrtoull_from_iter(from, count, 0, &val);		    \
 									    \
 	if (!res) {							    \
 		writeq(val, pdata->regs + _reg);			    \
@@ -300,15 +297,15 @@ DEBUGFS_STRUCT(_name, 0600,						    \
  * - Do the actual injection:
  *	echo 1 > /sys/kernel/debug/<device number>/inject_ecc
  */
-static ssize_t thunderx_lmc_inject_int_write(struct file *file,
-					     const char __user *data,
-					     size_t count, loff_t *ppos)
+static ssize_t thunderx_lmc_inject_int_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct thunderx_lmc *lmc = file->private_data;
+	struct thunderx_lmc *lmc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u64 val;
 	int res;
 
-	res = kstrtoull_from_user(data, count, 0, &val);
+	res = kstrtoull_from_iter(from, count, 0, &val);
 
 	if (!res) {
 		/* Trigger the interrupt */
@@ -319,16 +316,14 @@ static ssize_t thunderx_lmc_inject_int_write(struct file *file,
 	return res;
 }
 
-static ssize_t thunderx_lmc_int_read(struct file *file,
-				     char __user *data,
-				     size_t count, loff_t *ppos)
+static ssize_t thunderx_lmc_int_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct thunderx_lmc *lmc = file->private_data;
+	struct thunderx_lmc *lmc = iocb->ki_filp->private_data;
 	char buf[20];
 	u64 lmc_int = readq(lmc->regs + LMC_INT);
 
 	snprintf(buf, sizeof(buf), "0x%016llx", lmc_int);
-	return simple_read_from_buffer(data, count, ppos, buf, sizeof(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, sizeof(buf), to);
 }
 
 #define TEST_PATTERN 0xa5
@@ -403,12 +398,12 @@ static int inject_ecc_fn(void *arg)
 	return 0;
 }
 
-static ssize_t thunderx_lmc_inject_ecc_write(struct file *file,
-					     const char __user *data,
-					     size_t count, loff_t *ppos)
+static ssize_t thunderx_lmc_inject_ecc_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct thunderx_lmc *lmc = file->private_data;
+	struct thunderx_lmc *lmc = iocb->ki_filp->private_data;
 	unsigned int cline_size = cache_line_size();
+	size_t count = iov_iter_count(from);
 	u8 *tmp;
 	void __iomem *addr;
 	unsigned int offs, timeout = 100000;
-- 
2.43.0


