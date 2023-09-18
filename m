Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E017A4629
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjIRJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbjIRJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:38:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6A116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:38:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so67464461fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695029904; x=1695634704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Egq0+PAYmAFGhC0dBKdJhR5zg742IjpeLXYQAgOXhxk=;
        b=gmvOt9c3Od/u6G2PvNDnaThRPsCv0nulckq08/Ta9Jyz3uWFqWaaQykeUGBraasZKm
         ouj7wFK1Daok7xdKBjaUL6MXiUz2llTkIVnP3q47KvWnFlKpnSvVL9scad5rIfGL4Ihd
         Q6gOYLuYwWqYWTeKD6Xtc6mXvbZsfcmOVsvCk+204+AOdfAnfHa7JPew90n8uqCZOy8P
         +dU41fNNJqJzgOOuKDmHKTpqsbc9SwX4Z++Sj3j1aug2YEpDOxlLjWXPOxe8z/PcPRoy
         39s0GsN/lfYXN9dJzgShQhGIOUcslQlO/IxSGYD8v2GJ3zLpXyt8zicTuYL1x9AYmzPU
         7bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029904; x=1695634704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Egq0+PAYmAFGhC0dBKdJhR5zg742IjpeLXYQAgOXhxk=;
        b=NB/nVitKOAbqgAiAePNtPEgDqoJYF0eF1c/s6JpSspSxRwYoFQoae+zpP8MNREgUno
         F4vKGfeCpv3tCvFqqRrTXvWNMKZG94VKpiWXL5zsc23FCjEH8xRTQj8mt0LHZumf3jWc
         XOlgx6sQuZazV8kqYdY/pt4V31bOFIS2UzRfwfWZBFVCNECQl2idbVTMu3oxEdAL6eb1
         A4F+NDxXYLHNK9aZr04hxypNBqQOctBvU5u2P/OWY4hrN5XUO4WZ9boY50W2DFt4cjqA
         oya+CPaUVUqnD/fHW2SY5qBjUj7eRQGYNS6baKX+r7i0zB8JgJW8tOgqIlIPnuTl0HT7
         9uCQ==
X-Gm-Message-State: AOJu0YzTfgiU9P0AeL1zI9v88TtZYD4DfwT0xGuyDbmXE/l696JFiMwa
        t+4YaeIh3USmLjL5AeVl9X8WRg==
X-Google-Smtp-Source: AGHT+IH7kmnTx50/3M/pkyGvv8vrGrlBXdTZoQ56oS15M0gTekpHIJ0PLxeYLczE/du3gbl5H2bfRw==
X-Received: by 2002:a2e:a687:0:b0:2c0:7e0:2a1 with SMTP id q7-20020a2ea687000000b002c007e002a1mr2357484lje.41.1695029903688;
        Mon, 18 Sep 2023 02:38:23 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0099293cdbc98sm6251164ejh.145.2023.09.18.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:38:23 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 5/8] soc: mediatek: pm-domains: Unify configuration for infracfg and smi
Date:   Mon, 18 Sep 2023 11:37:49 +0200
Message-Id: <20230918093751.1188668-6-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918093751.1188668-1-msp@baylibre.com>
References: <20230918093751.1188668-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flags to distinguish between infracfg and smi subsystem for a bus
protection configuration. It simplifies enabling/disabling and prepares
the driver for the use of another regmap for mt8365.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/pmdomain/mediatek/mt6795-pm-domains.h |  16 +-
 drivers/pmdomain/mediatek/mt8167-pm-domains.h |  20 +-
 drivers/pmdomain/mediatek/mt8173-pm-domains.h |  16 +-
 drivers/pmdomain/mediatek/mt8183-pm-domains.h | 125 ++++++----
 drivers/pmdomain/mediatek/mt8186-pm-domains.h | 236 ++++++++++--------
 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 223 +++++++++++------
 drivers/pmdomain/mediatek/mt8192-pm-domains.h | 112 ++++++---
 drivers/pmdomain/mediatek/mt8195-pm-domains.h | 199 +++++++++------
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |  64 ++---
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  26 +-
 10 files changed, 612 insertions(+), 425 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt6795-pm-domains.h b/drivers/pmdomain/mediatek/mt6795-pm-domains.h
