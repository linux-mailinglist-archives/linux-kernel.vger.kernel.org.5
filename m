Return-Path: <linux-kernel+bounces-58183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2163084E274
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A881C25599
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686BE7869D;
	Thu,  8 Feb 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOWFEBKt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55667C0AA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400264; cv=none; b=NV6rmGosCG3vcsR4QPhCc/Yhci7ueH2rBpolfJsWkeVCC46EwPBNrGHV7JR2NSzykxbx/GOC+6pRFO53WWbjdKg+hR03qcMCAaWvyiGosbvAkaIzbSlnlyoVkUKAN+tO058eb/0rDALixkxecIToKpBrYnp4vzQqc2sLlEuR/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400264; c=relaxed/simple;
	bh=/J3HSWrt3Z+UiY24EU4Lkl8TbqvMM7ckFq18eXIR03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8ceal5VBA8bD2ZnLFpWd2VQaoRtKDEKFtG7irGBHY6a531VbWxeJpNHUv41UBn1vv+/TtPnTMIUCYC2ujWLpdSgI2LB3QXrih7TCmaiclbESyYBW/qsWSm1pSQIBVUdtv6qVm2GGA/BM37jnDjAaEON/0UuNW1gIlYFxGqrV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOWFEBKt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso15494935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400261; x=1708005061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTrzZqM2Ss1d3JLf/TDWyYpLJTs2h0kZukw/0ZYCnhU=;
        b=AOWFEBKtmCNnP73GOWO14AeICHHw+5K4Xlgb7WOf2FwwrHq6bYAQ8s+HM5/2NVeq0x
         B8pY2PAYPH6BZVeqXP2dEHrOA9uElm/8a4INmaDe5rrr4XupZfJh/vPilxiSSx+pKpVm
         S6D4J4QfLPMIQsEePklexqJQhf+LfVREs37c/1xLeij/uS+n06Zjimwye+mfM1p4Lme4
         Kk7OIaygVZxvlCMu1qxxU6LBtEpB3pZkHb8DqnloEvG1HsFnwpkUlbUutukY3IeMIVK3
         6kQO0hi/INQFXWs7eV4nBQblTa5kwNZszX1IWyv+F+xneyy/ZMgmb9ory+RBbF7b7l+k
         ojbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400261; x=1708005061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTrzZqM2Ss1d3JLf/TDWyYpLJTs2h0kZukw/0ZYCnhU=;
        b=t0ACckGmevVh6NZCeTByFYACWt/FLLs1QgRv1uUpUcAAES4LnpDMWA6MbnlMRNoGNl
         JqNCdWX/9XRVRjnL1+1Qhn8UpgxosgHnJEZYPN8O8wMVgAr6UTcxxuOpNZ5+rM/H846D
         ZKzzhnO+tce3ag5EBbZHTdOg7fWWpYrwnDRJqz2qkuwEn/7bfg9+puDeCDpQQU3A7Awx
         C/7w6pE727Kc98oQ0u3JNikDzFf4QCsa87va7k4uo0fnMey7g5uVijKnzQAcYguut9nd
         Bqb9PiVw7jLsOiK9hbKbGiFAz5oMywO0/RJhy47Qb2/U7jhN8uf6txWFq9AQTDqmgWVt
         E7qA==
X-Gm-Message-State: AOJu0YzyvL4tG1lzyuDszMarBEHmc2NfFjnBIr3lXg1r7iIPTEK5KQE6
	UB4o+3ATNafOw4A7y4tXOzhmClsaDEcwwVczBO16VnMBInk1h1KI2kLbrZschgs=
X-Google-Smtp-Source: AGHT+IEpidkG45WmfZvuFMnrxsVSXR7LI0UC41cWzvbh2d2Eheo4t1hW0x6R6eZdtc1eGmjIP418HQ==
X-Received: by 2002:adf:f712:0:b0:33b:464c:b121 with SMTP id r18-20020adff712000000b0033b464cb121mr6036997wrp.46.1707400260797;
        Thu, 08 Feb 2024 05:51:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBNww5u+ytPqRMgubANLFg/lV2GW44VntPtG++rsQqS9Ga9gfisZYLmloiKaXHsjGnhx+LJXbvQLxJ/jxWFS/sXnaqu/ssBaiHL5T+tJTPQJON6KpL0WtJH3alQalJGi66avPxff7Hq0/6rPcbv7YluUzDBPTKzID919DmmNXoo8lMLRALRuh95yRl0aSd7ebRXWXpy3rd5cl3nGuar4i0RkAJHPxVbSmKxafbrnFAL7piMe7A5s/b3MD9c2sVrncMsDfG0iWMqWzuDdPNZtu/1JAiiO2t3qZkGG79vS6fB7yimb643c4RBCeQa6q9k4ZpuBGzfdpBAK/bAVnqvbqqVUjBj71HkXG1wZ1KR/TbBJ+6J0SBlfiuGnRsN5Cy6U7C1pc3aFlUuFWHRvUpQL+uhk8panndLWd+55Jo7qgZz+cnwfIhxzpXskacqoKBiUAMYv3Td7RzaNvufVqJzUFfNsUox1n8Hb1NT+iFtr87tiewTX7Vhq/M3/418XLZhpr+cCYmldhbO+gFhWAzBiTbIa5f77F3bB/oKMjl6SUuBFHPKUArvMHlKh3Zr3vL9OOZmgUJ9hGTOtvoIEvXrSSqFd1wxThKej5JXXTFIQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0033b43a5f53csm3618820wrh.103.2024.02.08.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:50:59 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
Date: Thu,  8 Feb 2024 13:50:41 +0000
Message-ID: <20240208135045.3728927-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare driver to get rid of the of alias ID dependency. Split the
port_id logic into a dedicated method.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ac47755beb02..40de325bd094 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1200,6 +1200,27 @@ static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 	return (const struct s3c64xx_spi_port_config *)platform_get_device_id(pdev)->driver_data;
 }
 
+static int s3c64xx_spi_set_port_id(struct platform_device *pdev,
+				   struct s3c64xx_spi_driver_data *sdd)
+{
+	int ret;
+
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "spi");
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to get alias id\n");
+		sdd->port_id = ret;
+	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
+		sdd->port_id = pdev->id;
+	}
+
+	return 0;
+}
+
 static void s3c64xx_spi_set_fifomask(struct s3c64xx_spi_driver_data *sdd)
 {
 	const struct s3c64xx_spi_port_config *port_conf = sdd->port_conf;
@@ -1252,18 +1273,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->host = host;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
-	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "Failed to get alias id\n");
-		sdd->port_id = ret;
-	} else {
-		if (pdev->id < 0)
-			return dev_err_probe(&pdev->dev, -EINVAL,
-					     "Negative platform ID is not allowed\n");
-		sdd->port_id = pdev->id;
-	}
+
+	ret = s3c64xx_spi_set_port_id(pdev, sdd);
+	if (ret)
+		return ret;
 
 	if (sdd->port_conf->fifo_depth)
 		sdd->fifo_depth = sdd->port_conf->fifo_depth;
-- 
2.43.0.687.g38aa6559b0-goog


