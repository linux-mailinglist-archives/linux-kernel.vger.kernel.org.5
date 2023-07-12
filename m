Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC19751449
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjGLXPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjGLXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18242D64
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF19061997
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D612C433C9;
        Wed, 12 Jul 2023 23:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203656;
        bh=jH0tc4h0aO75yyuZ8Wux9PHPeYRfDjydLkgn8FKnic8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ipixi9oz240Fk6hh6FSP9GhovrfKKEzIsZ3oLPW0q4dhC5+issncyC24vCLZE8Kg/
         de4TSRZMX3Uqdzdm0x2rs/XDnDO49/TdNIJ/HGweFJJrq6fvH086rAmXjewhIVTaRc
         xm2KWPlKBf4pTa3sLxRwDjJG8G36WAREu3DQ2aXqoka2GCWPX/59B2VBSLWXJQP8AB
         hJL880LY3uoLYMF61ZaNe7G/Ho7fYy31SRSyhW1LLFzNu7dnXCbOK2s3+9xzSayDxU
         5y/UQNyG4kB5Q9ljKwX+pfh97nP/fyndOJw99CNy+96uMzhaX2RTwxOitDLogrV+2m
         +6TxkVYb7jssw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:53 +0100
Subject: [PATCH 04/10] ASoC: adau1373: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-4-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jH0tc4h0aO75yyuZ8Wux9PHPeYRfDjydLkgn8FKnic8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO2QeAN1qZjeKDjeWZf5jUfNPUw5eTH1mUr3
 kD7sEN0T62JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8ztgAKCRAk1otyXVSH
 0H1QB/4iY6SjVxxeAgJ3i31IWjv8dUuMUh56Plmnd8L/Gjj4DPuwDECXfBrKDCEByMAFh3lsyFe
 5uYXMAEeiHZTmYX8Nb/CeGSaWRwBwyYanOMW8GXNjF9kBwsWcm7Iggm3D9SzT3bhPyJqygq4TvJ
 yJGQW9coieAh/qrSrw9Fe2r0ik9MyyR3Sz35lVQkxxReGbtomCRaer5JzqIAQopo8tuCX8MtdJG
 k5B9Z1n/bANKmzw/XpTYlmkSnjpZKXfFiJtghBO3nvLczllwZ0uuxGmHM6HVCNDr+D7MREqifdd
 Z08quqPn7At4SouY/9OpmmJumf3ZiwoXgHfNpcbm8U6B4UQc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Update the adau1373 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index c5b087b8fffc..b0ab0a69b207 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1451,7 +1451,7 @@ static const struct regmap_config adau1373_regmap_config = {
 	.volatile_reg = adau1373_register_volatile,
 	.max_register = ADAU1373_SOFT_RESET,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = adau1373_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(adau1373_reg_defaults),
 };

-- 
2.39.2

