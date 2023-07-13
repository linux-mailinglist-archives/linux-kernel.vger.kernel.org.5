Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC7752615
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGMPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjGMPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:04:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DA4171D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9741caaf9d4so112597666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689260672; x=1691852672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwOgY7arZQoD9h63g66frjyHGnfB6U24ntym8yk4GhQ=;
        b=pg4Y6nPC9XR3k2s7akLzXuxkJX/iY4DWEw7l20/UXuQn5urHVoEQMpCEr3nDkLPD3Z
         RfmleBoYnH0yq+MolsXj0MXezzT2L5xPLp9uDiCUwwvooN9Dbye81UucFVkGD7GWVIZp
         poQQx/+n2Fu0fF8O/6Vpk9Hep9w3z2L52X1kpsA7kgoEgznWTmBLqPmqTQ+sJ4oDFkAQ
         LInn93Gx4ho6TTd/qR2mvxZcLd7/IKr+Dc3AjeyfiuK74k2vYghNrpcMSSVOQbQEjsah
         cMrYSdiC6NwacLYprhBTdwp7xpMhz1AADA4wimWUJfjb/aGoqjWqAE29SVn+FKmUyuhs
         VEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260672; x=1691852672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwOgY7arZQoD9h63g66frjyHGnfB6U24ntym8yk4GhQ=;
        b=BZmlnyBIt7348062A049dhD45pyjjyQRok/XQPdyMfC7tK9dQr7utkf59Ug+iGbXm0
         ZE3keW6eUHBcB//QkSp5A28z51YgZkkAiO0/7LVg8K/rLuwn0sjfh5azroxYVgwTxP8/
         KAEQs+VIlPxyNT4DtsVD+VCYWaFWoA+8m6rceiB1nMosuBHdyt4qkK3x6Zs4/2kk0g2U
         OY34Pjq2JTz91oRL6hs/5c/VDZNrbg8VWuHIZeLEY64r7pXK12LvhGYzOcckjCVPPuJU
         Awg6VrgW8/0Na2+0Xi2MeDGrNB9+r9CO9Cv4qmC7RdBEigDF2vfi7Zl/bRC2sayEta19
         SP0g==
X-Gm-Message-State: ABy/qLZ2xcC74ObD0ACDdG45/vWfUxLeTxzUHKtyd1dEzN/UEMJupCDm
        QbqEBkIzmxG3Kn+h3KO27D3+1Q==
X-Google-Smtp-Source: APBJJlHZc/uqfeCZE6Ejq3/nXF8F3WRbm2b3JzEmpq/zW8o8yySGkieRjMIEYx68o1+24z4k4BybPg==
X-Received: by 2002:a17:906:cd0e:b0:992:a90a:5d1f with SMTP id oz14-20020a170906cd0e00b00992a90a5d1fmr1805125ejb.68.1689260672579;
        Thu, 13 Jul 2023 08:04:32 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:1d6d:d215:e7c4:dd5e])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b009929c39d5c4sm4102939ejb.36.2023.07.13.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:04:32 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 6/8] soc: mediatek: Add support for WAY_EN operations
Date:   Thu, 13 Jul 2023 17:04:12 +0200
Message-Id: <20230713150414.891893-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713150414.891893-1-msp@baylibre.com>
References: <20230713150414.891893-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This updates the power domain to support WAY_EN operations. WAY_EN
operations on mt8365 are using a different component to check for the
acknowledgment, namely the infracfg-nao component. Also to enable a way
it the bit needs to be cleared while disabling a way needs a bit to be
set. To support these two operations two flags are added,
BUS_PROT_INVERTED and BUS_PROT_STA_COMPONENT_INFRA_NAO. Additionally
another regmap is created if the INFRA_NAO capability is set.

