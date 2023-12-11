Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0412780CC09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjLKN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjLKNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:54:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65302D47
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED32C433CA;
        Mon, 11 Dec 2023 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302795;
        bh=ehZFxJjugDtw5zznhofREfYOsDmMXS72v8JFNEqkE8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQI7kGcSshJjxVK3LA28UBPJxb+8o9IjbBj+JZcKhDLml0Y0XxQO6CEJ0BCDRz6qS
         1oAiKH/2az+s5WBZSWq54sdtvTaRQyrghxfMju08KHity/gMg3ZMo/Xk6ji6e4rbNR
         vlxHX+HO2Q5VSeRkvWm2D4zSQMJ8n7ucetuzOKQSW29Wzpr7dDmRjkhUqJY8dHuLLU
         UKlYTw6qUYjgJhBUjklxwdx2QZGu2+Dr2BxuiTqXhkmjjpgY1XL8xHTa60YzTPITFs
         fUnsH0My1HmCsGyf2cG+p2ayTaOInQAi4G7fPNMBFKkWCSOHEzcpYKEDnSxOT+qVqO
         PPVyPosf29eRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 29/47] ASoC: ops: add correct range check for limiting volume
Date:   Mon, 11 Dec 2023 08:50:30 -0500
Message-ID: <20231211135147.380223-29-sashal@kernel.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit fb9ad24485087e0f00d84bee7a5914640b2b9024 ]

Volume can have ranges that start with negative values, ex: -84dB to
+40dB. Apply correct range check in snd_soc_limit_volume before setting
the platform_max. Without this patch, for example setting a 0dB limit on
a volume range of -84dB to +40dB would fail.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 55b009d3c6815..2d25748ca7066 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -661,7 +661,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 	kctl = snd_soc_card_get_kcontrol(card, name);
 	if (kctl) {
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-		if (max <= mc->max) {
+		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
 			ret = 0;
 		}
-- 
2.42.0

