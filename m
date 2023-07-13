Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2625775260E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGMPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGMPEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:04:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E667010D4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-986d8332f50so123849266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689260668; x=1691852668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ng63cZGntPuN0j1n9XuJdxXGmv1YE1KlQ3j2MXnap4=;
        b=lQe41vnEFdqLyJ1o9YHM2ytU8kUBmglnP9jpOoPejOiPsl4O/66oeQyD/DkzKwLmJa
         S2fpJo54olIwFolsKPT6QwoP8x0xWeBuW0mrc4ILvOzRLp2INGvzHpgoS1ZEJveqA955
         xNaB+5f87gTytEA8UeSGAOsmWvO5RzsL6ExzcPrQae7/4IqsGv/NBrtJuUCQ/2z3lIIm
         9LhRcNJtIaIN4hPmTenqvmE2xvCzGtj/bl23j4bqv8jFblc8sqYDWPJwzDtA7FtwsKZI
         Rj3eFoXo+xNJKsoJeof4No6gV53sILXPLJrzj1aDeXk1G7NvfRWux9rlSVfJVcfRmhTx
         SKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260668; x=1691852668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ng63cZGntPuN0j1n9XuJdxXGmv1YE1KlQ3j2MXnap4=;
        b=Fb33e45Ple/dUpoJRw8vOTWClEw35u/5KiACivlRhzMPfM8Wq0pOtszpYJDMK5Eh5E
         Dd5f6UDpWbgMbKcw88azBdSpWwvsD9uKJxfYN1px/xGajD36jyhSphORnF0gYqrZpxHz
         KBSuIyrnTf0P9JxlQLlOUCzSIIrAHc1Bthbk03quUrNf05SQU1cxX0L/nuov22iOgduB
         Y3sHk114ACbzD58KtFjA/C4MXXoXwQO6z29gxSjg3usHekFKajKIVg15SM2kaI+17+10
         RB77mNjiweoyTQKqpxkjoE9SLoJP6QmquC5NDtZ30o/wf9i1kEdqjUfuhwatEji+S/nd
         Z5Xw==
X-Gm-Message-State: ABy/qLZwsB9aWMaAI8ZtGOQSVHriK9U84XF7xZ+8AAi/Qa3fFZaDZi7M
        7RrYGyQqo9+QK6baQG+WLPmvJg==
X-Google-Smtp-Source: APBJJlFS1yOXkJiGcsubz6fbxOwOREGZZ4cJYCXM2GYnkUxFZlHMLbXnpHunATsi046sOFIlMRziuQ==
X-Received: by 2002:a17:907:30cc:b0:994:577:f9dd with SMTP id vl12-20020a17090730cc00b009940577f9ddmr1614554ejb.9.1689260668546;
        Thu, 13 Jul 2023 08:04:28 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:1d6d:d215:e7c4:dd5e])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b009929c39d5c4sm4102939ejb.36.2023.07.13.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:04:28 -0700 (PDT)
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
Subject: [PATCH v7 2/8] soc: mediatek: pm-domains: Move bools to a flags field
Date:   Thu, 13 Jul 2023 17:04:08 +0200
Message-Id: <20230713150414.891893-3-msp@baylibre.com>
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

To simplify the macros, use a flags field for simple bools. This is in
preparation for more flags.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c |  6 +++---
 drivers/soc/mediatek/mtk-pm-domains.h | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 354249cc1b12..aa9ab413479e 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -128,7 +128,7 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 		if (!mask)
 			break;
 
-		if (bpd[i].bus_prot_reg_update)
+		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
 			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
 		else
 			regmap_write(regmap, bpd[i].bus_prot_set, mask);
@@ -165,12 +165,12 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 		if (!mask)
 			continue;
 
-		if (bpd[i].bus_prot_reg_update)
+		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
 			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
 		else
 			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
-		if (bpd[i].ignore_clr_ack)
+		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
 			continue;
 
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 5ec53ee073c4..d8c0c299dd45 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -42,23 +42,27 @@
 
 #define SPM_MAX_BUS_PROT_DATA		6
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
+enum scpsys_bus_prot_flags {
+	BUS_PROT_REG_UPDATE = BIT(1),
+	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
+};
+
+#define _BUS_PROT(_mask, _set, _clr, _sta, _flags) {		\
 		.bus_prot_mask = (_mask),			\
 		.bus_prot_set = _set,				\
 		.bus_prot_clr = _clr,				\
 		.bus_prot_sta = _sta,				\
-		.bus_prot_reg_update = _update,			\
-		.ignore_clr_ack = _ignore,			\
+		.flags = _flags					\
 	}
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+		_BUS_PROT(_mask, _set, _clr, _sta, 0)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
+		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_IGNORE_CLR_ACK)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
+		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_REG_UPDATE)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -71,8 +75,7 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
 	u32 bus_prot_sta;
-	bool bus_prot_reg_update;
-	bool ignore_clr_ack;
+	u8 flags;
 };
 
 /**
-- 
2.40.1

