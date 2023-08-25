Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C77887E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbjHYMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbjHYMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:55:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F241D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692968108; x=1724504108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6aOaMtJTiIJ9T6N93TEgDZWLDHpyfendla0pMWkd2/w=;
  b=Wlvgd60HYV0JiGtWdVWaMtunraDKctTLiqrrJr5sKh8GclP4qFNDGhaT
   aN/CGQtM2wLO5ztaOV9EoOn6h4SdcwktAYvcREY9CQGhW10fx3zjYgDzs
   ZzVx1g1tX9IruEVsJKck+GQsXoVZ4BNKrlwyZtUbwmZlPe/OEQ57u12lz
   qBWrIHAfZCZZXJuycrSA6LjbJYkgtvahl/Rh7WbKaY1IA8caDa5CE4nAb
   xD3yVcwmRjt1e8k4iNisep9kTAf5sdgseYyRaDwzFJ2WQzbjB86JQgkhg
   sxV57kvXryvS5MvHi61QsIty3EUhcoRajfI3IlqIv2mtOUhfm9IXH9eE9
   g==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1318866"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 05:55:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 05:55:07 -0700
Received: from che-lt-i67131.amer.actel.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 25 Aug 2023 05:55:01 -0700
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
Subject: [PATCH v4 2/8] drm: atmel-hlcdc: add flag to differentiate XLCDC and HLCDC IP
Date:   Fri, 25 Aug 2023 18:24:38 +0530
Message-ID: <20230825125444.93222-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825125444.93222-1-manikandan.m@microchip.com>
References: <20230825125444.93222-1-manikandan.m@microchip.com>
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

Add is_xlcdc flag in driver data to differentiate XLCDC and HLCDC code
within the atmel-hlcdc driver files.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 5b5c774e0edf..d68c79a6eae7 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -304,6 +304,7 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
  * @conflicting_output_formats: true if RGBXXX output formats conflict with
  *				each other.
  * @fixed_clksrc: true if clock source is fixed
+ * @is_xlcdc: true if XLCDC IP is supported
  * @layers: a layer description table describing available layers
  * @nlayers: layer description table size
  */
@@ -317,6 +318,7 @@ struct atmel_hlcdc_dc_desc {
 	int max_hpw;
 	bool conflicting_output_formats;
 	bool fixed_clksrc;
+	bool is_xlcdc;
 	const struct atmel_hlcdc_layer_desc *layers;
 	int nlayers;
 };
-- 
2.25.1

