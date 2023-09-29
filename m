Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8317B2BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjI2FmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjI2FlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:41:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17691B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ad810be221so1839325666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965995; x=1696570795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvjUZarHFJO+zWx3V69v2Tei4ukpxZZ/u4EWvCrOucE=;
        b=gXO6ktI9z5nXvKHtft/L/toPu2l2RKXuUujmZ/bxnw0jN3l8LPdXPwIvNmvqezI1YU
         yTgSgvhCG1gt8so4GxmxmaiZMnXZADf+vOwvxrUa4m+B0P3pYGpBkuTHykwFMsCB3+7N
         WIY+e6vXzde+X1jCE3mwcjSOIj/tiOktVPR3ANK665Xdmpjgv1Kbe7Au5JmPqKcbYEC7
         ePSsGdCkegkAYxRehyEAB4ZiWNrXGe+LDqbscCblul9pWhM7R6wj9AYEB3qWE2EqB3HC
         QL7CAXUe1pyYFcedfZ6lRWGL49trHA3WzRD5qRANRNaALS9BjsfZW6S9ImpWhqkDxfI9
         TyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965995; x=1696570795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvjUZarHFJO+zWx3V69v2Tei4ukpxZZ/u4EWvCrOucE=;
        b=rq/n2uQRqkCo3h8Ok/NTUIwqjK665mJfl5BvZZVkax6yB8arlSLNEQRQoyU/q7yqzR
         ez9iCfKqN3J/iJV4LFHRzhIRmn9JNUqcUYghdWZumj2PL1QveN0XqXMIXF4MBR/bCJ5N
         Tx1mqvwolZH5LZJPotO5fWripbk56LZWT3fGlzMIxwIE9rgKeDqjiub0dIzsfgH2NKUB
         bLwNUoBHWP1xHyEN6lyeL1N1jf/aCOu7nHdYPs8k4a4c4yNWRWaQ/UHYNJcScFJCchV6
         tU5BG4zUbttdOF20lHmDGOwOBxS/BBDDWTg0i5R7ZaxBmsWaDwAqYJLqwjPXKu2VRxah
         J1QQ==
X-Gm-Message-State: AOJu0Yx45pZgnWg/ReUuJIlF9ZJpJ5iqbWcq37031H7N0KrLpa9Wx9K8
        M1fSiA3B+PAkSV6jN3v4WV4CvQ==
X-Google-Smtp-Source: AGHT+IEUwMnQbTuZrCn4qIixlvNnGA5JJxPOfcR3lLy19IP+i1IsUOv2JxWftbGln8qg8TgeuE60Jg==
X-Received: by 2002:a17:906:3cb2:b0:9ad:df85:97ae with SMTP id b18-20020a1709063cb200b009addf8597aemr2968370ejh.66.1695965995744;
        Thu, 28 Sep 2023 22:39:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:55 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 18/28] pinctrl: renesas: rzg2l: add support for different ds values on different groups
Date:   Fri, 29 Sep 2023 08:39:05 +0300
Message-Id: <20230929053915.1530607-19-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S supports different drive strength values for different power sources
and pin groups (A, B, C). On each group there could be up to 4 drive
strength values per power source. Available power sources are 1v8, 2v5,
3v3. Drive strength values are fine tuned than what was previously
available on the driver thus the necessity of having micro-amp support.
As drive strength and power source values are linked together the
hardware setup for these was moved at the end of
rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
values.

The drive strength values are expected to be initialized though SoC
specific hardware configuration data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- s/strenght/strength, s/togheter/together in commit description
- got rid of RZG2L_INVALID_IOLH_VAL macro and consider zero as invalid
  value for entries in struct rzg2l_hwcfg::iolh_group[abc]_ua[] arrays
- removed spinlock in rzg2l_[sg]et_power_source()
- introduced caps_to_pwr_reg() and simplified the code in
  rzg2l_[sg]et_power_source()
- changed return type of rzg2l_iolh_ua_to_val() to int and return
  -EINVAL on failure cases
- s/rzg2l_ds_supported/rzg2l_ds_is_supported
- inverted the logic in rzg2l_pinctrl_pinconf_set() when applying drive
  strength and power source to hardware registers and thus simplified the
  code
