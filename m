Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A532C751446
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjGLXOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjGLXOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938D32724
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31EDC61991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989B6C433CA;
        Wed, 12 Jul 2023 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203649;
        bh=tuNPYAhEyAnDlSkVPmWiTnjeDyMPQdLYllR1mQgPQSw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tYqTP7vlgN93C5NQRewPJ6PRP0L45BpCpw5vbWHAc+XOTUEpxd799W8DQ5BgquKse
         YWcND+ra5rf+JooczK0Pl9eUqRF+Kg9N6Sb8TaRBEGM/sO0DBZDPWkW4uGGQoQhcbY
         5odhtdRnt6WB/XZYa5pQVv2J+zhq2geMTDdozR3Kl2ePe+YpA46q9IaP2C/PxRSHUA
         wC45WUzVKRfVIYU0htyfaAOVMwT2Fe02s5SdKXRotIcNVZq0dQ+Mw/3IHSRAQLCSBL
         knImCqlY9LwTbeP0Nmb8pzVOjHw+OCVRVqBmDGhKfExJhoTn3MSXxuBbhhvBG5xsip
         bsWdhSVV4oOrQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:50 +0100
Subject: [PATCH 01/10] ASoC: ad1836: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-1-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tuNPYAhEyAnDlSkVPmWiTnjeDyMPQdLYllR1mQgPQSw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO0HKgb+PiokGadY6+hoQmWVL29CfGYTKCqJ
 SmDd59p68qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8ztAAKCRAk1otyXVSH
 0FFBB/4ndindFBf5yEp/I95nIcivqePjK65zBv34UHzUK70RaetbkWTqRdU+nG68yEZ/8IjWATq
 kk1wT8gbd2765ACGA74xwtYQ3CfABB5vUIJwlMJTzve9dktPkLL/nwOKrD8QuxNGFVp+N37+4zp
 iRwjBovTdn3mGQ4kr/crXLjAaJYWLzYuXLXekzdPCEmIhHyGRNH7VmcXIBX1dCS23b9niE/7ejt
 W+q7QDunOCYMtHQsAdn93ZeleMQE1mA2mUqY1JBRNgVzctDsMhnZ1Kw+Mjr174ubrBFLpgPud/a
 btHWOJKTo1qGucsPKk3whNaA4ar/F15b5+8azKk2p8WMBdCk
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

Update the ad1836 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad1836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 2c64df96b5ce..949077108bef 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -358,7 +358,7 @@ static const struct regmap_config ad1836_regmap_config = {
 	.max_register = AD1836_ADC_CTRL3,
 	.reg_defaults = ad1836_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(ad1836_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int ad1836_spi_probe(struct spi_device *spi)

-- 
2.39.2

