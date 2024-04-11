Return-Path: <linux-kernel+bounces-141175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470B8A1AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04C71F23742
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344691F7858;
	Thu, 11 Apr 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mVLEirOo"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8C1F6F26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850160; cv=none; b=KsOa5LzUEWlAhy1H/zUKr+vThmx2C1KKuVeyJ+VhLdoQ1ikPUxUMnvZFoC4peBpDOs2CMcfMdeOFqVHRJjmnNAZ33zXSUzJPfyUf6IKEf2VN6tK4Wd3B9+Yu+GL8m87SB2C43GxtYNzfyK5lcGQDnxKdsMV/j7C3XZU50pfk/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850160; c=relaxed/simple;
	bh=Vrqcyec6hF25kX7zHSZZ5y7GOl5rDk+A82uY/0vxUJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8NJ1Aqu5aA4otE9+ZI83YIO/QagPEbU6mqMWDiYqh9WOhxdhQ4L/2nMEONoyrV3zxbrLJ+te3YlI8OEKF56fY3/ZjC5wha1i4pmbVc+GNeVInkkzTRbp78+CdLWbLDISnpa4RThx/sbMRF5Hg828wBjcvHe01fKW/bJFpQcHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mVLEirOo; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170650939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850158; x=1713454958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AsYF62zoKQ6xHxSJoAgeCHEcijXHfRzPoZD4kOFFmI=;
        b=mVLEirOoDlqmgO0w9H9gxlbALLdQuScCVDy369vgTrwcVwommeYw4UpGUklzHaj4UV
         B9ENJ9mw4iyeOCtLUoR/gT4eEH4AuEhxlndBJJiuDubSfqqTyHV89Knb3Rr+j2jaah8M
         +WIg/mEN++3kixCU+USjgIb7L6Xche8WMsCksvSI3+cry4DyBbeHbgiR5Bi4jkmSa6Mc
         /ITmb+xm+aKaOTfHC2zqrSSjsFCE8AuKeImTf985CswPeqsXxW//HeTFr5nCygkumgu5
         iKXikpqlpn31/1V4ZeRSJXCqCxYAGPrsCbsYuzfJKhdfZp9Av0LjPrmjrpqvDFLFh1KE
         yJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850158; x=1713454958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AsYF62zoKQ6xHxSJoAgeCHEcijXHfRzPoZD4kOFFmI=;
        b=LTVW71BBPp3Qh/PsAf5RNlP26RNQJWuOgtgYRExByYz31WoeWFkBIVmCOJOduzNRN6
         2GoqP7f4l8MTv6kS2eoNktlvfzv0Fn57dDoYRiSSlX/cnjkjd/aXd9g64kaibYBwasDU
         WbNqrY/WK1QpSBMhwAyUUATkamWJDMLzE/3X8jU0pVqEs5olb9ecDCEk/d0WE5nhA0VG
         YybzzpwuJNQUztSJK9jBSpaAKwzaeVTnYHAOoMDcDdyN0ktOG0io03M4WzMp1OriuelJ
         hA9mJeTFw3sEwX0ogzIBeJ7AfcPd+BG6CP+vzqwxWxNPxXMCNO/NbWOSj8RXfXUbGTW+
         5h2A==
X-Gm-Message-State: AOJu0YwgRn3OiQVt7WlgHlZa0PX5EIoCtkVf46HaesQdI1pSyuwUhrPR
	1PBci/s/C9zQIlpfwli29XyX4uhUaaqdKVFsvY6l7IVKb8dtvfkX2WEfXcUHqIYgxWDRbLk+xNb
	/
X-Google-Smtp-Source: AGHT+IGmDy3Lrp9Xa7qppe8MiNfgohckfX1lXC3Zl14juX584SBJh8/sedFE7cxdJNPyukdee14BJA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr198506ioj.2.1712850158005;
        Thu, 11 Apr 2024 08:42:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 392/437] EDAC/altera: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:52 -0600
Message-ID: <20240411153126.16201-393-axboe@kernel.dk>
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
 drivers/edac/altera_edac.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index ae17ce4d9722..889722751163 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -115,13 +115,13 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
-					    const char __user *data,
-					    size_t count, loff_t *ppos)
+static ssize_t altr_sdr_mc_err_inject_write(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct mem_ctl_info *mci = file->private_data;
+	struct mem_ctl_info *mci = iocb->ki_filp->private_data;
 	struct altr_sdram_mc_data *drvdata = mci->pvt_info;
 	const struct altr_sdram_prv_data *priv = drvdata->data;
+	size_t count = iov_iter_count(from);
 	u32 *ptemp;
 	dma_addr_t dma_handle;
 	u32 reg, read_reg;
@@ -187,7 +187,7 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 
 static const struct file_operations altr_sdr_mc_debug_inject_fops = {
 	.open = simple_open,
-	.write = altr_sdr_mc_err_inject_write,
+	.write_iter = altr_sdr_mc_err_inject_write,
 	.llseek = generic_file_llseek,
 };
 
@@ -640,30 +640,29 @@ altr_edac_device_trig(struct file *file, const char __user *user_buf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(altr_edac_device_trig);
 
 static const struct file_operations altr_edac_device_inject_fops __maybe_unused = {
 	.open = simple_open,
-	.write = altr_edac_device_trig,
+	.write_iter = altr_edac_device_trig_iter,
 	.llseek = generic_file_llseek,
 };
 
 static ssize_t __maybe_unused
-altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
-			  size_t count, loff_t *ppos);
+altr_edac_a10_device_trig_iter(struct kiocb *iocb, struct iov_iter *from);
 
 static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unused = {
 	.open = simple_open,
-	.write = altr_edac_a10_device_trig,
+	.write_iter = altr_edac_a10_device_trig_iter,
 	.llseek = generic_file_llseek,
 };
 
 static ssize_t __maybe_unused
-altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
-			   size_t count, loff_t *ppos);
+altr_edac_a10_device_trig2_iter(struct kiocb *iocb, struct iov_iter *from);
 
 static const struct file_operations altr_edac_a10_device_inject2_fops __maybe_unused = {
 	.open = simple_open,
-	.write = altr_edac_a10_device_trig2,
+	.write_iter = altr_edac_a10_device_trig2_iter,
 	.llseek = generic_file_llseek,
 };
 
@@ -1760,6 +1759,7 @@ altr_edac_a10_device_trig(struct file *file, const char __user *user_buf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(altr_edac_a10_device_trig);
 
 /*
  * The Stratix10 EDAC Error Injection Functions differ from Arria10
@@ -1823,6 +1823,7 @@ altr_edac_a10_device_trig2(struct file *file, const char __user *user_buf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(altr_edac_a10_device_trig2);
 
 static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 {
-- 
2.43.0


