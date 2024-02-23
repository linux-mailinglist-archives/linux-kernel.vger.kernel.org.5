Return-Path: <linux-kernel+bounces-78924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBCD861AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F130289281
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AE1419BD;
	Fri, 23 Feb 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CsJ3ajGP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA82142626
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710690; cv=none; b=Voo9Q9BWxX693yzMSV+A/pz+QIIg0Aq+v2KEpSBXws+RiCtSvbxxz4LrzyBi7CkZLisQ9BmKrgbvlWkPSwDgLJgPsQo7govJoJAkCm6mrnSlVxZnd4jb+t5P13kRclyB4eDwfxNxxIc+xyng70BGTsKCxSZKP7N38IBqt9jz690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710690; c=relaxed/simple;
	bh=pW74uAnucYIjrEPj94jKbVgAMVavsh0mwkAjnRlWePk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be5VzkcKyXQy7qU/Av0ahPaq/hYcKIWB2rRpFu9hjxTiHpwC5ShsgiDWttnHN6q9x46DPOoywYdRPQTfmZQ/rm/yRvwhrnQsD2pBCPQ8m5Vz8f+m0uNaeCztZQtdM9H3D3esIZ8QDAKKLEHHsYzwgw12A6Av1ESXiXQJNhbzX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CsJ3ajGP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41297377abeso3554805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710686; x=1709315486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1/AGt7uLQCyc0DA39X/n7sIWq1BnWpXSGWjqPrX0bo=;
        b=CsJ3ajGPB+VQVC9TwpcSlmfeDvFytb/2AaMFB67ILplgdT0R1hwZ9O8AN3DYRWwiuO
         T0fMY1hiIf+ReJHt/0tc9gSIiGQGSpiB+iZ8jFdaKn4yLzlWygUx2CkzOVRyBMeUbakC
         NMRdZhS5BaGx3FnlJeL1qY8bHaROUOZsiyqUzHH1DYxBIDzgupJ66JF/SSAd3u31FzQY
         ZFRyqPktLwUmZTlezffYqyG29GQUr1qKG5+Y1XpddqQUPvc4jV/PEhBn+SAamPKYNeH1
         0cPd5ZghX15tPEnPOjs+JLYKpt3BJNlV2UJh4C1LAbMLdAxAG65OVr8+gqGOiDch6DCx
         MF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710686; x=1709315486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1/AGt7uLQCyc0DA39X/n7sIWq1BnWpXSGWjqPrX0bo=;
        b=C6HcN5Q8BZTKf9ogYU6xHubQ7kA3Of7NS/+aClLVG2QsJEraPIt/Ni4cw/NKVfp6JE
         13Pypp/x0WvcTzab61hidG+TlzRvkkvaevcXm2p+31swxSodabd7WvrVb/Y2otVJxGC0
         /hY/FZ0nA0jFaZ2rWwfV4V2l64Oho6q17R10oX/VR0ckc1TLxsHWSUexM5H9aLC/D0SI
         yONlWa6q+DJHgL2hGaZvcUu9EnfMLk07fDJHS+31MYo/tkKAh55pDdbpMNk7izJ9v7CV
         umKB9TsLKYDtopgwIDQr5yRya02QE5dNn3Kvicn1757zHf8cAb1ESwA2NwXicSK3H0LQ
         XTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUja0ohKrWmJJOSf7AwYDF5/YdY5vHHG77Gm38mLU+KMcWId5HpPUqW22LBZf22dNK9JWHKvPdqPT+3mepxRe/QkjAywBtZxaYQHK7F
X-Gm-Message-State: AOJu0YyV0NlIsehf+WD9G7p/MOZgqpT9nGBaaHuCqRPr0Ah3b1U8YdTz
	/Jlpa+bxbF8GGgbH7mtd2NlBVThoE7ll/KkRX4gXIBLIcJHKqTKaEaWMkZXi/oY=
