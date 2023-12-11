Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0A80CB93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjLKNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbjLKNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199B1995
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2193DC433C8;
        Mon, 11 Dec 2023 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302752;
        bh=L/m0usjSFyvIqmBIXS7qRmIZGNCj7oEsBBqzks8O54w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM2c+Xaz/hdQiUkmmnAiI3Lq3i7e9lka8Dj2dg91IslTpKr3Uq+leavTz5GJgunHD
         HdiJWBljnx5JOB3j7MJnRihzcbY1Bsv8zAuIFk4ADXLq2jF3UDS9a3byHWRbjUOg/v
         kQwlNeKUQRXpqZkXjK3nP8RGoHpekwLwRj8AeFjH1IlTSuPUG47oZDw+vX6DyL0LSz
         +HrIaEGxnq33D48f+O9HV7OgoVq23XpIAkmHF1uRtFXuuolG/lh1q5oEKn+s6fKksH
         Oj+eYPcZBdf1JE8O58RP0PoQlnmrPQgKiEi3Sdv1L1VAVTCvhJazmard06qVzHy4Vp
         CZ6Zjf7+3OKAA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/47] ASoC: fsl_xcvr: refine the requested phy clock frequency
Date:   Mon, 11 Dec 2023 08:50:16 -0500
Message-ID: <20231211135147.380223-15-sashal@kernel.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 347ecf29a68cc8958fbcbd26ef410d07fe9d82f4 ]

As the input phy clock frequency will divided by 2 by default
on i.MX8MP with the implementation of clk-imx8mp-audiomix driver,
So the requested frequency need to be updated.

The relation of phy clock is:
    sai_pll_ref_sel
       sai_pll
          sai_pll_bypass
             sai_pll_out
                sai_pll_out_div2
                   earc_phy_cg

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://lore.kernel.org/r/1700702093-8008-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 77f8e2394bf93..f0fb33d719c25 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -358,7 +358,7 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 	struct device *dev = &xcvr->pdev->dev;
 	int ret;
 
-	freq = xcvr->soc_data->spdif_only ? freq / 10 : freq;
+	freq = xcvr->soc_data->spdif_only ? freq / 5 : freq;
 	clk_disable_unprepare(xcvr->phy_clk);
 	ret = clk_set_rate(xcvr->phy_clk, freq);
 	if (ret < 0) {
@@ -409,7 +409,7 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 m_ctl = 0, v_ctl = 0;
 	u32 r = substream->runtime->rate, ch = substream->runtime->channels;
-	u32 fout = 32 * r * ch * 10 * 2;
+	u32 fout = 32 * r * ch * 10;
 	int ret = 0;
 
 	switch (xcvr->mode) {
-- 
2.42.0

