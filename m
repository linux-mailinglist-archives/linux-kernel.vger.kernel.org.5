Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E27909A7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjIBVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjIBVGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:06:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE2E58
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:35 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FD4866072B6;
        Sat,  2 Sep 2023 22:06:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688794;
        bh=EIKQVEzIvsfCigiMKXYRAU8bDJtcz9v1w1No9Z6EJII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIg6hIb6YJvChqOHLmgZRHM6t+6lgXW0nWc5+QFgmoDU98F4hY6vU6CTDDydq9ZR9
         x09pVplTOecbN5bkQUF57p8OZY/NmIWHE4i3/4UJQLKv+a6+H/axVo5BwqpGS4bMv0
         YZKpzWOTm5iQq6+HqE+fi8lIWw2jyof60EaqH93IhBCLjXHyrX5LxMFQsCdX3+gRn1
         IU5/l+UqsuSx9RImlyX0LJgPDBDbsCxhSJuPx4yEEmmHOusLWEBOPIavgT6/CIEHnX
         ODRnV/FgbYoTeh8CtjujAcETFiWnQQxtsM7qDnY3L9iEAMwghBi9Vsri/GRhtp4KIm
         UCG6/HY2kdq1w==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 3/9] ASoC: cs35l41: Initialize completion object before requesting IRQ
Date:   Sun,  3 Sep 2023 00:06:15 +0300
Message-ID: <20230902210621.1184693-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technically, an interrupt handler can be called before probe() finishes
its execution, hence ensure the pll_lock completion object is always
initialized before being accessed in cs35l41_irq().

Fixes: f5030564938b ("ALSA: cs35l41: Add shared boost feature")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 722b69a6de26..fe5376b3e01b 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1273,6 +1273,8 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 		regmap_update_bits(cs35l41->regmap, CS35L41_IRQ1_MASK3, CS35L41_INT3_PLL_LOCK_MASK,
 				   0 << CS35L41_INT3_PLL_LOCK_SHIFT);
 
+	init_completion(&cs35l41->pll_lock);
+
 	ret = devm_request_threaded_irq(cs35l41->dev, cs35l41->irq, NULL, cs35l41_irq,
 					IRQF_ONESHOT | IRQF_SHARED | irq_pol,
 					"cs35l41", cs35l41);
@@ -1295,8 +1297,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	if (ret < 0)
 		goto err;
 
-	init_completion(&cs35l41->pll_lock);
-
 	pm_runtime_set_autosuspend_delay(cs35l41->dev, 3000);
 	pm_runtime_use_autosuspend(cs35l41->dev);
 	pm_runtime_mark_last_busy(cs35l41->dev);
-- 
2.41.0