X-Google-Smtp-Source: AGHT+IEPePMtPPf0gbB3B54/1cOa4I+uIJLCY5NUhl4hsQw9fY1wMXdm9tzTlTtsJfibzdZNlwi3Gw==
X-Received: by 2002:adf:f984:0:b0:33d:b2d6:b3a6 with SMTP id f4-20020adff984000000b0033db2d6b3a6mr300283wrr.48.1708710686707;
        Fri, 23 Feb 2024 09:51:26 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:26 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 6/6] ASoC: meson: axg-fifo: use FIELD helpers
Date: Fri, 23 Feb 2024 18:51:12 +0100
Message-ID: <20240223175116.2005407-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223175116.2005407-1-jbrunet@baylibre.com>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Use FIELD_GET() and FIELD_PREP() helpers instead of doing it manually.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c  | 24 ++++++++++++------------
 sound/soc/meson/axg-fifo.h  | 12 +++++-------
 sound/soc/meson/axg-frddr.c |  4 ++--
 sound/soc/meson/axg-toddr.c | 21 +++++++++------------
 4 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 65541fdb0038..597fd39e6e48 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -145,8 +145,8 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 	/* Enable irq if necessary  */
 	irq_en = runtime->no_period_wakeup ? 0 : FIFO_INT_COUNT_REPEAT;
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT),
-			   CTRL0_INT_EN(irq_en));
+			   CTRL0_INT_EN,
+			   FIELD_PREP(CTRL0_INT_EN, irq_en));
 
 	return 0;
 }
@@ -176,9 +176,9 @@ int axg_fifo_pcm_hw_free(struct snd_soc_component *component,
 {
 	struct axg_fifo *fifo = axg_fifo_data(ss);
 
-	/* Disable the block count irq */
+	/* Disable irqs */
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT), 0);
+			   CTRL0_INT_EN, 0);
 
 	return 0;
 }
@@ -187,13 +187,13 @@ EXPORT_SYMBOL_GPL(axg_fifo_pcm_hw_free);
 static void axg_fifo_ack_irq(struct axg_fifo *fifo, u8 mask)
 {
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_INT_CLR(FIFO_INT_MASK),
-			   CTRL1_INT_CLR(mask));
+			   CTRL1_INT_CLR,
+			   FIELD_PREP(CTRL1_INT_CLR, mask));
 
 	/* Clear must also be cleared */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_INT_CLR(FIFO_INT_MASK),
-			   0);
+			   CTRL1_INT_CLR,
+			   FIELD_PREP(CTRL1_INT_CLR, 0));
 }
 
 static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
@@ -204,7 +204,7 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 
 	regmap_read(fifo->map, FIFO_STATUS1, &status);
 
-	status = STATUS1_INT_STS(status) & FIFO_INT_MASK;
+	status = FIELD_GET(STATUS1_INT_STS, status);
 	if (status & FIFO_INT_COUNT_REPEAT)
 		snd_pcm_period_elapsed(ss);
 	else
@@ -254,15 +254,15 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 
 	/* Setup status2 so it reports the memory pointer */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_STATUS2_SEL_MASK,
-			   CTRL1_STATUS2_SEL(STATUS2_SEL_DDR_READ));
+			   CTRL1_STATUS2_SEL,
+			   FIELD_PREP(CTRL1_STATUS2_SEL, STATUS2_SEL_DDR_READ));
 
 	/* Make sure the dma is initially disabled */
 	__dma_enable(fifo, false);
 
 	/* Disable irqs until params are ready */
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_MASK), 0);
+			   CTRL0_INT_EN, 0);
 
 	/* Clear any pending interrupt */
 	axg_fifo_ack_irq(fifo, FIFO_INT_MASK);
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index a14c31eb06d8..4c48c0a08481 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -40,21 +40,19 @@ struct snd_soc_pcm_runtime;
 
 #define FIFO_CTRL0			0x00
 #define  CTRL0_DMA_EN			BIT(31)
