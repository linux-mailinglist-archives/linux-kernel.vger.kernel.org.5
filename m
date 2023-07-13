Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A172675158E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjGMAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjGMAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB7213F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D9CE619BD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB736C433CA;
        Thu, 13 Jul 2023 00:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209632;
        bh=0louHWS+XXVrWGr5v4QqW9jALA5BBNUAZSluJauCqd0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eHhvNSC09sshN/TRZdq0ojEkp4yvyxSjoXySGaKfDDFT8jO73InrOeQ6il4/+sPpM
         DpozH+tTS88+QRG21HXsNc0R3sJL/x3+RASFUkJJ2j2sdg2ILsqXQYgiNr07y1PrDl
         AKaI8/nKl43yf4isn+6b77hXYi1xiq5iVP+CrMyQMML7r9jjjxknpOVYoystRG8rWe
         22/NhSnbA8tfDe/rjV2Cs7Mtc+gKlVGNEpPZHAvEevxSwQNVj1T0s3qZoZrjoJUnYS
         D8UZdJ38P3v/iQQU5zyvcqDJXsTjgenZhg4T+A1cyGNQReZkHvkZ+rzzVkeC7oxcFs
         GemDoUQtYFRLQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:23 +0100
Subject: [PATCH 05/11] mfd: cs47l90: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-5-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0louHWS+XXVrWGr5v4QqW9jALA5BBNUAZSluJauCqd0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sNY5vw257sr3jpgkXKNHy/48m1h4uPbYXKl
 IOl8KrvhI6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LDQAKCRAk1otyXVSH
 0Nk9B/kBmk58s/KiHnGuAwEH83uyI8cL71peREwLy8yNm5+6bZndk1AlLQwcJbXTRdaH31maxRS
 lEkt2m7ASEmUq6xUL12Or5PpL3ZxsXpFo1M6rs2PqYg/09PzxkFTs4rt8o9nxeKiynFhreITXeQ
 HCO34NjJ6CCtpNcFGaY1BvTH4YQI+4pUA+C7WPwAknBiwrrMJ9eZevXaGal86CrJTBTJKXlX+L7
 dbKZrXHKcfSMDVJ/6jpIjXUnfOdSq32RLBT9luEJ0fc8AZOwXQhkctjuaNR8/43XwgtvLoZvW5i
 g5RS+6AVhzyNJLN7j2h3y2joCxyhgHw7Q8YFEA9oJf2D3eZ3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the cs47l90 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/cs47l90-tables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs47l90-tables.c b/drivers/mfd/cs47l90-tables.c
index 7345fc09c0bb..6f9ceb36c533 100644
--- a/drivers/mfd/cs47l90-tables.c
+++ b/drivers/mfd/cs47l90-tables.c
@@ -2539,7 +2539,7 @@ const struct regmap_config cs47l90_16bit_spi_regmap = {
 	.readable_reg = cs47l90_16bit_readable_register,
 	.volatile_reg = cs47l90_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l90_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l90_reg_default),
 };
@@ -2556,7 +2556,7 @@ const struct regmap_config cs47l90_16bit_i2c_regmap = {
 	.readable_reg = cs47l90_16bit_readable_register,
 	.volatile_reg = cs47l90_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l90_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l90_reg_default),
 };
@@ -2575,7 +2575,7 @@ const struct regmap_config cs47l90_32bit_spi_regmap = {
 	.readable_reg = cs47l90_32bit_readable_register,
 	.volatile_reg = cs47l90_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l90_32bit_spi_regmap);
 
@@ -2591,6 +2591,6 @@ const struct regmap_config cs47l90_32bit_i2c_regmap = {
 	.readable_reg = cs47l90_32bit_readable_register,
 	.volatile_reg = cs47l90_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l90_32bit_i2c_regmap);

-- 
2.39.2

