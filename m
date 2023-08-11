Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB2778C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjHKKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjHKKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:49:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85D4203;
        Fri, 11 Aug 2023 03:48:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlnJN014080;
        Fri, 11 Aug 2023 05:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750869;
        bh=cYwOg9sSDDYs3eB9PIp6KRE5y9IJWBUenEYnEjKg6d4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sULh9hgDkYbpveexEOVVPCzzWKfjsI8l4oyi7CRKIrThHTLo2XfbqIZeVIRRwyCkm
         0kecPhd+CxXAfQodm7kbb2BUMXw2WiYXwmKhfoGQLbrgjNrMFy6kbXbHZ6hH2fMBSZ
         53gie7LyLCM1YE6xPkaHWwl9b8Z/xZva62uxWEfc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlnwB041933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:49 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAllns060381;
        Fri, 11 Aug 2023 05:47:48 -0500
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
Subject: [PATCH v9 06/13] media: cadence: csi2rx: Configure DPHY using link freq
Date:   Fri, 11 Aug 2023 16:17:28 +0530
Message-ID: <20230811-upstream_csi-v9-6-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=MbEUtCGTIMiWhE0Nm9ZqdY4oWREymewboSsVKOIiK2U=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g7+NV9wdQwO2FExNgMMFOvIADTbDas/NQKxh
 WhwlXC5jteJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO/gAKCRBD3pH5JJpx
 RSFtD/4gCwHRlIjhB+Ye9qCxgcBUhHbri6BwdH0q6wQ1lUs4J6q2rVn9vFjxyJORswzN5Xsp2qG
 RTW/z/XEGjMrEXAe3OeHnIVD1FUTKQk9c38envuBFZijX5rCL9zezbOYyB59hTrm8LQhl77jYXm
 skpr5wvo6tILnxaWVtQ7g5/qe9mlXjoO8Xk3oHwjMvlWcMevQrabj9hddMQ4S5kJtDGf9q/8Fxa
 wgHVx0FRq4rr6cYmd/xhVdFbacfaKMTN1dbye8n9eUf7uQ2B9yn76qxS4R2R/Ma9P7abtgBrk0D
 4l1qcMomS1jbyDrQN7llimpVLO8q35milsCsq6qid2wRf/15WtUonNiJ8jLVrCs4DdpfZgxwmw8
 A+yH4kX6440wqHk/yoNC7wWP+p1xkD9sUAMtewKgIKKkIhuFStre6cW0G/OvlyCNQ7KxB8s0rtH
 fJfWdJIC4JSHZEO3l66Ptf+wH7aotxO8IEcSpQ4sVvr0TlorLeeneO/06wCToYUWHsXlgY7P2c6
 zFDHgSs1WIIbXJNypHHCeXxTC2v2ZLLCJ4EKJXNyksqtf9w0HELBoO1nEymsPy09pprrteft3qw
 Vz0rofmuNE+xK0vLkoAul6KMV2K7js2jZOGUjwd8LoB3Qv4EuaugDU2CJS5eZ3BZiOT+sbQku57
 EqX9BWWicpw+b0A==
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

Some platforms like TI's J721E can have the CSI2RX paired with an
external DPHY. Use the generic PHY framework to configure the DPHY with
the correct link frequency.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Co-authored-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes from v8:
    - Don't specify stream while calling .get_fmt()

 drivers/media/platform/cadence/cdns-csi2rx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 047e74ee2443..933edec89520 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -145,8 +145,32 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 {
 	union phy_configure_opts opts = { };
+	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
+	struct v4l2_subdev_format sd_fmt = {
+		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad	= CSI2RX_PAD_SINK,
+	};
+	const struct csi2rx_fmt *fmt;
+	s64 link_freq;
 	int ret;
 
+	ret = v4l2_subdev_call_state_active(&csi2rx->subdev, pad, get_fmt,
+					    &sd_fmt);
+	if (ret < 0)
+		return ret;
+
+	fmt = csi2rx_get_fmt_by_code(sd_fmt.format.code);
+
+	link_freq = v4l2_get_link_freq(csi2rx->source_subdev->ctrl_handler,
+				       fmt->bpp, 2 * csi2rx->num_lanes);
+	if (link_freq < 0)
+		return link_freq;
+
+	ret = phy_mipi_dphy_get_default_config_for_hsclk(link_freq,
+							 csi2rx->num_lanes, cfg);
+	if (ret)
+		return ret;
+
 	ret = phy_power_on(csi2rx->dphy);
 	if (ret)
 		return ret;

-- 
2.41.0
