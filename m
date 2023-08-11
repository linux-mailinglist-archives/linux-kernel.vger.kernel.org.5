Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04E3778C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjHKKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjHKKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A6BE52;
        Fri, 11 Aug 2023 03:48:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAloMi088936;
        Fri, 11 Aug 2023 05:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750870;
        bh=Jt/CtUJuvXw143SkqQX5c8m1ZObK6v0lOQaL9M+GqKw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p4wfv6ojuUec7N/hdWdI3pYKP0uTZmj/QRklyuANk5+KwNBRoznYTW2LQyUWrYX31
         ExcJdQQ8+ndaOkgBEl5czBlZaHqNijkgxSyBtqqbe+1xHC1OJJqxovfX52574bTfv7
         ms7gdWmYrM8TKRjNtl5CXO1LZcxeFK6uOBDOkSaY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlocc041945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:50 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAln0w008272;
        Fri, 11 Aug 2023 05:47:49 -0500
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
Subject: [PATCH v9 07/13] media: cadence: csi2rx: Soft reset the streams before starting capture
Date:   Fri, 11 Aug 2023 16:17:29 +0530
Message-ID: <20230811-upstream_csi-v9-7-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=ND2+AeL/8naVEz1dLhGdl9YP2oZXLbJkqWDu7tykgBY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g8BdvyE3kkHeBUT1BHxluyU5iP4UDye9dIGD
 PHmzrG9lVKJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYPAQAKCRBD3pH5JJpx
 RdFRD/4xFvP4EG7d7m365bT1NpU3doOJKtBE57fyECqryuflTFrskWMNJzvdsFjxXt/i5j1oF//
 pGYQGTlk3jxI5HR8Lo477dkD0cKsDk7yWzfqZd06uH3Cjs6Qan/nfyaXQYFVQDQZBnOq56TPbMm
 AUCfg0ubTuJAXEov7N03WtpPDLVyEt81iRpkmrCz1XAFi5SaWJOcsoORzDQxNE1QQ4+XFxfq+n0
 hYcuX3JjFStbI1fsb0ARhPLxibhqjkGcOEIC9u36en9sg1K+WLDOkS6VhQV3JkmR1w5+Y0I/7eg
 k9LIMaik4VEqZXv0UfF5GIIZw1mWGB2m8Gn7BUZ560+oFcY6emjjtpm5YiIA4SbXebZYx+UP+lO
 y9JH9ipz/6s2Ec1yM7xH4lG7Jc2b96DyosqEmtXNiS3ZFXIFP1nbGr7XTqTnz5mRQ9hB2WArrTT
 YB0WmXuKnUIYJskBXolm6HYSApkQUUunTlVfPpUViBgYy+sC63v8crXWmvqJqRY7MGG3cq9JSo6
 Q1VEN6WCJu8AjOOluYDC4oMwRSKkeOHzXt63qX0fAgkTr7eyVUP4xy1k1Yi2tJcnM4w2a+I2/tm
 2abHZMAS8MWLh9vZQ6Wvq7Trpa52Y4Lj69/UbwQiIhvEUC4Pa2KmOFLcz5Sktb3ap6tZ8RmC94e
 kgqIgDUs2OmClSQ==
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

This resets the stream state machines and FIFOs, giving them a clean
slate. On J721E if the streams are not reset before starting the
capture, the captured frame gets wrapped around vertically on every run
after the first.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes from v8:
    - Simplify reset sequence, minimizing delays

 drivers/media/platform/cadence/cdns-csi2rx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 933edec89520..b57e0c3b1944 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -40,6 +40,7 @@
 #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
+#define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
 #define CSI2RX_STREAM_CTRL_START			BIT(0)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
@@ -134,12 +135,23 @@ struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 
 static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 {
+	unsigned int i;
+
+	/* Reset module */
 	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
 	       csi2rx->base + CSI2RX_SOFT_RESET_REG);
+	/* Reset individual streams. */
+	for (i = 0; i < csi2rx->max_streams; i++) {
+		writel(CSI2RX_STREAM_CTRL_SOFT_RST,
+		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+	}
 
-	udelay(10);
+	usleep_range(10, 20);
 
+	/* Clear resets */
 	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
+	for (i = 0; i < csi2rx->max_streams; i++)
+		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
 }
 
 static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)

-- 
2.41.0
