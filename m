Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB075158D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjGMAx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGMAxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:53:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB95211F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3EC0618A6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64999C433CB;
        Thu, 13 Jul 2023 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209630;
        bh=9opwocm8Bxmswth6eY43OSPv8SSHNSdvl6coyj+aFLQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ak9P+SugOsPagKIfJrMaoaw+AAFvEqKBIhHa4D2xv4HwdZBFVrIlmdNCoBf7r8HYa
         /CvIKdO5PWpnTozdS1X8oCXBD6qrQVXJtwcMmemre2wOXmqwQ8Rz99HuyjNFjlwq7W
         zSK2O4wKemExGAYc5iw2esnXQfcWpK/yimFVNRmxw76vI+IMdh2vLmIlC2MVWRCVq8
         QCpBucBzBDNP6rdmg+Yh/hK/p9q1jgmVNqte1Z6+pZ+fji4ETwek3pQ6M4uiF0nCLE
         k3JlfC8OsLBw+bt6LXPD067CMChJbMxqh2zu09S7Ego4byc9gDl9Ew46ZQZqYr2Eyz
         WyBKiB97WCe0w==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:22 +0100
Subject: [PATCH 04/11] mfd: cs47l85: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-4-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9opwocm8Bxmswth6eY43OSPv8SSHNSdvl6coyj+aFLQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sM8UI068/G7/CDS8R7s+b+JyPD/0VjEJUc1
 2zJya7fnEKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LDAAKCRAk1otyXVSH
 0Do6B/4/iI5Agfo0eBLtv5QMHaMiWVLZezbwTn3XuOftiZ35oPvOCiUtMN7IenWL0iJ9EgMNnLg
 78u+6+VHZohZ7ADz7cScEppK17wigN7WHjX6fT8ldDDGp8t1IOqC4Nf8GtfRTLdfz9C7rxI+e2f
 iMjv3Yj5EAQxjadmGLiFNZseu46V7i/gwPdsL+qqk2y4H0qE7fxBI5u8cIAxwINJu8lqQgZHcvc
 cHwHH60N+3pHNMNuYHgYQpB43PW8Ym5xpYuy2Ocivd08nnkCjwn+00h90OLeEo85bUglVLoPWyo
 KG6AVCMxFZ2E8i8IvSbKYVK5KLapLQyleYUY4ogxaLWHJWyx
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

Update the cs47l85 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/cs47l85-tables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs47l85-tables.c b/drivers/mfd/cs47l85-tables.c
index 270d8eda3f5f..f397894827ce 100644
--- a/drivers/mfd/cs47l85-tables.c
+++ b/drivers/mfd/cs47l85-tables.c
@@ -2836,7 +2836,7 @@ const struct regmap_config cs47l85_16bit_spi_regmap = {
 	.readable_reg = cs47l85_16bit_readable_register,
 	.volatile_reg = cs47l85_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l85_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l85_reg_default),
 };
@@ -2853,7 +2853,7 @@ const struct regmap_config cs47l85_16bit_i2c_regmap = {
 	.readable_reg = cs47l85_16bit_readable_register,
 	.volatile_reg = cs47l85_16bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l85_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l85_reg_default),
 };
@@ -2872,7 +2872,7 @@ const struct regmap_config cs47l85_32bit_spi_regmap = {
 	.readable_reg = cs47l85_32bit_readable_register,
 	.volatile_reg = cs47l85_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l85_32bit_spi_regmap);
 
@@ -2888,6 +2888,6 @@ const struct regmap_config cs47l85_32bit_i2c_regmap = {
 	.readable_reg = cs47l85_32bit_readable_register,
 	.volatile_reg = cs47l85_32bit_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(cs47l85_32bit_i2c_regmap);

-- 
2.39.2

