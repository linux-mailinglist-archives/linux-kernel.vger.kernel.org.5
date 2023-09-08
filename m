Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E63798FEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbjIHTfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbjIHTfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:35:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406410FC;
        Fri,  8 Sep 2023 12:34:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D38C433BF;
        Fri,  8 Sep 2023 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201688;
        bh=LsNGYyxSOf55GU0VS8hQG7NBZCorbOMYgTI/lqWeqOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0jyKb2yKOw1ugHzYs6HvM+5CLotFNX03xXhAXHO0hN0os3JkPudtwmLO6xxvAix3
         7RGcOD/t2owWVTy7kFU8S6gq1QfadJ+v7wdcEb5cbwXl3Pg+NJrMlU2iy5sh0uUJ01
         nGnj49859Zo89TkCcY37dali5iOiGfmmufNkjkdp1VRGfe+8VDUrXfhLwA8/b2dVOH
         df2dIdZVG93EIEVbBaBGIH/InV4A66Tud9QhYozV6W5Ok1iwjM/6VJloLLSNGvAASJ
         bEOf5w9Fy5dj8gMx1vzUMttJ3K7QZj1yzrwnk3dEvFYTLDxWVg/gx0IwfYd7z2Gauf
         7nbpE3U4agFhw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Yaochun Hung <yc.hung@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/22] ASoC: SOF: topology: simplify code to prevent static analysis warnings
Date:   Fri,  8 Sep 2023 15:33:55 -0400
Message-Id: <20230908193407.3463368-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193407.3463368-1-sashal@kernel.org>
References: <20230908193407.3463368-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 55cb3dc271d81f1982c949a2ac483a6daf613b92 ]

make KCFLAGS='-fanalyzer' sound/soc/sof/intel/ reports a possible NULL
pointer dereference.

sound/soc/sof/topology.c:1136:21: error: dereference of NULL ‘w’
[CWE-476] [-Werror=analyzer-null-dereference]

 1136 |     strcmp(w->sname, rtd->dai_link->stream_name))

The code is rather confusing and can be simplified to make static
analysis happy. No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
Link: https://lore.kernel.org/r/20230731213748.440285-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 872e44408298f..e7305ce57ea1f 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1086,16 +1086,17 @@ static void sof_disconnect_dai_widget(struct snd_soc_component *scomp,
 {
 	struct snd_soc_card *card = scomp->card;
 	struct snd_soc_pcm_runtime *rtd;
+	const char *sname = w->sname;
 	struct snd_soc_dai *cpu_dai;
 	int i;
 
-	if (!w->sname)
+	if (!sname)
 		return;
 
 	list_for_each_entry(rtd, &card->rtd_list, list) {
 		/* does stream match DAI link ? */
 		if (!rtd->dai_link->stream_name ||
-		    strcmp(w->sname, rtd->dai_link->stream_name))
+		    strcmp(sname, rtd->dai_link->stream_name))
 			continue;
 
 		switch (w->id) {
-- 
2.40.1