index ef07c9dfdd9b..a3f7785b04bd 100644
--- a/drivers/pmdomain/mediatek/mt6795-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt6795-pm-domains.h
@@ -46,9 +46,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MM_M1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MM_M1),
 		},
 	},
 	[MT6795_POWER_DOMAIN_MJC] = {
@@ -95,11 +95,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
 		},
 	},
 };
diff --git a/drivers/pmdomain/mediatek/mt8167-pm-domains.h b/drivers/pmdomain/mediatek/mt8167-pm-domains.h
index 4d6c32759606..8a0e898b79ab 100644
--- a/drivers/pmdomain/mediatek/mt8167-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8167-pm-domains.h
@@ -22,9 +22,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MM_EMI |
-					       MT8167_TOP_AXI_PROT_EN_MCU_MM),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MM_EMI |
+						     MT8167_TOP_AXI_PROT_EN_MCU_MM),
 		},
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -56,9 +56,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MCU_MFG |
-					       MT8167_TOP_AXI_PROT_EN_MFG_EMI),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_MCU_MFG |
+						     MT8167_TOP_AXI_PROT_EN_MFG_EMI),
 		},
 	},
 	[MT8167_POWER_DOMAIN_MFG_2D] = {
@@ -88,10 +88,10 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = 0,
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_CONN_EMI |
-					       MT8167_TOP_AXI_PROT_EN_CONN_MCU |
-					       MT8167_TOP_AXI_PROT_EN_MCU_CONN),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8167_TOP_AXI_PROT_EN_CONN_EMI |
+						     MT8167_TOP_AXI_PROT_EN_CONN_MCU |
+						     MT8167_TOP_AXI_PROT_EN_MCU_CONN),
 		},
 	},
 };
diff --git a/drivers/pmdomain/mediatek/mt8173-pm-domains.h b/drivers/pmdomain/mediatek/mt8173-pm-domains.h
index 1a5dc63b7357..7be0f47f5214 100644
--- a/drivers/pmdomain/mediatek/mt8173-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8173-pm-domains.h
@@ -46,9 +46,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MM_M1),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MM_M1),
 		},
 	},
 	[MT8173_POWER_DOMAIN_VENC_LT] = {
@@ -106,11 +106,11 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
-		.bp_infracfg = {
-			BUS_PROT_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
-					       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+						     MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
 		},
 	},
 };
diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
index 99de67fe5de8..c4c1b63d85b1 100644
--- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
@@ -28,9 +28,12 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CONN, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_CONN,
+				    MT8183_TOP_AXI_PROT_EN_SET,
+				    MT8183_TOP_AXI_PROT_EN_CLR,
+				    MT8183_TOP_AXI_PROT_EN_STA1),
 		},
 	},
 	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
@@ -79,11 +82,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_1_MFG, MT8183_TOP_AXI_PROT_EN_1_SET,
-				    MT8183_TOP_AXI_PROT_EN_1_CLR, MT8183_TOP_AXI_PROT_EN_STA1_1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MFG, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_1_MFG,
+				    MT8183_TOP_AXI_PROT_EN_1_SET,
+				    MT8183_TOP_AXI_PROT_EN_1_CLR,
+				    MT8183_TOP_AXI_PROT_EN_STA1_1),
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MFG,
+				    MT8183_TOP_AXI_PROT_EN_SET,
+				    MT8183_TOP_AXI_PROT_EN_CLR,
+				    MT8183_TOP_AXI_PROT_EN_STA1),
 		},
 	},
 	[MT8183_POWER_DOMAIN_DISP] = {
@@ -94,14 +103,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_1_DISP, MT8183_TOP_AXI_PROT_EN_1_SET,
-				    MT8183_TOP_AXI_PROT_EN_1_CLR, MT8183_TOP_AXI_PROT_EN_STA1_1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_DISP, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_DISP,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_1_DISP,
+				    MT8183_TOP_AXI_PROT_EN_1_SET,
+				    MT8183_TOP_AXI_PROT_EN_1_CLR,
+				    MT8183_TOP_AXI_PROT_EN_STA1_1),
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_DISP,
+				    MT8183_TOP_AXI_PROT_EN_SET,
+				    MT8183_TOP_AXI_PROT_EN_CLR,
+				    MT8183_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_DISP,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
 				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
 				    MT8183_SMI_COMMON_CLAMP_EN),
