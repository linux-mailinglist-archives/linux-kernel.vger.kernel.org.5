Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C680CB65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjLKNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbjLKNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:51:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31410A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46530C433C8;
        Mon, 11 Dec 2023 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302719;
        bh=6dcB/Rn+AWHAhmwauQweLpvFGwp8tOOg34+0KfnM2Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RirT3b2evvDk0Lcg0zXdG+mw/vRRmh9niAL2P27QALChEUrm5h2DzZ5XuxMcXIFNR
         OuCXG8g+IgJom3OGUT1OhALXdZq/pKEqNyW2Vrin2kGJ+2ckRt98zIv9tXQiVfyGtv
         KZ6vY2xum+NGnYTC/nBeK+eOzkTgSwx03lCSGU1np+xywFV3p8agodzcTISMS8rQfX
         a42zUYadeSIGPnMo4QbAEfTxFKfcMFhZyKDIguT1BalLZ3Hrl4eF3QXW6iHhZIh/Jr
         p+O8vS5GEyvt/mKyY1eO239sckKSVKjeQhF8snwhJ+4cfZXASqh6V+Cl4MteqRwCsT
         1X9EbEdgwcLPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/47] ASoC: wm8974: Correct boost mixer inputs
Date:   Mon, 11 Dec 2023 08:50:05 -0500
Message-ID: <20231211135147.380223-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 37e6fd0cebf0b9f71afb38fd95b10408799d1f0b ]

Bit 6 of INPPGA (INPPGAMUTE) does not control the Aux path, it controls
the input PGA path, as can been seen from Figure 8 Input Boost Stage in
the datasheet. Update the naming of things in the driver to match this
and update the routing to also reflect this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231113155916.1741027-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8974.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 044b6f604c090..260bac695b20a 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -186,7 +186,7 @@ SOC_DAPM_SINGLE("PCM Playback Switch", WM8974_MONOMIX, 0, 1, 0),
 
 /* Boost mixer */
 static const struct snd_kcontrol_new wm8974_boost_mixer[] = {
-SOC_DAPM_SINGLE("Aux Switch", WM8974_INPPGA, 6, 1, 1),
+SOC_DAPM_SINGLE("PGA Switch", WM8974_INPPGA, 6, 1, 1),
 };
 
 /* Input PGA */
@@ -246,8 +246,8 @@ static const struct snd_soc_dapm_route wm8974_dapm_routes[] = {
 
 	/* Boost Mixer */
 	{"ADC", NULL, "Boost Mixer"},
-	{"Boost Mixer", "Aux Switch", "Aux Input"},
-	{"Boost Mixer", NULL, "Input PGA"},
+	{"Boost Mixer", NULL, "Aux Input"},
+	{"Boost Mixer", "PGA Switch", "Input PGA"},
 	{"Boost Mixer", NULL, "MICP"},
 
 	/* Input PGA */
-- 
2.42.0

