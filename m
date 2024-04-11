Return-Path: <linux-kernel+bounces-141173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99448A1AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755FB286909
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B851F6F20;
	Thu, 11 Apr 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fKF5wFrG"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7C1F63DB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850158; cv=none; b=aFQQqTvhOJzA4xCGpyg7s8llpTJVKHunb1kBRCockMsNmpz87A6vqoxse8aeALWw+TeLX6rYMqUzq/U8+SpnHZ8BoCvoEPnudsTk8Lvg7C5WiLq4XIx1Fp7dJfWTZQzXl8S+KQ2jCYNgAUkqTRJlN3x5pjMghPuPd5VSqmH/Sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850158; c=relaxed/simple;
	bh=Krw1Ns7wi8zJor2Df5ARSAp4IQYoYJJxomXQfbnDxyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfHwBknn8nkyZuMfLJJnA9A8dj5x/hpIz+6OXcbtqL/qwiHqHmptnJwfZQG1NHhKgRnhVCXqYuREHeiJg+fwCUCW6ZdcLg3hlvSf7o6crYayz5U+m2DQJzsDR7yWHk1kmQT++fwEXEIL9WeuOsDnELPlDQs6Tb57+t8nHBRaNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fKF5wFrG; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16258139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850155; x=1713454955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmPFlEE8wKBJ/+R6tyQqzbhRstdo6mylHM1eVnipaiY=;
        b=fKF5wFrGBioUVbgrc6hHEkM4MZjGdX76vgaRKbcRDOtABEE9dzmaQF270fb1an7/1d
         pcCdvjk3HL/De5xubKNUVfADfS5k7tJhUf41j9qO4nndmJr/TpP1N8uYZqsETdCC/5Oc
         mblP/48pGIJKCY/3cVCcG0MGoGi14Ac9sWC25eti77hjJ2WKSeaWj0tmEXNjp5XUt7k7
         3X9DiI9XMMFQNAu67TA7VUHVxBR0RLAXV5TgNUEftVIq5eNCQky3PLuio8lobxijtzDe
         KozOGOHYECVRq4GvG/C2/+/NT2sdFdvcYdAIp1S6pf+Afo65v+qNr96wtC1r2bX/hCtr
         8vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850155; x=1713454955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmPFlEE8wKBJ/+R6tyQqzbhRstdo6mylHM1eVnipaiY=;
        b=O7LVCUY6NHrntInu3h/0/d1AfIdzxfyAqmoKN8raV2zUYojSQtgnm3FpVXXa/RoODx
         WTHC2DNl1KU3mMqRFUNJUiR36ER2QUUKe3Ry7QTFNxJoyBhXlWapjOsaG6E4yF+JHqCm
         kTgfaSYqXbqkIqBuSOWJ15zpSBO5K+hiRspt7pUxtVmKeIPX8enydRIcuKzAj7MEpTYz
         mAcEOS9h3OLrlyx+IqEj6aSvy3MjnTgFP7hXiorg4+If5wf2OHghQiPmH2CQW/DgDI5V
         5j6TdrzNOWIbNHuFP0x1eInvT0ViWlH9pt1N/+4k5yklezi9QizAy1n6x95cX0cRmiL1
         d8OQ==
X-Gm-Message-State: AOJu0YyWpTNE0kbXYez1YMY3quxHEco9wj32n1BdGk8i0xU8Xg5uCNvM
	D6nKz0tQzky3cVi4rOG93xQk9ZvwFOT1+bgKbJ08URSE6OldTKlkE/evt/pI06sWGbP9jGdP+cg
	3
X-Google-Smtp-Source: AGHT+IGJilTeYdSv9yr1oLT8yaMZGUBZMSBDkCbo6RGHNuk8vGtfNkJYB/pd40mYdTHr60X72muV3Q==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr179128ioh.1.1712850155457;
        Thu, 11 Apr 2024 08:42:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 390/437] EDAC/npcm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:50 -0600
Message-ID: <20240411153126.16201-391-axboe@kernel.dk>
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
 drivers/edac/npcm_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
index 2e2133b784e9..54a756db7d67 100644
--- a/drivers/edac/npcm_edac.c
+++ b/drivers/edac/npcm_edac.c
@@ -195,13 +195,13 @@ static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static ssize_t force_ecc_error(struct file *file, const char __user *data,
-			       size_t count, loff_t *ppos)
+static ssize_t force_ecc_error(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct device *dev = file->private_data;
+	struct device *dev = iocb->ki_filp->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct priv_data *priv = mci->pvt_info;
 	const struct npcm_platform_data *pdata;
+	size_t count = iov_iter_count(from);
 	u32 val, syndrome;
 	int ret;
 
@@ -261,7 +261,7 @@ static ssize_t force_ecc_error(struct file *file, const char __user *data,
 
 static const struct file_operations force_ecc_error_fops = {
 	.open = simple_open,
-	.write = force_ecc_error,
+	.write_iter = force_ecc_error,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.43.0


