Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB27DB0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjJ2XYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjJ2XY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:24:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96710269E5;
        Sun, 29 Oct 2023 16:09:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B666FC4AF72;
        Sun, 29 Oct 2023 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620428;
        bh=TI437Uz5doT3OcNnkFPQnloGOW4OkSIhicfYxan8jO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJE3mS5oUX/M1ccZw6kDUQAwets+SGrBBnu9zhVq0xdUYysG4cfHspL7Mc25luZ0E
         trcqiGOPbp7UAL7kh0QRVU8qDw5p3zn4LZ7Nq2JpcaWDK21w+rWZ9p3QJBW6viio/1
         lFQIR7rCc35lwhiO5oB7+xlZDpU+w0aLTFmuAwxiBmyPnyjqvfF9jRmxHhJvynnXue
         0AwXxu5PkMdms+KVfKALXLGrHw9FI1dHhvil31lED5h6iUrf/JHFoCdhlButMDhN1h
         LQ5Qm8EoHkJD79G9/eS6gnIU9TXWAGoONUgZT842YaBe3wGqA279z2bvqKQzhtuJkY
         UO6Ah8Nqo8eCA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 08/16] ASoC: rt5650: fix the wrong result of key button
Date:   Sun, 29 Oct 2023 18:59:54 -0400
Message-ID: <20231029230014.792490-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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
index d1533e95a74f6..99d91bfb88122 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3241,6 +3241,8 @@ int rt5645_set_jack_detect(struct snd_soc_component *component,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 	}
 	rt5645_irq(0, rt5645);
 
-- 
2.42.0

