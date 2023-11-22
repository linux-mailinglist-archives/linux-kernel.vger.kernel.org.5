Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC7E7F4112
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKVJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbjKVJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBFD50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCC88C32774;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=FZx44+jtSgkFrLx8Od2iJYTAx8dRg8yyesFO858Q/JM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=EceBTOKnoEala0KiK/B3D33/naxFy/Q3W85xKU8TLRGJOo5ZknpuhJZWPI3NtaI24
         a4RosymgBI8hMGVRB4JB1rArnUtH8oJyM+eb4IoTeOoGhcTO6Vl3aUaVdTXdaYl6aO
         GJYzRT1DsINtR7KdZPf595C3PVtDXN+KTaq9nPBtjhbH4wAPrBBqtJkq6owPBbG3H7
         FLm/u4LZUUDzXU1QXUwp8mpMWicja3gDQAwxeDD91KxLjpqhJKLpa15wsNEJVxyqJr
         Be/USRuK9xzJMzLSUybDz73WFY1A+TRk8JZfg1BNc/dpWlmq70IKkrJ9YcdE/wr53n
         8fHgP1Et1b1jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C7567C61DA4;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 12:00:07 +0300
Subject: [PATCH v5 29/39] ASoC: ep93xx: Drop legacy DMA support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-29-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=2943;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=eaYYyY3EU5yH1thYJtH1GzVJh461lTsRZ3Y4qNieDjc=; =?utf-8?q?b=3DZdBgRlhTyelO?=
 =?utf-8?q?QHGAyiLn1nJde+7EKrWy6cF7QOa00NtJrrM50UXJen5ybVDUT8g9g3i5iE2KF80X?=
 6jGhXpQaAZZzeObQyeBf19tvQwi0MqhGLmMhaIIumyDr17wk6Hs8
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

And rely on OF DMA.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 19 -------------------
 sound/soc/cirrus/ep93xx-pcm.c | 19 +------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 522de4b80293..9e83cdf8a943 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -24,7 +24,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
 #include "ep93xx-pcm.h"
@@ -80,19 +79,6 @@ struct ep93xx_i2s_info {
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
 
-static struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
-	[SNDRV_PCM_STREAM_PLAYBACK] = {
-		.name		= "i2s-pcm-out",
-		.port		= EP93XX_DMA_I2S1,
-		.direction	= DMA_MEM_TO_DEV,
-	},
-	[SNDRV_PCM_STREAM_CAPTURE] = {
-		.name		= "i2s-pcm-in",
-		.port		= EP93XX_DMA_I2S1,
-		.direction	= DMA_DEV_TO_MEM,
-	},
-};
-
 static inline void ep93xx_i2s_write_reg(struct ep93xx_i2s_info *info,
 					unsigned reg, unsigned val)
 {
@@ -198,11 +184,6 @@ static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
-	info->dma_params_tx.filter_data =
-		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-	info->dma_params_rx.filter_data =
-		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
-
 	snd_soc_dai_init_dma_data(dai,	&info->dma_params_tx,
 					&info->dma_params_rx);
 
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index fa72acd8d334..5ecb4671cbba 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -18,8 +18,6 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
-
 #include "ep93xx-pcm.h"
 
 static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
@@ -35,30 +33,15 @@ static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 	.fifo_size		= 32,
 };
 
-static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
-{
-	struct ep93xx_dma_data *data = filter_param;
-
-	if (data->direction == ep93xx_dma_chan_direction(chan)) {
-		chan->private = data;
-		return true;
-	}
-
-	return false;
-}
-
 static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
 	.pcm_hardware = &ep93xx_pcm_hardware,
-	.compat_filter_fn = ep93xx_pcm_dma_filter,
 	.prealloc_buffer_size = 131072,
 };
 
 int devm_ep93xx_pcm_platform_register(struct device *dev)
 {
 	return devm_snd_dmaengine_pcm_register(dev,
-		&ep93xx_dmaengine_pcm_config,
-		SND_DMAENGINE_PCM_FLAG_NO_DT |
-		SND_DMAENGINE_PCM_FLAG_COMPAT);
+		&ep93xx_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL_GPL(devm_ep93xx_pcm_platform_register);
 

-- 
2.41.0

