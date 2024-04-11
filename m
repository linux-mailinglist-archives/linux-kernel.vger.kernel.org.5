Return-Path: <linux-kernel+bounces-141176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF08A1AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF14285F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03A1F787C;
	Thu, 11 Apr 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I9EE63Hd"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330A1F785E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850162; cv=none; b=g4AUWLHLJLL+k8/OpADgXDUGSne+eYKvaTR71+uTptCl9yY6ye2lq2yV3nPZVVtUdM04zXwej/8bVgpNgDVeeHqopiQVar2zyZT7+o+NbY7d1VgYVMwDRYmIzYtvJhgRCQGqL5yoBFY2iBL3HtKmWpo0FhL4x3dRH6oPvti+gG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850162; c=relaxed/simple;
	bh=jvpsN8KlOXxN4/oiUFPe6KRKbMwKQxQcdzBPB1oeLEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UM543Qsv+wC56pD6vMnf8+f0++uumAnMmeQNtACDkRkWpRTLUbqyB5MafiCw4nhT3fFqnz2dkUypieWedxGCPYRra5ikWXa5m6qyYHwXvI2D6PLF5w/eDiObqIbtfLKRhJKYgm8MksCENNhP8rm979x7lpNMnkts8WbHqCJfAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=I9EE63Hd; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9096339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850160; x=1713454960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA4TCE+h/Fv0oSXozg/ZSJqLNUD+oRGPkgpVB6waRDI=;
        b=I9EE63HdH8btZLLm7yTg/LxWfCqw7ytOAvTr5jfHOp+LjAdoXsSgRnZOkAWkvAdH/X
         cjVpNMw5F0zE5tZ5eRkZ+w/g71MsH2DkmQtlnzIn4DP+wwoKGPfv8XON3c9k6od7TCiK
         7JczSUnlhY5DgPLKqOvHsOeu9ksb+PhbR20vxn2S4wqyuvyrNozer/BUKpxErAEfb6td
         LypKeKWdp2EBPah9493IffJRnZjx5A8vLM8hWZk7UYNCtPsKoT1nLfBrExXZZ37XsF9B
         2mgTXQVSHUwZ75TNAy6kxo3dJgiyprsooDtNaA62WcWwismgCPYyy8c2zffFJNohb94F
         9E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850160; x=1713454960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CA4TCE+h/Fv0oSXozg/ZSJqLNUD+oRGPkgpVB6waRDI=;
        b=K5Bxi8XX7hePWTqG66i5NC6HhvUH9jpPeP6RlgCJT40S4BiV/t8AT6Bu6zk3hiRFbz
         0yMD8czi18em4szzgL6qCQ4UeRVzNW7SHYx/MP2Lv5hr/76G48HgBqooWkOlnnSJbvCc
         /Kek6yJiVxVGWONNO0L8ge0TVf67gtfwZ/bgLGl5+jWU9ghyMP50VBjTpv05vWzCp0yi
         zYbKTX7FKiVB/04J2nPhryq779GFXqHOf1TfMcR8H49agtZIG08IHhPv/itciz1FstU6
         DcHfu6g1gzV4urQbIEtypTmL0gAdtnMMNwqB5rx3IliPqABU5k7QRTsLHeRVPNVB6VFJ
         PRbA==
X-Gm-Message-State: AOJu0YzmjPMDlPdgyqL2CGzqnPmkny06qFnE2HdqGOVZwWA9jfeitSGI
	HFBAivmbii1g0zhLYU20E50rG1/TdDNj+NxX2Cs+u/OWhE/1N5GhJb4kjqmwdpaD7gIAyKmCX5P
	z
X-Google-Smtp-Source: AGHT+IFaE6d5/Wbov/yQXes3u6eSwUkrIIkhTeWtyiBPrcyL/ydwRB6qUhiCROlX4r+k/j3gwc6s4w==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr239249ioh.0.1712850160160;
        Thu, 11 Apr 2024 08:42:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 393/437] EDAC/debugfs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:53 -0600
Message-ID: <20240411153126.16201-394-axboe@kernel.dk>
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
 drivers/edac/altera_edac.c | 37 +++++++++++++++++--------------------
 drivers/edac/debugfs.c     |  9 ++++-----
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 889722751163..45536199e9b0 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -571,20 +571,20 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
 }
 
 static ssize_t __maybe_unused
