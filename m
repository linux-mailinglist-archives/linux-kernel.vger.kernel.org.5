Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0167DC084
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjJ3T3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJ3T3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:29:37 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73523DB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:29:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39UJSlsJ052235;
        Mon, 30 Oct 2023 14:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698694127;
        bh=dmgtTJaq9wvJAB+uUOddVab2zm5yVAqq7CEhc68g0vA=;
        h=From:To:CC:Subject:Date;
        b=yxctoWireIpdlVDftZ8syS/0DiCdAkWsjzIaGp7A0w1uyEIagLw9wtxO/yi/i9UQT
         0cqY6t3Iegob92/DXnsEt+VfpNQLRTK9gbiqJ5l/v4U6QaqFNBKe9JFPdyR3Ky9lwt
         +q3g6ME0C7yV0q7xDiPFRVmTtqpzmdoOXCq8w+t0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39UJSlR7027257
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Oct 2023 14:28:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 14:28:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 14:28:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39UJSk5J053179;
        Mon, 30 Oct 2023 14:28:47 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Francesco Dolcini <francesco@dolcini.it>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH] drm/bridge: tc358767: Support input format negotiation hook
Date:   Tue, 31 Oct 2023 00:58:46 +0530
Message-ID: <20231030192846.27934-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new connector model, tc358767 will not create the connector, when
DRM_BRIDGE_ATTACH_NO_CONNECTOR is set and display-controller driver will
rely on format negotiation to setup the encoder format.

Add the missing input-format negotiation hook in the
drm_bridge_funcs to complete DRM_BRIDGE_ATTACH_NO_CONNECTOR support.

Input format is selected to MEDIA_BUS_FMT_RGB888_1X24 as default, as is
the case with older model.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---

Notes:

  * Since I do not have hardware with me, this was just build tested. I would
    appreciate it if someone could test and review it, especically somebody, who
    uses the bridge for DPI/DSI to eDP format conversion.

  * The Toshiba TC358767 bridge is not enabled in arm64 defconfig by default,
    when it should be. Hence, I sent a quick patch[0] earlier.

[0]: https://lore.kernel.org/all/20231030152834.18450-1-a-bhatia1@ti.com/

 drivers/gpu/drm/bridge/tc358767.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ef2e373606ba..0affcefdeb1c 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1751,6 +1751,30 @@ tc_dpi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static u32 *
+tc_edp_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+				 struct drm_bridge_state *bridge_state,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state,
+				 u32 output_fmt,
+				 unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	/* This is the DSI/DPI-end bus format */
+	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	*num_input_fmts = 1;
+
+	return input_fmts;
+}
+
 static const struct drm_bridge_funcs tc_dpi_bridge_funcs = {
 	.attach = tc_dpi_bridge_attach,
 	.mode_valid = tc_dpi_mode_valid,
@@ -1777,6 +1801,7 @@ static const struct drm_bridge_funcs tc_edp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = tc_edp_atomic_get_input_bus_fmts,
 };
 
 static bool tc_readable_reg(struct device *dev, unsigned int reg)

base-commit: c503e3eec382ac708ee7adf874add37b77c5d312
-- 
2.42.0

