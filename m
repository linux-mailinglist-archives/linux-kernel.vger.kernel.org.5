Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0C7A462F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjIRJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbjIRJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:38:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E612A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:38:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-530a6cbbb47so2925919a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695029907; x=1695634707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjClo4xkeDmrqc325xBc4ylMLN29H3Nj2c2sd61GlRk=;
        b=aTEjsuPCC6PPuhvB4tZ37I5hFzy6+VAKRJBl34OzasX2Cz7Vq6eNI2JR3CUJE0gOHN
         yOGPhmod3gzYtS/xUs2rpTc/Y3tvVyQVdH0hqNxYIX0mQAF0fPpuNfSQKnRMhLdAwPb6
         vE9sl5pAigGw39AaAfP/n4TI8wLmBGWM7CX+Y752LRK31pk8Tq5R10uHnvG7j/D0Ggev
         A8174NhVzJ6QZGZQ7DpibHNECoHALaaV19Puc2dfMruxr4xtBVwZJyoCe2wezoJXxa1u
         ixihBwYRG9xN0zVRFyeV3dZBoRJ2hoMlCWyyFdED5bzpbwL7WK7piGug8qZlEscHQVuc
         zeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029907; x=1695634707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjClo4xkeDmrqc325xBc4ylMLN29H3Nj2c2sd61GlRk=;
        b=q2GAXmJJgn6qDc9Yl8vJL0M04f4nGMMVPFJBfLpyzU73YWV9Sf6XB7euGfnDtj/fI5
         M2cwMPW6HCf2C3q/XMWMl0jKiOSoekX2eKki6n5279CbEcRgDe+YQmlUoFS/p3YW/TP5
         PrygdXbWrYvQEQY3fU9SnxXF/TuKTE6IBLUl3xR3IdpbBQchGtGBu9jVVFkIx8kDdKTD
         ubEN0mQegE/lsZQZmfUP2zU5ETZ8A84HRTFS5mSCzeNjbwxLcHFrXKICvnB8+xylAERo
         72r/zf3fERRsa04p+Md7TdYyG298qn9YUahyo8dap9nrfpzEEG6Wdr0ld/NFuSRSFutt
         MeNA==
X-Gm-Message-State: AOJu0YxTKyjAyE5j5Wk9EV0ZPCAPgEN9RF+iI9lTNeRnJ5GobJQhoaLO
        Mr/9l2zIaE/OWYI4W9KTI45bvg==
X-Google-Smtp-Source: AGHT+IG5kT7m81nr2cfYALjUa49dNQ97RPPmoYgDi+S4RJYIvoH7+IKgfpfd4AnrNN10ZqjeCYkGUw==
X-Received: by 2002:a17:906:2011:b0:9ae:1de:f4f3 with SMTP id 17-20020a170906201100b009ae01def4f3mr2608681ejo.13.1695029907127;
        Mon, 18 Sep 2023 02:38:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0099293cdbc98sm6251164ejh.145.2023.09.18.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:38:26 -0700 (PDT)
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
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 8/8] soc: mediatek: pm-domains: Add support for MT8365
Date:   Mon, 18 Sep 2023 11:37:52 +0200
Message-Id: <20230918093751.1188668-9-msp@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

Add the needed board data to support MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/pmdomain/mediatek/mt8365-pm-domains.h | 197 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
 include/linux/soc/mediatek/infracfg.h         |  41 ++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h

