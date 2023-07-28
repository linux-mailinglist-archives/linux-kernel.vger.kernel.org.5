Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD06766ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjG1KeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjG1Kcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:32:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB2759CC;
        Fri, 28 Jul 2023 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540258; x=1722076258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07eRa4nNT3zBKO6DeHao4x0ptknF6w5CwCj1aTRYzGg=;
  b=WrCwuzPC4zyr68721KLsCYw/OWFQZCWzZjMLDe13c3H+/XuuRLiI/NWg
   rn7bJkL3Hsho91cYVh1mOgRyAqb/S3FLfE7ELMOhGYIuHueIkQ8Kwj1wS
   6BOLR+4MMgdlN52GHKEY+ajtP3i1X6jZWZpULyTMNDZWEyhzsL57DCSzK
   GNscBS6hZeUxFPe2xAmHXD5k7iSKUv5TKCWirdd542xCQBmm8iDduClMF
   RgGfE+V5a/TM82gvpCClbL3ja8dY6BEYRVhjTecJ9VP7mfr32y3nYPDIg
   buU0dDQOEmvxE0F8DCcoDFIKJd/zkiWJxIXtp2HwtAG+C+BP0Sz+IoyUc
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="225813934"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:30:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:30:40 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:30:37 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 45/50] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
Date:   Fri, 28 Jul 2023 16:00:32 +0530
Message-ID: <20230728103032.267597-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown controller support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 518b232bfd3d..8571b592f257 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -34,7 +34,7 @@ config POWER_RESET_AT91_RESET
 config POWER_RESET_AT91_SAMA5D2_SHDWC
 	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
 	depends on ARCH_AT91
-	default SOC_SAM9X60 || SOC_SAMA5
+	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	help
 	  This driver supports the alternate shutdown controller for some Atmel
 	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
-- 
2.25.1

