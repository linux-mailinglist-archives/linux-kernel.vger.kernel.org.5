Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677F17A180F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjIOIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOIMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EEE2718
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:12:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 107B5C433CB;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=qStEd6QZm6V99IZVR6/5QSiL8mguTvKoR2vWr7EDg/U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=fiTR9sArGV+BtdpCyE02q7FW4GRHN+vx4D5jVHEQ1hNp/Os2OjgDhLjWGwZanR85S
         qqvr3tl2VJeupYsicmXe3UAhOD8p9G9lebm446g3dN3R9M9O/OKxHKYhk75t6V6B2V
         /A5nqKDORmP8MLDs2MKs4AvxmgCW04RShN+IoCh60UuME8mV9TBH0e+ZLUEEUNGy1U
         UZXCL0Fkb8tyeyJ2Vu01nidH/Ju61oc2EIDPP9WKz2lYDHU+dwYE0fp/JAmurlAvA0
         9DWcs4ZJCfJbsDd360gV3s5u8tvLN+jGFqBdrbLWNsSfu1xdN0N/BUWMiIEoWV/SAi
         1Ic/rXJmYmWhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E9A2AEE6437;
        Fri, 15 Sep 2023 08:12:07 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:44 +0300
Subject: [PATCH v4 02/42] ARM: ep93xx: add swlocked prototypes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-2-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=998;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=4e/Qr2asmQtXJMkiz50DzFz2rs1k952ZZU/wOSJH0lk=; =?utf-8?q?b=3DjsOX10rW3UP4?=
 =?utf-8?q?eHzu10ShbnxtbhsIPxnfNQJ55bMbdLiieNrbNHxswj7ceLFSJRWoH3SH7AcUHyRF?=
 QUguy3+KA+Ig1fD/1KOb8BGByRCg43rd9wijIc7qQK1FwtyJ2wMM
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add ep93xx_regmap_write and ep93xx_regmap_update_bits to make drivers
compilable before actual implementation is added.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 include/linux/soc/cirrus/ep93xx.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 56fbe2dc59b1..8b4b8221ed4c 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -3,6 +3,7 @@
 #define _SOC_EP93XX_H
 
 struct platform_device;
+struct regmap;
 
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
@@ -34,4 +35,9 @@ static inline unsigned int ep93xx_chip_revision(void) { return 0; }
 
 #endif
 
+static inline void ep93xx_regmap_write(struct regmap *map, unsigned int reg, unsigned int val) {}
+static inline void ep93xx_regmap_update_bits(struct regmap *map, unsigned int reg,
+					     unsigned int mask, unsigned int val)
+{ }
+
 #endif

-- 
2.39.2

