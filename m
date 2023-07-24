Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0575E780
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGXB2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGXB1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632594681;
        Sun, 23 Jul 2023 18:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D182360F1D;
        Mon, 24 Jul 2023 01:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E35C433C8;
        Mon, 24 Jul 2023 01:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161849;
        bh=iqD2z/IVhDi0WM/KEjgSh/ZYzgqFhIE1K7YNkIMHOS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1TDVwOJTPOROGaypI7iKNFB/XIFNdRmAVmClEL5U6KEbipbeI27do2rCggdVLmRe
         NUJUpFWeKxVjiVFlQqUEN9HiPuTNd4ELsWZG0MdBRTPqhVnlN8OcqaKnF8dhN887jC
         1fPl+sWu3uuv1JEYXMA/10baoq7IfsvhJsf4DiSdUApkeWwjWsBToEkMb73I/Nd0ce
         ml2yvGi1uFI9xP7exBXffk8tuUFKK9L0Gl8YM9MaaaM/uiPkRZWtZF+VaqTGB5xDqr
         8NgZMTbC7OnmdeXMs+VTKUvB/y7ypvSvsv5gOMqYOvDspwCE7Y0I01W4Rr80FT6AY/
         DdcdR1RHi1olA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 16/23] ASoC: SOF: core: Free the firmware trace before calling snd_sof_shutdown()
Date:   Sun, 23 Jul 2023 21:23:27 -0400
Message-Id: <20230724012334.2317140-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012334.2317140-1-sashal@kernel.org>
References: <20230724012334.2317140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit d389dcb3a48cec4f03c16434c0bf98a4c635372a ]

The shutdown is called on reboot/shutdown of the machine.
At this point the firmware tracing cannot be used anymore but in case of
IPC3 it is using and keeping a DMA channel active (dtrace).

For Tiger Lake platforms we have a quirk in place to fix rare reboot issues
when a DMA was active before rebooting the system.
If the tracing is enabled this quirk will be always used and a print
appears on the kernel log which might be misleading or not even correct.

Release the fw tracing before executing the shutdown to make sure that this
known DMA user is cleared away.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230616100039.378150-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 59d0d7b2b55c8..5f8e89da7b578 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -406,8 +406,10 @@ int snd_sof_device_shutdown(struct device *dev)
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
 		cancel_work_sync(&sdev->probe_work);
 
-	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE)
+	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE) {
+		sof_fw_trace_free(sdev);
 		return snd_sof_shutdown(sdev);
+	}
 
 	return 0;
 }
-- 
2.39.2

