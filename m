Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED178A998
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjH1KE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjH1KEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:04:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF6F4;
        Mon, 28 Aug 2023 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693217086; x=1724753086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k7s9F712FvA8jSYfxO5MUGK+mY28MxXzM47n2+XEP4A=;
  b=MNNIY11R2+LjARYA+DMyZUHcQPLAdrCUz35YbQ7+W7Fgch0oKJkBTWlK
   bpJlB3wKsirwI+avh35vyoT2lGUHnBpwo6ljNj3W5b803F5Exvd4Exai/
   HW6To5lYcoj7QpwDKEMsPI2ZfW7MCB1wdjtPV1Dmb/kOfHkO5Ouwe8A7e
   3O6J5R86c8ehyAHGloS4jyfPppS+RzxKGw8MjJGcXXom2nW9wK+DvfC6s
   lId/J+ZyDorNwN7/Yl2b/kCHBbpKcx6Vnj9zU5VWFCfn6Ch2rttKcliG1
   5EdRMqCWRRC0SP9sYV55/74eLTZ/leYWENOjcTkbdiBRZQ+iLBIA5S3JD
   A==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="1616437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2023 03:04:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 28 Aug 2023 03:04:34 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 28 Aug 2023 03:04:29 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH] mmc: atmel-mci: Remove preprocessor directive
Date:   Mon, 28 Aug 2023 15:34:21 +0530
Message-ID: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
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

Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) while
checking if the device is compatible with atmel,hsmci. Instead handle it in
the if() condition. The compiler optimizes out the entire if() clause if
the first expression in the if() clause is constant false.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9694eb5afa21..9a191940d5af 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -262,16 +262,15 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 	unsigned int i;
 	bool active_high;
 
-#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
 	/*
 	 * The Atmel HSMCI has compatible property in the parent node and
 	 * gpio property in a child node
 	 */
-	if (of_device_is_compatible(np->parent, "atmel,hsmci")) {
+	if (IS_ENABLED(CONFIG_MMC_ATMELMCI) &&
+	    of_device_is_compatible(np->parent, "atmel,hsmci")) {
 		np_compat = np->parent;
 		np_propname = np;
 	}
-#endif
 
 	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
 		if (of_device_is_compatible(np_compat, gpios[i].compatible) &&
-- 
2.25.1

