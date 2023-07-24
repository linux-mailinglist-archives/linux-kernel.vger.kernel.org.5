Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAB75E65E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGXBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGXBSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:18:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100CE73;
        Sun, 23 Jul 2023 18:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E664A60EF2;
        Mon, 24 Jul 2023 01:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2D6C433C8;
        Mon, 24 Jul 2023 01:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161459;
        bh=b3OPZH3dyCLUwdhf6RB/2yvIUaHHXPW5Q8DktTtWGPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thlGnBfrkqht1Q6hOkb9zJI7j4lbcT271uF4qjxtuN4+BrxDTT+aRoO3bpKXZ2t9W
         eRclqA/0qq3Zhwh6QtTSNCEzr+KXoPu7TOdfdn/c5c1LXwoOcSOtm7e49E0b4ZVCGU
         N8dxC5j5vmek0iX/DJYS1G76/6pZAlzgo2r+8ROJg0BXOS4srWyQ0kE+GXVJXnjzLo
         lCWfzkoHQdUG56jm5mk/U/S5WyzmMpOQtxGA3CifL/qplPs/jk60J5GiGBV72DzKiJ
         BFciG60Su51lo8FplTrXYBkiJrF3Et/A0XbwkgrDKcJHip8bluZrJnAurfFkrLv9UN
         BNNb/5rHxsiuQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, daniel.baluta@nxp.com,
        perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 29/58] ASoC: SOF: Intel: fix SoundWire/HDaudio mutual exclusion
Date:   Sun, 23 Jul 2023 21:12:57 -0400
Message-Id: <20230724011338.2298062-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit f751b99255cacd9ffe8c4bbf99767ad670cee1f7 ]

The functionality described in Commit 61bef9e68dca ("ASoC: SOF: Intel: hda: enforce exclusion between HDaudio and SoundWire")
does not seem to be properly implemented with two issues that need to
be corrected.

a) The test used is incorrect when DisplayAudio codecs are not supported.

b) Conversely when only Display Audio codecs can be found, we do want
to start the SoundWire links, if any. That will help add the relevant
topologies and machine descriptors, and identify cases where the
SoundWire information in ACPI needs to be modified with a quirk.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20230606222529.57156-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 3153e21f100ab..3853582e32e12 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1343,12 +1343,22 @@ static void hda_generic_machine_select(struct snd_sof_dev *sdev,
 			hda_mach->mach_params.dmic_num = dmic_num;
 			pdata->tplg_filename = tplg_filename;
 
-			if (codec_num == 2) {
+			if (codec_num == 2 ||
+			    (codec_num == 1 && !HDA_IDISP_CODEC(bus->codec_mask))) {
 				/*
 				 * Prevent SoundWire links from starting when an external
 				 * HDaudio codec is used
 				 */
 				hda_mach->mach_params.link_mask = 0;
+			} else {
+				/*
+				 * Allow SoundWire links to start when no external HDaudio codec
+				 * was detected. This will not create a SoundWire card but
+				 * will help detect if any SoundWire codec reports as ATTACHED.
+				 */
+				struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
+
+				hda_mach->mach_params.link_mask = hdev->info.link_mask;
 			}
 
 			*mach = hda_mach;
-- 
2.39.2

