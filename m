Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF375144C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjGLXPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjGLXOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3026AF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B531618B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6914C433C7;
        Wed, 12 Jul 2023 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203660;
        bh=pfxaFdGw5kNjlwfEfF7+1VfvRMBqHwURM+HheyjiR08=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QUoYOgiWK8KiXpYWQp+HvRyyhd7fxNjNOfzjLAlQiKpA+/QskSKMDzIJTZm1nZ+6p
         iHMIY6m4E1n29pr9ugX2s10UGKUxXPu3U9r+ScZFaoK0DSUegvbJnyf14WMBsYWoIE
         SDFMBrAMqffaKYCCn0i5f8TKzew1/+tNDf7ZVuldOOIB7alM2L6/M8lbSTQQCGYAOc
         C0UAaBQfJOQFOWitF2tecWRd1dKCM9PB8fqkqWOMQ/3nIcwtYbtyQMw665X/nVPpF2
         iT2R5slNOnWiaehat2oskk3Ri6StMAUXeEaAOSQX1Dit3fSzJm3wU5Q1bI/tb7bPc2
         /Sq6+uL1eSDQw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:55 +0100
Subject: [PATCH 06/10] ASoC: adau1761: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-6-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pfxaFdGw5kNjlwfEfF7+1VfvRMBqHwURM+HheyjiR08=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO4BNyVqwXtReshaJmBftJFtBbR9NOfNcpeR
 4vYO3hXeEKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8zuAAKCRAk1otyXVSH
 0I/xB/490htK63/MWX1NZbt8bo5AAKXuVyzOl+bb1pfs9w0q5P+IeEWTCKEWew7m0dgR32ogwOU
 7oZdMQ038lqlgHbqtvEeAFZBWqLiTirpv9taA0P7MqHAxROWsfXeNe0lzeFz4NRPXPXrqrt6dcw
 gTmfbSNE+GlW0+2FSzcMCcbAVKXA04niXvSysZw2MkpUEuHy5JJUjnZGK+5zC+A7rhKQ152oXXF
 BjYc+jJ56Bhb5f2P0d3MYg4FCf9ZDprzz1gVlrcfmvSfOYyrnVzaTuPPvpgfCs39albNbPmbpPh
 Z8BUC/gf82zhPMnnyBKbo+yafJhv+srHb49uweGo+i5dag8c
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

Update the adau1761 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 3ccc7acac205..1f09ea385f8a 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -1014,7 +1014,7 @@ const struct regmap_config adau1761_regmap_config = {
 	.readable_reg = adau1761_readable_register,
 	.volatile_reg = adau17x1_volatile_register,
 	.precious_reg = adau17x1_precious_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(adau1761_regmap_config);
 

-- 
2.39.2

