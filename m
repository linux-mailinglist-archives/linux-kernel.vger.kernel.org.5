Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B468798FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbjIHTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbjIHTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:34:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B1E186;
        Fri,  8 Sep 2023 12:34:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32632C433BC;
        Fri,  8 Sep 2023 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201634;
        bh=4nvCPsfTTnSecXToPDOjR/OjH5NkC7hqBOdeR93jG80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QavqVBxWPaBTHBRkT+iNi2EE+S0/9ii0FGPLAo9qnJCQkW9DuoXKcDBxwxc1oI5st
         0Fao6rU+zNMJsJKe8IHixVxJt7YHL1u52v5mhkCQmHf3eBY9UZQ8XWSClYx4FCrSeN
         Xm5CL4WXwAGTCsNuIwMPPGNQr7X2V02cKkZXvyu9RoE2WSgcdepQBZCDCIuquTSqrM
         aAF5ybuqBL/afq82iPn/PsO7uoUsVGyTkw1ctkdJjKa14NrXssAiAIy6u8rQu9WZTy
         JYvlqBXw7qAdge/CC2LjqBOdrx3Hvp0YuCGF3kP7ZJEKi8lo5sHDzKnmotiojZi7Bf
         jakWwy2fqnhrg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        perex@perex.cz, tiwai@suse.com, Vsujithkumar.Reddy@amd.com,
        paul.olaru@nxp.com, AjitKumar.Pandey@amd.com,
        venkataprasad.potturu@amd.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 30/31] ASoC: SOF: amd: clear panic mask status when panic occurs
Date:   Fri,  8 Sep 2023 15:31:59 -0400
Message-Id: <20230908193201.3462957-30-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 3d02e1c439b4140215b624d423aa3c7554b17a5a ]

Due to scratch memory persistence, Once the DSP panic is reported, need to
clear the panic mask after handling DSP panic. Otherwise, It results in DSP
panic on next reboot.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230823073340.2829821-6-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-ipc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 749e856dc6011..6951c67bc599f 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -161,6 +161,8 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 		if ((status & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
 			snd_sof_dsp_panic(sdev, sdev->dsp_box.offset + sizeof(status),
 					  true);
+			status = 0;
+			acp_mailbox_write(sdev, sdev->dsp_box.offset, &status, sizeof(status));
 			return IRQ_HANDLED;
 		}
 		snd_sof_ipc_msgs_rx(sdev);
@@ -190,6 +192,8 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 	acp_mailbox_read(sdev, sdev->debug_box.offset, &status, sizeof(u32));
 	if ((status & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
 		snd_sof_dsp_panic(sdev, sdev->dsp_oops_offset, true);
+		status = 0;
+		acp_mailbox_write(sdev, sdev->debug_box.offset, &status, sizeof(status));
 		return IRQ_HANDLED;
 	}
 
-- 
2.40.1

