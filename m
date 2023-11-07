Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4AF7E43B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbjKGPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344084AbjKGPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:47:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB5B7;
        Tue,  7 Nov 2023 07:47:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA1EC433CB;
        Tue,  7 Nov 2023 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372027;
        bh=jnHpyki1qSdBdtIxqYK0C0tKCk6ziaG/P36fbiRWSV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jc87pD9iXMUb/G0feqZwwcf7FM3IRsJV6zqf7MBEDVSlhcCWVXvkGF+F+OkGU7tWE
         J7KYL1FK4HwwmilSyLangRbPXoL2GOyWhFYnSnnEIolGuv0XLYHtAd5b+4R/5ZjHMu
         LRi1YarCnUorwjNh16pGnG7L82iRBkJ3GuE5M+MxYPL6e4ss/SZbUEzxwFO5AWjCzT
         b7Hc11TyshyardGpfcmXR/tBNDOPaWz1A6TXmqkLuPc8a4uCPvEtQLP6d8HicCq9dv
         8Mk3uxQx8K9dTC9pLJ8IJ2aNfNOhxsyKEyjEwuyU8EJ9lE0Bkq7xScm/vWH9YPQdWp
         n5PfxF9TxNoaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/36] ASoC: cs35l56: Use PCI SSID as the firmware UID
Date:   Tue,  7 Nov 2023 10:45:47 -0500
Message-ID: <20231107154654.3765336-5-sashal@kernel.org>
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

[ Upstream commit 1a1c3d794ef65ef2978c5e65e1aed3fe6f014e90 ]

If the driver properties do not define a cirrus,firmware-uid try to get the
PCI SSID as the UID.

On PCI-based systems the PCI SSID is used to uniquely identify the specific
sound hardware. This is the standard mechanism for x86 systems and is the
way to get a unique system identifier for systems that use the CS35L56 on
SoundWire.

For non-SoundWire systems there is no Windows equivalent of the ASoC driver
in I2C/SPI mode. These would be:

1. HDA systems, which are handled by the HDA subsystem.
2. Linux-specific systems.
3. Composite devices where the cs35l56 is not present in ACPI and is
   configured using software nodes.

Case 2 can use the firmware-uid property, though the PCI SSID is supported
as an alternative, as it is the standard PCI mechanism.

Case 3 is a SoundWire system where some other codec is the SoundWire bridge
device and CS35L56 is not listed in ACPI. As these are SoundWire systems
they will normally use the PCI SSID.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230912163207.3498161-5-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index f9059780b7a7b..32d4ab2cd6724 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -772,9 +772,20 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 	struct dentry *debugfs_root = component->debugfs_root;
+	unsigned short vendor, device;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_tx_input_texts) != ARRAY_SIZE(cs35l56_tx_input_values));
 
+	if (!cs35l56->dsp.system_name &&
+	    (snd_soc_card_get_pci_ssid(component->card, &vendor, &device) == 0)) {
+		cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
+							  GFP_KERNEL,
+							  "%04x%04x",
+							  vendor, device);
+		if (!cs35l56->dsp.system_name)
+			return -ENOMEM;
+	}
+
 	if (!wait_for_completion_timeout(&cs35l56->init_completion,
 					 msecs_to_jiffies(5000))) {
 		dev_err(cs35l56->base.dev, "%s: init_completion timed out\n", __func__);
-- 
2.42.0

