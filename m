Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634A075144E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGLXPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGLXOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC91FF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0F061991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92577C433C9;
        Wed, 12 Jul 2023 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203665;
        bh=oxrEvVnY++rXrfX/tkK8XuL15XWkguq7C7FYOFUDMLQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Mcyq+ZCRUjSKsqH+2gWGYL+ZJ8fNk95+9ymWUC4hYY6Ep2iLEwdz3hEpwzwwWR3t5
         r9IQ5NrVS/6oxvPgAR2Ntr9cAIY7l3qmyFvvUxcgeKaqSxpdcH+QA0DU/74Wysl4Rr
         1wRyeZ6rAZTMBoXigetH8R0Wzc9gVGoI99wq1UbzeZf+J+BaloTCXmAiiNK2jX7Y76
         x+nZuQEq5kBaO3XqYkKqJmUya5vy85EB8y/kTR4GnuCyjee0fx7tFDq0vQAhXMzZvu
         HyvkH65SvWV9/wedjNGXFymUVKf4+YKeJZYQhMoZiDSLEXUEsSyMtzRInEE7CLIwnG
         UdGwGMVtDX9xA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:57 +0100
Subject: [PATCH 08/10] ASoC: adau1977: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-8-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oxrEvVnY++rXrfX/tkK8XuL15XWkguq7C7FYOFUDMLQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO5wAaemkmcKRuJko7ypNDdv7Hm9ulfRM27R
 4weqRcde92JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8zuQAKCRAk1otyXVSH
 0F50B/930U/ZNcmlBaFuT7GeFbHWP2yrfdXTOGRjnlRR/KII+Kov5kpoNCaaLewy8WjkwQSnVJ6
 aufN7XQNiUOXVSFrSMwmLBi3wkSiIm6CmTFGab1xy33jCnWPZd0kdkAhrc7DcMK0bcbR5fuAkYz
 J8NyKATqmqSkx9DK1ZtVmZIYg3YTD99tpMPo4P8pbZSxN1dWRwJx32hc175NuEzQ/ObmyWn/3CL
 dW3ai6+mGjj2LjFmm/fWp/bJbZsDVg4ZIY8chV8we/2xkXhJ4nXHUi/uIgCeGx2/5ODZS8Xgcdx
 6OfRCnxs1se8zKTaQ43Blj+JT6QtasZlzMSQIKqyobDt5USz
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

Update the adau1977 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1977.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 7a9672f94fc6..ae59efb38f26 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -991,7 +991,7 @@ const struct regmap_config adau1977_regmap_config = {
 	.max_register = ADAU1977_REG_DC_HPF_CAL,
 	.volatile_reg = adau1977_register_volatile,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = adau1977_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(adau1977_reg_defaults),
 };

-- 
2.39.2

