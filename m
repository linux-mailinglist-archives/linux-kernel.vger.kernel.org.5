Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BD7E43B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjKGPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjKGPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:47:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF099;
        Tue,  7 Nov 2023 07:47:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17736C433C7;
        Tue,  7 Nov 2023 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372025;
        bh=GTRXkb/PnBZm51qM3/nPCGsJZs0Ktvf0gOa0EAAkkg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHTKYH6jtBAUcBGrsgNxboo/zQELQ6gIRIQF5xzqg+DkGPUFy1ZmUHC2rFpAh4gsE
         7qAECDf069svzf+j4e9oLTV6lVnV/Ly+TJZYS+ESboXxS4kG5wdDHchsmXHPshxiuW
         vheS1ReM69x3RK5xgAu0hprrDDB+WVaylC77JQA4Yo0+qfBWtgcFobKbpAvuPisiqG
         t/7t4MKHWpdEVm9F3MxrxTzxgaEYW3JAIwZHSjXhK0vr46B9eJDFTppcepWQeYQoBv
         LOiaOwNhmQ3lMMeTA/ZD0qa7uS974Cop/RBm6DBRZr7pXBctGqxEMVXOBo7dzbiF2t
         jlO8f3+0cEcQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, gongjun.song@intel.com,
        uday.m.bhat@intel.com, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/36] ASoC: Intel: sof_sdw: Copy PCI SSID to struct snd_soc_card
Date:   Tue,  7 Nov 2023 10:45:46 -0500
Message-ID: <20231107154654.3765336-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit d8b387544ff4d02eda1d1839a0c601de4b037c33 ]

If the PCI SSID has been set in the struct snd_soc_acpi_mach_params,
copy this to struct snd_soc_card so that it can be used by other
ASoC components.

This is important for components that must apply system-specific
configuration.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230912163207.3498161-4-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 842649501e303..44f583e971e65 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1934,6 +1934,12 @@ static int mc_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(codec_info_list); i++)
 		codec_info_list[i].amp_num = 0;
 
+	if (mach->mach_params.subsystem_id_set) {
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
+	}
+
 	ret = sof_card_dai_links_create(card);
 	if (ret < 0)
 		return ret;
-- 
2.42.0

