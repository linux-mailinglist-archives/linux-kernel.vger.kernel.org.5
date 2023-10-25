Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751427D6CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjJYNH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjJYNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:07:53 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9E131;
        Wed, 25 Oct 2023 06:07:48 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1626E100046;
        Wed, 25 Oct 2023 16:07:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1626E100046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698239265;
        bh=0EQMoFRrUMx/pZxHfkfAMtFPBkQrssL7XqzVKbD+szU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=vx7Mcugj3I9S9uBn5rE9V5gZRQf8CUYDa9cbpn7gaCtackskccpRqqVw0zcmZ3QOS
         0zraMsyawXa63Eg83alOBOoAtLHB1PkWXAjhXzNHVl+1Q0HEIJYffeuEfMuQSo5jtN
         jyg+rx5GyBPaiwkC7GhYzrbG1CYRymgrWqSufJ72/P5JccGdqk4gbd5JBmOj85byQi
         8RWoH1dl+oNkX1MVLlDNk9a++QarZSRWb97vGp8eL9Pi8Etletswgf3DWNzMxv3RCi
         7d9NkNYGklHunkQY0Krex0ADtCfcboiJIwI5CzBDrQGNb0bOPN2OjKMJshjUCvloLw
         wKoGthGQ0y5vA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 16:07:44 +0300 (MSK)
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
Subject: [PATCH 4/8] leds: mlxreg: explicitly unregister LEDs at module's shutdown
Date:   Wed, 25 Oct 2023 16:07:33 +0300
Message-ID: <20231025130737.2015468-5-gnstark@salutedevices.com>
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
 drivers/leds/leds-mlxreg.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c93bd72..6d65e39c3372 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -258,6 +258,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int res;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -273,13 +274,22 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
-	return mlxreg_led_config(priv);
+	if (!devres_open_group(&pdev->dev, priv, GFP_KERNEL))
+		return -ENOMEM;
+
+	res = mlxreg_led_config(priv);
+	if (res)
+		devres_remove_group(&pdev->dev, priv);
+
+	return res;
 }
 
 static int mlxreg_led_remove(struct platform_device *pdev)
 {
 	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
 
+	devres_release_group(&pdev->dev, priv);
+
 	mutex_destroy(&priv->access_lock);
 
 	return 0;
-- 
2.38.4

