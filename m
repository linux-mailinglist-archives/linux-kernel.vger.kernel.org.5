Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3007EBC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjKODmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjKODlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:41:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFA1739;
        Tue, 14 Nov 2023 19:41:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D8C433C7;
        Wed, 15 Nov 2023 03:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019692;
        bh=lUsKXMEcfKyCwHNl9JB9mjhgJC/xXUEW6YNokU9FJ3I=;
        h=From:To:Cc:Subject:Date:From;
        b=babj6alPRAXnGTw/RKFrWb8+ZXdq8Qu43HKtnHLQcf+EuFFo6agDGFu/++u03pj9U
         C3G9QfLgRz31K2NkCPIsKKfHeLU3wSlT3tH9Igwa4XI2XydShq07Kp06GK5lZWZAMb
         ZQxzwwyhTAyherpcZ2RL3KTp9emYNTml1OnMD72el5ZALbUjy2I0+Vr4itN6AFxO4S
         t8aEyUtRq+8jgC+x40NPfy4s/u39bg17l6/GNXPZwGqyT4jXAqbDqqgqoYxUdYJR1+
         O02SPWLokFmbhNyd0b9u4crW2+O8w9wk3WvL4085jKwJzCWaawGByYMYKpV8YRrahl
         EJdY7GlNfst/A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peter.ujfalusi@gmail.com,
        jarkko.nikula@bitmer.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/3] ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings
Date:   Tue, 14 Nov 2023 22:41:12 -0500
Message-ID: <20231115034123.1239405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.200
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit fbb74e56378d8306f214658e3d525a8b3f000c5a ]

We need to check for an active device as otherwise we get warnings
for some mcbsp instances for "Runtime PM usage count underflow!".

Reported-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20231030052340.13415-1-tony@atomide.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/omap-mcbsp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 6025b30bbe77e..9a88992ac5f33 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -74,14 +74,16 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	pm_runtime_put_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_put_sync(mcbsp->dev);
 
 	r = clk_set_parent(mcbsp->fclk, fck_src);
 	if (r)
 		dev_err(mcbsp->dev, "CLKS: could not clk_set_parent() to %s\n",
 			src);
 
-	pm_runtime_get_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_get_sync(mcbsp->dev);
 
 	clk_put(fck_src);
 
-- 
2.42.0

