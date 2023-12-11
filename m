Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E380CB72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbjLKNwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbjLKNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96417FE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA59C433C8;
        Mon, 11 Dec 2023 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302735;
        bh=Y14sf/IUPwBLYu+5nkTsbDeUTC00rHFDrEquURAriTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUDRA2e4Ls4r9wFERkzIj8SUD8ojJDIJn0M1YIY7/ge3BtoEDCQcG8ojlCWvI1ppF
         l7jMeAqJKLLTblQWlC/j7gh5WeRvs7cc9cZIqmxsu1vrUuJ80s5ZKV0pGa0sr3AvUt
         FJJz4LQNjW3W8qj9qCIlyfmQKUXEaSCyHE01EgjIne8r98X8Tuh95qBeNmLISt03Jz
         XsZaXOkhFg8Cy+/vVoXF5bC1kOEXiMxLtuaoS6bIgt6aNc61LI6zycvoUjEVRitvNJ
         Qo0yLrArmtXyoOaYhr5vMlK3tBGNyeEd4QHPXHngWC+Luat5OdtcpZwv2jMwATLT6O
         qA+AUBAlIOoHg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kamil Duljas <kamil.duljas@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/47] ASoC: SOF: topology: Fix mem leak in sof_dai_load()
Date:   Mon, 11 Dec 2023 08:50:09 -0500
Message-ID: <20231211135147.380223-8-sashal@kernel.org>
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

From: Kamil Duljas <kamil.duljas@gmail.com>

[ Upstream commit 31e721fbd194d5723722eaa21df1d14cee7e12b5 ]

The function has multiple return points at which it is not released
previously allocated memory.

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20231116213926.2034-2-kamil.duljas@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index a3a3af252259d..37ec671a2d766 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1736,8 +1736,10 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	/* perform pcm set op */
 	if (ipc_pcm_ops && ipc_pcm_ops->pcm_setup) {
 		ret = ipc_pcm_ops->pcm_setup(sdev, spcm);
-		if (ret < 0)
+		if (ret < 0) {
+			kfree(spcm);
 			return ret;
+		}
 	}
 
 	dai_drv->dobj.private = spcm;
-- 
2.42.0

