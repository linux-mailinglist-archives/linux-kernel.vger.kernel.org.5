Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C787BDD88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376873AbjJINK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376810AbjJINKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E40BAF;
        Mon,  9 Oct 2023 06:10:08 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9pIP067945;
        Mon, 9 Oct 2023 08:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856991;
        bh=osyCAViLVBaJwUwzPfMFvHCi5OOIvQquFZEhN1wmj6I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rWIuf/JL49ME416VKZNZTuJe/4Q05XdDE6WGE0KW/mvwmEst1cN/CcqoXNjADawD9
         hdkNWLxlP+AqT1QT3fiXxgSl3u4xZa3T+ejgEnr1bi3LUV9+HpKiPLkfAEiWgDW7V7
         k9tAEOXMKqZgoF++EtL+g6nPuYp3PR1iiIFlU2AM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9pRe077021
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:51 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:50 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9nsj055571;
        Mon, 9 Oct 2023 08:09:50 -0500
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
Subject: [PATCH v10 06/13] media: cadence: csi2rx: Configure DPHY using link freq
Date:   Mon, 9 Oct 2023 18:39:32 +0530
Message-ID: <20231009-upstream_csi-v10-6-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=RUZIs/V1zB7ojxrNBwsr2VePDUlHFcaYY3FI90aQFqc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/sqauE21D0LzrllxQ8Zm96qKPACTyyvIfOKE
 DfQrHtbhmSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7KgAKCRBD3pH5JJpx
 RbiRD/sGU8AH/zCNvt5XjV9NEqO8d+OHg3Sue5Gk+a99KX6/iJNH6pKTXw2DwrGfI91tLvelI/P
 OTqtoxLacF408Tb77W/fide0gGKvZZMVjIR7ybBERGtit7W6pqXmGy6aovFDvC5N3dQI1XVy75W
 oF3r87dS6mv+7rVDmjmNy6tJ1bNobHB50wGDLCEImiJ7njN1SeDYBq96X52URntPTYDhQNHtOq0
 qf9C1uZ+FAWL+XOM/RaM4BYAWkBO3Nz+n3TO59XsfX5wBg96GEHAUYa4bYGPtNw8OsM3jiUli4a
 Tydd5Wl2lk6QoZeMBTFSN473kkcKz7pJe4K7tAFcTTNbxJPlpb+fLRUy3duGbDqDvVdhu1AsQKm
 UrLcXIAMNEkx/04iHhp7i0x6QIqmwJx7qid0arCVM5uZW4fj+rGXhspyKqzYp6G1B4QxkUoOxw9
 toj+ebKr+85lDxJg61/HEkGhJSsMLuiRdGzoIeVX5XEQBKFQrwIba5FHKqUecXArU7Q7afBAUDN
 bEMHfpAcGiuMg4bWzi8OaZoeVe3PEajHz8oDwfMhrpKQKi4NJxo97jF966uaAwYngkFGFR87NQn
 5iAwRcDgEKTV43xizNfPlO2X/+yD1vCIjwVgx+LDQayvc9V1tKYQgCOSY5O2bfyqCB8cd4OOwYV
 +5G0xqErUCTcBpg==
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

Some platforms like TI's J721E can have the CSI2RX paired with an
external DPHY. Use the generic PHY framework to configure the DPHY with
the correct link frequency.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Co-developed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f9b41451f4a4..77e2413c345a 100644
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
2.42.0
