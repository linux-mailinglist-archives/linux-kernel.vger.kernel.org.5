Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A787E444C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjKGPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjKGPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:51:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B1170F;
        Tue,  7 Nov 2023 07:49:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32134C433CA;
        Tue,  7 Nov 2023 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372141;
        bh=s/Mh36tJN3/055JmMnC8ctPCLi14V6zbTn9rZWmotJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPOtY+Rc9U30HIXRl//uESPAIn6GxsBORg+CKaZ081b8+xtNu+8RvicOb3WLSZnub
         bmXV4UBL8jqhlkg7K/nHdGvJjzP5jBDqcRPC2KCS13MCsDFpGU00On3X3sf90pTqDz
         1UFAwsBhU6CvsWCZlvRmaL5SdfGs/ZQrksTsvV2ZLdboBy8bNR0wonJtab60KM6g31
         Swm5E9Qv1xzUNHt3tfbEdg0QSJO0VJUDC/x7Qgj4uM6qDPWm63TLfSgFUB2jIyfZxG
         4K38EMNbareSTMRYUtZhvFkFWJSl8CEErfB7QQPX6fcWpBngZRb8ZaHpkRJjMSvVXt
         PvXQk92kQuC1A==
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
Subject: [PATCH AUTOSEL 6.5 06/34] ASoC: SOF: ipc4: handle EXCEPTION_CAUGHT notification from firmware
Date:   Tue,  7 Nov 2023 10:47:46 -0500
Message-ID: <20231107154846.3766119-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index ab6eddd91bb77..1b09496733fb8 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -614,6 +614,9 @@ static void sof_ipc4_rx_msg(struct snd_sof_dev *sdev)
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

