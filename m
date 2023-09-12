Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925779C5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjILE4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjILEzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24ED26AC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502a7e1bdc7so4711394e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494392; x=1695099192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPzDfgS0m67yk3NBORH6P58ZJVJyMAJ/Dphs2EJDyuo=;
        b=AamAtubrUVA7kk2x6EsegL6aKzOIzfBTgRkEtun2BKeb/mDtz1WdLNItfVcrwn6bEo
         Z2V8gf8z6zuvdudrjzw4IzLxatlMtLg6leHlVYN21NUNNpu+eud+lSUTexpP/wcQGphv
         ISwsiB7XcyWyj/sEzO5SYzVPzVteNHrFhaMAsFwMoBVYi+LEPk7idKOpee1cPWk+steS
         1kgPDJtd3RTTCK0itWPWknDvGV5Hqenn/4p5vh3jS+TIo5t+Togju5b0G4+KceMRQSTC
         yvCCFO8X1kabIX45YbYrYZ4mhX6lTzorGxC7yIYwvVJ7rKNL0K+jDwqXRDbnuiT6a0nv
         AsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494392; x=1695099192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPzDfgS0m67yk3NBORH6P58ZJVJyMAJ/Dphs2EJDyuo=;
        b=m7EJLkBKBh0P9w9qKj0lbBCC9GEiZ72i3pW+lrwa9nMNdvKGMiIu98N3S5KqfVK/RC
         JT3mmJb6295CKF8QHaYfPP9hYoXwz05o6fEOys8MhkpKJlEJQ0QF9103/7H5YLNhJvwu
         s+n8I5sa066gLH233Qt51m53LuO3u7O6O2r54M362epnFYGG5oyADS+rB3D4dSRcMP8k
         2cHpWbSypDu1TaafPBC20Kyi+7t+T0GEt7jBEV95IAXB6960lqkOJHDcrn2N8xHQQ5th
         KKeztRO/cUVTA1bNHIuDK6cziBYkt3Mo0xpNK6aM38t0RqZ5saCaSojKp0Pw/BehOqjh
         RiNQ==
X-Gm-Message-State: AOJu0Ywy44S79hFCjYHkmgms9o0tVCTMDktdxII46k0dh7uL6cwFSXu+
        UojYUZkT4zj4ZkOb0NPTkRWfog==
X-Google-Smtp-Source: AGHT+IHQMo5E3dklyI4K8s4HoUsPQM7WiC1IBtX0UieZR++XPmL4ZlOQncT47bKkUM+C5dVlGwNQMQ==
X-Received: by 2002:a05:6512:3189:b0:500:b0e8:a899 with SMTP id i9-20020a056512318900b00500b0e8a899mr10424630lfe.30.1694494391909;
        Mon, 11 Sep 2023 21:53:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:11 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 27/37] pinctrl: renesas: rzg2l: add support for different ds values on different groups
Date:   Tue, 12 Sep 2023 07:51:47 +0300
Message-Id: <20230912045157.177966-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S supports different drive strenght values for different power sources
and pin groups (A, B, C). On each group there could be up to 4 drive
strength values per power source. Available power sources are 1v8, 2v5,
3v3. Drive strength values are fine tuned than what was previously
available on the driver thus the necessity of having micro-amp support.
As drive strength and power source values are linked togheter the
hardware setup for these was moved at the end of
rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
values.

The drive strength values are expected to be initialized though SoC
specific hardware configuration data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 345 ++++++++++++++++++++----
 1 file changed, 294 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 1277bb26069c..d90ff5ea356d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -55,6 +55,8 @@
 #define PIN_CFG_FILONOFF		BIT(10)
 #define PIN_CFG_FILNUM			BIT(11)
 #define PIN_CFG_FILCLKSEL		BIT(12)
+#define PIN_CFG_IOLH_C			BIT(13)
+#define PIN_CFG_SOFT_PS			BIT(14)
 
 #define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
 					 PIN_CFG_SR | \
