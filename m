Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3857A4627
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjIRJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjIRJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:38:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697A126
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:38:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a645e54806so529917866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695029901; x=1695634701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPkAO3LL0QvdQ7w2MdKUYOEVc2znuVAY79aOTVN0dCo=;
        b=LJ+cfd0l/jPunwhRwkKj7zmyWOFU8E3d3bpl8OBgAyh4Smf80S6FZnUwsQnjkg8xJN
         GP2W3KrUb5nC2WdeZ+lF0XOEv/dSYOdJ9sZrLj+gUXKalrL/D+38YwTjRMU6qh+rG2e6
         s627R1v530HvN0Rp2/PgqbGUs4/Bxwjczk2MFCgq4YXmYrejhHbxOCZsDiq+wptbOCpf
         +nzb3XFBDJE8bfQsQpeU1GOt5bcF9Xn8pDf1I5YmugAXoNDzug76rm7J2md7rBBdvn4T
         LJxqEz88SLaWoNpf2FsTKcHeA4l1a4Ul02s8bThH/JI6kJ0qs7egAkXK/P/7/d2uMFE7
         Lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029901; x=1695634701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPkAO3LL0QvdQ7w2MdKUYOEVc2znuVAY79aOTVN0dCo=;
        b=NTn+z/83pzlKTe5N/cfhIRhuhgsOL79NzklC4gWKWE2MWqPkrHRURj000HwP+pWdwx
         UlpaATRbp9sQ8j0i7ULPPjBbb63ea+4+LvojdsdItm+S/h1O/s/dTOwwuLaPQzkwvE6s
         J1NX+y//+SlJZa+yuTGmPrGDl4hbvgP1LYibXfqML2B6fYMnjoLa/jLcwhZ5hOLpyzNU
         cwEKWw16prbbxX25pdbu/dAGA2GjLZU+DzGarSrPDxlEwz2UknRcgwOSsEd5EC/gy9dj
         aJBrPtXkoGf+mLb8jEMiwPm4F64DvNFNAZXLJQ2urXJNHutdHOwFDs3UzVsa8nBPk9RC
         wMUQ==
X-Gm-Message-State: AOJu0Yyf8Tk6Wtg6z7jyltyQh5K5BvQlQOojNPJIgly+Vp0Qem7NyofT
        eFRspgw1m7l+gRshj6R6WcmP/Q==
X-Google-Smtp-Source: AGHT+IHs7Cnv3jg5GzRKlzpQ9IDZ3feX0H8AC8mFOZw7p6rbCJmOXZ1Kq/GmBfj0dKmJX4KbWT9GYw==
X-Received: by 2002:a17:907:2ccb:b0:9a9:e4ce:c9a2 with SMTP id hg11-20020a1709072ccb00b009a9e4cec9a2mr7340397ejc.53.1695029901406;
        Mon, 18 Sep 2023 02:38:21 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0099293cdbc98sm6251164ejh.145.2023.09.18.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:38:21 -0700 (PDT)
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
Subject: [PATCH v8 3/8] soc: mediatek: pm-domains: Split bus_prot_mask
Date:   Mon, 18 Sep 2023 11:37:47 +0200
Message-Id: <20230918093751.1188668-4-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918093751.1188668-1-msp@baylibre.com>
References: <20230918093751.1188668-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus_prot_mask is used for all operations, set clear and acknowledge. In
preparation of m8365 power domain support split this one mask into two,
one mask for set and clear, another one for acknowledge.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 24 +++++++++++++---------
 drivers/pmdomain/mediatek/mtk-pm-domains.h | 14 +++++++------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index da675a33bdf5..dbb268e96310 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -123,18 +123,20 @@ static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, st
 	int i, ret;
 
 	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
-		u32 val, mask = bpd[i].bus_prot_mask;
+		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
+		u32 sta_mask = bpd[i].bus_prot_sta_mask;
+		u32 val;
 
-		if (!mask)
+		if (!set_clr_mask)
 			break;
 
 		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
-			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
+			regmap_set_bits(regmap, bpd[i].bus_prot_set, set_clr_mask);
 		else
-			regmap_write(regmap, bpd[i].bus_prot_set, mask);
+			regmap_write(regmap, bpd[i].bus_prot_set, set_clr_mask);
 
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, (val & mask) == mask,
+					       val, (val & sta_mask) == sta_mask,
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
@@ -160,21 +162,23 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 	int i, ret;
 
 	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
-		u32 val, mask = bpd[i].bus_prot_mask;
+		u32 set_clr_mask = bpd[i].bus_prot_set_clr_mask;
+		u32 sta_mask = bpd[i].bus_prot_sta_mask;
+		u32 val;
 
-		if (!mask)
+		if (!set_clr_mask)
 			continue;
 
 		if (bpd[i].flags & BUS_PROT_REG_UPDATE)
-			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
+			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, set_clr_mask);
 		else
-			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
+			regmap_write(regmap, bpd[i].bus_prot_clr, set_clr_mask);
 
 		if (bpd[i].flags & BUS_PROT_IGNORE_CLR_ACK)
 			continue;
 
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
-					       val, !(val & mask),
+					       val, !(val & sta_mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret)
 			return ret;
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index d8c0c299dd45..4c3ab72a907b 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -47,22 +47,23 @@ enum scpsys_bus_prot_flags {
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
 };
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _flags) {		\
-		.bus_prot_mask = (_mask),			\
+#define _BUS_PROT(_set_clr_mask, _set, _clr, _sta_mask, _sta, _flags) {	\
+		.bus_prot_set_clr_mask = (_set_clr_mask),	\
 		.bus_prot_set = _set,				\
 		.bus_prot_clr = _clr,				\
+		.bus_prot_sta_mask = (_sta_mask),		\
 		.bus_prot_sta = _sta,				\
 		.flags = _flags					\
 	}
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-		_BUS_PROT(_mask, _set, _clr, _sta, 0)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, 0)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_IGNORE_CLR_ACK)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_IGNORE_CLR_ACK)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, BUS_PROT_REG_UPDATE)
+		_BUS_PROT(_mask, _set, _clr, _mask, _sta, BUS_PROT_REG_UPDATE)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -71,9 +72,10 @@ enum scpsys_bus_prot_flags {
 				INFRA_TOPAXI_PROTECTSTA1)
 
 struct scpsys_bus_prot_data {
-	u32 bus_prot_mask;
+	u32 bus_prot_set_clr_mask;
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
+	u32 bus_prot_sta_mask;
 	u32 bus_prot_sta;
 	u8 flags;
 };
-- 
2.40.1

