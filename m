Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCE769038
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjGaIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGaI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EDC123;
        Mon, 31 Jul 2023 01:29:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TiJV054937;
        Mon, 31 Jul 2023 03:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792184;
        bh=E9UkcS+2VXbNP1qkq12sT+ScQLrPo9DPV31sM7WES4k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B33Hlm9iLPjIJwb3g26K0a9wPzpP/V87bw5IrUWs2ypo7cecEyzvM2vu3Z0R9Oe8P
         zPPPKOFdka/iXlVaS2t00Kf/3CTGXi6tiQh87P74VmQn3/kGwquyfAVSt3mN7clVNj
         VpW+W6mhfTUsa4TydOHxCMvLs9RoTIYmhihortyU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8Timm106712
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:44 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8ThOw041923;
        Mon, 31 Jul 2023 03:29:44 -0500
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
Subject: [PATCH v8 08/16] media: cadence: csi2rx: Configure DPHY using link freq
Date:   Mon, 31 Jul 2023 13:59:26 +0530
Message-ID: <20230731-upstream_csi-v8-8-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=lP78AAgdw8HiC/cJJfwyiOGaiGILwVLLk4FS6A1HMsg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xqP3MEVfG3j+vK71esq1Pw3SZABy+HUN0Ny
 M1nBEB7X0SJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsagAKCRBD3pH5JJpx
 RQUBD/9TQBQOcP/dYirvERLs4rZYIVZEt8J/BV1Z53D2ldbo3kjsrzqWKuTLkKGtrk7ZW81bOIm
 F16Jlbf0wBnVeDCRCYos1r5UDFqFCslsouyhFJueNgZY0MC5GAVSojwIjayDu9e4Y+4RySKChTz
 Krcgcke597uA62cuUwKb3aIYlKs33NwFCO9cxNFbPzL0vZKDNnOAYwwlnIImCJOwLOBNktgI7e3
 MWlqRD6m9UQUBhkHxg/ioyQF5QV833WFoH2qbbTkeD7wu2vSP53Tdtbem6V0h4i1kbug64HFXNS
 zPo6CRI9FcA5PWNf98lGMX1QT3xkov9VqrrO+KDgJcyG8OmM0plKExiqY+zt1wc9TWDe2IYJjvM
 sxB2f+fpasDnpD3c9yBaNDa6ButwPhGQl+lE5bTg9myo0Am2KhNvbPoKedYrnDDWwF4V9E57LKK
 1eE+XurVzM/GDoIh9FVziNUZ74dkWMSuehBrxnlD6MBCvTBAjzGHtN5IAJCTeyX2BQitbmwsCyD
 +Vhoecf+PU/nltqPHTS8run8jrZvjvRPEn6ceo5DzWosldwucLOvbu7j3j1orPeAj9O5fk7YvyA
 C58eYBGd3KqMk506ZrMY1h5HUf1jtUsg0iFpYgN2NAGL/raV1ZI6/VrSKv/XsW18P30M4z1yFh3
 4MgdIGtqXz6GBUg==
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

Some platforms like TI's J721E can have the CSI2RX paired with an
external DPHY. Use the generic PHY framework to configure the DPHY with
the correct link frequency.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Co-authored-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8
- Drop original patch in-lieu of already merged
  https://lore.kernel.org/linux-media/20230523085626.3295-5-jack.zhu@starfivetech.com/
- Add a new patch to configure DPHY using link_freq control from the
  source

 drivers/media/platform/cadence/cdns-csi2rx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 4f9654366485..2a80c66fb547 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -149,8 +149,33 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 {
 	union phy_configure_opts opts = { };
+	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
+	struct v4l2_subdev_format sd_fmt = {
+		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad	= CSI2RX_PAD_SINK,
+		.stream	= 0,
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
