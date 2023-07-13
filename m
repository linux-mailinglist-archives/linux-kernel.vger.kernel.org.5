Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2475158C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjGMAxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjGMAxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEF9210A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705D0619F4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F73BC433C8;
        Thu, 13 Jul 2023 00:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209627;
        bh=n1mRkRxsofMbN51KpusPFOu4u+ZtWLVZsPkgoysprZA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=O9Myz43uTNCdO96Dkoe7ai/cJA9u69eu3xPz5Rwa7vTFawTNgUf37Iur6Q8JcYW/L
         q3H3ySyOJttJB5a8P/AEIG24JdlX3GuwlVOtxWsCrbfuS9bZFDd5rmSVcCMLbnrBty
         6h+5x7SMilYrmxqV6U97EfU0rcx81N5ZkslQyrsEF0Pyj0nUtbi+FRbcC1z4kI544O
         Ibyzs6Bq7kytTLioN9QSQaWfVD66fXqxwkw43lKaQD+NqqjskLlMEy5EsWRyCeUtkq
         H3TLont3Myq57goDbtCSkP4IUBLabsKZocvvGkfF1j+uq04RoiqzHeesmKJJWSH/qy
         ++alQwUAt20hw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:21 +0100
Subject: [PATCH 03/11] mfd: cs47l35: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-3-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n1mRkRxsofMbN51KpusPFOu4u+ZtWLVZsPkgoysprZA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sMEJDv4ZzC26fTmVQlhSonR4VXSGlV0NmHf
 i8q/BgHhuaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LDAAKCRAk1otyXVSH
 0BW2B/411+ysH7+FPeLiCtraOBTEIZasU1W/69G6xJT5X9q0aF0VpCvL56RiGhznM8LZqOusnxD
 3lx/97Xr08FaWaa90C+xJ4z6bMzPWwvKz32+c3pHj15VnxRdG+QxPcSaMQNEzgSDQ7N0bogDiKH
 hh/ISLZ2d8OcHVG5n9rMWpsE0zf+RTJCIXFZg8l/WociSUq1LZ2IlauytT5jFVZ6SotGslq7gj+
 jdJAM/7IX5+MKqujcWnWNFysnXzlhFAyLanNJPARfnoUTTemJNmjADHtNw6B5YLqVAuPc9ir6Qi
 hg+O9Frye/NWKNRf6nOy97wTot96sCdv0GB6o3y3fBFrrQo5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Update the cs47l35 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/cs47l35-tables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs47l35-tables.c b/drivers/mfd/cs47l35-tables.c
index a0bc6c5100d6..274f4b05850a 100644
--- a/drivers/mfd/cs47l35-tables.c
+++ b/drivers/mfd/cs47l35-tables.c
@@ -1498,7 +1498,7 @@ const struct regmap_config cs47l35_16bit_spi_regmap = {
 	.readable_reg = cs47l35_16bit_readable_register,
 	.volatile_reg = cs47l35_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l35_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l35_reg_default),
 };
@@ -1515,7 +1515,7 @@ const struct regmap_config cs47l35_16bit_i2c_regmap = {
 	.readable_reg = cs47l35_16bit_readable_register,
 	.volatile_reg = cs47l35_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l35_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l35_reg_default),
 };
@@ -1534,7 +1534,7 @@ const struct regmap_config cs47l35_32bit_spi_regmap = {
 	.readable_reg = cs47l35_32bit_readable_register,
 	.volatile_reg = cs47l35_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l35_32bit_spi_regmap);
 
@@ -1550,6 +1550,6 @@ const struct regmap_config cs47l35_32bit_i2c_regmap = {
 	.readable_reg = cs47l35_32bit_readable_register,
 	.volatile_reg = cs47l35_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l35_32bit_i2c_regmap);

-- 
2.39.2

