Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA9751448
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGLXO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGLXO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F982D4A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9514361986
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36783C433C7;
        Wed, 12 Jul 2023 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203654;
        bh=kN7Q6TJPWhd01UrZwm4+vTZv1EOlCbd/ekAQgk9Q93c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rWQEJEivsSk6CTDFC7Z+KHcYysw+oLo8b103kbDfOS9WcPySkiwbDiN5f5KSj0pGE
         tdzLGg+Hwqyx/WwF7ZjGq+8v9qLfWDs3TXl3u9V1r5DF4WsNIc48YvNKDgf0lanl3R
         s/gWISWZC3vDTUO7upY5zs72+XsxHn1mclnUoOj4beV5WjebF7luIyBrHkjWlP6O5B
         W4xB8kTyhIx01q33wsGzcIY24FdvMoqnHDQpP6Vp6cUQaJ98Iq/kUUGTDfu5H2WgtV
         wDs87BOwg0oQ9vLk6SuHMX8eT6bxcGhd3aXes0nPtgp0HYuzT4KLgxgamNBOLRuEtp
         MZx8u3pPAgF6w==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:52 +0100
Subject: [PATCH 03/10] ASoC: adau1372: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-3-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kN7Q6TJPWhd01UrZwm4+vTZv1EOlCbd/ekAQgk9Q93c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO1KqolmtERSVYJzcgTWk3E6LU4Zkx2yQfGc
 WUADF6r8HGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8ztQAKCRAk1otyXVSH
 0JyJB/4z9Pv2qfbbzQqA5kCF0sJCwwmsIcMbHzjeKZ1HIfSTwVaxROgcEMiob7c464mqIrfC/uM
 2LXePFR2T5h8UJzFVXChi6EWBx6vCvPOCm219+i7HLqwrTvOb7LXtWp7ChTL3aJ2ijTlxvKIUCo
 0qKi8ZWy1h+o6IHy1SoEFm29XAft+RG+2g+ehjnkd+vAo76QIR54dCxnXayQOsppg6NWRnb3/Lr
 rO5jGLIbTQvdVewdKrxrVTwd9skTPdOR5myBYe8M9wrA5Xdadw+8TrxLZd96LX14BXft6TDReci
 1zbQ477M9BrNDbtRKx+31sozssDTXxq3mWlaZI7VRHlIA+Kd
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

Update the adau1382 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index d9bde7eb043a..98380a7ce64d 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -1056,7 +1056,7 @@ const struct regmap_config adau1372_regmap_config = {
 	.reg_defaults = adau1372_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(adau1372_reg_defaults),
 	.volatile_reg = adau1372_volatile_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_GPL(adau1372_regmap_config);
 

-- 
2.39.2