@@ -133,27 +135,40 @@ struct rzg2l_register_offsets {
 	u16 sd_ch;
 };
 
+/* Value to be passed on drive strength arrays as invalid value. */
+#define RZG2L_INVALID_IOLH_VAL (0xffff)
+
 /**
  * enum rzg2l_iolh_index - starting indexes in IOLH specific arrays
+ * @RZG2L_IOLH_IDX_1V8: starting index for 1V8 power source
+ * @RZG2L_IOLH_IDX_2V5: starting index for 2V5 power source
  * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
  * @RZG2L_IOLH_IDX_MAX: maximum index
  */
 enum rzg2l_iolh_index {
-	RZG2L_IOLH_IDX_3V3 = 0,
-	RZG2L_IOLH_IDX_MAX = 4,
+	RZG2L_IOLH_IDX_1V8 = 0,
+	RZG2L_IOLH_IDX_2V5 = 4,
+	RZG2L_IOLH_IDX_3V3 = 8,
+	RZG2L_IOLH_IDX_MAX = 12,
 };
 
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
  * @iolh_groupa_ua: IOLH group A micro amps specific values
+ * @iolh_groupb_ua: IOLH group B micro amps specific values
+ * @iolh_groupc_ua: IOLH group C micro amps specific values
  * @iolh_groupb_oi: IOLH group B output impedance specific values
+ * @drive_strength_ua: driver strenght in ua is supported (otherwise mA is supported)
  * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
 	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_oi[RZG2L_IOLH_IDX_MAX];
+	bool drive_strength_ua;
 	u8 func_base;
 };
 
@@ -172,6 +187,16 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 };
 
