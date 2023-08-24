Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26824787A07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjHXVNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbjHXVM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:12:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B21BCC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:12:49 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDB496607281;
        Thu, 24 Aug 2023 22:12:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692911568;
        bh=ZEk4vxttkiExCnA+WQA0eWrX8wJNdUD6swJb0CzA9Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzQyrE6j+7k2SQ4rJqt4CtrpRT0K7+LW9s+ZtLgre9uJKLDisAz/d59ApKK9SnQk2
         75zBJv7S5knRqC5zuM19nchhsY8HS9nXTu5cdOdvTEt12w9FO7q5BDAhOmmRmjLc8S
         iqQWfCAEF6yT6SyAKuyN4A9z/beQUWvX/LTNcvYgqUAEG8MMq6TmG0inDEeyod1V0/
         SnWM7ww97PyOyRr1knTgYRXguPIyIhiM5rl7glnUMBDLZSCXgkjs/+LAS94ywDR3cT
         nS45Bz8CRx+5tnK3654jvweplaEjZY+VQmZ72kHO2A20cUHw/ufwxoIOuBqtLJ8FF8
         owJMK+HYXAZ0A==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 1/2] ASoC: core: Do not error if a DAI link component is not found
Date:   Fri, 25 Aug 2023 00:12:40 +0300
Message-ID: <20230824211241.388201-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
References: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
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

A recent cleanup of soc_dai_link_sanity_check() is responsible for
generating lots of confusing errors before returning -EPROBE_DEFER:

  acp5x_mach acp5x_mach.0: ASoC: Component acp5x_i2s_dma.0 not found for link acp5x-8821-play
  [...]
  acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:00 not found for link acp5x-CS35L41-Stereo
  [...]
  acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:01 not found for link acp5x-CS35L41-Stereo

Switch back to the initial behaviour of logging those messages on
KERN_DEBUG level instead of KERN_ERR.

Fixes: 0e66a2c69409 ("ASoC: soc-core.c: cleanup soc_dai_link_sanity_check()")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5b96c17633a..75a9641349ee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1003,7 +1003,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 	return -EINVAL;
 
 component_not_find:
-	dev_err(card->dev, "ASoC: Component %s not found for link %s\n", dlc->name, link->name);
+	dev_dbg(card->dev, "ASoC: Component %s not found for link %s\n", dlc->name, link->name);
 	return -EPROBE_DEFER;
 
 dai_empty:
-- 
2.41.0

