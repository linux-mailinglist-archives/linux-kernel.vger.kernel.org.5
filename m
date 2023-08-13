Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5477A993
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjHMQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjHMQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474533A82;
        Sun, 13 Aug 2023 09:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A5363BBB;
        Sun, 13 Aug 2023 16:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA9CC433C7;
        Sun, 13 Aug 2023 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943184;
        bh=7EfpjV6UkQb8GEClCzJ7rPtqBaocAGoLvvZIn10Dp2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/cNy+bqaWa+nMLSt36egv4eqTrBypb8gJmwQGnMvkfbcau2uMwQzeczMMgmOPcCl
         idESWwToDo/Io+5rafgUDHr3/v0b4zh7oT1/vQLZmKHkIH61Xr/4QE3qj+I2mFmcY2
         3ALm6kZLkQJf1pmcmUdlNZ8I5kFVNCNTEbU0m5C2HiFvsldRfFIlVhlYlyOeL+z4Lp
         7A+zYELgxEBC5OABMPSPZd0UQxuAJx7KPpKevKIpL3TKWClFvpXoDWIvLjeTGEeESX
         nln6G9af906NDSr+eScTxUwTWQd4nI/skjq44ikLvpy164I1wH0YNHeD3WvdOLw8B7
         PkVPE7mJHskkQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guiting Shen <aarongt.shen@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, claudiu.beznea@tuxon.dev,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 11/14] ASoC: atmel: Fix the 8K sample parameter in I2SC master
Date:   Sun, 13 Aug 2023 12:11:59 -0400
Message-Id: <20230813161202.1086004-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161202.1086004-1-sashal@kernel.org>
References: <20230813161202.1086004-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.253
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guiting Shen <aarongt.shen@gmail.com>

[ Upstream commit f85739c0b2b0d98a32f5ca4fcc5501d2b76df4f6 ]

The 8K sample parameter of 12.288Mhz main system bus clock doesn't work
because the I2SC_MR.IMCKDIV must not be 0 according to the sama5d2
series datasheet(I2SC Mode Register of Register Summary).

So use the 6.144Mhz instead of 12.288Mhz to support 8K sample.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
Link: https://lore.kernel.org/r/20230715030620.62328-1-aarongt.shen@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/atmel-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index d870f56c44cfc..0341b31197670 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -163,11 +163,14 @@ struct atmel_i2s_gck_param {
 
 #define I2S_MCK_12M288		12288000UL
 #define I2S_MCK_11M2896		11289600UL
+#define I2S_MCK_6M144		6144000UL
 
 /* mck = (32 * (imckfs+1) / (imckdiv+1)) * fs */
 static const struct atmel_i2s_gck_param gck_params[] = {
+	/* mck = 6.144Mhz */
+	{  8000, I2S_MCK_6M144,  1, 47},	/* mck =  768 fs */
+
 	/* mck = 12.288MHz */
-	{  8000, I2S_MCK_12M288, 0, 47},	/* mck = 1536 fs */
 	{ 16000, I2S_MCK_12M288, 1, 47},	/* mck =  768 fs */
 	{ 24000, I2S_MCK_12M288, 3, 63},	/* mck =  512 fs */
 	{ 32000, I2S_MCK_12M288, 3, 47},	/* mck =  384 fs */
-- 
2.40.1

