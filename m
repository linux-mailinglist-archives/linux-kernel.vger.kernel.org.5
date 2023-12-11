Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618980CAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjLKN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbjLKNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B5E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:25:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5879BC433CA;
        Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702301145;
        bh=CR4WEiVLSbI2eaXlZ+1qwly9qiLQTKtm9P5IJp8GAYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdrWVEgwfxDc3wu20xBwcrinYaKy9S/4VKOe2QcSwApLUdLd98hme+dafUfnIfslC
         VFr1/X/On6ADNdadg3HQG8Ax2xuuvxNT/v+BxdjKJ3PpC5icWCBW6pi1Ikt0N1xasX
         QfFluSUWQuyWw8FnN3K2H8hR/KQcbswmsVnSuHwMMDzeSF4zQew0e/Xt3fVj/KSI21
         y5y2UN6d8W4EpJM1HsnUl9J/6mppJ62SjUYm+zftSjaCYoilQBDmmSx3TiToYW2520
         Ok1fnf7nOvLnsPhR0dT4Z7hMU7KgPWAavD97ZovBr6TYAGYJqrkFTSM2gkq5RVTGR3
         zIpKvPf2igNsg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rCgIq-0007Fh-0m;
        Mon, 11 Dec 2023 14:26:32 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 1/2] ASoC: ops: add correct range check for limiting volume
Date:   Mon, 11 Dec 2023 14:26:07 +0100
Message-ID: <20231211132608.27861-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
MIME-Version: 1.0
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

commit fb9ad24485087e0f00d84bee7a5914640b2b9024 upstream.

Volume can have ranges that start with negative values, ex: -84dB to
+40dB. Apply correct range check in snd_soc_limit_volume before setting
the platform_max. Without this patch, for example setting a 0dB limit on
a volume range of -84dB to +40dB would fail.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 55b009d3c681..2d25748ca706 100644
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
2.41.0

