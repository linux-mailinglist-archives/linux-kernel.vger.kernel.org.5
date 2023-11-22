Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78B7F40FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjKVJCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjKVJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9AA1A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058CAC07615;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=BVnDmDR+rKA4mtrirPHxlLdI+MU30boGQ/k5V99HSF8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=L+o67bdv5DweiwDYl+nJzfqToDyKxUkExMC38yPasyDNleSxEXj4Zsdi183XH1SFx
         hCDJ6tvMvE37ciMt5xX2Mzvxh2lWPU4dcg1PX9wKaVTrBOX7Oog5GV5q3uxZwfwcCm
         jYJa584gXyzbRMEEjb1Uq448Oak17PzTQhMXE+5Djf3N0DoWGyPDGKn1R1H/cg8ECA
         H7Kpf27wYOQHy9OtcWFvkjqUMarWRGqLYdxP0kd5cwleh3b6MlI8uX/o+SpjmpBR/z
         i8K9GglXyLIKTAhUg6HteyAQYD6HtRrnUyJ07KE42Zh/mQr656+FSMxkmxdri9AeQN
         XdnVbRmIKDypQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D3C61D9B;
        Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 11:59:51 +0300
Subject: [PATCH v5 13/39] pwm: ep93xx: add DT support for Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231122-ep93xx-v5-13-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=1050;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=QfKrIvPfB0fCTM7t3btZ7iI1VCeVDRfOLLuVOPs44Gc=; =?utf-8?q?b=3D02/osWpbgbRk?=
 =?utf-8?q?zW7KjznAETCQDg3jQaL31dRaL4iHz27/zOx6kT5K0RAYMfu9fe7+hbqKkzfDog1R?=
 sG0lB+5IDenimgU5+TFPIHCH7HbgT8a6j58z/H8IiZA2HMsZ6rYY
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

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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
2.41.0

