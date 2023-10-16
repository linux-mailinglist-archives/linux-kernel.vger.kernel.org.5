Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074D7C9E20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJPESh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:18:33 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B10D6;
        Sun, 15 Oct 2023 21:18:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5DD440005;
        Mon, 16 Oct 2023 04:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697429910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x6Nt+lmoIZYSVOu6ZTlQjSZu1KbJRj9ixtTG2gZ2sqg=;
        b=YC6sEOm62jCK773k2RKL/MqbmZJ0ktqxrjnpdXnEBrwg3alwv/F52dDYgbwWgdYu46d7qe
        sWiFLZK9we8VfHTGPlkFkYSOm+8JKvyUaYIIiiDedQCISh9mV66HgNyD72IA9kTuYbD8jc
        0goBpM9S0KTNrB7ax8p9Ylq/CkCT16MIHvHszGqTUkQbkxAJq2lgatcEIxMYwnZRDDiUNT
        sSPBBsRKJbVJzlm4QlGHFT/rTlZu8aINo235VAjohBpVsE+W8goymtlevj0slPZ5/yBYj5
        /0tD1t69Hvy02zDdlkL1CbzWKG4GW/gZ7TPmzp+ABRBDeeUT3/3xH8qKqoNVwA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     kernel test robot <lkp@intel.com>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: at91rm9200: annotate at91_rtc_remove with __exit again
Date:   Mon, 16 Oct 2023 06:18:16 +0200
Message-ID: <20231016041816.246426-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Without __exit, having the driver as a builtin after dropping the __exit
annotation results in:

>> drivers/rtc/rtc-at91rm9200.c:561:13: warning: 'at91_rtc_remove' defined but not used [-Wunused-function]
     561 | static void at91_rtc_remove(struct platform_device *pdev)
         |             ^~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310160705.vlElNOGb-lkp@intel.com/
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 3f5ff9867c02..c16fe711a0d9 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -558,7 +558,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 /*
  * Disable and remove the RTC driver
  */
-static void at91_rtc_remove(struct platform_device *pdev)
+static void __exit at91_rtc_remove(struct platform_device *pdev)
 {
 	/* Disable all interrupts */
 	at91_rtc_write_idr(AT91_RTC_ACKUPD | AT91_RTC_ALARM |
-- 
2.41.0

