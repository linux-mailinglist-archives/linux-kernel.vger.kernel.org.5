Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1565879E218
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbjIMI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbjIMI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:29:45 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9AB19A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c0f4ad9eb1so1542697a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694593777; x=1695198577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdHiqmsycYyIT3/cC+/dOfMKn4pKdIqRmHbcGwVnX5s=;
        b=a7Wx/BSgXPtobcvlpHklykk4gqzvnAVkm5LRPsgtOBmkvFPLmh3UQY+ozUMoPzCGUo
         YQvPCAbloLfGYVFm7zhyyaHJgYPoPhsTC4cdvlusPVx0io7107h/Xmrg2gY7QJe8fbJh
         PPlMdMPAkNhvQ/B1INv2Ry8F3T1VwCcpZvmdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593777; x=1695198577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdHiqmsycYyIT3/cC+/dOfMKn4pKdIqRmHbcGwVnX5s=;
        b=HlXdm+w73jMca9Zy3M8gMgj1T3C00FomcOuaQYd7aqw0LDDprW723aWBl3S+bqIuvy
         2vnIFQLOnkDEGblakUiMdiFTNv/M3B1k2mtD1FvkqYFwRChem6+4AadnvwPG87hJ/13R
         H9EJQ/2BFDIZObIdHrSB0AoJVBi64GIDcX9Rc3HtdkSY60duzTpkLkU00C4yLj60yfhX
         UzAW9359YVe7PxI2LhrUTguDoVgVHdIUKfjRx6ojSGord4Z0A7zCYvYaE7wNYsAd5z3q
         hoii8JRfy4SWflgBb59EGEBWJFI+a8LolMaFDfS5N9wCQV1Nj7Y9DHZ2Jc2eg5U/W4dL
         bzSg==
X-Gm-Message-State: AOJu0YzXnmXFDBSnXdw417OhPuLzvjHLBpdVGlUegA5Ft0pLhU/Em6gq
        C0jnN+rrSy+xRrAh948WTnjNX+p906gFvPd9A7s=
X-Google-Smtp-Source: AGHT+IEAk04XlqXXsbF3kNq6HWqUzflUESMdvKxSa9IgjgSc+RGUwJ6TTDvbnhxYl19Rn4xSY68iwA==
X-Received: by 2002:a05:6358:42a1:b0:135:4003:7841 with SMTP id s33-20020a05635842a100b0013540037841mr2163234rwc.13.1694593777309;
        Wed, 13 Sep 2023 01:29:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b24c:3be4:d952:d3b1])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b006901bd3a9e4sm418781pfo.104.2023.09.13.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:29:36 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/3] regulator: mt6358: Add output voltage fine tuning to fixed regulators
Date:   Wed, 13 Sep 2023 16:29:17 +0800
Message-ID: <20230913082919.1631287-3-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230913082919.1631287-1-wenst@chromium.org>
References: <20230913082919.1631287-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
This patch needs an ack from Lee.

 drivers/regulator/mt6358-regulator.c | 15 +++++++++++++--
 include/linux/mfd/mt6358/registers.h |  6 ++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 935c7ad56c7e..ecb2cd1eb34f 100644
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
@@ -482,8 +488,13 @@ static const struct regulator_ops mt6358_volt_table_ops = {
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
2.42.0.283.g2d96d420d3-goog