- used devm_kcalloc() instead of devm_kzalloc()
- adderessed the rest of the review comments

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 323 ++++++++++++++++++++----
 1 file changed, 272 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 2afc9a34ffa3..8b74838510ad 100644
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
@@ -135,12 +137,16 @@ struct rzg2l_register_offsets {
 
 /**
  * enum rzg2l_iolh_index - starting indices in IOLH specific arrays
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
 
 /* Maximum number of driver strength entries per power source. */
@@ -150,13 +156,19 @@ enum rzg2l_iolh_index {
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
  * @iolh_groupa_ua: IOLH group A uA specific values
+ * @iolh_groupb_ua: IOLH group B uA specific values
+ * @iolh_groupc_ua: IOLH group C uA specific values
  * @iolh_groupb_oi: IOLH group B output impedance specific values
+ * @drive_strength_ua: drive strength in uA is supported (otherwise mA is supported)
  * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
 	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_oi[4];
+	bool drive_strength_ua;
 	u8 func_base;
 };
 
@@ -175,6 +187,16 @@ struct rzg2l_pinctrl_data {
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
@@ -192,8 +214,12 @@ struct rzg2l_pinctrl {
 
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
@@ -557,6 +583,156 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32 caps)
+{
+	if (caps & PIN_CFG_IO_VMC_SD0)
+		return SD_CH(regs->sd_ch, 0);
+	if (caps & PIN_CFG_IO_VMC_SD1)
+		return SD_CH(regs->sd_ch, 1);
+	if (caps & PIN_CFG_IO_VMC_QSPI)
+		return QSPI;
+
+	return -EINVAL;
+}
+
+static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	int pwr_reg;
+
+	if (caps & PIN_CFG_SOFT_PS)
+		return pctrl->settings[pin].power_source;
+
+	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
+	if (pwr_reg == -EINVAL)
+		return -EINVAL;
+
+	return (readl(pctrl->base + pwr_reg) & PVDD_MASK) ? 1800 : 3300;
+}
+
+static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps, u32 ps)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	int pwr_reg;
+
+	if (caps & PIN_CFG_SOFT_PS) {
+		pctrl->settings[pin].power_source = ps;
+		return 0;
+	}
+
+	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
+	if (pwr_reg == -EINVAL)
+		return -EINVAL;
+
+	writel((ps == 1800) ? PVDD_1800 : PVDD_3300, pctrl->base + pwr_reg);
+	pctrl->settings[pin].power_source = ps;
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
+	 * We multiply with RZG2L_IOLH_MAX_DS_ENTRIES as we have
+	 * RZG2L_IOLH_MAX_DS_ENTRIES DS values per power source
+	 */
+	return i * RZG2L_IOLH_MAX_DS_ENTRIES;
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
+static int rzg2l_iolh_ua_to_val(const struct rzg2l_hwcfg *hwcfg, u32 caps,
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
+		return -EINVAL;
+
+	for (i = 0; i < RZG2L_IOLH_MAX_DS_ENTRIES; i++) {
+		if (array[i] == ua)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
+				  enum rzg2l_iolh_index iolh_idx,
+				  u16 ds)
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
+	if (!array[iolh_idx])
+		return false;
+
+	for (i = 0; i < RZG2L_IOLH_MAX_DS_ENTRIES; i++) {
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
@@ -564,13 +740,11 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
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
@@ -596,40 +770,49 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
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
+		if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
@@ -653,14 +836,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
+	int ret;
 	u8 bit;
 
 	if (!pin_data)
@@ -691,34 +873,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
 
 			for (index = RZG2L_IOLH_IDX_3V3;
@@ -733,11 +896,19 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
+			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
 
 			for (index = 0; index < ARRAY_SIZE(hwcfg->iolh_groupb_oi); index++) {
@@ -756,6 +927,39 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		}
 	}
 
+	/* Apply power source. */
+	if (settings.power_source != pctrl->settings[_pin].power_source) {
+		ret = rzg2l_ps_is_supported(settings.power_source);
+		if (!ret)
+			return -EINVAL;
+
+		/* Apply power source. */
+		ret = rzg2l_set_power_source(pctrl, _pin, cfg, settings.power_source);
+		if (ret)
+			return ret;
+	}
+
+	/* Apply drive strength. */
+	if (settings.drive_strength_ua != pctrl->settings[_pin].drive_strength_ua) {
+		enum rzg2l_iolh_index iolh_idx;
+		int val;
+
+		iolh_idx = rzg2l_ps_to_iolh_idx(settings.power_source);
+		ret = rzg2l_ds_is_supported(pctrl, cfg, iolh_idx,
+					    settings.drive_strength_ua);
+		if (!ret)
+			return -EINVAL;
+
+		/* Get register value for this PS/DS tuple. */
+		val = rzg2l_iolh_ua_to_val(hwcfg, cfg, iolh_idx, settings.drive_strength_ua);
+		if (val == -EINVAL)
+			return -EINVAL;
+
+		/* Apply drive strength. */
+		rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, val);
+		pctrl->settings[_pin].drive_strength_ua = settings.drive_strength_ua;
+	}
+
 	return 0;
 }
 
@@ -1463,6 +1667,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 
 static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 {
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
 	u32 *pin_data;
@@ -1505,6 +1710,22 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		pins[index].drv_data = &pin_data[index];
 	}
 
+	pctrl->settings = devm_kcalloc(pctrl->dev, pctrl->desc.npins, sizeof(*pctrl->settings),
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
-- 
2.39.2

