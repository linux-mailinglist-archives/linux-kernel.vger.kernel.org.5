Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19C77F2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349437AbjHQJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349456AbjHQJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:14:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A32D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692263651; x=1723799651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6kZse0DIIi42zKGvbzzypMbJw6gaghq4kSIuQcg1rU8=;
  b=X+GmpCMO5DU3Na5YB9+5HMdEpEbeopxHoc28m5g9WnHUtOsP0XhBoTzr
   0YvVs6tY3I204ZP7bLbqhfU6ym9Uc60sXSxKglRGbjEiAoqFfCjHhbjBj
   TeeLOFoynC4BpTidmOmxYt2cWWGkHJB7Jo31A2oYfBpQ/Zyty8ucuK/kO
   7MYuloUU51QkR4axQAVprkyE2eIuj5mn2t/l8RYI5b/v5av2bBrxwytst
   nDjgbBKPRVI5E5h4ZWmn/1Xx4xT7TJW1uKB79+c1441v9T6mQ2ZDtDL/B
   ppJ3Yfyusqz6ylnGCBoA7035EhLmAltmgo7eZAHJjEPgJGSHhioSOHsPg
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="230219066"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2023 02:14:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 17 Aug 2023 02:14:10 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 17 Aug 2023 02:14:04 -0700
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
Subject: [PATCH v3 7/8] drm: atmel-hlcdc: add vertical and horizontal scaling support for XLCDC
Date:   Thu, 17 Aug 2023 14:42:49 +0530
Message-ID: <20230817091250.225512-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817091250.225512-1-manikandan.m@microchip.com>
References: <20230817091250.225512-1-manikandan.m@microchip.com>
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

update the LCDC_HEOCFG30 and LCDC_HEOCFG31 registers of XLCDC IP which
supports vertical and horizontal scaling with Bilinear and Bicubic
co-efficients taps for Chroma and Luma componenets of the Pixel.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  4 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 20 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index d30aec174aa2..ae3e1a813482 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -536,6 +536,8 @@ static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
 			.general_config = 12,
 			.csc = 16,
 			.scaler_config = 23,
+			.vxs_config = 30,
+			.hxs_config = 31,
 		},
 		.clut_offset = 0x1300,
 	},
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 8b05a54b5fd0..27074a4c5aec 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -198,6 +198,8 @@
  * @disc_pos: discard area position register
  * @disc_size: discard area size register
  * @csc: color space conversion register
+ * @vxs_config: vertical scalar filter taps control register
+ * @hxs_config: horizontal scalar filter taps control register
  */
 struct atmel_hlcdc_layer_cfg_layout {
 	int xstride[ATMEL_HLCDC_LAYER_MAX_PLANES];
@@ -217,6 +219,8 @@ struct atmel_hlcdc_layer_cfg_layout {
 	int disc_pos;
 	int disc_size;
 	int csc;
+	int vxs_config;
+	int hxs_config;
 };
 
 /**
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 62c4bb65d8ac..27a7937465bb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -972,6 +972,26 @@ static void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
 		atmel_hlcdc_layer_write_cfg(&plane->layer,
 					    desc->layout.csc + i,
 					    xlcdc_csc_coeffs[i]);
+
+	if (desc->layout.vxs_config && desc->layout.hxs_config) {
+		/*
+		 * Updating vxs.config and hxs.config fixes the
+		 * Green Color Issue in SAM9X7 EGT Video Player App
+		 */
+		atmel_hlcdc_layer_write_cfg(&plane->layer,
+					    desc->layout.vxs_config,
+					    ATMEL_XLCDC_LAYER_VXSYCFG_ONE |
+					    ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE |
+					    ATMEL_XLCDC_LAYER_VXSCCFG_ONE |
+					    ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE);
+
+		atmel_hlcdc_layer_write_cfg(&plane->layer,
+					    desc->layout.hxs_config,
+					    ATMEL_XLCDC_LAYER_HXSYCFG_ONE |
+					    ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE |
+					    ATMEL_XLCDC_LAYER_HXSCCFG_ONE |
+					    ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE);
+	}
 }
 
 static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
-- 
2.25.1

