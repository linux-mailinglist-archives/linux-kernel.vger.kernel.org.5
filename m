Return-Path: <linux-kernel+bounces-140988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CD8A19F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2406B1F27EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61031BF6CB;
	Thu, 11 Apr 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x1SO5Z60"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16211BED97
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849868; cv=none; b=Mtuq1vO0qpode7IJsc6/K2A+PFXR3+jhNW1zcsVnlIzcJJse18Ej7SUSjZmS1vXIvO9eb8jjXUP1PGrX4PzTI0RCGbpJYMAwIhv0YGljWU/kdeXYCa52kYaJYSV3dvDV64gckxOaUk7iq7w3dTuWke49FlnkQa+Aku6fw4F2rLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849868; c=relaxed/simple;
	bh=1UdNv5U1emH9JAurW/QvLJxO9pAOFAvRC5+gJWMaXCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaxdmb3YcARlaX3OVYkQSsTZRj6t+u40L4lluTP/v7AlNPMVmP5woKO44P5DT/FnoMv9rXdfhKb62SATaBcuSG1nbGzbpNFdZFlUNIdGCg0bawhAyEGqUWM4a2cFn3LTAc5aKYlrhACRUk88pHOa6clEweK1eUb2k1HxUoHOhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x1SO5Z60; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8978439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849865; x=1713454665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KCAzXLIsOopEV86W9ZOhnzNKs/kN2+Z3mGkecdfZBk=;
        b=x1SO5Z60yZY5HEB/19D3PfCntgbs88e1a2wpBvnxfme1Rji5TMldqK6OvywpQBawvK
         Fhi4vS3aU5bB4S+2YphDdSDSw5VHFXCdiQdp+4BpOe/xx+QLlozEbPX45cIcg8RXyiw2
         schRiDV49ZCh8wXEs+glwGAumfmDqLxS7jENhvr/Rr9pl+MZJMHODCVoD0mpvejrq027
         2QD0CEuTMA6GOnPV0oc+Gt1jUqDPfITEvBS/OebyToE2BlHf6YQiyeC7AfwlNxva1bl9
         2lWQwxEBQ7ywupiilMYD8sbXylbhBw5zP52v3LStlh00fe37ngj6LuoC2I4r6fsDH61b
         Mc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849865; x=1713454665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KCAzXLIsOopEV86W9ZOhnzNKs/kN2+Z3mGkecdfZBk=;
        b=GFrM+IJIY9rmNZbx7rrP673Lcpppxh+c+5pVDj+x5ZrgoN1dAFF3A4rW6Chi05Usbq
         yy8zIpyHg6Enno+gukYYzEyRLmHqYrYChJwN2bVsc8v4sueS1QjgPb1L5Bjcs1n4yZiN
         XYi9SWOYsCCQqxy7yU9NvH5a8ZAcAmC2o5sjSE33lp5oAqDJXT6xaK9Wi52wbUKYU5iX
         b1XxOP4S+YeW2VHIxqiPFsBOYJyuk/umBsg6hHoyVqOuXCPoaIDbFZ5pebGwTMHJWQTz
         26XJwn2VZDZ59lEUCnLxx3zim3nFUq7zL6OH6GixR/ieOIex2ZEURtXm/YXiZCC1rWtI
         8BeA==
X-Gm-Message-State: AOJu0Yybog6bztyrA32YENG+0Yy8IL/cZytbOiqrGN9cxFfYqgOBBnCJ
	5SL1lBCb+04djoqyxGEzzEh5pczQlm6n3Wtl7ApvTWb7Z/S6AQ/ne5EkN4eGcixMPK9+6LoUykS
	7
X-Google-Smtp-Source: AGHT+IHWzdFOOh+smnVtBm72whFts10EnA8bKrHgB5LuGlqbh4f95rpJyUvVpQHLa1j/5+p9QH/08w==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3586963ilg.2.1712849865528;
        Thu, 11 Apr 2024 08:37:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 218/437] misc: tps6594-pfsm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:58 -0600
Message-ID: <20240411153126.16201-219-axboe@kernel.dk>
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
 drivers/misc/tps6594-pfsm.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 88dcac814892..3e3da7b4bb7e 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -45,11 +45,11 @@ struct tps6594_pfsm {
 	struct regmap *regmap;
 };
 
-static ssize_t tps6594_pfsm_read(struct file *f, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t tps6594_pfsm_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
-	loff_t pos = *ppos;
+	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
+	loff_t pos = iocb->ki_pos;
 	unsigned int val;
 	int ret;
 	int i;
@@ -66,20 +66,19 @@ static ssize_t tps6594_pfsm_read(struct file *f, char __user *buf,
 		if (ret)
 			return ret;
 
-		if (put_user(val, buf + i))
+		if (put_iter(val, to))
 			return -EFAULT;
 	}
 
-	*ppos = pos + count;
-
+	iocb->ki_pos = pos + count;
 	return count;
 }
 
-static ssize_t tps6594_pfsm_write(struct file *f, const char __user *buf,
-				  size_t count, loff_t *ppos)
+static ssize_t tps6594_pfsm_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(f);
-	loff_t pos = *ppos;
+	struct tps6594_pfsm *pfsm = TPS6594_FILE_TO_PFSM(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
+	loff_t pos = iocb->ki_pos;
 	char val;
 	int ret;
 	int i;
@@ -92,7 +91,7 @@ static ssize_t tps6594_pfsm_write(struct file *f, const char __user *buf,
 		count = TPS6594_PMIC_MAX_POS - pos;
 
 	for (i = 0 ; i < count ; i++) {
-		if (get_user(val, buf + i))
+		if (get_iter(val, from))
 			return -EFAULT;
 
 		ret = regmap_write(pfsm->regmap, pos + i, val);
@@ -100,8 +99,7 @@ static ssize_t tps6594_pfsm_write(struct file *f, const char __user *buf,
 			return ret;
 	}
 
-	*ppos = pos + count;
-
+	iocb->ki_pos = pos + count;
 	return count;
 }
 
@@ -221,8 +219,8 @@ static long tps6594_pfsm_ioctl(struct file *f, unsigned int cmd, unsigned long a
 static const struct file_operations tps6594_pfsm_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= generic_file_llseek,
-	.read		= tps6594_pfsm_read,
-	.write		= tps6594_pfsm_write,
+	.read_iter	= tps6594_pfsm_read,
+	.write_iter	= tps6594_pfsm_write,
 	.unlocked_ioctl	= tps6594_pfsm_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
 };
-- 
2.43.0


