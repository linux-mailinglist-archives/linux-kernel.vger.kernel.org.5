Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96C7AE4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjIZEk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjIZEkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:40:21 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60240B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:15 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57bab4e9e1aso2561376eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695703214; x=1696308014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQhU1RkcH7MjgUWyE/kqZPIAnN+PPGh4wt2Rdh5pkv0=;
        b=K8QfU4KhRgNakiAdKwmfrWjPvYqSw3nu9DfoFwAgEA7GIuLeRzvPMLSr6wE1p+j1et
         PwIFle+QFXDL0Be9StgCe/zgKJr93LAXoibhbtNX5Oihk/Ub8udAxmED7jP2Asd2vajK
         CP97vvcTrcPCllrxl1FvhP2piMtM7mlZVAq+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703214; x=1696308014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQhU1RkcH7MjgUWyE/kqZPIAnN+PPGh4wt2Rdh5pkv0=;
        b=fEhhVyNRf5DCQR8X4z2hsO9DB72/2Kk4RsDxUyB5KNy9BIlP5OGilufJyDSvuTPD33
         oyQa6w04S8XVW/mBe4bjWe52KtXGil8zPABQ4qL44LoTf+v666h6isuAEmSIsQYJpelX
         3mz5qEsZAwNO7qNuHwu72K+pl/Odol5BwkL188Ss1ClD9F+dLL6VJypqf1bjq4ik0g3E
         Qse6007dxr5mBen96qV04QOwB5/aX5fgpeQnFuCi65fgl0/T6fkEBu5GHS/jXeq37/m4
         2IXD9CTOd9UPjdukBa8+MLaP1vcLWjNGJOZ9alnf4hSTYNJzAvyQzcszLlUMxu8tvoUy
         axjw==
X-Gm-Message-State: AOJu0YxwdykTW44fpAFTkyTz0CfjH6qqCEDjsB/bd2FoFtNkYmCMpaaG
        GeZDm8CSbPJBNW9Vf41n8vZ5Dg==
X-Google-Smtp-Source: AGHT+IEWSTLXw8RQzEFqN1UX9tizE2LvrNAvvFmqQcPF3kAdf+Kqd7mBd/0Vf+yCuYgkkHfxWZqQ9g==
X-Received: by 2002:a05:6870:17a7:b0:1bb:4606:5be with SMTP id r39-20020a05687017a700b001bb460605bemr11235714oae.9.1695703214656;
        Mon, 25 Sep 2023 21:40:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ba86:87c4:df1a:be60])
        by smtp.gmail.com with ESMTPSA id p11-20020a63ab0b000000b00563590be25esm8667210pgf.29.2023.09.25.21.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 21:40:14 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND v3 2/3] regulator: mt6358: Add output voltage fine tuning to fixed regulators
Date:   Tue, 26 Sep 2023 12:34:47 +0800
Message-ID: <20230926043450.2353320-3-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926043450.2353320-1-wenst@chromium.org>
References: <20230926043450.2353320-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fixed" LDO regulators found on the MT6358 and MT6366 PMICs have
either no voltage selection register, or only one valid setting.
However these do have a fine voltage calibration setting that can
slightly boost the output voltage from 0 mV to 100 mV, in 10 mV
increments.

Add support for this by changing these into linear range regulators.
Some register definitions that are missing are also added.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/mt6358-regulator.c | 15 +++++++++++++--
 include/linux/mfd/mt6358/registers.h |  6 ++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 4ca8fbf4b3e2..f2eb0c14d1ed 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -123,10 +123,13 @@ struct mt6358_regulator_info {
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
-		.n_voltages = 1,	\
+		.n_voltages = 11,	\
+		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
+		.vsel_mask = GENMASK(3, 0),	\
 		.enable_reg = enreg,	\
 		.enable_mask = BIT(enbit),	\
 		.min_uV = volt,	\
+		.uV_step = 10000, \
 	},	\
 	.status_reg = MT6358_LDO_##vreg##_CON1,	\
 	.qi = BIT(15),							\
@@ -219,10 +222,13 @@ struct mt6358_regulator_info {
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6366_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
-		.n_voltages = 1,	\
+		.n_voltages = 11,	\
+		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
+		.vsel_mask = GENMASK(3, 0),	\
 		.enable_reg = enreg,	\
 		.enable_mask = BIT(enbit),	\
 		.min_uV = volt,	\
+		.uV_step = 10000, \
 	},	\
 	.status_reg = MT6358_LDO_##vreg##_CON1,	\
 	.qi = BIT(15),							\
@@ -488,8 +494,13 @@ static const struct regulator_ops mt6358_volt_table_ops = {
 	.get_status = mt6358_get_status,
 };
 
+/* "Fixed" LDOs with output voltage calibration +0 ~ +10 mV */
 static const struct regulator_ops mt6358_volt_fixed_ops = {
 	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = mt6358_get_buck_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 3d33517f178c..5ea2590be710 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -262,6 +262,12 @@
 #define MT6358_LDO_VBIF28_CON3                0x1db0
 #define MT6358_VCAMA1_ANA_CON0                0x1e08
 #define MT6358_VCAMA2_ANA_CON0                0x1e0c
+#define MT6358_VFE28_ANA_CON0                 0x1e10
+#define MT6358_VCN28_ANA_CON0                 0x1e14
+#define MT6358_VBIF28_ANA_CON0                0x1e18
+#define MT6358_VAUD28_ANA_CON0                0x1e1c
+#define MT6358_VAUX18_ANA_CON0                0x1e20
+#define MT6358_VXO22_ANA_CON0                 0x1e24
 #define MT6358_VCN33_ANA_CON0                 0x1e28
 #define MT6358_VSIM1_ANA_CON0                 0x1e2c
 #define MT6358_VSIM2_ANA_CON0                 0x1e30
-- 
2.42.0.515.g380fc7ccd1-goog

