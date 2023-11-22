Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EB7F3BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjKVCWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:22:50 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182A181
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:22:45 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 478091A0F04;
        Wed, 22 Nov 2023 03:22:44 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FB5A1A0D38;
        Wed, 22 Nov 2023 03:22:44 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 76E58183AD45;
        Wed, 22 Nov 2023 10:22:42 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case
Date:   Wed, 22 Nov 2023 09:42:53 +0800
Message-Id: <1700617373-6472-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit 10 in TX_DPTH_CTRL register controls the TX clock rate.
If this bit is set, TX datapath clock should be = 2* TX bit rate.
If this bit is not set, TX datapath clock should be 10* TX bit rate.

As the spdif only case, we always use 2 * TX bit clock, so
this bit need to be set.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index fa0a15263c66..77f8e2394bf9 100644
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
2.34.1

