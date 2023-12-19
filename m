Return-Path: <linux-kernel+bounces-4629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB9818018
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA3B2205B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97F125BD;
	Tue, 19 Dec 2023 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fWG6S1BN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44310D533;
	Tue, 19 Dec 2023 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955268;
	bh=IfM/vMNw/LOYZUhoIV667VtEVLC2SySrCHMGBWAyBsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWG6S1BN9oMJAL83R6uq6stdWBaCI91ShXs6irkJGfZsXsub5CvclJDX+AWp9wXBX
	 BFfFWNHthqkqjgvK58lSybt7LzTVccmBWwPQTtbQiDo/t+6WIO9r+GDavfjQ3O3vb6
	 xOLrtjM9hXEE+/JYtNYycVH8c4ec0hCUBxxDoRMrBuFiuGfXdCX5rftHtsIrV+wWHd
	 UFmFIvHy3cF4Ryz+eeZoUKiszjU7VgqCvQqQQZmJ2r84PvpAaqJrqerUMHaylrt96I
	 Zw42zycWkHx66PwJMFbJELO8WfMJTUj3tzx4uF6FZcKBucFP105w2cmQAQ0RItjFK6
	 WsITxxwWlAfsQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6AE2A3781495;
	Tue, 19 Dec 2023 03:07:48 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
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
	Emil Velikov <emil.velikov@collabora.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	kernel@collabora.com
Subject: [PATCH v2 7/8] ASoC: SOF: core: Skip firmware test for custom loaders
Date: Tue, 19 Dec 2023 05:07:25 +0200
Message-ID: <20231219030728.2431640-8-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
References: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

According to AMD, a combined ".ri" file which includes the code and data
segments cannot be used due to a limitation preventing the code image to
be signed on build time.

Fix the issue by skipping the firmware file test if a custom loader is
being used instead of the generic one.

Fixes: 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if firmware files are missing")
Co-developed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/fw-file-profile.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
index 138a1ca2c4a8..b56b14232444 100644
--- a/sound/soc/sof/fw-file-profile.c
+++ b/sound/soc/sof/fw-file-profile.c
@@ -89,6 +89,12 @@ static int sof_test_topology_file(struct device *dev,
 	return ret;
 }
 
+static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
+{
+	return (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
+		sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy);
+}
+
 static int
 sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
 			      enum sof_ipc_type ipc_type,
@@ -130,7 +136,8 @@ sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
 	 * For default path and firmware name do a verification before
 	 * continuing further.
 	 */
-	if (base_profile->fw_path || base_profile->fw_name) {
+	if ((base_profile->fw_path || base_profile->fw_name) &&
+	    sof_platform_uses_generic_loader(sdev)) {
 		ret = sof_test_firmware_file(dev, out_profile, &ipc_type);
 		if (ret)
 			return ret;
@@ -181,7 +188,8 @@ sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
 	out_profile->ipc_type = ipc_type;
 
 	/* Test only default firmware file */
-	if (!base_profile->fw_path && !base_profile->fw_name)
+	if ((!base_profile->fw_path && !base_profile->fw_name) &&
+	    sof_platform_uses_generic_loader(sdev))
 		ret = sof_test_firmware_file(dev, out_profile, NULL);
 
 	if (!ret)
@@ -267,7 +275,11 @@ static void sof_print_profile_info(struct snd_sof_dev *sdev,
 
 	dev_info(dev, "Firmware paths/files for ipc type %d:\n", profile->ipc_type);
 
-	dev_info(dev, " Firmware file:     %s/%s\n", profile->fw_path, profile->fw_name);
+	/* The firmware path is only valid when generic loader is used */
+	if (sof_platform_uses_generic_loader(sdev))
+		dev_info(dev, " Firmware file:     %s/%s\n",
+			 profile->fw_path, profile->fw_name);
+
 	if (profile->fw_lib_path)
 		dev_info(dev, " Firmware lib path: %s\n", profile->fw_lib_path);
 	dev_info(dev, " Topology file:     %s/%s\n", profile->tplg_path, profile->tplg_name);
-- 
2.43.0


