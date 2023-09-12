Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81179C5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjILE4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjILEzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874A10E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso6501408a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494390; x=1695099190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMS8kOQsdHFVYgvIWOqQemx7X4c25FP2RPdgDWcI0CA=;
        b=lRE6ONlLIOV/fQ3oQRltHYaTakUGNdZg0zk7Fa8w0DCxWblz//Vf8yzWRAwAKphBne
         ngRKNIPwPNRuXgiJvytcaskSmSo9zCYbrJZSO/8rRtiXFdjXJ3m5F20DDdkvy5NY5BFx
         Q7OEWqJkiGIaVHe+CY9LZ9gNTDJ2BmsZpdXduE2vjjUq3Qik7SDEunAWExBbSQsANH+Z
         2FnEQhqf/hUUQFvm2rWiNsII/D6gj/HORn0ePl27D+AGxlRu1W9m2EOyHSUFFb3iT8y9
         kW7nNOf9qYPE5VOiP3q4RE569KRV6GgJiqrCgpytbwcA+sQwOby9tMiNqq21RumrwlHf
         2jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494390; x=1695099190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMS8kOQsdHFVYgvIWOqQemx7X4c25FP2RPdgDWcI0CA=;
        b=cXVLHgVTofmiSN5h/v0R646NwIxT4f5c7RQGwEW+udfk/pA348r69TSQw4AAph35/T
         OogukPRFacWRNGI8RIQEI+PHmDlaN3m2n0RxpHymAebfLit2DREovJrGbsE4fjqgbEBb
         Q74YhJhEQ1+s0HjP9O2vbfFuoMEdfCRs/OVmY6zIZZYyNT5O0Lvcr5MVSSvT7iRxEmTb
         D+ytBnFz+sAZn875f+0REF24hhcY0c25SkNXk+v4yxOCGNywXXPE2alD2fxmabyr/xls
         mheUMIil+2p6EqVPZGZ5RPmPLMycVJUd5bZwhIfJ6rCK6cViyNzd8EvAbo0JgFXrMIHX
         b6Lw==
X-Gm-Message-State: AOJu0YwKkE5tghxNDKlClo1C696GQyDRcahYlrcSyjaRjuojL2QdemKc
        7t53wBZHC6KdJNFJhyhb7BS6rw==
X-Google-Smtp-Source: AGHT+IFbratpw5cbhvOy/o1S4rIehuUbSUwiaR6+JJi31uQXxb58tXp18zpTL7TrYlYFazDrou6b3A==
X-Received: by 2002:aa7:c508:0:b0:525:4471:6b59 with SMTP id o8-20020aa7c508000000b0052544716b59mr9625847edq.7.1694494389821;
        Mon, 11 Sep 2023 21:53:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:09 -0700 (PDT)
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
Subject: [PATCH 26/37] pinctrl: renesas: rzg2l: move ds and oi to SoC specific configuration
Date:   Tue, 12 Sep 2023 07:51:46 +0300
Message-Id: <20230912045157.177966-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Move drive strength and output impedance values to SoC specific
configuration data structure (struct rzg2l_hwcfg). This allows extending
the drive strength support for RZ/G3S. Along with this the DS values
were converted to uA for simple integration with RZ/G3S support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 38 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 80cacac7ec95..1277bb26069c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -133,13 +133,27 @@ struct rzg2l_register_offsets {
 	u16 sd_ch;
 };
 
+/**
+ * enum rzg2l_iolh_index - starting indexes in IOLH specific arrays
+ * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
+ * @RZG2L_IOLH_IDX_MAX: maximum index
+ */
+enum rzg2l_iolh_index {
+	RZG2L_IOLH_IDX_3V3 = 0,
+	RZG2L_IOLH_IDX_MAX = 4,
+};
+
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @iolh_groupa_ua: IOLH group A micro amps specific values
+ * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupb_oi[RZG2L_IOLH_IDX_MAX];
 	u8 func_base;
 };
 
@@ -177,9 +191,6 @@ struct rzg2l_pinctrl {
 	struct mutex			mutex; /* serialize adding groups and functions */
 };
 
-static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
-static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
-
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -609,7 +620,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupa_mA[index];
+		arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
 		break;
 	}
 
@@ -620,7 +631,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupb_oi[index];
+		arg = hwcfg->iolh_groupb_oi[index];
 		break;
 	}
 
@@ -708,11 +719,11 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_A))
 				return -EINVAL;
 
-			for (index = 0; index < ARRAY_SIZE(iolh_groupa_mA); index++) {
-				if (arg == iolh_groupa_mA[index])
+			for (index = RZG2L_IOLH_IDX_3V3; index < RZG2L_IOLH_IDX_3V3 + 4; index++) {
+				if (arg == (hwcfg->iolh_groupa_ua[index] / 1000))
 					break;
 			}
-			if (index >= ARRAY_SIZE(iolh_groupa_mA))
+			if (index == (RZG2L_IOLH_IDX_3V3 + 4))
 				return -EINVAL;
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
@@ -726,11 +737,11 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_B))
 				return -EINVAL;
 
-			for (index = 0; index < ARRAY_SIZE(iolh_groupb_oi); index++) {
-				if (arg == iolh_groupb_oi[index])
+			for (index = 0; index < ARRAY_SIZE(hwcfg->iolh_groupb_oi); index++) {
+				if (arg == hwcfg->iolh_groupb_oi[index])
 					break;
 			}
-			if (index >= ARRAY_SIZE(iolh_groupb_oi))
+			if (index == ARRAY_SIZE(hwcfg->iolh_groupb_oi))
 				return -EINVAL;
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
@@ -1562,6 +1573,11 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 		.pwpr = 0x3014,
 		.sd_ch = 0x3000,
 	},
+	.iolh_groupa_ua = {
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 2000, 4000, 8000, 12000,
+	},
+	.iolh_groupb_oi = { 100, 66, 50, 33, },
 };
 
 static struct rzg2l_pinctrl_data r9a07g043_data = {
-- 
2.39.2

