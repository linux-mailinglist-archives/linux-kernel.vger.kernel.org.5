Return-Path: <linux-kernel+bounces-79609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0BD8624AE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5674CB21852
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72CE44362;
	Sat, 24 Feb 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuVkbI/f"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2D3F9D4
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775152; cv=none; b=mYZ7ndDyFABaZZOzfi5d8sA4FGdAAtgpkTV3aKYCooYXF6MbTLtjIpiDZW82xStmVPgYcY1GK/mSERD1O5b/RnrayA/NOwj9KtX2lYJ9ymVqMhTq81IEdj+S3zYTefSB82W8bfAelQiilAfnmQtbUKcfUoh0L69DfVh32u/RKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775152; c=relaxed/simple;
	bh=LBYbJJcKNkovxCNxqMFmQnZVJ0MhhcOaMIIez5oaN/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUokQgrWDc7nk5gKa6pp6vm3C8lh0VURq7Q6MvX3T2+n77k36Rp2PxyItxe38LyQAqa27JE/FdQzZ4DIFMy865VFwjdf0F6dp6VoGiLo2+/MOYqWnHO710+ORvbJz0MFf9o0kSsUvqDidWnME9T5BmY8QrtSpC0nXLhNl5YJFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GuVkbI/f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e75e30d36so319555566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775148; x=1709379948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mR91Nlk8bU7hN1mKQvT/jofMFqB5jMPs1+IzmpRfSw=;
        b=GuVkbI/fjSAXY/O+/Wkp5ShwKRPx8j2PanpK8m/lK8FLdfR93EAlF5oC75ss2vKKyL
         Atx5DiHRPqS5MGcqgVgchZbAzDpvEy7a7RfO3CcfMhXUiVrtSjwkWzu4Z28KnPOYLN+h
         xlKnuNxkC7dsfrSJ1PDjO6X+96mO3PzZOPgzSgJJkTpecIVDWpVHZVabYIEwPjxwMV7U
         /XM2DTIjaez9ynCn34LB6mErhRkJpxGLrv45/P4auRcYaFhHDSK5f5A0qzfbQWA8o0mR
         6bs7q04auqpN8/LYSFQhRd6RK+R12OJ7uhDT0O/70yR9+WxCVVOIBb8kw275Ew3JJn2p
         Xydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775148; x=1709379948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mR91Nlk8bU7hN1mKQvT/jofMFqB5jMPs1+IzmpRfSw=;
        b=UKDLN0g2Z9gFxA/tBZHZR7uQj0Gc22GWV5KXZzacumKJ15VA0gnNbKjAN7cNBPHl1z
         Isj5oPRYvJGlIuZVoDVgR4rfQw98ejlRm+uO4h8dd9vOabjYmPA1ZYBZfGNtW+0BdSE2
         h0kJsUlVHEKuOJsGmkfDSEFPkqYLlbfg/5Q31HwqiTTfAHLfcrlPWA0IyIP4ZoZ658gR
         5kTaqwC4JQbIAzteuq/hQLpygGTAJdN7J0sLGzY2nrURglV4KG3lrGp0NFnQ2lchUZv4
         WoqIN8CRxGI7CDwSjpbUTQRXZQwdtUwoqIhg3Dy1W+UHRnjx7+0qY+PDHYpCyH/Les+4
         470A==
X-Gm-Message-State: AOJu0YwufAth07UWmM3NIWYZ2k/xEk+6fkLefgDVjxj8D7JEP+azwiGL
	Cr6y8gdHEFCyuuDdpLdJz5ADZPYs057ZwujzhHhS8b0IMcqZxeVGdxcBDNr4uyo=
X-Google-Smtp-Source: AGHT+IGjxNzgWdBFt5aeuD4+4+BjQWvnRAhU55i8TgSI08FiXYgOuTbPsxjtLH6gFKSzuTkeVMItVw==
X-Received: by 2002:a17:906:718d:b0:a3f:8dea:85f7 with SMTP id h13-20020a170906718d00b00a3f8dea85f7mr1958294ejk.15.1708775148504;
        Sat, 24 Feb 2024 03:45:48 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:48 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Kalyani Akula <Kalyani.akula@amd.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/11] nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
Date: Sat, 24 Feb 2024 11:45:11 +0000
Message-Id: <20240224114516.86365-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=P2cGF0VtfcCt36gLWA03f5z+B2HP6m3MQtEOR09ei5k=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLtUXHVO3V0pwG/elzGVXwkjhsvd+/Oq7tJ sXVBhpvAyeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N9SQB/4v0TpoIJ/h4H9frZHRj07Cv7m/Xs4KHhUbSNlOiTTOqlDYYFwliOI5GYjjEbFAiPZI8ce k/wToFqt2g88Ezdg1SB9soMp+tQEvJ3vqSkCFTm7vqUFZcBL52mVbh42O+HK0JTrLkUsDqTuYN8 3F+ljhIIXWfx6pim4kXdR1rXv9HBrIUkajLy/4tToHCgmz9HpmcvEOp6U8gA96duF8M54LTxEly klKtR5hqwaZCX21dy8owqvYwfcK6pzBAQBBn+xuwcu/XZA7hNc2PoX6OrBPtspaBFHH9Gbg/0Sr 0L0/CVx2v7Y9wDaDTTgmHCWXGW7YzSKS1uTQiCSNYPAikHOS
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>

- Remove static nvmem_config declaration
- Remove zynqmp_nvmem_data

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Acked-by: Kalyani Akula <Kalyani.akula@amd.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/zynqmp_nvmem.c | 37 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 7f15aa89a9d0..391d8e88b270 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2019 Xilinx, Inc.
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
  */
 
 #include <linux/module.h>
@@ -11,36 +12,25 @@
 
 #define SILICON_REVISION_MASK 0xF
 
-struct zynqmp_nvmem_data {
-	struct device *dev;
-	struct nvmem_device *nvmem;
-};
 
 static int zynqmp_nvmem_read(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
+	struct device *dev = context;
 	int ret;
-	int idcode, version;
-	struct zynqmp_nvmem_data *priv = context;
+	int idcode;
+	int version;
 
 	ret = zynqmp_pm_get_chipid(&idcode, &version);
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
+	dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
 	*(int *)val = version & SILICON_REVISION_MASK;
 
 	return 0;
 }
 
-static struct nvmem_config econfig = {
-	.name = "zynqmp-nvmem",
-	.owner = THIS_MODULE,
-	.word_size = 1,
-	.size = 1,
-	.read_only = true,
-};
-
 static const struct of_device_id zynqmp_nvmem_match[] = {
 	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
 	{ /* sentinel */ },
@@ -50,21 +40,18 @@ MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
 static int zynqmp_nvmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct zynqmp_nvmem_data *priv;
+	struct nvmem_config econfig = {};
 
-	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->dev = dev;
+	econfig.name = "zynqmp-nvmem";
+	econfig.owner = THIS_MODULE;
+	econfig.word_size = 1;
+	econfig.size = 1;
 	econfig.dev = dev;
 	econfig.add_legacy_fixed_of_cells = true;
+	econfig.read_only = true;
 	econfig.reg_read = zynqmp_nvmem_read;
-	econfig.priv = priv;
-
-	priv->nvmem = devm_nvmem_register(dev, &econfig);
 
-	return PTR_ERR_OR_ZERO(priv->nvmem);
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
 }
 
 static struct platform_driver zynqmp_nvmem_driver = {
-- 
2.25.1


