Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1280CB81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbjLKNwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbjLKNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFBAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C21C433C7;
        Mon, 11 Dec 2023 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302744;
        bh=B/U5W9npea2EkzEYQL8tfRUKdcmXLdor/S2UDsVoyR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ho+7+k85nLQyj9pznnMr9mQ1U5Ir0QqFxjBXCVLpDZvvp9L0jqr4eB6dopFa7jSYd
         4QaCTiFl/ZEC5WZ4pf9LIBhMGXlaT//rb0SjyrZ0pJJGCShUfNkSOPqiq5wbGEET9K
         xWQf9wN3w0l7h6XME5L96Lt53V452Wyg5i4BPqWD0yZaMDHbZ43dBEdYROvC6fMYk9
         gsR5sCFzZM5jycl9QNTUgPyVC7kDhaAehVZCY1F5P26an9dIw1BLBeTiGGk5v1TDCt
         pGeFLaLSFdF86T6tV1/H8tFAvQ+SJ9KSyimj9OcNp7XcmL6zveaFj8bB7wDRIaLMt5
         9saGaJckwGDow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/47] ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case
Date:   Mon, 11 Dec 2023 08:50:13 -0500
Message-ID: <20231211135147.380223-12-sashal@kernel.org>
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

[ Upstream commit c33fd110424dfcb544cf55a1b312f43fe1918235 ]

The bit 10 in TX_DPTH_CTRL register controls the TX clock rate.
If this bit is set, TX datapath clock should be = 2* TX bit rate.
If this bit is not set, TX datapath clock should be 10* TX bit rate.

As the spdif only case, we always use 2 * TX bit clock, so
this bit need to be set.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1700617373-6472-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index fa0a15263c66d..77f8e2394bf93 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -414,6 +414,16 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream *substream,
 
 	switch (xcvr->mode) {
 	case FSL_XCVR_MODE_SPDIF:
+		if (xcvr->soc_data->spdif_only && tx) {
+			ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_TX_DPTH_CTRL_SET,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM);
+			if (ret < 0) {
+				dev_err(dai->dev, "Failed to set bypass fem: %d\n", ret);
+				return ret;
+			}
+		}
+		fallthrough;
 	case FSL_XCVR_MODE_ARC:
 		if (tx) {
 			ret = fsl_xcvr_en_aud_pll(xcvr, fout);
-- 
2.42.0

