Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228D7DB07A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjJ2XHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjJ2XGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:06:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D56598;
        Sun, 29 Oct 2023 16:01:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA99C04E60;
        Sun, 29 Oct 2023 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620382;
        bh=6f08pzcovKZTGn6aZpAyBL6OCiu5ckqlVg/z8CmfMJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOqNcB2NT7bT/xJuXk0bLC+40vwQ0WkfGFlpMX8dZHXai9xb+yG/qKsHWfyFVa/ph
         DzsFU0ujvMUxxBZMeGEUo6FzQ51/ZYZKlioMjg0PET4GwjF4Ux9pJD+FcpXA4uzCXS
         X4lp3xQUSDXVqCd+mrYJrSpFTyf9HWQvWnZrRGgsi0QxD4iXFRvj9MaBj1aYb9otz8
         QVeyawCTl419U6MR7NTSZ87jXPrZ+XCj1sFYRRq4JOi0SvN6GEINu32uyVJ0prIoMx
         MLVf8sBLuIXzcVUvju/sCTlZARTn11SVJ/d57mB42AygBdfffYKOrgYjeXJnB84At5
         gZiTxvWtUI0Lw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 18/28] ASoC: rt5650: fix the wrong result of key button
Date:   Sun, 29 Oct 2023 18:58:53 -0400
Message-ID: <20231029225916.791798-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit f88dfbf333b3661faff996bb03af2024d907b76a ]

The RT5650 should enable a power setting for button detection to avoid the wrong result.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20231013094525.715518-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8ea6d43335626..385f2cca939a0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3251,6 +3251,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
-- 
2.42.0

