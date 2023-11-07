Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294137E449A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjKGPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343927AbjKGPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:55:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A194691;
        Tue,  7 Nov 2023 07:50:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130FC433C9;
        Tue,  7 Nov 2023 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372237;
        bh=RAEojFqwqgOcOXtzgp2Oy6zuCow9wVPVopz6v1fS3ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKSp8Kpaqg7GGj9+7WmUd0NXd0H2Ma6djIqYORu5G70la0jkTA7dIlOgYa6y5vE2X
         hR2PFCTrEYy2gzXfZ2vVTsmRwQr90/lBSIfz0kQGHsno6TEvHT4esPm00X1PCGBA1u
         VCmgMd0ixjl8zngua9xRlaSr+n+Xj9kK5yjqfHnx35X44R3YExPcpd1+Ih4LLcuQ2s
         WGizouAcxBG82kTb4z+jsTJ4d6kx1ZO2mIA/gzY3wDhwjHBLc3LEoGi6+PMgOfNPMZ
         hWbILyXppZtIvn+AG6wZNqMSqAuHxBf0K/1D/Kz+CKsBSIP+2eFXX/FC1vwZ5X5O+R
         RBbXly2omUGvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/30] ASoC: SOF: ipc4: handle EXCEPTION_CAUGHT notification from firmware
Date:   Tue,  7 Nov 2023 10:49:39 -0500
Message-ID: <20231107155024.3766950-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

[ Upstream commit c1c48fd6bbe788458e3685fea74bdb3cb148ff93 ]

Driver will receive exception IPC message and process it by
snd_sof_dsp_panic.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230919092416.4137-10-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index c08f3960ddd96..06e1872abfee7 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -601,6 +601,9 @@ static void sof_ipc4_rx_msg(struct snd_sof_dev *sdev)
 	case SOF_IPC4_NOTIFY_LOG_BUFFER_STATUS:
 		sof_ipc4_mtrace_update_pos(sdev, SOF_IPC4_LOG_CORE_GET(ipc4_msg->primary));
 		break;
+	case SOF_IPC4_NOTIFY_EXCEPTION_CAUGHT:
+		snd_sof_dsp_panic(sdev, 0, true);
+		break;
 	default:
 		dev_dbg(sdev->dev, "Unhandled DSP message: %#x|%#x\n",
 			ipc4_msg->primary, ipc4_msg->extension);
-- 
2.42.0