-#define  CTRL0_INT_EN(x)		((x) << 16)
+#define  CTRL0_INT_EN			GENMASK(23, 16)
 #define  CTRL0_SEL_MASK			GENMASK(2, 0)
 #define  CTRL0_SEL_SHIFT		0
 #define FIFO_CTRL1			0x04
-#define  CTRL1_INT_CLR(x)		((x) << 0)
-#define  CTRL1_STATUS2_SEL_MASK		GENMASK(11, 8)
-#define  CTRL1_STATUS2_SEL(x)		((x) << 8)
+#define  CTRL1_INT_CLR			GENMASK(7, 0)
+#define  CTRL1_STATUS2_SEL		GENMASK(11, 8)
 #define   STATUS2_SEL_DDR_READ		0
-#define  CTRL1_FRDDR_DEPTH_MASK		GENMASK(31, 24)
-#define  CTRL1_FRDDR_DEPTH(x)		((x) << 24)
+#define  CTRL1_FRDDR_DEPTH		GENMASK(31, 24)
 #define FIFO_START_ADDR			0x08
 #define FIFO_FINISH_ADDR		0x0c
 #define FIFO_INT_ADDR			0x10
 #define FIFO_STATUS1			0x14
-#define  STATUS1_INT_STS(x)		((x) << 0)
+#define  STATUS1_INT_STS		GENMASK(7, 0)
 #define FIFO_STATUS2			0x18
 #define FIFO_INIT_ADDR			0x24
 #define FIFO_CTRL2			0x28
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 98140f449eb3..97ca0ea5faa5 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -59,8 +59,8 @@ static int axg_frddr_dai_hw_params(struct snd_pcm_substream *substream,
 	/* Trim the FIFO depth if the period is small to improve latency */
 	depth = min(period, fifo->depth);
 	val = (depth / AXG_FIFO_BURST) - 1;
-	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
-			   CTRL1_FRDDR_DEPTH(val));
+	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH,
+			   FIELD_PREP(CTRL1_FRDDR_DEPTH, val));
 
 	return 0;
 }
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 32ee45cce7f8..5b08b4e841ad 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -19,12 +19,9 @@
 #define CTRL0_TODDR_EXT_SIGNED		BIT(29)
 #define CTRL0_TODDR_PP_MODE		BIT(28)
 #define CTRL0_TODDR_SYNC_CH		BIT(27)
-#define CTRL0_TODDR_TYPE_MASK		GENMASK(15, 13)
-#define CTRL0_TODDR_TYPE(x)		((x) << 13)
-#define CTRL0_TODDR_MSB_POS_MASK	GENMASK(12, 8)
-#define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
-#define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
-#define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+#define CTRL0_TODDR_TYPE		GENMASK(15, 13)
+#define CTRL0_TODDR_MSB_POS		GENMASK(12, 8)
+#define CTRL0_TODDR_LSB_POS		GENMASK(7, 3)
 #define CTRL1_TODDR_FORCE_FINISH	BIT(25)
 #define CTRL1_SEL_SHIFT			28
 
@@ -76,12 +73,12 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 	width = params_width(params);
 
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_TODDR_TYPE_MASK |
-			   CTRL0_TODDR_MSB_POS_MASK |
-			   CTRL0_TODDR_LSB_POS_MASK,
-			   CTRL0_TODDR_TYPE(type) |
-			   CTRL0_TODDR_MSB_POS(TODDR_MSB_POS) |
-			   CTRL0_TODDR_LSB_POS(TODDR_MSB_POS - (width - 1)));
+			   CTRL0_TODDR_TYPE |
+			   CTRL0_TODDR_MSB_POS |
+			   CTRL0_TODDR_LSB_POS,
+			   FIELD_PREP(CTRL0_TODDR_TYPE, type) |
+			   FIELD_PREP(CTRL0_TODDR_MSB_POS, TODDR_MSB_POS) |
+			   FIELD_PREP(CTRL0_TODDR_LSB_POS, TODDR_MSB_POS - (width - 1)));
 
 	return 0;
 }
-- 
2.43.0


