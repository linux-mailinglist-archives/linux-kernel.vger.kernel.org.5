Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552DF7A183B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjIOIM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjIOIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB520272A;
        Fri, 15 Sep 2023 01:12:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EBE9C116AA;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765529;
        bh=kAt8817iBUWjVxWMBOqzROB0TJ1eW00HgMPsspiwX+E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=l90hpNTWu7YShdFcNGTlJu3c+zNDKyO4jcR0EclxbZw/RJKns7gpAJ42OvcqIyJYu
         Q3gn86vEERTGUPpGGsV4rHyHUZIamc1tYhplS1UR1uieZgyeeOkdlmOP+O1eeTS5Qv
         p4Y3ZIhChTuXZ65RaghMaJfauIsq0LiXgKAyfb/P3Wo6EiB2DpKggPQWYzh8ks8kyJ
         5Z11ZK+JYg+Eu4v18yHucHVJSAYq4P4uSJF/nDJqbAZWwCiYC0JkTbS8Exb11lNGam
         QD3aU2lFzCtX1uGRv8S5fIO1OAtphG4/Q2iERknxPZmeE2/6PiLKeAA6VF8dD+/bZQ
         32Sradg2flsew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F5EE6436;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:11:00 +0300
Subject: [PATCH v4 18/42] pwm: ep93xx: add DT support for Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-18-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=985;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=q6xBgC7li0n86IdULKMuNEoQ+2zcC5ZGWjR9L/JodCY=; =?utf-8?q?b=3D17EIERKxucpL?=
 =?utf-8?q?j2jHDScpqVG/JDsbky54hnLYZZQD6n4zymck1pC9rboVavxsowMs3mzFYr6QHwl9?=
 r3pM7v+oD1AbrekAA6l3Tdes0KKT6GvCpzMRQX0plaq3Rn+K3A6F
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

Add OF ID match table.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/pwm/pwm-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index c45a75e65c86..361984ef4c0b 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -190,9 +191,16 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_pwm_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-pwm" },
+	{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pwm_of_ids);
+
 static struct platform_driver ep93xx_pwm_driver = {
 	.driver = {
 		.name = "ep93xx-pwm",
+		.of_match_table = ep93xx_pwm_of_ids,
 	},
 	.probe = ep93xx_pwm_probe,
 };

-- 
2.39.2

