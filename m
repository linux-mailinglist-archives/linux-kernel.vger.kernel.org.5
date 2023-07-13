Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B8751590
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjGMAyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjGMAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AC2690
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D59561804
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057FFC433CB;
        Thu, 13 Jul 2023 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209634;
        bh=fh6MWW5xM6TIC1bWh50RDviYmRNKAyHpmR3q/bXKhDU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FTuivQKQBdt9UEsyx3/KpaT+faJpV+JSsnAAwPop5YbJJYWUkWn/K4QpSk04+p20u
         aFcmRSQGqyVZjTwCWyj33IYTru5TLRdrcJlODIdMwZ6I/TjL+J1O7GkMrKKJkPvgvq
         uwJhZanwGJmFbLmMzYzWQcj6YRwcBbd0/zHNUvVWtXeA+vISR9B9fw6wTIq7b531bC
         Zylttd3FFis7CwFQLQvooiCj8OpOnbe/itPpz16AwdJXPh30hpA+MP55EbsYigBtpm
         MsMXNMzwrEUNxfnGDEgZ6h1D33Puwpj+tzgxkzKUJhZCYm8iBMM5C1LgXyecAbRjje
         9iNnXxM8wR5Dg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:24 +0100
Subject: [PATCH 06/11] mfd: cs47l92: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-6-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fh6MWW5xM6TIC1bWh50RDviYmRNKAyHpmR3q/bXKhDU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sON5sQREXOfKHsvrHnNJcEcMKpCwbhosYs8
 g5ElL14lkWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LDgAKCRAk1otyXVSH
 0OHKB/9UmALu5xfiHKHx2GCR8b42sDK88pzDGhSp5VuvDZXe7Ow2s4KY3YVMU1Bv4cYvmbkUGRW
 KUoMeLFpCijKt0BSTIDlxQJqgEPpAvnyKznAmjf89d+pXiozENzEKja4Q3YITNkDsic3OtXFl2u
 7fS0m6LoSLV338UYq/8AdF8w1qpBJIFdsUMgbvtEfOcA6GsshfkgzCRcHCTPsuhuqWRqXKw6qQc
 oo2+BkYUly/Kja62upqHODZnYo+ZQUmA+fW3+GLtH+NmIYaVJSCyv4fx1TY5/jyMRZnRbb8roVx
 nPG1eIIMlTkf0hOesZpPI1PDGpUk+Hywph9oBAtgwpOLzycZ
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

Update the cs47l92 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/cs47l92-tables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs47l92-tables.c b/drivers/mfd/cs47l92-tables.c
index f296e355df4d..4d9ba865aaf6 100644
--- a/drivers/mfd/cs47l92-tables.c
+++ b/drivers/mfd/cs47l92-tables.c
@@ -1890,7 +1890,7 @@ const struct regmap_config cs47l92_16bit_spi_regmap = {
 	.readable_reg = &cs47l92_16bit_readable_register,
 	.volatile_reg = &cs47l92_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l92_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l92_reg_default),
 };
@@ -1907,7 +1907,7 @@ const struct regmap_config cs47l92_16bit_i2c_regmap = {
 	.readable_reg = &cs47l92_16bit_readable_register,
 	.volatile_reg = &cs47l92_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l92_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l92_reg_default),
 };
@@ -1926,7 +1926,7 @@ const struct regmap_config cs47l92_32bit_spi_regmap = {
 	.readable_reg = &cs47l92_32bit_readable_register,
 	.volatile_reg = &cs47l92_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l92_32bit_spi_regmap);
 
@@ -1942,6 +1942,6 @@ const struct regmap_config cs47l92_32bit_i2c_regmap = {
 	.readable_reg = &cs47l92_32bit_readable_register,
 	.volatile_reg = &cs47l92_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l92_32bit_i2c_regmap);

-- 
2.39.2

