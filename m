Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BA7BBC6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJFQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJFQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:06 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380FBCA;
        Fri,  6 Oct 2023 09:05:05 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 5E5E912000E;
        Fri,  6 Oct 2023 19:05:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5E5E912000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608303;
        bh=WaWXADN19ORvBXYMLJECaMTRXaSMTpZYcOLrM7Lv0aQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=PmyneMcwDIwgP/VkvXd1A3ZkKJcEPIb7S6mWuLFlyeZxcO7Z+9Bo1B5P5BrHc6+Yx
         OX3RVim6scjvNm6hadttpzduzbkVYXXrQcliciWhUVzwHJ1z0q+loTnbr5ZxNjxIA7
         6OBVirF9LwXDkZHK6rHooH7Cy4ix0EVtUMFXoxSFCP1HxFPTM+vrbXOyTus87hfRn2
         FDMXVDNXhFRPu5a//yo8Tnil8l2HRnN7YZRtfEX7qy+zbSsfD2OyXCaLfXd4BnPb6H
         NDF1IZX9J/XU4sK3g92Z0efqA3bQcLC8gMmdF6nHLhCuwcsSFEECsN5B7DFxoghFwI
         ym/4Akxc3/TLw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:05:02 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:05:02 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 08/11] leds: aw200xx: enable disable_locking flag in regmap config
Date:   Fri, 6 Oct 2023 19:04:34 +0300
Message-ID: <20231006160437.15627-9-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231006160437.15627-1-ddrokosov@salutedevices.com>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180439 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/06 13:25:00 #22070343
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <gnstark@salutedevices.com>

In the driver regmap is always used under mutex so regmap's inner lock
can be disabled.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/leds-aw200xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index a1ef0b0a62fc..5a1a93ffe36c 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -541,6 +541,7 @@ static const struct regmap_config aw200xx_regmap_config = {
 	.rd_table = &aw200xx_readable_table,
 	.wr_table = &aw200xx_writeable_table,
 	.cache_type = REGCACHE_RBTREE,
+	.disable_locking = true,
 };
 
 static int aw200xx_probe(struct i2c_client *client)
-- 
2.36.0

