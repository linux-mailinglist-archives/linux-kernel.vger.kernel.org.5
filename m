Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F467BDD8B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJINKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjJINKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16FD9E;
        Mon,  9 Oct 2023 06:10:06 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9qX3067951;
        Mon, 9 Oct 2023 08:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856992;
        bh=s/9/WCV+Z+pRzQZL2aiY/uIoSmDyX8F6tP63wjbi9vE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=scGwhFKwA5pRAGoHG0YS/WQI2YiJzxEzzS8I1uiRTi+nk3z6AqGnz5kxIWcQ3GiT5
         K3v5Iw7x7zvwgkqopdysJFBqpBk/5QOJXQ9hkF9a5+00/aIE8jRV+8O48E7AK80X8e
         6ffWv408jey835cSZcI0UNf7cE2wyJ0LuEiF1Nk8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9qDX021644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9pe6118001;
        Mon, 9 Oct 2023 08:09:52 -0500
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
Subject: [PATCH v10 07/13] media: cadence: csi2rx: Soft reset the streams before starting capture
Date:   Mon, 9 Oct 2023 18:39:33 +0530
Message-ID: <20231009-upstream_csi-v10-7-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=zwQO/Y0U7j6zw1eN4GZhJJir4qCqq/uRF3NrJzvTBjY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/srZujrV2s5oLEjLN6orJklsHOAgav/7loNc
 tE/7oCCHfyJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7KwAKCRBD3pH5JJpx
 Rf2UD/9bxjA5/hCvux1X58DeE8Cjm+ol7yNkLScPpPXlouX36Ilq1806L6u4BJOnftH7aZkk109
 luUFhs69wvW6doNpfpIjQ4U/2OgaJsqbF2R3vH0Q4wIUo8kwq/AhYQsANiLwM34X4czTIahidtb
 QlWYSBh1C97JXJSYfCLi9xhtNRZPGzfnMvuEYd6duj7N2ntnx7sOTjYOrm8N/kZGa2GQ2PFUZBj
 WkmYEPry3p9jQpw7IIC8Ys6BOpsUmrjw7wP8xclGE9sbE6gOscYS4hmugbBOidIUOViBLAJiM4r
 yEk7soEiFt9LTg/SNmgoW+PetF6vplyFr5bC5qxTZKljQCmVOumVyvaly0MLk3rMfoE2Q/jgoH3
 oWTGYZx4b+OnYnz1R9HvbPD9hO59nlGIEkR77ZoZMHDv048jJ60apfKU8cmupLxP8o9E2hLrela
 03Jlax2vwgtEdcBdXAEAtIcznwyT7TEOiPp9zZmsLePBf8uBBokH10i1W3HVCl/yIhFueGcXmWR
 oXzZV7YcNFbcg/VqQ5SF3eqfDaXNbDW0sRsqiRXuwFJiG3XjsengYrPHiHhpUnMnvyN1yyKocFw
 YjCiNc4O5T+V1RQas7jJYAA/TSSZ3PVCWZAHVFiHQFQFy+Kbp4uHnBBQTGbPqnRJ8/6IrowoX8E
 sNL9O4Hw4ctG5SA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 77e2413c345a..913f84c341f4 100644
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
2.42.0
