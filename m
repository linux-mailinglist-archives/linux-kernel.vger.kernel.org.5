Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3275144A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjGLXPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjGLXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F92693
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2E7861991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B209BC433CA;
        Wed, 12 Jul 2023 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203658;
        bh=ZyuiWzGM9QePvtgOw/zkkwTBfsCaKneK7VJV37MCYHg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=U/hJm4vmH6x6R213PvNvlm1FI6AKH8VhqjVRn0o9SitLpFuV/rLS+ZDTFTArLAmSl
         3z6v4ajrh3sPIa2LekFrjsc+mkMGjIbVSptjKpdGg2Z/i9Gowhi/JNJWxXo3Ylys6R
         o3Cqz9/Gicj2q8Uzg4yT5Q6iFqgHiCWRS4z04qVk2Pf7s4Mg0f6zRToTTKzonBJOIS
         gC7fxhYzhOLHsxb95dcqB4y8tBpZxagiqnE3tH+zk0H6zkP+dAqi/Bo7gPs8pyxhRl
         BO2KXPL1mFe4fRoNOHdsY32OXSAJBEW3FIC+eD2XY7xt6RKhklNKGAFgFnzlMfQ3yt
         T8xhB8GXRdnhw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 00:13:54 +0100
Subject: [PATCH 05/10] ASoC: adau1701: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-asoc-ad-maple-v1-5-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZyuiWzGM9QePvtgOw/zkkwTBfsCaKneK7VJV37MCYHg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzO3/uZY5QNBmGcSn4rf2mODTsNtqLX6JrRrs
 XpWfRfmB0SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8ztwAKCRAk1otyXVSH
 0PteB/4gampxLjwqYH3skRZTqilbrZu9SlPoLfZrJvrSvoOcgBXT/I1vrB0Pva3LEcjBluSTdS+
 HIbOnbrJ/w8ecu2gssUQ1Yyiw1OKgcQfh7m3kt0+FRe792/K3KGO7jwLi1cnbA7BJYIf2kz1WNL
 Jq9p1Qv3mw8XmMMWwaWhY60AXGa/QtdgA/F4VgUdbTLU/S2wVHVbyhH0ViSxy4dzg4oxCKYa4zT
 OmWXDjHM8tlHlP62XMoWFyRmkQbWm1VLf+hcbjcM79hU/r8uMPMT9rxMDaXXIb23ZwExiLw17EG
 xrZfo3TlyqaApEnSJnS1DPy3+PRVPAIiAnu6uIIX3CGcpYzP
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

Update the adau1701 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 8c8de3b3c901..94831aad7ac6 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -778,7 +778,7 @@ static const struct regmap_config adau1701_regmap = {
 	.reg_bits		= 16,
 	.val_bits		= 32,
 	.max_register		= ADAU1701_MAX_REGISTER,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 	.volatile_reg		= adau1701_volatile_reg,
 	.reg_write		= adau1701_reg_write,
 	.reg_read		= adau1701_reg_read,

-- 
2.39.2