-altr_edac_device_trig(struct file *file, const char __user *user_buf,
-		      size_t count, loff_t *ppos)
+altr_edac_device_trig(struct kiocb *iocb, struct iov_iter *from)
 
 {
 	u32 *ptemp, i, error_mask;
 	int result = 0;
 	u8 trig_type;
 	unsigned long flags;
-	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct edac_device_ctl_info *edac_dci = iocb->ki_filp->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
 	const struct edac_device_prv_data *priv = drvdata->data;
+	size_t count = iov_iter_count(from);
 	void *generic_ptr = edac_dci->dev;
 
-	if (!user_buf || get_user(trig_type, user_buf))
+	if (get_iter(trig_type, from))
 		return -EFAULT;
 
 	if (!priv->alloc_mem)
@@ -640,29 +640,28 @@ altr_edac_device_trig(struct file *file, const char __user *user_buf,
 
 	return count;
 }
-FOPS_WRITE_ITER_HELPER(altr_edac_device_trig);
 
 static const struct file_operations altr_edac_device_inject_fops __maybe_unused = {
 	.open = simple_open,
-	.write_iter = altr_edac_device_trig_iter,
+	.write_iter = altr_edac_device_trig,
 	.llseek = generic_file_llseek,
 };
 
 static ssize_t __maybe_unused
-altr_edac_a10_device_trig_iter(struct kiocb *iocb, struct iov_iter *from);
+altr_edac_a10_device_trig(struct kiocb *iocb, struct iov_iter *from);
 
 static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unused = {
 	.open = simple_open,
-	.write_iter = altr_edac_a10_device_trig_iter,
+	.write_iter = altr_edac_a10_device_trig,
 	.llseek = generic_file_llseek,
 };
 
 static ssize_t __maybe_unused
-altr_edac_a10_device_trig2_iter(struct kiocb *iocb, struct iov_iter *from);
+altr_edac_a10_device_trig2(struct kiocb *iocb, struct iov_iter *from);
 
 static const struct file_operations altr_edac_a10_device_inject2_fops __maybe_unused = {
 	.open = simple_open,
-	.write_iter = altr_edac_a10_device_trig2_iter,
+	.write_iter = altr_edac_a10_device_trig2,
 	.llseek = generic_file_llseek,
 };
 
@@ -1734,17 +1733,17 @@ MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
  */
 
 static ssize_t __maybe_unused
-altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
-			  size_t count, loff_t *ppos)
+altr_edac_a10_device_trig(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct edac_device_ctl_info *edac_dci = iocb->ki_filp->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
 	const struct edac_device_prv_data *priv = drvdata->data;
 	void __iomem *set_addr = (drvdata->base + priv->set_err_ofst);
+	size_t count = iov_iter_count(from);
 	unsigned long flags;
 	u8 trig_type;
 
-	if (!user_buf || get_user(trig_type, user_buf))
+	if (get_iter(trig_type, from))
 		return -EFAULT;
 
 	local_irq_save(flags);
@@ -1759,7 +1758,6 @@ altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
 
 	return count;
 }
-FOPS_WRITE_ITER_HELPER(altr_edac_a10_device_trig);
 
 /*
  * The Stratix10 EDAC Error Injection Functions differ from Arria10
@@ -1767,17 +1765,17 @@ FOPS_WRITE_ITER_HELPER(altr_edac_a10_device_trig);
  * Inject the error into the memory and then readback to trigger the IRQ.
  */
 static ssize_t __maybe_unused
-altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+altr_edac_a10_device_trig2(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct edac_device_ctl_info *edac_dci = iocb->ki_filp->private_data;
 	struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
 	const struct edac_device_prv_data *priv = drvdata->data;
 	void __iomem *set_addr = (drvdata->base + priv->set_err_ofst);
+	size_t count = iov_iter_count(from);
 	unsigned long flags;
 	u8 trig_type;
 
-	if (!user_buf || get_user(trig_type, user_buf))
+	if (get_iter(trig_type, from))
 		return -EFAULT;
 
 	local_irq_save(flags);
@@ -1823,7 +1821,6 @@ altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 
 	return count;
 }
-FOPS_WRITE_ITER_HELPER(altr_edac_a10_device_trig2);
 
 static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 {
diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 4804332d9946..a2b8458a4c1a 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -3,14 +3,13 @@
 
 static struct dentry *edac_debugfs;
 
-static ssize_t edac_fake_inject_write(struct file *file,
-				      const char __user *data,
-				      size_t count, loff_t *ppos)
+static ssize_t edac_fake_inject_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct device *dev = file->private_data;
+	struct device *dev = iocb->ki_filp->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	static enum hw_event_mc_err_type type;
 	u16 errcount = mci->fake_inject_count;
+	size_t count = iov_iter_count(from);
 
 	if (!errcount)
 		errcount = 1;
@@ -38,7 +37,7 @@ static ssize_t edac_fake_inject_write(struct file *file,
 
 static const struct file_operations debug_fake_inject_fops = {
 	.open = simple_open,
-	.write = edac_fake_inject_write,
+	.write_iter = edac_fake_inject_write,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.43.0


