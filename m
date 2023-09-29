Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A627B2BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjI2FmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjI2FlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:41:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91A195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1826961666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965994; x=1696570794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCdeJPGU8dd/6qVQQoCrQDlRgEb+6zveKJgbVuoeTT8=;
        b=qWDj0CNdUuVobCzg1x216C9G+35D1Hag3kCMV4Jn9KtPQAvKd7FBauhjbTsVJyeWh3
         pky6o0pcym/oY1XFx7cCJNEZYSPQ/tFtqt6DSp+XExSLPksX56xoz7o3hKQU/jIAq/Vy
         wjqt8i2AgLeJ9PoYBVIobVdirUCCDffSaTFG6WpclcH3cCtqNA+imxV1s78cRFuo8LKI
         Oqn+3OIQkkdpmT5l+DI7HEp9wUgnfS3a3zH6jTEJVCY9mhHBTtOYYn34YoQS1F++Co7f
         anhwWY6+N1OCK2zTB5eu/+ccOO9icZJ+rkAL9ZiqnccXKPtDLGQpTXIr2U5fn9idsRZt
         dWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965994; x=1696570794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCdeJPGU8dd/6qVQQoCrQDlRgEb+6zveKJgbVuoeTT8=;
        b=eX5mcZxwuc+rf6Nun0oBb7mMQbjPw+up7KoHsOR11pwyllBiLiSo8WEpBQZ9J42UtL
         MOLb//BQsXwyCheMIoeGy4nHUBosQj+moCs8l93uVpRQwbTauWjfmBSgizCGWx/dGgLL
         zOV9q3aKzoHEUd3yreTam/udkWQjDk0B5q21aq9gTGnvX5eFOakX4ENDk20eBzTSybha
         cfou1qJrQ+5M30kATpDVkVrTvOkgltGerX5TLyxOnSlarNpYn6/An8boC9ZWTtfb+8Ox
         GiA9gdPeVSOtUybkxQm7IztBAFtsFda8+w2BXnRPHjqnaE0KKUg1Xn2O4XuJWwnfqG7w
         xzEg==
X-Gm-Message-State: AOJu0YxJHDm5qA995VTWlLe95NW/6BsRs0JXJoIDi2zQF9NGqa/eOvF8
        Un14jVoyLTA5sw8+Ukr6xuiVzQ==
X-Google-Smtp-Source: AGHT+IE8LyqXyBhXf7YsTLE5wkHLmEQar6G84DOrxW13gzxDyxH9XYdGUfrDleuLvNQy+MtuRQr7og==
X-Received: by 2002:a17:906:3089:b0:9ae:46f3:b03f with SMTP id 9-20020a170906308900b009ae46f3b03fmr2835364ejv.0.1695965993884;
        Thu, 28 Sep 2023 22:39:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:53 -0700 (PDT)
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
Subject: [PATCH v2 17/28] pinctrl: renesas: rzg2l: move ds and oi to SoC specific configuration
Date:   Fri, 29 Sep 2023 08:39:04 +0300
Message-Id: <20230929053915.1530607-18-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Move drive strength and output impedance values to SoC specific
configuration data structure (struct rzg2l_hwcfg). This allows extending
the drive strength support for RZ/G3S. Along with this the DS values
were converted to uA for simple integration with RZ/G3S support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- s/indexes/indices in code documentation
- s/micro amps/uA in code documentation
- added RZG2L_IOLH_MAX_DS_ENTRIES for "+ 4" statements in code
- changed struct rzg2l_hwcfg::iolh_groupb_oi[] size to 4 to avoid
  oversize it in next commits when RZG2L_IOLH_IDX_MAX will be increased
  and thus avoiding issues when executing
  "if (index == ARRAY_SIZE(hwcfg->iolh_groupb_oi))" in
  rzg2l_pinctrl_pinconf_set()
- collected tags

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 42 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 73d8a84af04a..2afc9a34ffa3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -133,13 +133,30 @@ struct rzg2l_register_offsets {
 	u16 sd_ch;
 };
 
+/**
+ * enum rzg2l_iolh_index - starting indices in IOLH specific arrays
+ * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
+ * @RZG2L_IOLH_IDX_MAX: maximum index
+ */
+enum rzg2l_iolh_index {
+	RZG2L_IOLH_IDX_3V3 = 0,
+	RZG2L_IOLH_IDX_MAX = 4,
+};
+
+/* Maximum number of driver strength entries per power source. */
+#define RZG2L_IOLH_MAX_DS_ENTRIES	(4)
+
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @iolh_groupa_ua: IOLH group A uA specific values
+ * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupb_oi[4];
 	u8 func_base;
 };
 
@@ -177,9 +194,6 @@ struct rzg2l_pinctrl {
 	struct mutex			mutex; /* serialize adding groups and functions */
 };
 
-static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
-static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
-
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -608,7 +622,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupa_mA[index];
+		arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
 		break;
 	}
 
@@ -619,7 +633,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupb_oi[index];
+		arg = hwcfg->iolh_groupb_oi[index];
 		break;
 	}
 
@@ -707,11 +721,12 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_A))
 				return -EINVAL;
 
-			for (index = 0; index < ARRAY_SIZE(iolh_groupa_mA); index++) {
-				if (arg == iolh_groupa_mA[index])
+			for (index = RZG2L_IOLH_IDX_3V3;
+			     index < RZG2L_IOLH_IDX_3V3 + RZG2L_IOLH_MAX_DS_ENTRIES; index++) {
+				if (arg == (hwcfg->iolh_groupa_ua[index] / 1000))
 					break;
 			}
-			if (index >= ARRAY_SIZE(iolh_groupa_mA))
+			if (index == (RZG2L_IOLH_IDX_3V3 + RZG2L_IOLH_MAX_DS_ENTRIES))
 				return -EINVAL;
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
@@ -725,11 +740,11 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
@@ -1562,6 +1577,11 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
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

