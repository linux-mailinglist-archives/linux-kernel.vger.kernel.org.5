Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FE8138BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjLNRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjLNRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:36:23 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE2131;
        Thu, 14 Dec 2023 09:36:29 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2D8CE12001F;
        Thu, 14 Dec 2023 20:36:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2D8CE12001F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1702575386;
        bh=nTXR4WBFZR+kxSlC13nocgtwFZu8ItCajWxM9cqi5i0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=G2Btu04+yak/8X6fT3WuNA96d147W5JSc/bjvRnU3To5MiV3hU85t8rXnzP1CDGJc
         Nqi8RAragqLnWBD4xThH4DPHRJeqjq58CKKSzgix9X4rgOi6cVOuHKI5XgBWdGQAZD
         OG+zH2ofCmV/bRXj7tb2mVyDD+mwAj/ljsNBXZIAQ3/dzl+vQDOSuMBk7FkfrY9HbY
         5joVO1jvu2Kcjc8zbRWhmeyTqGx/Mdrp9Doa6r0FjTpQ0ke64J+vKkcl4lIXeOEBPn
         J2StXK9G5d/jG+k3NjZgO3V4NLF2RXBdffOgoFSKMlTT6+khG/VfmDFw0U3LqNxEFW
         leNh/hF5COznw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 20:36:25 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 20:36:25 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
        <vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <nikitos.tr@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v4 08/10] leds: mlxreg: use devm_mutex_init for mutex initializtion
Date:   Thu, 14 Dec 2023 20:36:12 +0300
Message-ID: <20231214173614.2820929-9-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214173614.2820929-1-gnstark@salutedevices.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182125 [Dec 14 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/14 10:50:00 #22693095
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses mutex which was destroyed already
in module's remove() so use devm API instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-mlxreg.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c93bd72..64a78eff05c7 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/io.h>
 #include <linux/leds.h>
 #include <linux/module.h>
@@ -258,6 +259,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int err;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -269,28 +271,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	mutex_init(&priv->access_lock);
+	err = devm_mutex_init(&pdev->dev, &priv->access_lock);
+	if (err)
+		return err;
+
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
 	return mlxreg_led_config(priv);
 }
 
-static int mlxreg_led_remove(struct platform_device *pdev)
-{
-	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
-
-	mutex_destroy(&priv->access_lock);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_led_driver = {
 	.driver = {
 	    .name = "leds-mlxreg",
 	},
 	.probe = mlxreg_led_probe,
-	.remove = mlxreg_led_remove,
 };
 
 module_platform_driver(mlxreg_led_driver);
-- 
2.25.1

