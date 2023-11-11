Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB147E8BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKKRhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKKRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:37:49 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4903A81
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:37:44 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 1rvQrNcO1Fh5i1rvRrEGB4; Sat, 11 Nov 2023 18:37:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699724262;
        bh=3p8y78zf3gHeF4GPQWXy2DVL3f5hRqnTpp31RIibFuo=;
        h=From:To:Cc:Subject:Date;
        b=Fxc8kV+G8Enn/8tu+igh6v6COk98EiwnJVmlpbcFYaZIrcxRrvynh6DZ/M/TkI5WN
         3A7a+d14YAeGc7xAs2uR0D3HAM08xyed7ofWB6IIwvfauN0t2+IOUaKnT1mNwan4KN
         HWXcmQ16uuwE3JsnQsbusDOocXQnvPED21hOTzCbu0Cm2atUzIRyM1uGjYzKUn93CS
         9qbqJlemRNitnBTl+4CdDIRa+qP2P8XS968v7AlMsd3TwDYg867MdakUj9Gjr8TQVS
         dih9KCXCwL4tovkOHhzUAnMQaAe5W5AEZJyiP3VXCavv7Awy7ePhx5WBiugdJE8dCG
         HFzH7Q3UnW4Og==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Nov 2023 18:37:42 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] ASoC: tegra: convert not to use dma_request_slave_channel()
Date:   Sat, 11 Nov 2023 18:37:39 +0100
Message-Id: <b78685e4103f12931ddb09c1654bc6b04b640868.1699724240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is deprecated. dma_request_chan() should
be used directly instead.

Switch to the preferred function and update the error handling accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/tegra/tegra_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 142e8d4eefd5..42acb56543db 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -98,8 +98,8 @@ int tegra_pcm_open(struct snd_soc_component *component,
 		return ret;
 	}
 
-	chan = dma_request_slave_channel(cpu_dai->dev, dmap->chan_name);
-	if (!chan) {
+	chan = dma_request_chan(cpu_dai->dev, dmap->chan_name);
+	if (IS_ERR(chan)) {
 		dev_err(cpu_dai->dev,
 			"dmaengine request slave channel failed! (%s)\n",
 			dmap->chan_name);
-- 
2.34.1

