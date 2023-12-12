Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF680E5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbjLLIWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346050AbjLLIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EACEB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43701C433D9;
        Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369325;
        bh=AkcpEhPlxoOxc0vqhKcuHKzbdjTpRUS7egHrzbO96pU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=XcCxWmrdLkigs6uQjfBq6O0oowB2oncVXEdC4JpiHMzawCERWPKkkA7XmI4y+KwZD
         sBKw7m0a+kOFlqFXz1nBWrdyXWvlYmSLV2hO3EGiLxviQsuK+sz5Lp8/RLzMa8lgq5
         XwUxZnbDjlMIwEaFLYpxNRgXINWftHpu0UyBd2FdnkTUlBNW7/02Sw0DqfkVXuLbwt
         aDen9463fCH0v4VYtT8rgjRyTusrA4tQoT2eyPoS9ufLB99Hde/MnTQG3uKnah7B3r
         tKP5qbatLEBAN3oX1o6sqeSiNhOdOuQAixrJqWtkpI2nWlsKc6nDPkXTYUubb7FeWp
         tOqsQk/rzwuJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 33717C4167D;
        Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:31 +0300
Subject: [PATCH v6 14/40] pwm: ep93xx: add DT support for Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231212-ep93xx-v6-14-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=1050;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=0ShGpvSFf+bjybDV16t/6Z4F0QpifBcoOlR0O8wpExg=; =?utf-8?q?b=3DgrluBWepXcbY?=
 =?utf-8?q?qdApuYh5g6HwthFV7Zvx+EM/WLnkrNxPKC8gN2q/jI27B/DuQOn3ASHV9dko+PoR?=
 tI/nnnuvDYiKP+s0Ljlb689QPUHGYMnN6fqfu6PVBEAiq6S7G73x
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

Add OF ID match table.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/pwm/pwm-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 51e072572a87..7cf05d0b78fb 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -189,9 +190,16 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
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
2.41.0