diff --git a/drivers/pmdomain/mediatek/mt8365-pm-domains.h b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
new file mode 100644
index 000000000000..3d83d49eaa7c
--- /dev/null
+++ b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mediatek,mt8365-power.h>
+
+/*
+ * MT8365 power domain support
+ */
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI(_mask)				\
+		BUS_PROT_WR(INFRA, _mask,				\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_SET,		\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_CLR,		\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_STA1)
+
+#define MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(_mask)			\
+		BUS_PROT_WR(INFRA, _mask,				\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_1_SET,	\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR,	\
+			    MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1)
+
+#define MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(port)			\
+		BUS_PROT_WR(SMI, BIT(port),				\
+			    MT8365_SMI_COMMON_CLAMP_EN_SET,		\
+			    MT8365_SMI_COMMON_CLAMP_EN_CLR,		\
+			    MT8365_SMI_COMMON_CLAMP_EN)
+
+#define MT8365_BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
+		_BUS_PROT(_set_mask, _set, _set, _sta_mask, _sta,	\
+			  BUS_PROT_COMPONENT_INFRA |			\
+			  BUS_PROT_STA_COMPONENT_INFRA_NAO |		\
+			  BUS_PROT_INVERTED |				\
+			  BUS_PROT_REG_UPDATE)
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
+	[MT8365_POWER_DOMAIN_MM] = {
+		.name = "mm",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
+			MT8365_BUS_PROT_WAY_EN(
+				MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S,
+				MT8365_INFRA_TOPAXI_SI0_CTL,
+				MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED,
+				MT8365_INFRA_NAO_TOPAXI_SI0_STA),
+			MT8365_BUS_PROT_WAY_EN(
+				MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1,
+				MT8365_INFRA_TOPAXI_SI2_CTL,
+				MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED,
+				MT8365_INFRA_NAO_TOPAXI_SI2_STA),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S),
+		},
+		.caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_INFRA_NAO,
+	},
+	[MT8365_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = 0x0304,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(1),
+		},
+	},
+	[MT8365_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = 0x0314,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(12, 8),
+		.sram_pdn_ack_bits = GENMASK(17, 13),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8365_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8365_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
+		},
+	},
+	[MT8365_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
+		},
+	},
+	[MT8365_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0370,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(3),
+		},
+	},
+	[MT8365_POWER_DOMAIN_APU] = {
+		.name = "apu",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x0378,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(14, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 15),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST),
+			MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
+		},
+	},
+	[MT8365_POWER_DOMAIN_DSP] = {
+		.name = "dsp",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x037C,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_cfg = {
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+};
+
+static const struct scpsys_soc_data mt8365_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8365,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8365),
+};
+
+#endif /* __SOC_MEDIATEK_MT8365_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 69cdf6ff00b8..e26dc17d07ad 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -24,6 +24,7 @@
 #include "mt8188-pm-domains.h"
 #include "mt8192-pm-domains.h"
 #include "mt8195-pm-domains.h"
+#include "mt8365-pm-domains.h"
 
 #define MTK_POLL_DELAY_US		10
 #define MTK_POLL_TIMEOUT		USEC_PER_SEC
@@ -652,6 +653,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8195-power-controller",
 		.data = &mt8195_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8365-power-controller",
+		.data = &mt8365_scpsys_data,
+	},
 	{ }
 };
 
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 07f67b3d8e97..6c6cccc848f4 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -2,6 +2,47 @@
 #ifndef __SOC_MEDIATEK_INFRACFG_H
 #define __SOC_MEDIATEK_INFRACFG_H
 
+#define MT8365_INFRA_TOPAXI_PROTECTEN_STA1				0x228
+#define MT8365_INFRA_TOPAXI_PROTECTEN_SET				0x2a0
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CLR				0x2a4
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0				BIT(1)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1				BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S				BIT(6)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0		BIT(10)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1		BIT(11)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB			BIT(13)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB			BIT(14)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0				BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG			BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1				0x258
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_SET				0x2a8
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR				0x2ac
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP				BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0	BIT(16)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1	BIT(17)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST	BIT(18)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST		BIT(19)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST		BIT(20)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV	BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB	BIT(24)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO		BIT(27)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M		BIT(28)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M		BIT(30)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S		BIT(31)
+
+#define MT8365_INFRA_NAO_TOPAXI_SI0_STA					0x0
+#define MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED			BIT(24)
+#define MT8365_INFRA_NAO_TOPAXI_SI2_STA					0x28
+#define MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED			BIT(14)
+#define MT8365_INFRA_TOPAXI_SI0_CTL					0x200
+#define MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S				BIT(6)
+#define MT8365_INFRA_TOPAXI_SI2_CTL					0x234
+#define MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1				BIT(5)
+
+#define MT8365_SMI_COMMON_CLAMP_EN			0x3c0
+#define MT8365_SMI_COMMON_CLAMP_EN_SET			0x3c4
+#define MT8365_SMI_COMMON_CLAMP_EN_CLR			0x3c8
+
 #define MT8195_TOP_AXI_PROT_EN_STA1                     0x228
 #define MT8195_TOP_AXI_PROT_EN_1_STA1                   0x258
 #define MT8195_TOP_AXI_PROT_EN_SET			0x2a0
-- 
2.40.1