This operation is required by the mt8365 for the MM power domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 39 +++++++++++++++++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h |  3 +++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 5d10a363e435..a9ac79e5c295 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -44,6 +44,7 @@ struct scpsys_domain {
 	struct clk_bulk_data *clks;
 	int num_subsys_clks;
 	struct clk_bulk_data *subsys_clks;
+	struct regmap *infracfg_nao;
 	struct regmap *infracfg;
 	struct regmap *smi;
 	struct regulator *supply;
@@ -127,13 +128,26 @@ static struct regmap *scpsys_bus_protect_get_regmap(struct scpsys_domain *pd,
 		return pd->infracfg;
 }
 
+static struct regmap *scpsys_bus_protect_get_sta_regmap(struct scpsys_domain *pd,
+							const struct scpsys_bus_prot_data *bpd)
+{
+	if (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO)
+		return pd->infracfg_nao;
+	else
+		return scpsys_bus_protect_get_regmap(pd, bpd);
+}
+
 static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
 				    const struct scpsys_bus_prot_data *bpd)
 {
+	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
 	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 sta_mask = bpd->bus_prot_sta_mask;
+	u32 expected_ack;
 	u32 val;
 
+	expected_ack = (bpd->flags & BUS_PROT_STA_COMPONENT_INFRA_NAO ? sta_mask : 0);
+
 	if (bpd->flags & BUS_PROT_REG_UPDATE)
 		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
 	else
@@ -142,14 +156,15 @@ static int scpsys_bus_protect_clear(struct scpsys_domain *pd,
 	if (bpd->flags & BUS_PROT_IGNORE_CLR_ACK)
 		return 0;
 
-	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
-					val, !(val & sta_mask),
+	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
+					val, (val & sta_mask) == expected_ack,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
 static int scpsys_bus_protect_set(struct scpsys_domain *pd,
 				  const struct scpsys_bus_prot_data *bpd)
 {
+	struct regmap *sta_regmap = scpsys_bus_protect_get_sta_regmap(pd, bpd);
 	struct regmap *regmap = scpsys_bus_protect_get_regmap(pd, bpd);
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 	u32 val;
@@ -159,7 +174,7 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
 	else
 		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
 
-	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+	return regmap_read_poll_timeout(sta_regmap, bpd->bus_prot_sta,
 					val, (val & sta_mask) == sta_mask,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
@@ -173,7 +188,10 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 		if (!bpd->bus_prot_set_clr_mask)
 			break;
 
-		ret = scpsys_bus_protect_set(pd, bpd);
+		if (bpd->flags & BUS_PROT_INVERTED)
+			ret = scpsys_bus_protect_clear(pd, bpd);
+		else
+			ret = scpsys_bus_protect_set(pd, bpd);
 		if (ret)
 			return ret;
 	}
@@ -190,7 +208,10 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 		if (!bpd->bus_prot_set_clr_mask)
 			continue;
 
-		ret = scpsys_bus_protect_clear(pd, bpd);
+		if (bpd->flags & BUS_PROT_INVERTED)
+			ret = scpsys_bus_protect_set(pd, bpd);
+		else
+			ret = scpsys_bus_protect_clear(pd, bpd);
 		if (ret)
 			return ret;
 	}
@@ -377,6 +398,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 			return ERR_CAST(pd->smi);
 	}
 
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_INFRA_NAO)) {
+		pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
+		if (IS_ERR(pd->infracfg_nao))
+			return ERR_CAST(pd->infracfg_nao);
+	} else {
+		pd->infracfg_nao = NULL;
+	}
+
 	num_clks = of_clk_get_parent_count(node);
 	if (num_clks > 0) {
 		/* Calculate number of subsys_clks */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 209f68dcaeac..17c033217704 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -11,6 +11,7 @@
 /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
 #define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
+#define MTK_SCPD_HAS_INFRA_NAO		BIT(7)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -45,8 +46,10 @@
 enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
+	BUS_PROT_INVERTED = BIT(3),
 	BUS_PROT_COMPONENT_INFRA = BIT(4),
 	BUS_PROT_COMPONENT_SMI = BIT(5),
+	BUS_PROT_STA_COMPONENT_INFRA_NAO = BIT(6),
 };
 
 #define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
-- 
2.40.1