@@ -115,18 +129,24 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_CAM, MT8183_TOP_AXI_PROT_EN_MM_SET,
-				    MT8183_TOP_AXI_PROT_EN_MM_CLR, MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_CAM, MT8183_TOP_AXI_PROT_EN_SET,
-				    MT8183_TOP_AXI_PROT_EN_CLR, MT8183_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MM_CAM,
+				    MT8183_TOP_AXI_PROT_EN_MM_SET,
+				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_CAM,
+				    MT8183_TOP_AXI_PROT_EN_SET,
+				    MT8183_TOP_AXI_PROT_EN_CLR,
+				    MT8183_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8183_TOP_AXI_PROT_EN_MM_CAM_2ND,
 					MT8183_TOP_AXI_PROT_EN_MM_SET,
 					MT8183_TOP_AXI_PROT_EN_MM_CLR,
 					MT8183_TOP_AXI_PROT_EN_MM_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_CAM,
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_CAM,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
 				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
 				    MT8183_SMI_COMMON_CLAMP_EN),
@@ -140,18 +160,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_ISP,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MM_ISP,
 				    MT8183_TOP_AXI_PROT_EN_MM_SET,
 				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND,
+			BUS_PROT_WR_IGN(INFRA,
+					MT8183_TOP_AXI_PROT_EN_MM_ISP_2ND,
 					MT8183_TOP_AXI_PROT_EN_MM_SET,
 					MT8183_TOP_AXI_PROT_EN_MM_CLR,
 					MT8183_TOP_AXI_PROT_EN_MM_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_ISP,
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_ISP,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
 				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
 				    MT8183_SMI_COMMON_CLAMP_EN),
@@ -165,8 +186,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VDEC,
+		.bp_cfg = {
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_VDEC,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
 				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
 				    MT8183_SMI_COMMON_CLAMP_EN),
@@ -180,8 +202,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VENC,
+		.bp_cfg = {
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_VENC,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
 				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
 				    MT8183_SMI_COMMON_CLAMP_EN),
@@ -195,22 +218,24 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP,
 				    MT8183_TOP_AXI_PROT_EN_MM_SET,
 				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_VPU_TOP,
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_VPU_TOP,
 				    MT8183_TOP_AXI_PROT_EN_SET,
 				    MT8183_TOP_AXI_PROT_EN_CLR,
 				    MT8183_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MM_VPU_TOP_2ND,
 				    MT8183_TOP_AXI_PROT_EN_MM_SET,
 				    MT8183_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MM_STA1),
