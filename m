Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72F7D6CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJYNIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344347AbjJYNHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:07:55 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF5111;
        Wed, 25 Oct 2023 06:07:53 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 41D8F100047;
        Wed, 25 Oct 2023 16:07:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 41D8F100047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698239265;
        bh=oixfku0w9a55w5ewxmzKyEa0rIk5Ii9elJB6GpE/4So=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=JTTgkKt0p6xO4qtz6WSKRWy/EAKHEVUbJHuYRMIpW/u5mzRvw+5YeQrApya0AzjYE
         673HGNkA9lOnam9JcG4sHvTC3NfQnBIrqdWpXnxKqIzr3obiYJ5VEEJcuCrWtamRnW
         nNq1qiE8ecwC3g24VScn4jGdkTozEIV7ZjE//RvEf18vg17uq4opxfKCUpejcsiZgW
         Odly5/PkftjP7/H2XUrsp7/+DNvRlPsn0948dHMzrhFlpLDZ7GlQlCpviPcfZB8fGX
         iS79uDOHdGwL6IDzc/cIgztEYi2LEXwH/GRuA4zmJSGThQcFfybuW2Q4hTLx3KSvhK
         yXRG75zTfFupg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 16:07:45 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 25 Oct 2023 16:07:44 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <gnstark@salutedevices.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@sberdevices.ru>
Subject: [PATCH 5/8] leds: aw200xx: explicitly unregister LEDs at module's shutdown
Date:   Wed, 25 Oct 2023 16:07:34 +0300
Message-ID: <20231025130737.2015468-6-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025130737.2015468-1-gnstark@salutedevices.com>
References: <20231025130737.2015468-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180883 [Oct 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/25 11:29:00 #22291710
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEDs are registered using devm_led_classdev_register() and automatically
unregistered after module's remove(). led_classdev_unregister() calls
led_set_brightness() to turn off the LEDs and module's appropriate callback
uses resources those were destroyed already in module's remove().
So explicitly unregister LEDs at module shutdown.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-aw200xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 96979b8e09b7..3da0923507ec 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -539,6 +539,10 @@ static int aw200xx_probe(struct i2c_client *client)
 static void aw200xx_remove(struct i2c_client *client)
 {
 	struct aw200xx *chip = i2c_get_clientdata(client);
+	int i;
+
+	for (i = 0; i < chip->num_leds; i++)
+		devm_led_classdev_unregister(&client->dev, &chip->leds[i].cdev);
 
 	aw200xx_chip_reset(chip);
 	mutex_destroy(&chip->mutex);
-- 
2.38.4