+/**
+ * struct rzg2l_pinctrl_pin_settings - pin data
+ * @power_source: power source
+ * @drive_strength_ua: drive strength (in micro amps)
+ */
+struct rzg2l_pinctrl_pin_settings {
+	u16 power_source;
+	u16 drive_strength_ua;
+};
+
 struct rzg2l_pinctrl {
 	struct pinctrl_dev		*pctl;
 	struct pinctrl_desc		desc;
@@ -189,8 +214,12 @@ struct rzg2l_pinctrl {
 
 	spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
+
+	struct rzg2l_pinctrl_pin_settings *settings;
 };
 
+static const u16 available_ps[] = { 1800, 2500, 3300 };
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -555,6 +584,164 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	unsigned long flags;
+	void __iomem *addr;
+	u32 pwr_reg;
+	u16 ps;
+
+	if (caps & PIN_CFG_IO_VMC_SD0)
+		pwr_reg = SD_CH(regs->sd_ch, 0);
+	else if (caps & PIN_CFG_IO_VMC_SD1)
+		pwr_reg = SD_CH(regs->sd_ch, 1);
+	else if (caps & PIN_CFG_IO_VMC_QSPI)
+		pwr_reg = QSPI;
+	else if (!(caps & PIN_CFG_SOFT_PS))
+		return -EINVAL;
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	if (caps & PIN_CFG_SOFT_PS) {
+		ps = pctrl->settings[pin].power_source;
+	} else {
+		addr = pctrl->base + pwr_reg;
+		ps = (readl(addr) & PVDD_MASK) ? 1800 : 3300;
+	}
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return ps;
+}
+
+static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps, u32 ps)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	unsigned long flags;
+	void __iomem *addr;
+	u32 pwr_reg;
+
+	if (caps & PIN_CFG_IO_VMC_SD0)
+		pwr_reg = SD_CH(regs->sd_ch, 0);
+	else if (caps & PIN_CFG_IO_VMC_SD1)
+		pwr_reg = SD_CH(regs->sd_ch, 1);
+	else if (caps & PIN_CFG_IO_VMC_QSPI)
+		pwr_reg = QSPI;
+	else if (!(caps & PIN_CFG_SOFT_PS))
+		return -EINVAL;
+
+	addr = pctrl->base + pwr_reg;
+	spin_lock_irqsave(&pctrl->lock, flags);
+	if (!(caps & PIN_CFG_SOFT_PS))
+		writel((ps == 1800) ? PVDD_1800 : PVDD_3300, addr);
+	pctrl->settings[pin].power_source = ps;
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
+static bool rzg2l_ps_is_supported(u16 ps)
+{
+	u8 i;
+
+	for (i = 0; i < ARRAY_SIZE(available_ps); i++) {
+		if (available_ps[i] == ps)
+			return true;
+	}
+
+	return false;
+}
+
+static enum rzg2l_iolh_index rzg2l_ps_to_iolh_idx(u16 ps)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(available_ps); i++) {
+		if (available_ps[i] == ps)
+			break;
+	}
+
+	/*
+	 * We multiply with 4 as we have 4 DS values per power source
+	 * (see enum rzg2l_iolh_index)
+	 */
+	return i * 4;
+}
+
+static u16 rzg2l_iolh_val_to_ua(const struct rzg2l_hwcfg *hwcfg, u32 caps, u8 val)
+{
+	if (caps & PIN_CFG_IOLH_A)
+		return hwcfg->iolh_groupa_ua[val];
+
+	if (caps & PIN_CFG_IOLH_B)
+		return hwcfg->iolh_groupb_ua[val];
+
+	if (caps & PIN_CFG_IOLH_C)
+		return hwcfg->iolh_groupc_ua[val];
+
+	/* Should not happen. */
+	return 0;
+}
+
+static u16 rzg2l_iolh_ua_to_val(const struct rzg2l_hwcfg *hwcfg, u32 caps,
+				enum rzg2l_iolh_index ps_index, u16 ua)
+{
+	const u16 *array = NULL;
+	u16 i;
+
+	if (caps & PIN_CFG_IOLH_A)
+		array = &hwcfg->iolh_groupa_ua[ps_index];
+
+	if (caps & PIN_CFG_IOLH_B)
+		array = &hwcfg->iolh_groupb_ua[ps_index];
+
+	if (caps & PIN_CFG_IOLH_C)
+		array = &hwcfg->iolh_groupc_ua[ps_index];
+
+	if (!array)
+		return RZG2L_INVALID_IOLH_VAL;
+
+	for (i = 0; i < 4; i++) {
+		if (array[i] == ua)
+			return i;
+	}
+
+	return RZG2L_INVALID_IOLH_VAL;
+}
+
+static bool rzg2l_ds_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
+			       enum rzg2l_iolh_index iolh_idx,
+			       u16 ds)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const u16 *array = NULL;
+	u16 i;
+
+	if (caps & PIN_CFG_IOLH_A)
+		array = hwcfg->iolh_groupa_ua;
+
+	if (caps & PIN_CFG_IOLH_B)
+		array = hwcfg->iolh_groupb_ua;
+
+	if (caps & PIN_CFG_IOLH_C)
+		array = hwcfg->iolh_groupc_ua;
+
+	/* Should not happen. */
+	if (!array)
+		return false;
+
+	if (array[iolh_idx] == RZG2L_INVALID_IOLH_VAL)
+		return false;
+
+	for (i = 0; i < 4; i++) {
+		if (array[iolh_idx + i] == ds)
+			return true;
+	}
+
+	return false;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -562,13 +749,11 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	unsigned int arg = 0;
-	unsigned long flags;
-	void __iomem *addr;
 	u32 off, cfg;
+	int ret;
 	u8 bit;
 
 	if (!pin_data)
@@ -594,40 +779,50 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		break;
 
