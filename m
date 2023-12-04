Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AC803C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjLDSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjLDSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:07:09 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08EFF;
        Mon,  4 Dec 2023 10:07:13 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C9100120015;
        Mon,  4 Dec 2023 21:07:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C9100120015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701713230;
        bh=2odVOM9BnkWCbIAdrFB9FbwUfhyeUbvi+YVzHb6e/sU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=uhrUXJipaXGYfVT73+HL9DJgULCzGID9RZhkeIk3XZZj0FJvs/6+VXnYlmDqO9mlW
         kaR/oX8BvDrhQP9yG7l5JJWxJOWhL3v/GJc/JzSoaBv0Itciu2axBKy3GkZhacsvoT
         hzE5AzoQQrvHWOqwZmnCZhTM/hNGFvdPrMwLnSlkRDncWG3QTBiQ6Hlcl9iPxy4XTW
         EzLrLtpXEOGZ35KY5Mf5slq8GwF/3WP6QzQNpC6lu7PhVec0DaNXB+++Amv8qVLIkb
         x70MVxpA4jPrqs8LjGUq+DtVUBfl2/zize5/IXd7rKM69E4KPrZ/gZ4F8qzHKSDGTU
         EvPOjO6Lq95KQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  4 Dec 2023 21:07:10 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 21:07:10 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <andy.shevchenko@gmail.com>,
        <jic23@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 00/10] devm_led_classdev_register() usage problem
Date:   Mon, 4 Dec 2023 21:05:53 +0300
Message-ID: <20231204180603.470421-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181831 [Dec 04 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_uf_ne_domains}, {Tracking_urls_end_caps}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/12/04 17:37:00
X-KSMG-LinksScanning: Clean, bases: 2023/12/04 17:37:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/04 11:06:00 #22624476
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

This patch series fixes the problem of devm_led_classdev_register misusing.

The basic problem is described in [1]. Shortly when devm_led_classdev_register()
is used then led_classdev_unregister() called after driver's remove() callback.
led_classdev_unregister() calls driver's brightness_set callback and that callback
may use resources which were destroyed already in driver's remove().

After discussion with maintainers [2] [3] we decided:
1) don't touch led subsytem core code and don't remove led_set_brightness() from it
but fix drivers
2) don't use devm_led_classdev_unregister

So the solution is to use devm wrappers for all resources
driver's brightness_set() depends on. And introduce dedicated devm wrapper
for mutex as it's often used resource.

[1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
[2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
[3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383

George Stark (10):
  devm-helpers: introduce devm_mutex_init
  leds: aw2013: unlock mutex before destroying it
  leds: aw2013: use devm API to cleanup module's resources
  leds: aw200xx: use devm API to cleanup module's resources
  leds: lp3952: use devm API to cleanup module's resources
  leds: lm3532: use devm API to cleanup module's resources
  leds: nic78bx: use devm API to cleanup module's resources
  leds: mlxreg: use devm_mutex_init for mutex initializtion
  leds: an30259a: use devm_mutext_init for mutext initialization
  leds: powernv: add LED_RETAIN_AT_SHUTDOWN flag for leds

 drivers/leds/leds-an30259a.c | 14 ++++----------
 drivers/leds/leds-aw200xx.c  | 36 +++++++++++++++++++++++++-----------
 drivers/leds/leds-aw2013.c   | 28 ++++++++++++++++------------
 drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
 drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
 drivers/leds/leds-mlxreg.c   | 15 ++++-----------
 drivers/leds/leds-nic78bx.c  | 25 +++++++++++++------------
 drivers/leds/leds-powernv.c  | 23 ++++++++---------------
 include/linux/devm-helpers.h | 18 ++++++++++++++++++
 9 files changed, 116 insertions(+), 93 deletions(-)

--
2.38.4

