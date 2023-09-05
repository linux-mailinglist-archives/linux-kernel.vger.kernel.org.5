Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77185792BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348930AbjIEREf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354185AbjIEKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:08:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E81AB;
        Tue,  5 Sep 2023 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693908533; x=1725444533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+8MX5ACtp0E3yDFO037e/NmBawdAVmspJKr7wW6W9gE=;
  b=i38X5fCHxDmaP4LRFg3nEZuBqfAoPear1ZPI/GL9hweOVcp7jHLh1GrC
   ru4MoxqCj7g76I0QM04ZIXXvcWpNis6L0wfxA7LOx/GbSfRS6D7dnfO/C
   V0hdNdrWY9mGfehBuTQu8mXidkkmo6Zapj1mLO5wcqCOqcXfuRzwKd/u2
   zOxNGNgAnocXYAjSl6QxlZlUgsxRHIFwDVABEi8RxgLszwA1wERadcq6M
   W8CIK0sSclvga1aFaz/Rd/3K6+Pr0EEOyVWdgobyvAqgit/49hm+G9SmQ
   x5iZ/1AHI6qKm76hO5Rl2w94EIuztyIOP8Zn088shyFqgEIQhcnieFLw/
   g==;
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="2881960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2023 03:08:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 5 Sep 2023 03:08:43 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 5 Sep 2023 03:08:40 -0700
From:   Dharma Balasubiramani <dharma.b@microchip.com>
To:     <kamel.bouhara@bootlin.com>, <william.gray@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <balamanikandan.gunasundar@microchip.com>,
        <hari.prasathge@microchip.com>, <nicolas.ferre@microchip.com>,
        Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [linux][PATCH] counter: microchip-tcb-capture: Fix the use of internal GCLK logic
Date:   Tue, 5 Sep 2023 15:38:35 +0530
Message-ID: <20230905100835.315024-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the datasheet, the clock selection Bits 2:0 – TCCLKS[2:0] should
be set to 0 while using the internal GCLK (TIMER_CLOCK1).

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index e2d1dc6ca668..c7af13aca36c 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -98,7 +98,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
 		priv->qdec_mode = 0;
 		/* Set highest rate based on whether soc has gclk or not */
 		bmr &= ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
-		if (priv->tc_cfg->has_gclk)
+		if (!priv->tc_cfg->has_gclk)
 			cmr |= ATMEL_TC_TIMER_CLOCK2;
 		else
 			cmr |= ATMEL_TC_TIMER_CLOCK1;
-- 
2.25.1

