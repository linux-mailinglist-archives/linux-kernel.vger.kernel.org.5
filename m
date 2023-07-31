Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243D769034
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGaIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjGaI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:56 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BDF18C;
        Mon, 31 Jul 2023 01:29:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TkaN054942;
        Mon, 31 Jul 2023 03:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792186;
        bh=dKmMEpqsVJQCvV6Lp8DGVqTPdKyQoRAETp9L6a97G68=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LkR2METcX3SYvaFJHj8dsj6i6n/p241ccTOgSV4G3UZngKlpPCJ+b0IUUN1wiGOZA
         +d5k2Wutngp0+0r8lhM3c36FGEa9XjP0quvBhP/i4in0Si35Sz4edq8qC9f1qj+k+o
         g1KPLt/Fuxiog9GCPGhajb6Vft8UYZn08JPlB85Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TkSW106720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:46 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TjWa041939;
        Mon, 31 Jul 2023 03:29:45 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 09/16] media: cadence: csi2rx: Soft reset the streams before starting capture
Date:   Mon, 31 Jul 2023 13:59:27 +0530
Message-ID: <20230731-upstream_csi-v8-9-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Jr1HqoB3E2drdTZLT7y6JgE0f/Pnt2n1lScYOS5wBxs=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xqE2Q0tImNDFK01hdkztRVJ/xOXdVJIENUI
 a7LnemX9XaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsagAKCRBD3pH5JJpx
 RUwYD/48JrxUM6k4+45cOnMsAhXH1ynSFA8gSIxlntBL0735llyo+ivOH7GmwsictV3p0CdvK90
 xLqmVsVBghwBpZwMwP3+nwKtvaHnk0l0haeKOeR7wXIg/Vi04LQ19oAL8cqI305kVPzfxi0FUMB
 RsCB6b8FlpIqjpw2ymokGnRn7R+UuEjSpLbDNZ5diEK/bnR8GTO6jCPl/GXhVky7AFztmTAHsM6
 PIhmdWuOe2cXorty6N4xtPXsgZqq3uZrJ3cWxzq5ZM4Q5lmLlXi+MarImmUxlphj40g0Z2W53Wz
 6Vo2QLT7XV6+Ut2I+bgzMbZcuJBeFz3dRC+C9kSbhnuma7XbukhjXhLli/gO9MXL1daxbuil9sp
 9IV3c5MsexufIqfHljIp5hdnFS4KPWM4qBGVMsWPoPpDZ2rKE5fit17QC+9i6+r6mIR4iEQgUPj
 lqBRougxxOyuLtSbdPPlsdg6znH6PKzBnH6BMqSEWXCbVQKXYzVUZRe1LcfOD7m6Ke7IEJNTQhR
 4e3kkweTBMifA73LSMWYrdHlPXFZ48KZ+Z66ThG7Vlm2BZbQUwrKmiMP/mpYdLhlo1P12GIebdV
 tMemelH2tZM+vg7Q5RrKeD/v1bSoeUk3jzLHZ0XR87PEnzB6HmVVGGdxY44VrEdtUCpcBL02mcd
 +xu74RUmtuSoaig==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8: No change

 drivers/media/platform/cadence/cdns-csi2rx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 2a80c66fb547..30cdc260b46a 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -40,6 +40,7 @@
 #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
+#define CSI2RX_STREAM_CTRL_SOFT_RST			BIT(4)
 #define CSI2RX_STREAM_CTRL_START			BIT(0)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
@@ -138,12 +139,22 @@ struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 
 static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 {
+	unsigned int i;
+
 	writel(CSI2RX_SOFT_RESET_PROTOCOL | CSI2RX_SOFT_RESET_FRONT,
 	       csi2rx->base + CSI2RX_SOFT_RESET_REG);
 
 	udelay(10);
 
 	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
+
+	/* Reset individual streams. */
+	for (i = 0; i < csi2rx->max_streams; i++) {
+		writel(CSI2RX_STREAM_CTRL_SOFT_RST,
+		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+		usleep_range(10, 20);
+		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
+	}
 }
 
 static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)

-- 
2.41.0
