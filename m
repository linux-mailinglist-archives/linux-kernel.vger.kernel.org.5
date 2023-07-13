Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCFD752612
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGMPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjGMPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:04:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24431B6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992b27e1c55so120604066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689260670; x=1691852670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZuj2vYwtu1q+1KUWNq9Rx/83sQjYgOtd/pHC+rLp7M=;
        b=RkOwDzpMuH2Q9wEvS+/gVNzvc/el3qTstPACqXVvJhgiFkyO7cPmPhjkqX8bY/QLbu
         u9SKdly9DwBumaoDqWYPBQ1978dW7/fouv1P0eozmwURIR0aJdPnUEa58U448y9oBKxB
         5RBWiTAwtqECxcetJeECbX6/8qH6UTWahp0ZvOJ/6EJL6gEnol6jN4/Xw/0nbB8N4X+H
         Q48XYb8vfaAo7S2vdE0XM29Sx8zQeMXxUeM+gaUt5dlVONtiIoMr82nXBCef7KUcMgF+
         XXBldbQz5isMQVIjGEw041lqXVa/Z3YxOYloRIFOMXVLhS4wnj0CpRzqFO+RMKQeNl5/
         8mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260670; x=1691852670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZuj2vYwtu1q+1KUWNq9Rx/83sQjYgOtd/pHC+rLp7M=;
        b=VsV3F8+VX9Nc2RIq1eetu0qCjYmI08wqcs5s1LKxoZijeogr0Oq0waOhTqMPE3k08j
         NXWPL0hTUeYvbr+4ABJuACLnPG+Zb/cYd/nT7SK/vPIW3O1GeQrNhrYfcuRmOQXaBIBG
         bw9MZC9ZLHwW6XoJzd7vjUYISTgwCgUYShm/eP2BYAWnIaF95Xj3CMw9C+kwRoRLw029
         Ct6N3FaxvHl1+FKJFTWqKPlcum0vSE61XTrq+/039xb7HoQ6koDB3m0rpI7n8FPoDCIo
         w5RplsAMzj84ffnSB4SasxQ3NIEG5PiK++4mPXihQ0bjLv+QSjkMLcFl2lCuftO1+Sgx
         z5Xg==
X-Gm-Message-State: ABy/qLaQCeiee0ISiFeLWRTSwgpJY7dLorqTKJ5Wml71frbYqUkWdQw2
        qrWzjMGlCAV02uChnyd1JkWRug==
X-Google-Smtp-Source: APBJJlGQBOniWxQQ0p4125shOSawu+R4zWBBkYj1MASWCD7uyRwcaZd75TijtpdYHX2tDjuhURKpQw==
X-Received: by 2002:a17:906:10d9:b0:98e:2b01:ab97 with SMTP id v25-20020a17090610d900b0098e2b01ab97mr1739243ejv.68.1689260670406;
        Thu, 13 Jul 2023 08:04:30 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:1d6d:d215:e7c4:dd5e])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b009929c39d5c4sm4102939ejb.36.2023.07.13.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:04:30 -0700 (PDT)
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
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 4/8] soc: mediatek: pm-domains: Create bus protection operation functions
Date:   Thu, 13 Jul 2023 17:04:10 +0200
Message-Id: <20230713150414.891893-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713150414.891893-1-msp@baylibre.com>
References: <20230713150414.891893-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the register access used for bus protection enable/disable into
their own functions. These will be used later for WAY_EN support.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 68 +++++++++++++++------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index a2c8f5313124..a7a46fb132ee 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -118,26 +118,50 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
 					MTK_POLL_TIMEOUT);
 }
 
+static int scpsys_bus_protect_clear(const struct scpsys_bus_prot_data *bpd,
+				    struct regmap *regmap)
+{
+	u32 sta_mask = bpd->bus_prot_sta_mask;
+	u32 val;
+
+	if (bpd->flags & BUS_PROT_REG_UPDATE)
+		regmap_clear_bits(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
+	else
+		regmap_write(regmap, bpd->bus_prot_clr, bpd->bus_prot_set_clr_mask);
+
+	if (bpd->flags & BUS_PROT_IGNORE_CLR_ACK)
+		return 0;
+
+	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+					val, !(val & sta_mask),
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_bus_protect_set(const struct scpsys_bus_prot_data *bpd,
+				  struct regmap *regmap)
+{
+	u32 sta_mask = bpd->bus_prot_sta_mask;
+	u32 val;
+
+	if (bpd->flags & BUS_PROT_REG_UPDATE)
+		regmap_set_bits(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
+	else
+		regmap_write(regmap, bpd->bus_prot_set, bpd->bus_prot_set_clr_mask);
+
+	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta,
+					val, (val & sta_mask) == sta_mask,
+					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
 static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
 {
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
-		u32 sta_mask = bpd[i].bus_prot_sta_mask;
-		u32 val;
-
-		if (!set_clr_mask)
+		if (!bpd[i].bus_prot_set_clr_mask)
 			break;
 
-		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
-			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
-		else
-			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
-
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, (val & sta_mask) == sta_mask,
-					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		ret = scpsys_bus_protect_set(&bpd[i], regmap);
 		if (ret)
 			return ret;
 	}
@@ -162,24 +186,10 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	int i, ret;
 
 	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
-		u32 sta_mask = bpd[i].bus_prot_sta_mask;
-		u32 val;
-
-		if (!set_clr_mask)
-			continue;
-
-		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
-			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
-		else
-			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
-
-		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
+		if (!bpd[i].bus_prot_set_clr_mask)
 			continue;
 
-		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, !(val & sta_mask),
-					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		ret = scpsys_bus_protect_clear(&bpd[i], regmap);
 		if (ret)
 			return ret;
 	}
-- 
2.40.1