-		},
-		.bp_smi = {
-			BUS_PROT_WR(MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP,
+			BUS_PROT_WR(SMI,
+				    MT8183_SMI_COMMON_SMI_CLAMP_VPU_TOP,
 				    MT8183_SMI_COMMON_CLAMP_EN_SET,
 				    MT8183_SMI_COMMON_CLAMP_EN_CLR,
 				    MT8183_SMI_COMMON_CLAMP_EN),
@@ -224,12 +249,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0,
 				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
 				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE0_2ND,
 				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
 				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
@@ -244,12 +271,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1,
 				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
 				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
-			BUS_PROT_WR(MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8183_TOP_AXI_PROT_EN_MCU_VPU_CORE1_2ND,
 				    MT8183_TOP_AXI_PROT_EN_MCU_SET,
 				    MT8183_TOP_AXI_PROT_EN_MCU_CLR,
 				    MT8183_TOP_AXI_PROT_EN_MCU_STA1),
diff --git a/drivers/pmdomain/mediatek/mt8186-pm-domains.h b/drivers/pmdomain/mediatek/mt8186-pm-domains.h
index fce86f79c505..cbac715c38fa 100644
--- a/drivers/pmdomain/mediatek/mt8186-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8186-pm-domains.h
@@ -33,23 +33,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP2,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP3,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP4,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_MFG1_STEP2,
+					MT8186_TOP_AXI_PROT_EN_SET,
+					MT8186_TOP_AXI_PROT_EN_CLR,
+					MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_MFG1_STEP3,
+					MT8186_TOP_AXI_PROT_EN_SET,
+					MT8186_TOP_AXI_PROT_EN_CLR,
+					MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP4,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
@@ -101,15 +105,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_DIS_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_DIS_STEP2,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_DIS_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_DIS_STEP2,
+					MT8186_TOP_AXI_PROT_EN_SET,
+					MT8186_TOP_AXI_PROT_EN_CLR,
+					MT8186_TOP_AXI_PROT_EN_STA),
 		},
 	},
 	[MT8186_POWER_DOMAIN_IMG] = {
@@ -120,15 +126,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_IMG_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_IMG_STEP2,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -150,15 +158,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_IPE_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_IPE_STEP2,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -170,15 +180,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_CAM_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_CAM_STEP2,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -210,15 +222,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_VENC_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_VENC_STEP2,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -230,15 +244,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP2,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP2,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -250,15 +266,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP1,
-				MT8186_TOP_AXI_PROT_EN_2_SET,
-				MT8186_TOP_AXI_PROT_EN_2_CLR,
-				MT8186_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP2,
-				MT8186_TOP_AXI_PROT_EN_2_SET,
-				MT8186_TOP_AXI_PROT_EN_2_CLR,
-				MT8186_TOP_AXI_PROT_EN_2_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_2_WPE_STEP1,
+					MT8186_TOP_AXI_PROT_EN_2_SET,
+					MT8186_TOP_AXI_PROT_EN_2_CLR,
+					MT8186_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_2_WPE_STEP2,
+					MT8186_TOP_AXI_PROT_EN_2_SET,
+					MT8186_TOP_AXI_PROT_EN_2_CLR,
+					MT8186_TOP_AXI_PROT_EN_2_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
@@ -268,23 +286,27 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.ctl_offs = 0x304,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CONN_ON_STEP1,
-				MT8186_TOP_AXI_PROT_EN_1_SET,
-				MT8186_TOP_AXI_PROT_EN_1_CLR,
-				MT8186_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP2,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP3,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP4,
-				MT8186_TOP_AXI_PROT_EN_SET,
-				MT8186_TOP_AXI_PROT_EN_CLR,
-				MT8186_TOP_AXI_PROT_EN_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_1_CONN_ON_STEP1,
+					MT8186_TOP_AXI_PROT_EN_1_SET,
+					MT8186_TOP_AXI_PROT_EN_1_CLR,
+					MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP2,
+					MT8186_TOP_AXI_PROT_EN_SET,
+					MT8186_TOP_AXI_PROT_EN_CLR,
+					MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP3,
+					MT8186_TOP_AXI_PROT_EN_SET,
+					MT8186_TOP_AXI_PROT_EN_CLR,
+					MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP4,
+					MT8186_TOP_AXI_PROT_EN_SET,
+					MT8186_TOP_AXI_PROT_EN_CLR,
+					MT8186_TOP_AXI_PROT_EN_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
 	},
@@ -320,15 +342,17 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP1,
-				MT8186_TOP_AXI_PROT_EN_3_SET,
-				MT8186_TOP_AXI_PROT_EN_3_CLR,
-				MT8186_TOP_AXI_PROT_EN_3_STA),
-			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP2,
-				MT8186_TOP_AXI_PROT_EN_3_SET,
-				MT8186_TOP_AXI_PROT_EN_3_CLR,
-				MT8186_TOP_AXI_PROT_EN_3_STA),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP1,
+					MT8186_TOP_AXI_PROT_EN_3_SET,
+					MT8186_TOP_AXI_PROT_EN_3_CLR,
+					MT8186_TOP_AXI_PROT_EN_3_STA),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP2,
+					MT8186_TOP_AXI_PROT_EN_3_SET,
+					MT8186_TOP_AXI_PROT_EN_3_CLR,
+					MT8186_TOP_AXI_PROT_EN_3_STA),
 		},
 		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
 	},
diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index 0692cb444ed0..06834ab6597c 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -33,28 +33,34 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_1_SET,
 				    MT8188_TOP_AXI_PROT_EN_1_CLR,
 				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -99,12 +105,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -135,8 +143,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -151,8 +160,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -165,12 +175,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -185,12 +197,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -205,12 +219,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -225,12 +241,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -245,12 +263,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -265,24 +285,29 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -296,16 +321,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -319,16 +347,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -342,8 +373,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -358,8 +390,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -374,16 +407,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -397,12 +433,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -417,12 +455,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -437,12 +477,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
@@ -457,16 +499,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -479,16 +524,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -503,12 +551,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -541,24 +591,29 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_1_SET,
 				    MT8188_TOP_AXI_PROT_EN_1_CLR,
 				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -573,20 +628,24 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
+			BUS_PROT_WR(INFRA,
+				    MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
diff --git a/drivers/pmdomain/mediatek/mt8192-pm-domains.h b/drivers/pmdomain/mediatek/mt8192-pm-domains.h
index b97b2051920f..6f139eed3769 100644
--- a/drivers/pmdomain/mediatek/mt8192-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8192-pm-domains.h
@@ -19,8 +19,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_AUDIO,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_2_AUDIO,
 				    MT8192_TOP_AXI_PROT_EN_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_2_STA1),
@@ -34,16 +35,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_CONN,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_CONN,
 				    MT8192_TOP_AXI_PROT_EN_SET,
 				    MT8192_TOP_AXI_PROT_EN_CLR,
 				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_CONN_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_CONN_2ND,
 				    MT8192_TOP_AXI_PROT_EN_SET,
 				    MT8192_TOP_AXI_PROT_EN_CLR,
 				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_CONN,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_1_CONN,
 				    MT8192_TOP_AXI_PROT_EN_1_SET,
 				    MT8192_TOP_AXI_PROT_EN_1_CLR,
 				    MT8192_TOP_AXI_PROT_EN_1_STA1),
@@ -68,20 +72,24 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_MFG1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_1_MFG1,
 				    MT8192_TOP_AXI_PROT_EN_1_SET,
 				    MT8192_TOP_AXI_PROT_EN_1_CLR,
 				    MT8192_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_2_MFG1,
 				    MT8192_TOP_AXI_PROT_EN_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MFG1,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MFG1,
 				    MT8192_TOP_AXI_PROT_EN_SET,
 				    MT8192_TOP_AXI_PROT_EN_CLR,
 				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_MFG1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_2_MFG1_2ND,
 				    MT8192_TOP_AXI_PROT_EN_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_2_STA1),
@@ -141,24 +149,29 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_DISP,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8192_TOP_AXI_PROT_EN_MM_DISP,
 					MT8192_TOP_AXI_PROT_EN_MM_SET,
 					MT8192_TOP_AXI_PROT_EN_MM_CLR,
 					MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8192_TOP_AXI_PROT_EN_MM_2_DISP,
+			BUS_PROT_WR_IGN(INFRA,
+					MT8192_TOP_AXI_PROT_EN_MM_2_DISP,
 					MT8192_TOP_AXI_PROT_EN_MM_2_SET,
 					MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
 					MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_DISP,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_DISP,
 				    MT8192_TOP_AXI_PROT_EN_SET,
 				    MT8192_TOP_AXI_PROT_EN_CLR,
 				    MT8192_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_DISP_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_DISP_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_DISP_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_DISP_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -172,12 +185,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_IPE,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
@@ -191,12 +206,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -210,12 +227,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_ISP2,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
@@ -229,12 +248,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_MDP,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -248,12 +269,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_VENC,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VENC_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_VENC_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
@@ -267,12 +290,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_VDEC,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_VDEC_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_VDEC_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
@@ -295,24 +320,29 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_CAM,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_2_CAM,
 				    MT8192_TOP_AXI_PROT_EN_2_SET,
 				    MT8192_TOP_AXI_PROT_EN_2_CLR,
 				    MT8192_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_CAM,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_1_CAM,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_1_CAM,
 				    MT8192_TOP_AXI_PROT_EN_1_SET,
 				    MT8192_TOP_AXI_PROT_EN_1_CLR,
 				    MT8192_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_MM_CAM_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_CAM_2ND,
 				    MT8192_TOP_AXI_PROT_EN_MM_SET,
 				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_VDNR_CAM,
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_VDNR_CAM,
 				    MT8192_TOP_AXI_PROT_EN_VDNR_SET,
 				    MT8192_TOP_AXI_PROT_EN_VDNR_CLR,
 				    MT8192_TOP_AXI_PROT_EN_VDNR_STA1),
