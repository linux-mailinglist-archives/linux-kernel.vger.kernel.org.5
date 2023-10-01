Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216D97B46D5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjJAK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjJAK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227DEF2;
        Sun,  1 Oct 2023 03:29:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F50C433AB;
        Sun,  1 Oct 2023 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156176;
        bh=V5NO9Eimgbw69L8Od1rfVYN0dRB+fO4oXX7TicgV984=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qEvo8uYvYQl5wCj9aAVrWgmZjbzhFA/cz+wLt20ADTMaVUnqvN/UapsW+yZd4Doeb
         1PutTEahLi8TdbdklaUDNjvcIm7FLyNY1Tsd7bHBst9pzrpqfMG8/EUASAuUi6Z+Zx
         J9vBUtjKiJnFr15t4/HcAM8mT9Ch5LkrGRleOtVdyZpLt8g/j5i3ACOnMf3Z5rDcfL
         iiq7INdBOgI/71nsBEu6Z5MgYz6Sl25gKDkuxIDG0ofdNi4iwwrqRyjTiw/7yhuCWQ
         MmFBlT7xL+u0pY0YjnAIZtb+4KcQLkfkHHNdMqtMYRmsHa7xiCrMF+OKFnpOtnAAl5
         caEyJ2jxxqg2Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:53 +0100
Subject: [PATCH 6/7] mfd: tps65912: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-6-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=broonie@kernel.org;
 h=from:subject:message-id; bh=V5NO9Eimgbw69L8Od1rfVYN0dRB+fO4oXX7TicgV984=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoEkhKdGHIabE6MfZ+vp9Br4OfWBGP4DEc0t
 MxMVC/VSbqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKBAAKCRAk1otyXVSH
 0JSCB/wOtSYtQGqp0830iApAkdB5IPntP2Xl0u173+zjH5l3foV8hV2GhHxiWlkjxuzfse9OeLe
 sqHO6lrAwL2iJb3EjTt61iaVeMA9oAFRwr4irGZxLg7lCRJdzbyryu15FTkTVbPL0REAklsEbIf
 I7/uMZ2fxNKoTjywXNVkYtaK2nZkFsQeJLngKhvmtFXdBaDM2kx22CzN2CcZTAEAyDjdB33PVpZ
 1k++Gp+Grdy/zxO1asjGJkNtgMsk1wXcX6sCtAR0bUZdKkwvYZGA1iv4nJRAyOZswoQ/AW6v7tr
 teT2M4+Bd0oW07P2/auzlSyaB/tX6eMZlk1Ho9qBZgG4uPTC
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
 drivers/mfd/tps65912-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65912-core.c b/drivers/mfd/tps65912-core.c
index 7d994b8a5965..2305ea60367a 100644
--- a/drivers/mfd/tps65912-core.c
+++ b/drivers/mfd/tps65912-core.c
@@ -81,7 +81,7 @@ static const struct regmap_access_table tps65912_volatile_table = {
 const struct regmap_config tps65912_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_table = &tps65912_volatile_table,
 };
 EXPORT_SYMBOL_GPL(tps65912_regmap_config);

-- 
2.39.2

