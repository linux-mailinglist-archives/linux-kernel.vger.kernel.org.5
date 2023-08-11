Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E4778C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjHKKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjHKKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E2E5C;
        Fri, 11 Aug 2023 03:48:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlrR1092962;
        Fri, 11 Aug 2023 05:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750873;
        bh=Tp2QgrB8tCvb/QQfth0MGxz7+7yJ6LRuOrdjwNQ12Po=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hggH12wexSmj/KBcq+bWY8DGcZPfo9WjnPzYm1efobHI/5MAU7kLq18vd9e+4He1B
         yrLg8HyqOFtlYlGNGAGl7Q3++zMPZ3J4cyCdIGwvds0eaVeWuu9FXpEIt+N34JCEL7
         GMNIVNFJkU13SoQQAq6iqChD5njsvhqb0dQVmQAI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlrot041968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:53 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:52 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlq5H008299;
        Fri, 11 Aug 2023 05:47:52 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v9 09/13] media: cadence: csi2rx: Fix stream data configuration
Date:   Fri, 11 Aug 2023 16:17:31 +0530
Message-ID: <20230811-upstream_csi-v9-9-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=RlcrrehLFe+hG3TiUpTHm5QtZkOc/RxB0DZpu5hgOzE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g8FkvbYM1oPinCX7J7OhxCS6I4Q32BaAUX3m
 HTvoux/tjaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYPBQAKCRBD3pH5JJpx
 RWGLD/9W3wJCa9x6e8TacMw3ePUHN9NEVN0ffLIPBHKAOSf8tPLdSWwRvCcBatlBIohLpWEiTeG
 LgDVZNEom4Vii82olxMzUHJCjHkkXtijEk01G4j37N+leDZhgNTjVEWFOQBlz6nFeT5I2FpJZV0
 iPcpR5lPewxr0XE/EOMaboLjsEODH0e2oCXGup7d52hprmgOq7jcSmlJ9md36Ul5EJZX1cdk+HL
 TprUswGRCuF4xevBBu3x62KOo/3CsQbUQ/W8WkHoWkvnQCK8Ka+cE8Al7ajrDuoD6RURCfOcVAx
 blRxWsPBMZ9dSvvDOuyEQCkm8kN5mDiwfrxZIapAXhMUGZEnjFzDZi9Uhw/n6C7GP+DS1pN5Xgt
 0BB9t+/9Nyfcodk8kMdqqAsOHU1pNAGsR75txf/vrXIZuTD0rbDTqI+Eh19vOs2fr1Se6sP75Vg
 IiXwM+LqBMsCWO3Vxp1QQtB05tDuGazqsBL5LAZzzgz/x2AGNV21xgfc6VA4XoT9x9J50qX1/gz
 HbO4SEVhy9ZM4ai0Vt+LL9BKfvoX2QRwS3J+6Vz7S5Vk3Azp9EXmNPCme74ELPDk3DItnXu86WU
 a8+9kN3LUZ5cqDpfnzJwFXIioIBEZdzB5btZbTtlPXOQ3t+JNYJlmLvnVlKu6RIOgg3JeVuyziN
 Smo5A+6kBd7vTnA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Firstly, there is no VC_EN bit present in the STREAM_DATA_CFG register.
Bit 31 is part of the VL_SELECT field. Remove it completely.

Secondly, it makes little sense to enable ith virtual channel for ith
stream. Sure, there might be a use-case that demands it. But there might
also be a use case that demands all streams to use the 0th virtual
channel. Prefer this case over the former because it is less arbitrary
and also makes it very clear what the limitations of the current driver
is instead of giving a false impression that multiple virtual channels
are supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f8205c3a28c0..46effbbe580d 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -49,7 +49,6 @@
 #define CSI2RX_STREAM_STATUS_RDY			BIT(31)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
-#define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
 
 #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
@@ -271,8 +270,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		writel(CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT |
-		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
+		/*
+		 * Enable one virtual channel. When multiple virtual channels
+		 * are supported this will have to be changed.
+		 */
+		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,

-- 
2.41.0