diff --git a/drivers/pmdomain/mediatek/mt8195-pm-domains.h b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
index d7387ea1b9c9..59aa031ae632 100644
--- a/drivers/pmdomain/mediatek/mt8195-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
@@ -23,12 +23,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P0,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P0,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_SET,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P0,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P0,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
@@ -42,12 +44,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P1,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_SET,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P1,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
@@ -95,8 +99,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_ADSP,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_2_ADSP,
 				    MT8195_TOP_AXI_PROT_EN_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_2_STA1),
@@ -111,8 +116,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_AUDIO,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_2_AUDIO,
 				    MT8195_TOP_AXI_PROT_EN_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_2_STA1),
@@ -136,28 +142,34 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MFG1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MFG1,
 				    MT8195_TOP_AXI_PROT_EN_SET,
 				    MT8195_TOP_AXI_PROT_EN_CLR,
 				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_2_MFG1,
 				    MT8195_TOP_AXI_PROT_EN_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_1_MFG1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_1_MFG1,
 				    MT8195_TOP_AXI_PROT_EN_1_SET,
 				    MT8195_TOP_AXI_PROT_EN_1_CLR,
 				    MT8195_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_2_MFG1_2ND,
 				    MT8195_TOP_AXI_PROT_EN_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MFG1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MFG1_2ND,
 				    MT8195_TOP_AXI_PROT_EN_SET,
 				    MT8195_TOP_AXI_PROT_EN_CLR,
 				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
@@ -222,24 +234,29 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VPPSYS0,
 				    MT8195_TOP_AXI_PROT_EN_SET,
 				    MT8195_TOP_AXI_PROT_EN_CLR,
 				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VPPSYS0_2ND,
 				    MT8195_TOP_AXI_PROT_EN_SET,
 				    MT8195_TOP_AXI_PROT_EN_CLR,
 				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
@@ -253,16 +270,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS0,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDOSYS0,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDOSYS0,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDOSYS0,
 				    MT8195_TOP_AXI_PROT_EN_SET,
 				    MT8195_TOP_AXI_PROT_EN_CLR,
 				    MT8195_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
@@ -276,16 +296,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS1,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -299,16 +322,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDOSYS1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VDOSYS1,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -322,8 +348,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_DP_TX,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_DP_TX,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
@@ -338,8 +365,9 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_EPD_TX,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_EPD_TX,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
 				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
@@ -364,16 +392,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_WPESYS,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_WPESYS,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -387,20 +418,24 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDEC0,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDEC0_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -415,12 +450,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDEC1,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VDEC1_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
@@ -435,12 +472,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -455,16 +494,19 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VENC,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VENC_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VENC,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -479,12 +521,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_CORE1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_VENC_CORE1,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC_CORE1,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_VENC_CORE1,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -499,12 +543,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_IMG,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_IMG_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
@@ -529,12 +575,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IPE,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_IPE,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_IPE,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_IPE,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
@@ -549,24 +597,29 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_CAM,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_2_CAM,
 				    MT8195_TOP_AXI_PROT_EN_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_2_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_CAM,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_1_CAM,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_1_CAM,
 				    MT8195_TOP_AXI_PROT_EN_1_SET,
 				    MT8195_TOP_AXI_PROT_EN_1_CLR,
 				    MT8195_TOP_AXI_PROT_EN_1_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM_2ND,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_CAM_2ND,
 				    MT8195_TOP_AXI_PROT_EN_MM_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_CAM,
