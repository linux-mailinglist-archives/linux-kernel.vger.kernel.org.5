Return-Path: <linux-kernel+bounces-141171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69B8A1AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3681E2819FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721AA1F63CF;
	Thu, 11 Apr 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YMNtAlYt"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA911F63A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850155; cv=none; b=kZ1gZdBr3RIuu++DG7G2HWMHzT1TDldNkpznEPeSL9SSFQ4JQV1oikWZKIaHXj77tJmR1TI0bkY71iXxBzRrRt8QRKNqyYhRCsnPK3GxPOQ20FxRsleNAui/hhIfqxnpYblF6rEVCmMb3Ah5hsZFr2DM+exZjcCCNQV+ccEbenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850155; c=relaxed/simple;
	bh=gA8rFMhsudIRasINC+2az15qgXyL/gqKmnjo/t8ieBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvSMykpOFdvkFY069v2eRXIvFGgAQ5aGJaxAfsFlV9OTE7CgMSJf90c5ov69P7YIScQw7Jf7KBiuwtioOyDPb7yPSGo0scl7B2QONjDR4B9Hoq8ApyKm+WKkE0F+UJomqyi7IeGglxoO2vVKcqYIdGbGJUFaUpSJ/7wwrBkeyBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YMNtAlYt; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9094539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850152; x=1713454952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gLv0Ik+40YEsN6bRxyBw09qExxmyScg525+OgMqQYQ=;
        b=YMNtAlYteGbFkZ75oHST8JuY+sV+YP9mFsEJJG92G52PdLisdAWA4zbeGDKnwc5MNP
         hqJkGPvFHT2WmkKX3sv5MQsPON10fVJp0cxsZOIj/ANZyIYGz5b7QcD1hCczl1ez2IWM
         yGOepXi85oBU4dkpW7TYIBa5KTGMKAkWrpUCtCX3icv3B0uveyqFDiybMVQOW4x/Uy5H
         4tZfgWUPKexYOAcLaGVaaRFScKC/3yPa2IywAIk7n3PxfUiTjfkW08O+ZrgG0PcvEV3D
         qpro882/pCHqdFNXb+wZwYJzT3sNZ64R/WgijMdB4zkrTefBFgSqz9ZE2XfsdAiCMPRC
         O7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850152; x=1713454952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gLv0Ik+40YEsN6bRxyBw09qExxmyScg525+OgMqQYQ=;
        b=e+SPzokCY04afqhoQ4KWjFXnq6yP3Jm1nZwH5/g8PpKfN8RWfA8wg8EbJwZNuKGGLJ
         6CPbxMBhL0JDvt6xrsomqcZtKaXOXWGGKqwcOU+uixnBpxtvDm0wSN54CwD/+Nvtp105
         6W8Xj3fSQI4j0AOi4U+9/6HTtKGDwheNZf5DBU1shzWUiw6o8LlrW63/mToFJ3jLSsOj
         fHIAbOvLStKCIEsnjdrRRcKXdxUuCJk7imemKSIEyG9sIvRj9QrV8Lc4IRZ3ZlhmZrSx
         wM9Z0msBy4Arlir5k0HcON8P0jLObHpVLC6AuBmswJ3KkiFzGrehaa7tSMT0UhlHiNWb
         qRlQ==
X-Gm-Message-State: AOJu0YxUIO7muLZ3Dm6LFIqFHwXUtggVIVI33FSd9IprDjRg1MmvIK+n
	yOEMVudP8NCO9uTPojvH3XrgiWQVhopKL16Hgz5x2NvxBfwnhNE4yT1v56CAUUjlUtM3UrDl865
	V
X-Google-Smtp-Source: AGHT+IFl1U7Gq7SRFJqISZ2qZ9AaZnNqVRV/Z2Gc6jkS8X0UtLV/9CSxw5RRR9mCr/twh144gM9VTg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr198224ioj.2.1712850152720;
        Thu, 11 Apr 2024 08:42:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 388/437] EDAC/zynqmp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:48 -0600
Message-ID: <20240411153126.16201-389-axboe@kernel.dk>
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
 drivers/edac/zynqmp_edac.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index 2d9a5cfd8931..53d697b4137a 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -247,17 +247,14 @@ static void write_fault_count(struct edac_priv *priv)
  * - Write the Correctable Error bit position value:
  *	echo <bit_pos val> > /sys/kernel/debug/edac/ocm/inject_ce_bitpos
  */
-static ssize_t inject_ce_write(struct file *file, const char __user *data,
-			       size_t count, loff_t *ppos)
+static ssize_t inject_ce_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_device_ctl_info *edac_dev = iocb->ki_filp->private_data;
 	struct edac_priv *priv = edac_dev->pvt_info;
+	size_t count = iov_iter_count(from);
 	int ret;
 
-	if (!data)
-		return -EFAULT;
-
-	ret = kstrtou8_from_user(data, count, 0, &priv->ce_bitpos);
+	ret = kstrtou8_from_iter(from, count, 0, &priv->ce_bitpos);
 	if (ret)
 		return ret;
 
@@ -280,7 +277,7 @@ static ssize_t inject_ce_write(struct file *file, const char __user *data,
 
 static const struct file_operations inject_ce_fops = {
 	.open = simple_open,
-	.write = inject_ce_write,
+	.write_iter = inject_ce_write,
 	.llseek = generic_file_llseek,
 };
 
@@ -291,21 +288,18 @@ static const struct file_operations inject_ce_fops = {
  * - Write the Uncorrectable Error bit position values:
  *      echo <bit_pos0 val>,<bit_pos1 val> > /sys/kernel/debug/edac/ocm/inject_ue_bitpos
  */
-static ssize_t inject_ue_write(struct file *file, const char __user *data,
-			       size_t count, loff_t *ppos)
+static ssize_t inject_ue_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_device_ctl_info *edac_dev = iocb->ki_filp->private_data;
 	struct edac_priv *priv = edac_dev->pvt_info;
 	char buf[6], *pbuf, *token[2];
+	size_t count = iov_iter_count(from);
 	u64 ue_bitpos;
 	int i, ret;
 	u8 len;
 
-	if (!data)
-		return -EFAULT;
-
 	len = min_t(size_t, count, sizeof(buf));
-	if (copy_from_user(buf, data, len))
+	if (!copy_from_iter_full(from, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -342,7 +336,7 @@ static ssize_t inject_ue_write(struct file *file, const char __user *data,
 
 static const struct file_operations inject_ue_fops = {
 	.open = simple_open,
-	.write = inject_ue_write,
+	.write_iter = inject_ue_write,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.43.0