-	case PIN_CONFIG_POWER_SOURCE: {
-		u32 pwr_reg = 0x0;
-
-		if (cfg & PIN_CFG_IO_VMC_SD0)
-			pwr_reg = SD_CH(regs->sd_ch, 0);
-		else if (cfg & PIN_CFG_IO_VMC_SD1)
-			pwr_reg = SD_CH(regs->sd_ch, 1);
-		else if (cfg & PIN_CFG_IO_VMC_QSPI)
-			pwr_reg = QSPI;
-		else
-			return -EINVAL;
-
-		spin_lock_irqsave(&pctrl->lock, flags);
-		addr = pctrl->base + pwr_reg;
-		arg = (readl(addr) & PVDD_MASK) ? 1800 : 3300;
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+	case PIN_CONFIG_POWER_SOURCE:
+		ret = rzg2l_get_power_source(pctrl, _pin, cfg);
+		if (ret < 0)
+			return ret;
+		arg = ret;
 		break;
-	}
 
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
 
-		if (!(cfg & PIN_CFG_IOLH_A))
+		if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		/*
+		 * Drive strenght mA is supported only by group A and only
+		 * for 3V3 port source.
+		 */
 		arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
 		break;
 	}
 
+	case PIN_CONFIG_DRIVE_STRENGTH_UA: {
+		enum rzg2l_iolh_index iolh_idx;
+		u8 val;
+
+		if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
+		    !hwcfg->drive_strength_ua)
+			return -EINVAL;
+
+		ret = rzg2l_get_power_source(pctrl, _pin, cfg);
+		if (ret < 0)
+			return ret;
+		iolh_idx = rzg2l_ps_to_iolh_idx(ret);
+		val = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		arg = rzg2l_iolh_val_to_ua(hwcfg, cfg, iolh_idx + val);
+		break;
+	}
+
 	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
 		unsigned int index;
 
-		if (!(cfg & PIN_CFG_IOLH_B))
+		if (!(cfg & PIN_CFG_IOLH_B) ||
+		    hwcfg->iolh_groupb_oi[0] == RZG2L_INVALID_IOLH_VAL)
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
@@ -651,12 +846,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
+	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	unsigned long flags;
-	void __iomem *addr;
 	unsigned int i;
 	u32 cfg, off;
 	u8 bit;
@@ -689,34 +882,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 		}
 
-		case PIN_CONFIG_POWER_SOURCE: {
-			unsigned int mV = pinconf_to_config_argument(_configs[i]);
-			u32 pwr_reg = 0x0;
-
-			if (mV != 1800 && mV != 3300)
-				return -EINVAL;
-
-			if (cfg & PIN_CFG_IO_VMC_SD0)
-				pwr_reg = SD_CH(regs->sd_ch, 0);
-			else if (cfg & PIN_CFG_IO_VMC_SD1)
-				pwr_reg = SD_CH(regs->sd_ch, 1);
-			else if (cfg & PIN_CFG_IO_VMC_QSPI)
-				pwr_reg = QSPI;
-			else
-				return -EINVAL;
-
-			addr = pctrl->base + pwr_reg;
-			spin_lock_irqsave(&pctrl->lock, flags);
-			writel((mV == 1800) ? PVDD_1800 : PVDD_3300, addr);
-			spin_unlock_irqrestore(&pctrl->lock, flags);
+		case PIN_CONFIG_POWER_SOURCE:
+			settings.power_source = pinconf_to_config_argument(_configs[i]);
 			break;
-		}
 
 		case PIN_CONFIG_DRIVE_STRENGTH: {
 			unsigned int arg = pinconf_to_config_argument(_configs[i]);
 			unsigned int index;
 
-			if (!(cfg & PIN_CFG_IOLH_A))
+			if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 				return -EINVAL;
 
 			for (index = RZG2L_IOLH_IDX_3V3; index < RZG2L_IOLH_IDX_3V3 + 4; index++) {
@@ -730,11 +904,20 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 		}
 
+		case PIN_CONFIG_DRIVE_STRENGTH_UA:
+			if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
+			    !hwcfg->drive_strength_ua)
+				return -EINVAL;
+
+			settings.drive_strength_ua = pinconf_to_config_argument(_configs[i]);
+			break;
+
 		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
 			unsigned int arg = pinconf_to_config_argument(_configs[i]);
 			unsigned int index;
 
