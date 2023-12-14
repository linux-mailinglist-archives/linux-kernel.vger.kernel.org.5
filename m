Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8858812A60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjLNIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjLNI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:29:48 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E0BD;
        Thu, 14 Dec 2023 00:29:51 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 3922312004C;
        Thu, 14 Dec 2023 11:29:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3922312004C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1702542589;
        bh=k3WMJ0GNwuGRczuP2LxdxutooPucV6JPLeqyGQDEPIA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=of1Tn4MRm5JWSFtRnnpDpM398sl1bI3loVSFhziq0an1Mqfcp58dJ8NWZ3hV9x8TG
         ttbTHk6KPFMrlpdvRaSJGr9Esy179EGMKnpANrgkKDqn57Cpt0YSowxKnapmgy3qFN
         5kXd5YF12alRwLC8xE7auXPFz1I+uEEsqt8x3Tk/pRevSHfhVr8EJyoMeeZIKwpd0D
         R7+EuFWggZUxYrUC1GszOPHbdCq53M5alfHXiyKCu9Rag/osUYHalxhY5nVIk5AhPb
         CShMmbVYiUzNkB4NNyVu9/i2tkoG8VeCzsvshqWp9bmL0Aj2Up13qUEhHGYTDmouAg
         PzrmOJzcC6yCQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 11:29:49 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 11:29:48 +0300
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
Subject: [PATCH v3 08/11] leds: nic78bx: use devm API to cleanup module's resources
Date:   Thu, 14 Dec 2023 11:29:37 +0300
Message-ID: <20231214082940.2718303-4-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214082940.2718303-1-gnstark@salutedevices.com>
References: <20231214082940.2718303-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182104 [Dec 14 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/14 06:13:00 #22683038
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
the LEDs and that callback uses resources which were destroyed already
in module's remove() so use devm API instead of remove().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-nic78bx.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-nic78bx.c b/drivers/leds/leds-nic78bx.c
index f196f52eec1e..f3049fa14f04 100644
--- a/drivers/leds/leds-nic78bx.c
+++ b/drivers/leds/leds-nic78bx.c
@@ -118,6 +118,15 @@ static struct nic78bx_led nic78bx_leds[] = {
 	}
 };
 
+static void lock_led_reg_action(void *data)
+{
+	struct nic78bx_led_data *led_data = (struct nic78bx_led_data *)data;
+
+	/* Lock LED register */
+	outb(NIC78BX_LOCK_VALUE,
+	     led_data->io_base + NIC78BX_LOCK_REG_OFFSET);
+}
+
 static int nic78bx_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -152,6 +161,10 @@ static int nic78bx_probe(struct platform_device *pdev)
 	led_data->io_base = io_rc->start;
 	spin_lock_init(&led_data->lock);
 
+	ret = devm_add_action(dev, lock_led_reg_action, led_data);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < ARRAY_SIZE(nic78bx_leds); i++) {
 		nic78bx_leds[i].data = led_data;
 
@@ -167,17 +180,6 @@ static int nic78bx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int nic78bx_remove(struct platform_device *pdev)
-{
-	struct nic78bx_led_data *led_data = platform_get_drvdata(pdev);
-
-	/* Lock LED register */
-	outb(NIC78BX_LOCK_VALUE,
-	     led_data->io_base + NIC78BX_LOCK_REG_OFFSET);
-
-	return 0;
-}
-
 static const struct acpi_device_id led_device_ids[] = {
 	{"NIC78B3", 0},
 	{"", 0},
@@ -186,7 +188,6 @@ MODULE_DEVICE_TABLE(acpi, led_device_ids);
 
 static struct platform_driver led_driver = {
 	.probe = nic78bx_probe,
-	.remove = nic78bx_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = ACPI_PTR(led_device_ids),
-- 
2.25.1

