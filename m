Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788680B663
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjLIUyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjLIUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:54:10 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5261700;
        Sat,  9 Dec 2023 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155251;
        bh=UoqvFkaEAiG7kyRT5ZdtctH0/Mb0yDTsfGCKAKoC8Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmDDoM7D8lYjc+7UCUEnEFx8lXJdPtzd9zfFMJtjvvDErifqsb7bO2AfgE7510dBB
         m18vz0bHGZq6wpUKmdz4X84iBKF3Z+VYR17Jj9by1zDQ9YAH5v6I70MZlmAbuQpbg8
         d5hDFEzxCo6l0H2QyTk1sbxbeEYSDjuuk7OZNwj3puCcHkt/4zEz5unzusJ/fPhGcB
         Cjp0WA2/h6gXAxtHxvPkUDZ1qB0+zf3kQQynIHpWN2PD8t0mFgMW4nCeKYnVx9O/I0
         e4+vDEJPAS0QvuVBcduDAKFmhP6nlLKIniQXv5riUrGW8itC8mR133cfoficcmBbJq
         HHPjCtHiDiIZg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 77FD637813DF;
        Sat,  9 Dec 2023 20:54:11 +0000 (UTC)
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
Subject: [PATCH 08/11] ASoC: SOF: amd: Override default fw name for Valve Galileo
Date:   Sat,  9 Dec 2023 22:53:47 +0200
Message-ID: <20231209205351.880797-9-cristian.ciocaltea@collabora.com>
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

The ACP driver for Vangogh platform uses a quirk for Valve Galileo
device to setup a custom firmware loader, which neither requires nor
uses the firmware file indicated via the default_fw_filename member of
struct sof_dev_desc.

Since commit 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version
fallback if firmware files are missing"), the provided filename gets
verified and triggers a fatal error on probe:

[ 7.719337] snd_sof_amd_vangogh 0000:04:00.5: enabling device (0000 -> 0002)
[ 7.721486] snd_sof_amd_vangogh 0000:04:00.5: SOF firmware and/or topology file not found.
[ 7.721565] snd_sof_amd_vangogh 0000:04:00.5: Supported default profiles
[ 7.721569] snd_sof_amd_vangogh 0000:04:00.5: - ipc type 0 (Requested):
[ 7.721573] snd_sof_amd_vangogh 0000:04:00.5:  Firmware file: amd/sof/sof-vangogh.ri
[ 7.721577] snd_sof_amd_vangogh 0000:04:00.5:  Topology file: amd/sof-tplg/sof-vangogh-nau8821-max.tplg
[ 7.721582] snd_sof_amd_vangogh 0000:04:00.5: Check if you have 'sof-firmware' package installed.
[ 7.721585] snd_sof_amd_vangogh 0000:04:00.5: Optionally it can be manually downloaded from:
[ 7.721589] snd_sof_amd_vangogh 0000:04:00.5:    https://github.com/thesofproject/sof-bin/
[ 7.721997] snd_sof_amd_vangogh: probe of 0000:04:00.5 failed with error -2

Skip testing the default firmware by overriding fw_name in
sof_vangogh_ops_init().

Fixes: d0dab6b76a9f ("ASoC: SOF: amd: Add sof support for vangogh platform")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/vangogh.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
index de15d21aa6d9..5843ff8a8b40 100644
--- a/sound/soc/sof/amd/vangogh.c
+++ b/sound/soc/sof/amd/vangogh.c
@@ -151,8 +151,14 @@ int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
 	sof_vangogh_ops.num_drv = ARRAY_SIZE(vangogh_sof_dai);
 
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
-	if (dmi_id && dmi_id->driver_data)
+	if (dmi_id && dmi_id->driver_data) {
 		sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
+		/*
+		 * Board doesn't use the default firmware, hence override
+		 * its name to prevent probe error due to fw validation.
+		 */
+		sdev->pdata->ipc_file_profile_base.fw_name = "";
+	}
 
 	return 0;
 }
-- 
2.43.0

