Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5777F2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349451AbjHQJON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349460AbjHQJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:13:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4457230E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692263627; x=1723799627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UXb9sg2LMUaA2IiZniOpQvzHPeODoB7tiHuPfvDdr0o=;
  b=KuHunlMopOTVIpU6JjmIHpN9pLkoIsL8Yo/IBvz/M19hsmrb44hQRM/u
   /OaFSrldHQeemBvYZnPwsMUqzAkmKTYAW8dej4dlZMLQIF5MvfUWg8nSE
   POiCTl0rNxvUW8AfTW4F4YkYh/EATYYNvQ26klHGzPgBXL2PCqZdcWg26
   P4SVF+1nMumqnyKxHZnC4KxOMC50yO2bgqHrNHO5N61YY+V0wcSUiQYuT
   3HaYARJATwqhrqGEBdpoWii9KpxWFO8qOz8bAzSRjwQWO62d3kS//HuUC
   i8g4tt+/zoKZJNkH9TaOhw6EFeIcHG9EvxULbdwXX5tR/zvAcemrAaUvP
   w==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="166879614"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2023 02:13:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 17 Aug 2023 02:13:20 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 17 Aug 2023 02:13:14 -0700
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
Subject: [PATCH v3 0/8] Add support for XLCDC to sam9x7 SoC family.
Date:   Thu, 17 Aug 2023 14:42:42 +0530
Message-ID: <20230817091250.225512-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
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

This patch series aims to add support for XLCDC IP of sam9x7 SoC family
to the DRM subsystem.XLCDC IP has additional registers and new
configuration bits compared to the existing register set of HLCDC IP.
The new compatible string "microchip,sam9x75-xlcdc" is defined for sam9x75
variant of the sam9x7 SoC family.The is_xlcdc flag under driver data helps
to differentiate the XLCDC and existing HLCDC code within the same driver.

changes in v3:
* Removed de-referencing the value of is_xlcdc flag multiple times in
a single function.
* Removed cpu_relax() call when using regmap_read_poll_timeout.
* Updated xfactor and yfactor equations using shift operators
* Defined CSC co-efficients in an array for code readability.

changes in v2:
* Change the driver compatible name from "microchip,sam9x7-xlcdc" to
"microchip,sam9x75-xlcdc".
* Move is_xlcdc flag to driver data.
* Remove unsed Macro definitions.
* Add co-developed-bys tags
* Replace regmap_read() with regmap_read_poll_timeout() call
* Split code into two helpers for code readablitity.

Durai Manickam KR (1):
  drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC specific registers

Manikandan Muralidharan (7):
  mfd: atmel-hlcdc: Add compatible for sam9x75 XLCD controller
  drm: atmel-hlcdc: add flag to differentiate XLCDC and HLCDC IP
  drm: atmel-hlcdc: add LCD controller layer definition for sam9x75
  drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 168 +++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  99 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  48 +++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 353 +++++++++++++++---
 drivers/mfd/atmel-hlcdc.c                     |   1 +
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 6 files changed, 584 insertions(+), 95 deletions(-)

-- 
2.25.1

