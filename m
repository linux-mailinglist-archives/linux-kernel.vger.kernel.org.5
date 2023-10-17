Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D377CCBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjJQTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjJQTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:05:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD85F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso10373524a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697569550; x=1698174350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTZ7ydCHaq0IR0zgFwrKFeHLGdmRgxiSDO8Km/mu1j0=;
        b=f8N2dB9Hc6JvZBRlwHsKr69/4shh7DCQothc7EtuhjSo0xlFPBk4reZIDgHF6CuJwg
         8UmW3Wo16xV2p9agNH/SHVJMKsI7zlWYEkxzZ9EfNXliF2lCFSpI/UkFxhRPgmx+Mq6w
         yhoMYAxf96WuT/gP/MQkWlPMNSMrIW+v3dOwNRfAplalU+JqVe1YmJSQ2PvXvpZyXW3S
         LZ2V0ogOBYkzZw2N469//hrR24exNN9Arp06ZbC7/vklAmGPnE9F+dGdLGO/BObUJQAP
         b3wkHRw363Ep3tJ5kvtcdh6ng6c7x/B7WHEH1kdKt6ekeHLeaUvKqneRfGDvSqfTxVhu
         iPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569550; x=1698174350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTZ7ydCHaq0IR0zgFwrKFeHLGdmRgxiSDO8Km/mu1j0=;
        b=DsUrHjk23MEHZFLMOoU/znVG0T8nItc3sczGzClEGGlAFpI7ZuIVtwd3bSaVP68wmd
         2GZ5msDPfEdBgTNovSZkhBCiQ80qNxOaSn/YKF/fKh7/iLLbyEoj9e/ElqrS7wYMb9sw
         77uUS4BGR1bUWx8Gto72K/EG5Lsl01iB+p/KuKiDff+CwkJBhLpYtN/ozHQLMQAtSBEl
         IiURh06y01BRop6N2HvtEUaius00KkdNAl24jU8p9vmFipHqtHMdBxgy6lJHEp+J7UAF
         tSN9xgpQN9Vhkz+bsxOJp3wLuiUyicYNcX10W4QQ3DJUxNfVNyMsD3fzURijgvhmnudq
         yAvA==
X-Gm-Message-State: AOJu0YxLSY74sfT6VptI9H/rhjMUN05dXRIBd2MJZFvguFnO09TD7jW0
        KeCcPQm6ZJUFErAUT9uC0ImRfw==
X-Google-Smtp-Source: AGHT+IHTok1uXYbQmcBYZ3DpRgVqshI4ym+zYBZCxCyBgZ9L59hGQf5RckEwtL69URzk/lG24SRzkQ==
X-Received: by 2002:a50:8e1b:0:b0:53e:611b:abb3 with SMTP id 27-20020a508e1b000000b0053e611babb3mr2047014edw.17.1697569550277;
        Tue, 17 Oct 2023 12:05:50 -0700 (PDT)
Received: from ryzen9.fritz.box ([2a01:2a8:8f03:b001:fe65:a70:2777:ab31])
        by smtp.gmail.com with ESMTPSA id bq14-20020a056402214e00b00537963f692esm1637990edb.0.2023.10.17.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:05:49 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v5 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
Date:   Tue, 17 Oct 2023 21:05:43 +0200
Message-ID: <20231017190545.157282-4-bero@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
References: <20231017190545.157282-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add LVTS Driver support for MT8192.

Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: cosmetic changes, rebase]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index c5a03bdf63e9d..487401424951d 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -89,6 +89,7 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
+#define LVTS_HW_SHUTDOWN_MT8192		105000
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 
 #define LVTS_MINIMUM_THRESHOLD		20000
@@ -1286,6 +1287,88 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
 
+static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
+	{
+		.cal_offset = { 0x04, 0x08 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU0 },
+			{ .dt_id = MT8192_MCU_BIG_CPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.cal_offset = { 0x0c, 0x10 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_BIG_CPU2 },
+			{ .dt_id = MT8192_MCU_BIG_CPU3 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_MCU_LITTLE_CPU0 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU1 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU2 },
+			{ .dt_id = MT8192_MCU_LITTLE_CPU3 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+		.mode = LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] = {
+		{
+		.cal_offset = { 0x24, 0x28 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_VPU0 },
+			{ .dt_id = MT8192_AP_VPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x2c, 0x30 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_GPU0 },
+			{ .dt_id = MT8192_AP_GPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x34, 0x38 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_INFRA },
+			{ .dt_id = MT8192_AP_CAM },
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	},
+	{
+		.cal_offset = { 0x3c, 0x40, 0x44 },
+		.lvts_sensor = {
+			{ .dt_id = MT8192_AP_MD0 },
+			{ .dt_id = MT8192_AP_MD1 },
+			{ .dt_id = MT8192_AP_MD2 }
+		},
+		.num_lvts_sensor = 3,
+		.offset = 0x300,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8192,
+	}
+};
+
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1365,6 +1448,16 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_data mt8192_lvts_mcu_data = {
+	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+};
+
+static const struct lvts_data mt8192_lvts_ap_data = {
+	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+};
+
 static const struct lvts_data mt8195_lvts_mcu_data = {
 	.lvts_ctrl	= mt8195_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_mcu_data_ctrl),
@@ -1376,6 +1469,8 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 };
 
 static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
 	{},
-- 
2.42.0

