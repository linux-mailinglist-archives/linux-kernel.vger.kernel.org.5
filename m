Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3167803C52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjLDSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjLDSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:07:12 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DC9109;
        Mon,  4 Dec 2023 10:07:16 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E09ED10000C;
        Mon,  4 Dec 2023 21:07:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E09ED10000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701713234;
        bh=d8YylvO0HU+4GQf+TTFQ6STuqvCB6UYaTCNR2JumiPA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=b4Oum7vjao8QFZ4tE78SOvrwMO/aOqJsA2M1wdA9lpv/7TjEOD7kdaiYWFSmKhDGX
         W68K4Ng3qvkEdcCy3/RD6ubyV05jBnAS/qxoOcnIbJiKDol0byE7VpOQtAbEQ0IRzx
         ElWkA7MZkVeTPmJV9kp/rYqd/az+8zU70vHrUucxTGbYzr8L42jYPzpPcgtNlod77E
         Mnan6JsNC8ZXiu9VzL9+fWBbnA69TWVJyO2MYyq20YKlmw2qdxn9gUGG4ZSR2GaWDk
         Et68R647fEWjtzWT8GJ4UGd4cgb6ZPvuTKQ5UbHGhJUdB/5VLFuh8OimkqlANlu7hU
         NhgHVafzVX2WQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  4 Dec 2023 21:07:14 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 21:07:14 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <andy.shevchenko@gmail.com>,
        <jic23@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 02/10] leds: aw2013: unlock mutex before destroying it
Date:   Mon, 4 Dec 2023 21:05:55 +0300
Message-ID: <20231204180603.470421-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204180603.470421-1-gnstark@salutedevices.com>
References: <20231204180603.470421-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
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

In the probe() callback in case of error mutex is destroyed being locked
which is not allowed so unlock the mute before destroying.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-aw2013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 59765640b70f..c2bc0782c0cd 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -397,6 +397,7 @@ static int aw2013_probe(struct i2c_client *client)
 	regulator_disable(chip->vcc_regulator);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
-- 
2.38.4

