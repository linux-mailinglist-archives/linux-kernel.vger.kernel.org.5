Return-Path: <linux-kernel+bounces-113259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E260A8882CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F4287F6D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9255187E8A;
	Sun, 24 Mar 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdT2cT6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AD13CAAE;
	Sun, 24 Mar 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320058; cv=none; b=KatgnXT3aPUEoYVVeblnvgMH0/ScLMdw3Pdz+TgxL7dEfOjTOQXM31bcOtdBF0im9W9s0aQbXWF9WbP8MZOKhtTeeWs7mxYH/LwKWryXw4whdiLgf/6ntGYH9V0jsyCX/imntROgBax1meQdHK1twIr5AM8RoBS1I8F+lGOX1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320058; c=relaxed/simple;
	bh=jqBEbx6uLVaceB5dNxt0n9v1/Q0sXsq3XUNnRAUTcTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLEQxqqKIM+PH+Yd7ubLYP34QWNpm/8sOifh0i62KoZXCp/AQn+D8B0U9bW0wSiesT7gUcV3/v9GBcAyVkVHqO01Wp9edBmvc0dSZo4lcCPLLtDkNuPoj7SsFhjJ2lO9Pyut2N/ljbAoQx41fWG8axGzLtmfVgMv4EjN0N3VsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdT2cT6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C62C433F1;
	Sun, 24 Mar 2024 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320058;
	bh=jqBEbx6uLVaceB5dNxt0n9v1/Q0sXsq3XUNnRAUTcTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdT2cT6qrpz4/0tTQwjq7Tl1zirK1h+0vV6608Zfyhuc4dOTfROK3V+GvLyfjpS/5
	 t2LUslw7+q+Q+gOUvhk/NHbCzsfQqm4hW9M9VcvlLX4HmKuflf/IZOiLZNg20UHT6J
	 J4dGDgQkBzdklvaKrCOtHxU7Aykp5f2/C7Ub3i9Fwz8yGTDbQ6zFDJhcClwL7xabH9
	 nk9r95BSR4e1ew5ixbhQvBRCipPvtzGBqmjZJBDP4zD9sbxSuTCLELRHqWI9UmB4Jm
	 v2ciPART6V+WsQ90KE+RWqDsuQeAShcV6nlI2lQvgNYNqAVh8NpfH8cCTFgK6V+Ab4
	 QnE8j9sPJcNBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 368/715] ASoC: SOF: core: Skip firmware test for custom loaders
Date: Sun, 24 Mar 2024 18:29:07 -0400
Message-ID: <20240324223455.1342824-369-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 369b997a1371aeecd0a1fb0f9f4ef3747a1d07a4 ]

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
Link: https://msgid.link/r/20231219030728.2431640-8-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/fw-file-profile.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
index 138a1ca2c4a85..b56b14232444c 100644
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


