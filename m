Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E027BA333
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjJEPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjJEPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3906EA87
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696515039; x=1728051039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LW3pFUStHKEnZSyxevXGQeuoxSERTH8HcpzSlQGWuPU=;
  b=KldejUr4z2FlzuS2IRpRemlAzN897UTIxHgjfO8x5dcj0LvvuMR6d7+U
   ca7ah67y+Gd9Qek+cdGzcdPun2Mt9LSxr2kOpYBB5uGtgdCRr5R3T7Y12
   5Rd7WSvLW8M8ikroxtuhZBPtK3HKLjznXFcK37xWlCrCaMk/uLglF5ZUZ
   NXi7iTjxQetQL7zLKz0Cqe2gEXKGdHBvNsTPqjYDvzdZHVslELPgxfdcZ
   N5lgQrkcXeL3LWoDjtlqUfASgB8PJXjksaJD/YgI4CGpJBneIsJ+r51BY
   GjfsNmtiKMHtpvsaqbvO4pF+6rIaxZreXZyDwHD13ij+CQ28Mt+M+WpjU
   Q==;
X-CSE-ConnectionGUID: b6BRdfjJRX2crKWroRfoVA==
X-CSE-MsgGUID: 3XwwLdyaQLyVBAreOl8qRA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="8249575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 02:30:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 5 Oct 2023 02:30:42 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 5 Oct 2023 02:30:35 -0700
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
        Manikandan Muralidharan <manikandan.m@microchip.com>,
        Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v7 5/7] drm: atmel-hlcdc: add DPI mode support for XLCDC
Date:   Thu, 5 Oct 2023 14:59:52 +0530
Message-ID: <20231005092954.881059-6-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005092954.881059-1-manikandan.m@microchip.com>
References: <20231005092954.881059-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Display Pixel Interface (DPI) Compatible Mode
support in atmel-hlcdc driver for XLCDC IP along with legacy
pixel mapping. DPI mode BIT is configured in LCDC_CFG5 register.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
[durai.manickamkr@microchip.com: update DPI mode bit using is_xlcdc flag]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 1ac31c0c474a..1899be2eb6a3 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -30,10 +30,12 @@
  *
  * @base: base CRTC state
  * @output_mode: RGBXXX output mode
+ * @dpi: output DPI mode
  */
 struct atmel_hlcdc_crtc_state {
 	struct drm_crtc_state base;
 	unsigned int output_mode;
+	u8 dpi;
 };
 
 static inline struct atmel_hlcdc_crtc_state *
@@ -164,6 +166,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 
 	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
 	cfg = state->output_mode << 8;
+	if (is_xlcdc)
+		cfg |= state->dpi << 11;
 
 	if (!is_xlcdc && (adj->flags & DRM_MODE_FLAG_NVSYNC))
 		cfg |= ATMEL_HLCDC_VSPOL;
@@ -176,7 +180,9 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
 			   ATMEL_HLCDC_DISPPOL | ATMEL_HLCDC_DISPDLY |
 			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
-			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
+			   ATMEL_HLCDC_GUARDTIME_MASK |
+			   (is_xlcdc ? ATMEL_XLCDC_MODE_MASK |
+			   ATMEL_XLCDC_DPI : ATMEL_HLCDC_MODE_MASK),
 			   cfg);
 
 	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
@@ -374,7 +380,15 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 
 	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
 	hstate->output_mode = fls(output_fmts) - 1;
-
+	if (crtc->dc->desc->is_xlcdc) {
+		/* check if MIPI DPI bit needs to be set */
+		if (fls(output_fmts) > 3) {
+			hstate->output_mode -= 4;
+			hstate->dpi = 1;
+		} else {
+			hstate->dpi = 0;
+		}
+	}
 	return 0;
 }
 
@@ -478,6 +492,7 @@ static struct drm_crtc_state *
 atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct atmel_hlcdc_crtc_state *state, *cur;
+	struct atmel_hlcdc_crtc *c = drm_crtc_to_atmel_hlcdc_crtc(crtc);
 
 	if (WARN_ON(!crtc->state))
 		return NULL;
@@ -489,6 +504,8 @@ atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
 
 	cur = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
 	state->output_mode = cur->output_mode;
+	if (c->dc->desc->is_xlcdc)
+		state->dpi = cur->dpi;
 
 	return &state->base;
 }
-- 
2.25.1

