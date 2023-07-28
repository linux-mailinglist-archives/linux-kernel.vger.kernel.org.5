Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB0766AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjG1Kci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjG1KcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:32:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF494C29;
        Fri, 28 Jul 2023 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540230; x=1722076230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EDSMF3KpdZJFrM1zcY0RzUGcphR/aMUmi1WoZ4tRDvM=;
  b=zIuHWuW1iH04d4EBB7qEEsSC0pzfHvRn1EORTdvbRFjNwlagBFkJHx1D
   eyFjQtTcp0yyJW27LoMxsDqpi32L3ZhFgpt01bogtUqKZfOOtzepaLXnm
   GACQnLu2ptAYYIoTe+raMVA/Ujq9r0ZrtkfsRAlKmuZz1zSHMLYKrO+jE
   yqBgV4rOToyqWcsGOiWQVuFE06sGlssi5i2J6YmtYVYlIANRGjPn4Z8/2
   dwnS8qyC/7W7Z9FbPYy73qBsnqlOyhvkvy4+dPh33myOXTYn4Fo6Aynk8
   3dJfcoqgyhqZZMVTLGkuKkTMee4VROYLb2l1YB54L3q+evJQQ7Wy8yrTs
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="163712909"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:29:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:29:52 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:29:47 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 40/50] clk: at91: sam9x7: Allow PLLs to be exported and referenced in DT
Date:   Fri, 28 Jul 2023 15:59:43 +0530
Message-ID: <20230728102943.267342-1-varshini.rajendran@microchip.com>
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

Allow PLLADIV2 and LVDSPLL to be referenced as a PMC_TYPE_CORE
clock from phandle in DT.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 include/dt-bindings/clock/at91.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 3e3972a814c1..6ede88c3992d 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -38,6 +38,10 @@
 #define PMC_CPU			(PMC_MAIN + 9)
 #define PMC_MCK1		(PMC_MAIN + 10)
 
+/* SAM9X7 */
+#define PMC_PLLADIV2		(PMC_MAIN + 11)
+#define PMC_LVDSPLL		(PMC_MAIN + 12)
+
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
-- 
2.25.1

