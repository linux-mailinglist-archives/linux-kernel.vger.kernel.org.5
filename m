Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF337B36AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjI2PYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjI2PYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:24:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825CACC0;
        Fri, 29 Sep 2023 08:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827B9C433C8;
        Fri, 29 Sep 2023 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001043;
        bh=AQ1REKYT86SJIRHe3K5iba5TZtrH/NWHd9owkuv5xu0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=a77Cx8lSOcSbDVjROeK8pw5RnUWUbqQ+t6QmjSYSOzQQbPY1Bt7GnLj2cltthIDl9
         r+erRbvznO88LbZ6Pm3isGWloQZX03PmPlVRXDANbmEvx2J5XR9YO7pYsStNn0q3eI
         OJkQvk2W1xiboFX2YTg1GKc6Gds2vjlZP/GHUp2oqZG84C365GiJyrZBuBk2adMrYa
         bPqRhVKeL+d2CBchQbq9SPDWQIyJiB0gS0+pHSW4c14BK+Ankz6GqdS5OJuXHAV5c2
         I8zyytCNigZRSO8MCdHPzaJIQBENafeOP15QvcBS47PHnTQn98eFZGXJB4AxqQfIDh
         x5wTSUYDXIgHA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 17:23:36 +0200
Subject: [PATCH 2/4] leds: aw200xx: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-leds-maple-v1-2-ba5f9dcb1e75@kernel.org>
References: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
In-Reply-To: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AQ1REKYT86SJIRHe3K5iba5TZtrH/NWHd9owkuv5xu0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFuwL3d/DlfaPVVeaegTsqycBQsOy9i6K0vwb+
 jeWKhIefrCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbsCwAKCRAk1otyXVSH
 0HIYB/45TgdBG2Ss70Jh8DRaIN77i2WLODSMblCgcF1Zu5+JnNV+YCrOpr9UH+NqA+VyLoiIDK2
 /lTSYdadgqwrmCnqWWPl+vSG2u0DrjobEWICJX7Ki4pk4Ua5O6JdAR1mSNh6eEPoe2HEUlZy8qX
 QVLOmWMToju9HsTgZ5Un57nmYCRQfrxm8sLVGDZ+321jB7LtRNrHCcTef66AKwVmQKv4N1KFymF
 6Ps56VsLprCjT5g+atpaPCANdH/bizLEfiEGK/cuA+WP3mc4NBBWbbRbsaY8wcY84C5DK7i2Gyi
 J1vtdByG1iJQEp8X9Mss7v8uiT1I+WY38i1S241NGxpQX/sh
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
 drivers/leds/leds-aw200xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 691a743cc9b0..bec846272398 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -479,7 +479,7 @@ static const struct regmap_config aw200xx_regmap_config = {
 	.num_ranges = ARRAY_SIZE(aw200xx_ranges),
 	.rd_table = &aw200xx_readable_table,
 	.wr_table = &aw200xx_writeable_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int aw200xx_probe(struct i2c_client *client)

-- 
2.39.2

