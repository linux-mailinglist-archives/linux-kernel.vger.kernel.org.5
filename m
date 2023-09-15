Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812A7A1CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjIOKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjIOKt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:49:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC14106
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694774961; x=1726310961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Vv10apy3dujTxAUU/bAcUdLl39yKDSm3soc5TeW2ww=;
  b=joKlDGUX7t7/HVn0kviclldaO/UCjA/iT9PUt8wcipOng1QwNDWIvISA
   WpHbmegfQ70o7vmCw6Bg+caLR/TTO9cVhwC+sZqMENndZ+awmGwntkW6/
   2Y7d2kwn1MpAM83t8K5A7JHl+EbBA7gvk1ZEKKU2M4iInKBOF/wEEj53q
   +jO6MLdIH1mbm4TNqXKp3qwhYnTCv3klEHTXjaefn2jhlqEqBLY8LbHzO
   ++m55fI7z7cNgZYjn9jFwQ+tt8buCtT9hLIvilE6GjOppEfFuPbAaJ8Ee
   vx36W0RM+ETCxzHbZOJMMHxyM9I0JvuWCYa1kBVrY7sIRftER/C8B/nr2
   A==;
X-CSE-ConnectionGUID: hk8tCQZzSVuMTtVQhU7nfA==
X-CSE-MsgGUID: t49tHJxNQbmVit/s87sdOA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="4844792"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 03:49:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 03:49:12 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 15 Sep 2023 03:49:06 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v5 3/8] drm: atmel-hlcdc: add LCD controller layer definition for sam9x75
Date:   Fri, 15 Sep 2023 16:18:44 +0530
Message-ID: <20230915104849.187146-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915104849.187146-1-manikandan.m@microchip.com>
References: <20230915104849.187146-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LCD controller layer definition and descriptor structure for
sam9x75 for the following layers,
- Base Layer
- Overlay1 Layer
- Overlay2 Layer
- High End Overlay

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 97 ++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index fa0f9a93d50d..d30aec174aa2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -462,6 +462,99 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 = {
 	.layers = atmel_hlcdc_sam9x60_layers,
 };
 
+static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
+	{
+		.name = "base",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x60,
+		.id = 0,
+		.type = ATMEL_HLCDC_BASE_LAYER,
+		.cfgs_offset = 0x1c,
+		.layout = {
+			.xstride = { 2 },
+			.default_color = 3,
+			.general_config = 4,
+			.disc_pos = 5,
+			.disc_size = 6,
+		},
+		.clut_offset = 0x700,
+	},
+	{
+		.name = "overlay1",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x160,
+		.id = 1,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset = 0x1c,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.xstride = { 4 },
+			.pstride = { 5 },
+			.default_color = 6,
+			.chroma_key = 7,
+			.chroma_key_mask = 8,
+			.general_config = 9,
+		},
+		.clut_offset = 0xb00,
+	},
+	{
+		.name = "overlay2",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x260,
+		.id = 2,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset = 0x1c,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.xstride = { 4 },
+			.pstride = { 5 },
+			.default_color = 6,
+			.chroma_key = 7,
+			.chroma_key_mask = 8,
+			.general_config = 9,
+		},
+		.clut_offset = 0xf00,
+	},
+	{
+		.name = "high-end-overlay",
+		.formats = &atmel_hlcdc_plane_rgb_and_yuv_formats,
+		.regs_offset = 0x360,
+		.id = 3,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.cfgs_offset = 0x30,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.memsize = 4,
+			.xstride = { 5, 7 },
+			.pstride = { 6, 8 },
+			.default_color = 9,
+			.chroma_key = 10,
+			.chroma_key_mask = 11,
+			.general_config = 12,
+			.csc = 16,
+			.scaler_config = 23,
+		},
+		.clut_offset = 0x1300,
+	},
+};
+
+static const struct atmel_hlcdc_dc_desc atmel_xlcdc_dc_sam9x75 = {
+	.min_width = 0,
+	.min_height = 0,
+	.max_width = 2048,
+	.max_height = 2048,
+	.max_spw = 0xff,
+	.max_vpw = 0xff,
+	.max_hpw = 0x3ff,
+	.fixed_clksrc = true,
+	.is_xlcdc = true,
+	.nlayers = ARRAY_SIZE(atmel_xlcdc_sam9x75_layers),
+	.layers = atmel_xlcdc_sam9x75_layers,
+};
+
 static const struct of_device_id atmel_hlcdc_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9n12-hlcdc",
@@ -487,6 +580,10 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
 		.compatible = "microchip,sam9x60-hlcdc",
 		.data = &atmel_hlcdc_dc_sam9x60,
 	},
+	{
+		.compatible = "microchip,sam9x75-xlcdc",
+		.data = &atmel_xlcdc_dc_sam9x75,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);
-- 
2.25.1

