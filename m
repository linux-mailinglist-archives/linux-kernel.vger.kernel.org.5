Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B88070AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378445AbjLFNNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378432AbjLFNNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:13:46 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E6D47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:13:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rcz@pengutronix.de>)
        id 1rArii-0001DV-2f; Wed, 06 Dec 2023 14:13:44 +0100
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rcz@pengutronix.de>)
        id 1rArig-00DyO1-MO; Wed, 06 Dec 2023 14:13:42 +0100
Received: from rcz by dude05.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <rcz@pengutronix.de>)
        id 1rArig-00D0Qc-20;
        Wed, 06 Dec 2023 14:13:42 +0100
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Josua Mayer <josua@solid-run.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: rfkill: gpio: set GPIO direction
Date:   Wed,  6 Dec 2023 14:13:35 +0100
Message-Id: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rcz@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the undefined usage of the GPIO consumer API after retrieving the
GPIO description with GPIO_ASIS. The API documentation mentions that
GPIO_ASIS won't set a GPIO direction and requires the user to set a
direction before using the GPIO.

This can be confirmed on i.MX6 hardware, where rfkill-gpio is no longer
able to enabled/disable a device, presumably because the GPIO controller
was never configured for the output direction.

Fixes: b2f750c3a80b ("net: rfkill: gpio: prevent value glitch during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 net/rfkill/rfkill-gpio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 5a81505fba9ac..3d9ae696397cf 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -126,6 +126,16 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (rfkill->reset_gpio)
+		ret = gpiod_direction_output(rfkill->reset_gpio, true);
+	if (ret)
+		return ret;
+
+	if (rfkill->shutdown_gpio)
+		ret = gpiod_direction_output(rfkill->shutdown_gpio, true);
+	if (ret)
+		return ret;
+
 	rfkill->rfkill_dev = rfkill_alloc(rfkill->name, &pdev->dev,
 					  rfkill->type, &rfkill_gpio_ops,
 					  rfkill);

base-commit: 994d5c58e50e91bb02c7be4a91d5186292a895c8
-- 
2.39.2

