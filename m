Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9A7F40EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjKVJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjKVJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D510C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4802C4167D;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643674;
        bh=qrQdSRYnIt0dvVsr5w3gpaU+qxRo3oybmeMtAq01eqc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=DAkSlfKRoqdKXl+97Zp7S7DMHBarH40Nr4aiynaIXPqYI4S+/C/llOhWE9zXFRDv9
         s9ZfHjuRgCebecTBDgqkwFLvJkMhUQjUWoBXVqMdHKYDI8fUg5F90kTVlD9oEgoyoa
         jfFs5Qu1uQRPveeyRzSkbBb+8UFvEdGD3XEYUDRbP+OW0novojbtIP8fNF/+ebLx1e
         bLfnsy9+XfND+D5ivpDWwn95g74Pq9aAB482klnn3sF2CK2o+UBzQ9nAs6ZtUM94hn
         C3q46+jK/pjNQzZIOxWl1R4Tc/Zhm/+n7w+yMwScMAsGS/rbxd4MW1AdqmHmYo68K5
         m/J2YnspWWRng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id D60BDC61D96;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:49 +0300
Subject: [PATCH v5 11/39] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-11-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=1127;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=yDvFgKkbYlXFeJISIbxBJBumhjJt07IbMFASDCbxstc=; =?utf-8?q?b=3DnUPgLWqUfPB/?=
 =?utf-8?q?EH0zfj9uDpJKoUw7+XBWKaMkeekgEfmUEtPLZiG/th4inQYFjyyBKh3edmoNW72d?=
 SYMHjbgGCjeFG07GM0UCQuaOPxdWipQ5Mw4mDRl0jkPuDrF+Vm1x
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/watchdog/ep93xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 59dfd7f6bf0b..af89b7bb8f66 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
@@ -127,9 +128,16 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_wdt_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_wdt_of_ids);
+
 static struct platform_driver ep93xx_wdt_driver = {
 	.driver		= {
 		.name	= "ep93xx-wdt",
+		.of_match_table = ep93xx_wdt_of_ids,
 	},
 	.probe		= ep93xx_wdt_probe,
 };

-- 
2.41.0

