Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9826375144D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjGLXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGLXOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95226BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EE66198C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5C4C433C8;
        Wed, 12 Jul 2023 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203663;
        bh=maeyk8niWnAULCMV0FtXrXZznstBI6OwjQVjqc4uEYk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mfPSQfriX5rZDjSOqd+inssI9AYvJXrlboAL80eucCDW32Hw4Q2YeY2Wcr7svsb4r
         bKrnM/X0a0ftZBpLH0KefzpkGqmGlXGhD2TDpcYWeGjrfn5CG3U4gn47bK6ZImXqqm
         /ZVIy5yGbw57oKhDRBYjLXQO0I8nYvejoWDgK0hCzLnw30iPcCr0v82g4q+7nm89dX
         BTQPU3ZilWPR7OUqmA1xDcEI9eFZ6BRpuMHnQ27vHRvkoo8l6GeDybkRuHWaTsbu7a
         uP1QgNwFaWvrlJmJ8tLXd5WRbT6d0BMUZOInmTQTu9MZvlsNuSDP+cV2TnEadceWHv
         YKQnagZVbPrHQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:56 +0100
Subject: [PATCH 07/10] ASoC: adau1781: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-7-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=maeyk8niWnAULCMV0FtXrXZznstBI6OwjQVjqc4uEYk=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhpT1xjuapwooPA3U2swTbvvmtOAWvpuVmaKHthQIHObvq
 dzEY9HayWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBMpPEOB0Ojd8hD7bwc0Sm9
 yvXmnZ8YXPpqTTwT/A9ZrncUYxbMudi3+tGzL8lMj0OnX0iKnLQh+b6OaNj32zdPrQheqf7+zGT
 HvdcETrtXCPQyzdka27+Dyay41vu9bFvy3sDcIr3wb2s2OnmsDZ2wre/cpvIFHEwlV+6F5m82V2
 hKunEnrpnx9FKePPutnxKnfPD7vsLnx/kcXZa/dzN6Lvd+TMj3S304X9v63f5ws70sm8yOBIvuO
 rJwzcrHvDcSJgp7+bUu6q538efjbtTU1nb/cKRgV8eK+Q2N7yt4VRb5uD4qucxinSBdUtyt6C7p
 1SAXGF/6dXdFdI/k4xCtUA3NuFd+javfNVoJRhfr6lYBAA==
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

Update the adau1781 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1781.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index ff6be24863bf..faad2f9f8dd2 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -472,7 +472,7 @@ const struct regmap_config adau1781_regmap_config = {
 	.readable_reg		= adau1781_readable_register,
 	.volatile_reg		= adau17x1_volatile_register,
 	.precious_reg		= adau17x1_precious_register,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(adau1781_regmap_config);
 

-- 
2.39.2

