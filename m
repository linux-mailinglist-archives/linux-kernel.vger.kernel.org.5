Return-Path: <linux-kernel+bounces-52634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C41849AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40079283EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03956210F4;
	Mon,  5 Feb 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytmQxFes"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12A1CA88
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137124; cv=none; b=D6hWrSoshId2LWVjc8brvdwIIDHQfFOnUPXknOHAl2SRJIpMsbr4j8godotFBOxCef5/N7CVDL3F+osXEZj//0huwfKLvVcGkyr/m4WPfpaCEiiOb26ui/S1qscqbZi7ByLnhly83lLDAYAulP22YW+7ekKZ+qxeLdIPeCqdMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137124; c=relaxed/simple;
	bh=F124QJAevKWdFhGb5sj8HrO8muyAjVQUMric9Xoo0PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpsO5JUk1GGwE34UBymt86e1kAyjkV/Hs3+ChQ+I9sLBN2N1jO+446PuIu5Lvyv3it/NbwZFyCE64ptn395yHu76wjTuuCv91Ylb7DmY7RJKuIMWqn+qsc+IFWS9MHF+TCmvMAqO41CnNd0Je9hKU6TJGPiI95WozdY479noHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytmQxFes; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33934567777so2926348f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137120; x=1707741920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOBjoaorUabw6V0kVhecCBVM+DqJR5V0WfMbUMGzKiM=;
        b=ytmQxFes1ArYQxU0/WAEZsWB7bHZI+JEABZFpFeehELiXjFZ7O+380widLKzXGvCN1
         wETkdeQnP++UbhJHoVYpz1ukzxR5f0BLpdGQZ1OaYolbrirexBCGp50q5up+HjOCLljT
         jLITSDjcWHXAa6SwKz6zeB23p8Io24BbY+69aDdJVW09pp2f360Kl9RwMANXd8wVVg0J
         O0SMmvvrAsNRZlR5bIWmYZRM1U3sKnyfqyMGGKnUI1vMHy+T++CBuLfSdL4O4u6mFSo/
         Pd0XGxJ9B3BQ7SWi7Grw5LRKJYUD5JDIBHh+j4MQRN3kaCbWqDIxCooaM3EgL0hkriqB
         8DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137120; x=1707741920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOBjoaorUabw6V0kVhecCBVM+DqJR5V0WfMbUMGzKiM=;
        b=Qxf3m7bHoQQ39PIWsS3ba/oGVxNCncn5SRtl5B4zDjnvRHbtlBRsiQKJJG12d4OtPU
         vqrS4Kt1sgSMH/T1yCN4oSueM/9At8XhWsIOJtBT8EfZeyheqUCrrNLgSO+4Er6wCB9A
         rKURfaSeE/ZrNUxqyQYxua2CMprv6yGIrkRx+PCGWrHzEUFX73v4SJt+9rbLEMoY5Vq1
         TlkaTUn00boskesZu8ZwDS9fXfHUNdgD5ZHiSWpTDBOzFXOLVL9/9yRC1lZ1VOMUma+0
         OYzFMmcgTVpGUx12dVwWAG4Yymt5DBPuBcdmrQwg8BZI53EeDCsCrOw8UV4KSI//+AJG
         FcRw==
X-Gm-Message-State: AOJu0Yy2vRs27aD+Z0uLX58ymwtM7y1LkOCXXNGkS1zZ9y9emKYqxh4f
	YC3BCHpexcAV4keS2BL81Uc15CU2dxAi2kKNjtQ40qtSr4VuI2Uj5i3uKBrYFPM=
X-Google-Smtp-Source: AGHT+IE/R//MpNPylh0UwnhF9YKZR3KGGY4fGA5i2/YHcwiL3Cuz8pM968aVwJ0sUeRb5fLUjg+zTw==
X-Received: by 2002:a5d:64c8:0:b0:33b:3b96:87b4 with SMTP id f8-20020a5d64c8000000b0033b3b9687b4mr2800257wri.14.1707137120374;
        Mon, 05 Feb 2024 04:45:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMfIKOUFnj98diFmwBJtthJx6XEcrlECRzI+G2PUYmp9a0qQk6FHpzoZ9Ia24ALKuUN657wE98H7tOGJZHXUA8msOETP4O6LwvEYPkhKFL0nxyBUrL5e2O8PpjE8+a4M9P11ukmFcNBgXZEa5aWKSANDzieilHAieWiKlkvLrl13nCFPWQDtoDpKen60XHXzT8GvyRKD0vD//k+Qg1LxdRN+OAWLXIj1JfNpuN7SLfryV6uFyeKnFgV3lAGAtE909omOuHJ5ZKKnCxJ33RwVeCOHVP1+ZoaQqjUzQ/CMVw80T4NvSdqgiC2OQow6M6qnGiei69Mp7y7alVSVZkJ1ldjTF35HcXRcoCWooaacUQTyzUzMuFslAV2REvXdO+IicsZi5ls10DblwKzyoM1PGP0iWzrmPzgE0Bol6vhVkkb80eWfLhYsJwxLAt+xlvddzVmWCt7BqPk4BIU9IpSbhTdg1EU/O/4BVSuH2MpZeYc7sOZdT093oW1fodyg==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:19 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 04/16] spi: s3c64xx: fix typo, s/configuartion/configuration
Date: Mon,  5 Feb 2024 12:45:01 +0000
Message-ID: <20240205124513.447875-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo, s/configuartion/configuration.

Fixes: 6b8d1e4739f4 ("spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c3176a510643..3df4906bba34 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -180,7 +180,7 @@ struct s3c64xx_spi_port_config {
  * @cur_speed: Current clock speed
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
- * @port_conf: Local SPI port configuartion data
+ * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
  */
 struct s3c64xx_spi_driver_data {
-- 
2.43.0.594.gd9cf4e227d-goog


