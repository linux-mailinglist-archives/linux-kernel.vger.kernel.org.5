Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33580B661
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjLIUyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjLIUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:54:08 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD3E1BB;
        Sat,  9 Dec 2023 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155249;
        bh=4/ljxDEHtTvIlqAZ4vM3o3PXrWgZstPeEiyPFB52jiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMyVa0w9ssaQ4z2ta6GYiFSLZdAZzG6yiwDP9gWn5XrGdJDQCH+Eh9Si3zcfz2lmC
         sp9w+Fs9GHs4XfG4ovXDzzc3hOT2+iJZepIbbe2dtxomSOjXFU1pppqEUxS8g9wr21
         C5sOYcBqZY7MvkEzHA+EYhCNS208rPtgTdaGOEu2/C43dT8k9bAYywI18CLOwLMOmk
         0AsWWQTM8aJWiT5aCPJE2zqO/hhqwKRYc5upHlYMnpbCTlIfBhT7niaTz2aQmOTDl2
         k/u0bVMrq7AJVO/t3nFZJj7TFRzY+8yLPscxnzpcsrcpMhklK49DPP8NDrULDh4DQF
         Yr60aIHteyFKQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1031037813E1;
        Sat,  9 Dec 2023 20:54:09 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 06/11] ASoC: SOF: amd: Optimize quirk for Valve Galileo
Date:   Sat,  9 Dec 2023 22:53:45 +0200
Message-ID: <20231209205351.880797-7-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valve's Steam Deck OLED is uniquely identified by vendor and product
name (Galileo) DMI fields.

Simplify the quirk by removing the unnecessary match on product family.

Additionally, fix the related comment as it points to the old product
variant.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/acp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index c6f637f29847..1e9840ae8938 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -28,11 +28,10 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 
 const struct dmi_system_id acp_sof_quirk_table[] = {
 	{
-		/* Valve Jupiter device */
+		/* Steam Deck OLED device */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
 		},
 		.driver_data = (void *)SECURED_FIRMWARE,
 	},
-- 
2.43.0

