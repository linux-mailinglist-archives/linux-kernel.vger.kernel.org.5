Return-Path: <linux-kernel+bounces-58187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6A84E280
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7E0288C76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F5C81ABE;
	Thu,  8 Feb 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfDQL3PU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CF7EF0C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400269; cv=none; b=iVJ4tjUNVY7wUWIZLd+pOx7zKBhgATR1SwYKC3SyGHW9isx8VuiktYyO78wWIdaZvHzuULaYcLB7cPY+jULGUgYsGOFzmfbluTiJ/opDPBCAsjcQAa8ryxUQ8DwNPYq0jMULXRq+rpsyDY8aXLyNfYli5PrpW98jdiu7DutvAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400269; c=relaxed/simple;
	bh=QDMQ1KkcYtiV6MjOl7LHm4vYVsmfWSXZLbn40VwBYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqDLrnD9Y3TMpdYZBftGCv2AgfybpmMedniKc3StTaE4e0VaScGtj3HUncYW8nHencw5PY9htij7csQuC/xPEqjChQinhigtmlBvSqEHP8VYFsox5PCYm40TnAlmLlrlZ5H4liFkQPty0PCM7CitFE3asCnl4f6jJ4bG73yURCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfDQL3PU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4104ebb01fdso1355435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400265; x=1708005065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzqxKaIV5lycuIt7a1okhuIIh6nU9oeZCJpLQ+HKFAg=;
        b=MfDQL3PUQaKxfMJmVH5Lu7nQMEdxejTo9BdsdN0SGShXXgCtgCk8RpNeO/C7PeSkAR
         hdo3mfmUdNY+HRbQU3+Sr+Fmolc9dN9gnKbJuOopFyHksLUBYh1ytrOI3P/ZOXcN5Cm6
         gptbT43sdpVXufKe51qwZwCADuvyiM/6yuc1m+30/G+VfUll4TOljgKUuFB/nvCE15xD
         aoUwxyXsiSXu2GS/C1A5tljTIrVZFLGCus9KVt4cmV0q8iMHgPGyhWc+CAIpu8xX/8Dl
         FhvpGfqqqKKQMU1Oex2cSLstzDrtvNk47LacbwLWEmf70JlZz3N2RScpKsjzHVwBNeUV
         rENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400265; x=1708005065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzqxKaIV5lycuIt7a1okhuIIh6nU9oeZCJpLQ+HKFAg=;
        b=FpbfKTKWSbk35OeU/vYkltgXR3PtGcdWiLGaVzo0CXqmZfK934+lzgtXJC/4HN1Wdy
         NkWHBL/5/UPOJGcE5XtyPiDh5f1d/ERNXgf/rseTeva4WsrfpRLVoU59UXqF31p/fJVX
         CzhuzdxY7irPigjWWqxIRhhfF1p86XIqXT5OeWOrHOHXrZrRrLztLDTYJ9fZJtCCkv9w
         qFKLjXop+ZIiALtEa3MWaX58Kvsg4lDBljWLxDMjpOEQvaa2XZHpkP1QoDFsVAPOQFZP
         SQaJEjMZRXRlTdxJjb7FiAur7vAJ1mqKhdaMDFWXUy3x0TEx86n9faBkPCYTEFdQ8Ebk
         N+kw==
X-Gm-Message-State: AOJu0YwqByOo/sZbsBBu1IRjxpUVBYF65J2mMw+d1VJy74nnp/52Dv9F
	wb0BVrsh1tAr7GFmzq5/t6MuECoD1T4QIN/S0nal/2LeQNpaq117Qj18Cnok8XY=
X-Google-Smtp-Source: AGHT+IHWIjXxPYN55agE12/MHmkqXhHPtF1gnuJNIC45a25qfLfhPZOuIq3uWHUK5ZgGJZLOtFpkJA==
X-Received: by 2002:a5d:5915:0:b0:33b:5955:80f0 with SMTP id v21-20020a5d5915000000b0033b595580f0mr1256423wrd.21.1707400265049;
        Thu, 08 Feb 2024 05:51:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0g5/QpwgVtEE+r/3+XY/sOhedUizACmG5fdHi6VpzcVaBsZdi6cByCvkvZEIO3ZlW0QNef4727PNWVfQtjQwvDhW1c7sA99vH/Z4wwTJfAGNmblZzzuSb5q1yC1jSXHQrao9emy/77l6oVWMPbvObQWFw5cIycpm/owUy/H/OLpkobNFWm1Tdp2UGNHkPIKuUfDBsyzu1q+V+h2Po6cxe5dQg6Ey9ZfwkbiPLWeGHwq790T9/hORNfXtVSgPg7xruKOfADvxxggItqPiohmyoRw2tD+at0PCxH3cDmNPoNFdtNVIztl6r6NNnfrPF9Y92iyFO45RpqCJnP29SiuJpMeDHDKEAbSvSS4AU3KpJIgxSXAJh1Tr+JElVQPaoy6dOKTzOK4pxZ4GVRbY8TZw/DGqD2AwryQvg03FXsJ/JJEvGj6gjeubnozOKzfLoMLQkMQyIg+pb6LKH1p8oOu8MqhFOj4OdBhwIrU9arwKijcC+edxb7O/eeQSqi4JZOXhe00lwMdT1ff2sGKJeafo8ZB7xqb87ZyxkBCNjSrnQj2qLYnNbWnlUQ+6Qn4R09EPNXTrnFq0pwZaYpt4WSS6DvZBxu/ey/S2MWvhLuQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0033b43a5f53csm3618820wrh.103.2024.02.08.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:04 -0800 (PST)
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
Subject: [PATCH 12/12] spi: s3c64xx: switch exynos850 to new port config data
Date: Thu,  8 Feb 2024 13:50:45 +0000
Message-ID: <20240208135045.3728927-13-tudor.ambarus@linaro.org>
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

Exynos850 has the same version of USI SPI (v2.1) as GS101.
Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
config data.

Backward compatibility with DT is not broken because when alises are
set:
- the SPI core will set the bus number according to the alias ID
- the FIFO depth is always the same size for exynos850 (64 bytes) no
  matter the alias ID number.

Advantages of the change:
- drop dependency on the OF alias ID.
- FIFO depth is inferred from the compatible. Exynos850 integrates 3 SPI
  IPs, all with 64 bytes FIFO depths.
- use full mask for SPI_STATUS.{RX, TX}_FIFO_LVL fields. Using partial
  masks is misleading and can hide problems of the driver logic.

Just compiled tested.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 784786407d2e..9fcbe040cb2f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1576,10 +1576,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
-	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
-	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
-	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
-	.rx_lvl_offset	= 15,
+	.fifo_depth	= 64,
+	.rx_fifomask	= S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
+	.tx_fifomask	= S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
 	.high_speed	= true,
-- 
2.43.0.687.g38aa6559b0-goog