-			if (!(cfg & PIN_CFG_IOLH_B))
+			if (!(cfg & PIN_CFG_IOLH_B) ||
+			    hwcfg->iolh_groupb_oi[0] == RZG2L_INVALID_IOLH_VAL)
 				return -EINVAL;
 
 			for (index = 0; index < ARRAY_SIZE(hwcfg->iolh_groupb_oi); index++) {
@@ -753,6 +936,47 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		}
 	}
 
+	/* Apply drive strength and power source. */
+	if (memcmp(&settings, &pctrl->settings[_pin], sizeof(settings))) {
+		enum rzg2l_iolh_index iolh_idx;
+		unsigned long flags;
+		int ret;
+		u16 val;
+
+		if (settings.power_source == pctrl->settings[_pin].power_source)
+			goto apply_drive_strength;
+
+		ret = rzg2l_ps_is_supported(settings.power_source);
+		if (!ret)
+			return -EINVAL;
+
+		/* Apply power source. */
+		ret = rzg2l_set_power_source(pctrl, _pin, cfg, settings.power_source);
+		if (ret)
+			return ret;
+
+apply_drive_strength:
+		if (settings.drive_strength_ua == pctrl->settings[_pin].drive_strength_ua)
+			return 0;
+
+		iolh_idx = rzg2l_ps_to_iolh_idx(settings.power_source);
+		ret = rzg2l_ds_supported(pctrl, cfg, iolh_idx,
+					 settings.drive_strength_ua);
+		if (!ret)
+			return -EINVAL;
+
+		/* Get register value for this PS/DS tuple. */
+		val = rzg2l_iolh_ua_to_val(hwcfg, cfg, iolh_idx, settings.drive_strength_ua);
+		if (val == RZG2L_INVALID_IOLH_VAL)
+			return -EINVAL;
+
+		/* Apply drive strength. */
+		rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, val);
+		spin_lock_irqsave(&pctrl->lock, flags);
+		pctrl->settings[_pin].drive_strength_ua = settings.drive_strength_ua;
+		spin_unlock_irqrestore(&pctrl->lock, flags);
+	}
+
 	return 0;
 }
 
@@ -1459,6 +1683,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 
 static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 {
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
 	u32 *pin_data;
@@ -1501,6 +1726,22 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		pins[index].drv_data = &pin_data[index];
 	}
 
+	pctrl->settings = devm_kzalloc(pctrl->dev, sizeof(*pctrl->settings) * pctrl->desc.npins,
+				       GFP_KERNEL);
+	if (!pctrl->settings)
+		return -ENOMEM;
+
+	for (i = 0; hwcfg->drive_strength_ua && i < pctrl->desc.npins; i++) {
+		if (pin_data[i] & PIN_CFG_SOFT_PS) {
+			pctrl->settings[i].power_source = 3300;
+		} else {
+			ret = rzg2l_get_power_source(pctrl, i, pin_data[i]);
+			if (ret < 0)
+				continue;
+			pctrl->settings[i].power_source = ret;
+		}
+	}
+
 	ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
 	if (ret) {
@@ -1574,6 +1815,8 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 		.sd_ch = 0x3000,
 	},
 	.iolh_groupa_ua = {
+		/* 1v8, 2v5 power source */
+		[RZG2L_IOLH_IDX_1V8 ... RZG2L_IOLH_IDX_3V3 - 1] = RZG2L_INVALID_IOLH_VAL,
 		/* 3v3 power source */
 		[RZG2L_IOLH_IDX_3V3] = 2000, 4000, 8000, 12000,
 	},
-- 
2.39.2

