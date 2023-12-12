Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929AE80E5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbjLLIWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:21:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A462CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E0FDC433C9;
        Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369324;
        bh=Ws2Fzeywcs8Feiu8aYxTjd9qqzeV993oSjVcYoa9TP0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=QroiM6jnH+6B0Q6h7+XZppIhkxowijpYKqr0rf/Gr43zcPFlXumHa0OBj5K7xyKEt
         KWhZvvbr9SDNcJo8mH2CZr/W/EIMjN0CPlSGBjszA3M7TBpDMpISwc4CS7g9J4PkXB
         C5SgtLYTuzKPkQe6f5mjJqhBlmoFUc0MJscWgBwnYHXZHWHrzNFXXyCEj1gFaH5kUs
         w3qKvRXNGR21FzAXwtj1tl//kFNvUX87UY6vQsL4Q1hDFvdFX34exhSsYu3VbYANXU
         36O1M2B6vjiDtzaTCuWdJblRKG4LPSbFU3KpOirDfo9bQaeaEnJHbha4ceBlwKkovB
         tKjVKQf1wTlGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 88EEFC4167B;
        Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:18 +0300
Subject: [PATCH v6 01/40] ARM: ep93xx: Add terminator to gpiod_lookup_table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-1-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=740;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=BLqbGJKvsA7sLJyVC3iK75j5WqPmntAKufr+KsjrO8M=; =?utf-8?q?b=3DVYM6IAgjJ4AS?=
 =?utf-8?q?/synFz4n7psMJW+cvi6GL+317NuXXjxtumJ9AgZbQxp1v1chmXVQemUPzRZop6DM?=
 ukG6sH4rBKlE34uN7mSliYxHYtu+OecQvOyCJkTXfUuEgThZ/GMk
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Without the terminator, if a con_id is passed to gpio_find() that
does not exist in the lookup table the function will not stop looping
correctly, and eventually cause an oops.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 71b113976420..8b1ec60a9a46 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -339,6 +339,7 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 

-- 
2.41.0

