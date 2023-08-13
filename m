Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F277A7F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjHMPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjHMPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD1E2121;
        Sun, 13 Aug 2023 08:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1292B6308C;
        Sun, 13 Aug 2023 15:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55AEC433C8;
        Sun, 13 Aug 2023 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941883;
        bh=CZ1VOSmecvmJzeT4sK3xTUGATLMgP7JW4yUzJyHes6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8882IR9FHXlyYiPqTLpYwSO4yZpvCEbGFVJx26WjKaKr2hHsSzxVPbT+7Fxu/jRW
         sWxwnLWzNNRcMYBXl0WMwF7oJnJ34pldkZk6PiHqrXSSYgeDZrzrWSePB2Hvav7LiT
         1BJNW44ceozIERZEe2Wl7oLBH3iP/C9T5bi/EzurH9j1joPeh99ZdWikAemzgUwUBG
         Vu5b3Y2fFxpE4XZyhASrOaQ0En/fqe1iMzYS2gdbG5x2YzF36lygz54j+7FxD/tuCY
         1p9oagYPSAjXc3EBvxgRIuajX3Px4GcLqDuBlwHbuREj99wzlBuSg86Iqo/Lgmp5LI
         LqhTpyaAORkxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guiting Shen <aarongt.shen@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, claudiu.beznea@tuxon.dev,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 33/54] ASoC: atmel: Fix the 8K sample parameter in I2SC master
Date:   Sun, 13 Aug 2023 11:49:12 -0400
Message-Id: <20230813154934.1067569-33-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 49930baf5e4d6..69a88dc651652 100644
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

