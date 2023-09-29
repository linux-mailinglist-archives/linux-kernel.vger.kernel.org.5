Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FCE7B36B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjI2PYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjI2PYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:24:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C534D6;
        Fri, 29 Sep 2023 08:24:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57948C433C7;
        Fri, 29 Sep 2023 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001046;
        bh=tLMR3aghMf/AhPWtcH9w+gBW2wf07ak+UQvSzPzVblg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lPugBENK75E1xPTbcI7TkQk5iJUR5UJwI80B5HCMKmXDz2hUS+yyQPiEaZmFwwUXD
         755Euk3tP9dI8ejzwlPMqudTcEg2Ho534V/Pi6oN652nUVntc4PM3EYxkAM3J6T5A5
         XJcCyCox6evJWGFjQ79Y4rOOGbNNtcoLf8/Fo51OUG248FeAWQIcNpsIgLUEZ/ApNy
         MWRiI1K3TcBiVl3oChKOyR4J8ZmzH2cXWmCr9382BUETZ9OeDdo2HuwuESZlyosSlc
         h+0HsnHpDUzcCNK6m/p9SnO1QryWOx2uhT1b6QqI0kwsTzx8obOYWGhQOg1ezi3d68
         OSaI2HU4vFwkg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 17:23:38 +0200
Subject: [PATCH 4/4] leds: lp3952: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-leds-maple-v1-4-ba5f9dcb1e75@kernel.org>
References: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
In-Reply-To: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tLMR3aghMf/AhPWtcH9w+gBW2wf07ak+UQvSzPzVblg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFuwMEbV1tKZ8nY6RRmPRJ+2AC9dtNMCbEkm1R
 RYyIhWY6JGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbsDAAKCRAk1otyXVSH
 0L4xB/0TxhhxrltOUFZlHxCGEUR6FDZlIKlKg/YnUQILVybkIhRRHFK4VFZNggnJ7Nsf49UJqj3
 2vpT9CYxEs89GtgiYZJjIXTAStAoPVE2Y06IMrU4FSY+4M5SHDhD1srw8AB3rUh7Hyl7fW2Y7lA
 EPAloHoLY2/N8j4eEJ10b7JOYN7HlXpxvJDArnP9qSuivMFitFqhuYfq66lbNE3atRYXTTK2GOx
 v3BcsXnLb+yEnSqqSeyIAp8QPdlQJ7W6t94XhupXRZopa1MVPr0CqG0jitSxRQNJyVVc5Spu8hC
 ye3eW/gSfS51jZtohbbFNqlwiPd/0/rS9PKr8IsjOUAifq50
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/leds/leds-lp3952.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
index 3bd55652a706..9e6a3d300b2f 100644
--- a/drivers/leds/leds-lp3952.c
+++ b/drivers/leds/leds-lp3952.c
@@ -204,7 +204,7 @@ static const struct regmap_config lp3952_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = REG_MAX,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int lp3952_probe(struct i2c_client *client)

-- 
2.39.2

