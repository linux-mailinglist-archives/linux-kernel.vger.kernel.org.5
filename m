Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF757E448E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbjKGPy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjKGPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:54:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD33C3B;
        Tue,  7 Nov 2023 07:50:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A0FC433C7;
        Tue,  7 Nov 2023 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372230;
        bh=Cv/QICXBxGN0LBB9aU/l96c/3YUcqq/wkTfR5iVc+44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjZ6vIn6reyAzMpxAxlRpSL0sm1Cm1oRedvr5kz5c/MkEH/H5La5dlUjOxjOxt1y/
         Nik8ZSD4JNjtVaCgy2FMECFKLTV9jqSflQoQBYGMcdzTfXjnL5GMEVIWbC8matCQg0
         bdWBm1tIB4MnyOM65DA5NWklACXrwmkosr5jheKikkwdxEkYZdXm9prej9ALBTHuVk
         tTITXTpULrxZ+ciSE68DntwhweXTr75xvMVv0O1EZMnDMdt5WSvHkgAq/pon8Qs+5a
         WiFO+BP22U5F/TCbCVkzfD4GXxt9saH7xQhhKpvfRsqSVPY8EB/RftKfgxeeGyNGMg
         WIX7tJo2Eg9ig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, linux-sound@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 02/30] ASoC: SOF: Pass PCI SSID to machine driver
Date:   Tue,  7 Nov 2023 10:49:36 -0500
Message-ID: <20231107155024.3766950-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit ba2de401d32625fe538d3f2c00ca73740dd2d516 ]

Pass the PCI SSID of the audio interface through to the machine driver.
This allows the machine driver to use the SSID to uniquely identify the
specific hardware configuration and apply any platform-specific
configuration.

struct snd_sof_pdata is passed around inside the SOF code, but it then
passes configuration information to the machine driver through
struct snd_soc_acpi_mach and struct snd_soc_acpi_mach_params. So SSID
information has been added to both snd_sof_pdata and
snd_soc_acpi_mach_params.

PCI does not define 0x0000 as an invalid value so we can't use zero to
indicate that the struct member was not written. Instead a flag is
included to indicate that a value has been written to the
subsystem_vendor and subsystem_device members.

sof_pci_probe() creates the struct snd_sof_pdata. It is passed a struct
pci_dev so it can fill in the SSID value.

sof_machine_check() finds the appropriate struct snd_soc_acpi_mach. It
copies the SSID information across to the struct snd_soc_acpi_mach_params.
This done before calling any custom set_mach_params() so that it could be
used by the set_mach_params() callback to apply variant params.

The machine driver receives the struct snd_soc_acpi_mach as its
platform_data.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230912163207.3498161-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-acpi.h    | 7 +++++++
 include/sound/sof.h         | 8 ++++++++
 sound/soc/sof/sof-audio.c   | 7 +++++++
 sound/soc/sof/sof-pci-dev.c | 8 ++++++++
 4 files changed, 30 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 528279056b3ab..1a5f90b0a5463 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -67,6 +67,10 @@ static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
  * @i2s_link_mask: I2S/TDM links enabled on the board
  * @num_dai_drivers: number of elements in @dai_drivers
  * @dai_drivers: pointer to dai_drivers, used e.g. in nocodec mode
+ * @subsystem_vendor: optional PCI SSID vendor value
+ * @subsystem_device: optional PCI SSID device value
+ * @subsystem_id_set: true if a value has been written to
+ *		      subsystem_vendor and subsystem_device.
  */
 struct snd_soc_acpi_mach_params {
 	u32 acpi_ipc_irq_index;
@@ -79,6 +83,9 @@ struct snd_soc_acpi_mach_params {
 	u32 i2s_link_mask;
 	u32 num_dai_drivers;
 	struct snd_soc_dai_driver *dai_drivers;
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	bool subsystem_id_set;
 };
 
 /**
diff --git a/include/sound/sof.h b/include/sound/sof.h
index 341fef19e6124..1caeb7bf109b4 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -63,6 +63,14 @@ struct snd_sof_pdata {
 	const char *name;
 	const char *platform;
 
+	/*
+	 * PCI SSID. As PCI does not define 0 as invalid, the subsystem_id_set
+	 * flag indicates that a value has been written to these members.
+	 */
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	bool subsystem_id_set;
+
 	struct device *dev;
 
 	/* indicate how many first bytes shouldn't be loaded into DSP memory. */
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index cf2c0db57d899..061ab7289a6c3 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -832,6 +832,13 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 		mach = snd_sof_machine_select(sdev);
 		if (mach) {
 			sof_pdata->machine = mach;
+
+			if (sof_pdata->subsystem_id_set) {
+				mach->mach_params.subsystem_vendor = sof_pdata->subsystem_vendor;
+				mach->mach_params.subsystem_device = sof_pdata->subsystem_device;
+				mach->mach_params.subsystem_id_set = true;
+			}
+
 			snd_sof_set_mach_params(mach, sdev);
 			return 0;
 		}
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 643fd1036d60b..6e3709561fa86 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -210,6 +210,14 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return ret;
 
 	sof_pdata->name = pci_name(pci);
+
+	/* PCI defines a vendor ID of 0xFFFF as invalid. */
+	if (pci->subsystem_vendor != 0xFFFF) {
+		sof_pdata->subsystem_vendor = pci->subsystem_vendor;
+		sof_pdata->subsystem_device = pci->subsystem_device;
+		sof_pdata->subsystem_id_set = true;
+	}
+
 	sof_pdata->desc = desc;
 	sof_pdata->dev = dev;
 
-- 
2.42.0