+			BUS_PROT_WR(INFRA,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CAM,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 5b694fde7b56..c1154de98830 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -118,9 +118,19 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
-				    struct regmap *regmap)
+static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
+						    const struct scpsys_bus_prot_data *bpd)
 {
+	if (bpd->flags & BUS_PROT_COMPONENT_SMI)
+		return pd->smi;
+	else
+		return pd->infracfg;
+}
+
+static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
+				    const struct scpsys_bus_prot_data *bpd)
+{
+	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 val;
 
@@ -137,9 +147,10 @@ static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
-				  struct regmap *regmap)
+static int scpsys_bus_protect_set(struct scpsys_domain *pd,
+				  const struct scpsys_bus_prot_data *bpd)
 {
+	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 val;
 
@@ -153,15 +164,16 @@ static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 {
-	int i, ret;
+	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
+		int ret;
 
-	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		if (!bpd[i].bus_prot_set_clr_mask)
+		if (!bpd->bus_prot_set_clr_mask)
 			break;
 
-		ret = scpsys_bus_protect_set(&bpd[i], regmap);
+		ret = scpsys_bus_protect_set(pd, bpd);
 		if (ret)
 			return ret;
 	}
@@ -169,27 +181,16 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 	return 0;
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
-{
-	int ret;
-
-	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
-	if (ret)
-		return ret;
-
-	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
-}
-
-static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
-				       struct regmap *regmap)
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 {
-	int i, ret;
+	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
+		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
+		int ret;
 
-	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		if (!bpd[i].bus_prot_set_clr_mask)
+		if (!bpd->bus_prot_set_clr_mask)
 			continue;
 
-		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
+		ret = scpsys_bus_protect_clear(pd, bpd);
 		if (ret)
 			return ret;
 	}
@@ -197,17 +198,6 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
-{
-	int ret;
-
-	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
-	if (ret)
-		return ret;
-
-	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
-}
-
 static int scpsys_regulator_enable(struct regulator *supply)
 {
 	return supply ? regulator_enable(supply) : 0;
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 4c3ab72a907b..209f68dcaeac 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -45,6 +45,8 @@
 enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
+	BUS_PROT_COMPONENT_INFRA = BIT(4),
+	BUS_PROT_COMPONENT_SMI = BIT(5),
 };
 
 #define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
@@ -56,17 +58,19 @@ enum scpsys_bus_prot_flags {
 		.flags = _flags					\
 	}
 
-#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, 0)
+#define BUS_PROT_WR(_hwip, _mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_COMPONENT_##_hwip)
 
-#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_IGNORE_CLR_ACK)
+#define BUS_PROT_WR_IGN(_hwip, _mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
+			  BUS_PROT_COMPONENT_##_hwip | BUS_PROT_IGNORE_CLR_ACK)
 
-#define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_REG_UPDATE)
+#define BUS_PROT_UPDATE(_hwip, _mask, _set, _clr, _sta) \
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, \
+			  BUS_PROT_COMPONENT_##_hwip | BUS_PROT_REG_UPDATE)
 
-#define BUS_PROT_UPDATE_TOPAXI(_mask)				\
-		BUS_PROT_UPDATE(_mask,				\
+#define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)			\
+		BUS_PROT_UPDATE(INFRA, _mask,			\
 				INFRA_TOPAXI_PROTECTEN,		\
 				INFRA_TOPAXI_PROTECTEN,		\
 				INFRA_TOPAXI_PROTECTSTA1)
@@ -90,8 +94,7 @@ struct scpsys_bus_prot_data {
  * @ext_buck_iso_offs: The offset for external buck isolation
  * @ext_buck_iso_mask: The mask for external buck isolation
  * @caps: The flag for active wake-up action.
- * @bp_infracfg: bus protection for infracfg subsystem
- * @bp_smi: bus protection for smi subsystem
+ * @bp_cfg: bus protection configuration for any subsystem
  */
 struct scpsys_domain_data {
 	const char *name;
@@ -102,8 +105,7 @@ struct scpsys_domain_data {
 	int ext_buck_iso_offs;
 	u32 ext_buck_iso_mask;
 	u8 caps;
-	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
-	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
+	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
 };
-- 
2.40.1

