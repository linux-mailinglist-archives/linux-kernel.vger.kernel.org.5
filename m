Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0FD7E4519
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjKGQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344824AbjKGP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C97B7EF3;
        Tue,  7 Nov 2023 07:52:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA14C433C8;
        Tue,  7 Nov 2023 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372373;
        bh=L1B1zDFGVSaiCHf6gca5X0oMN9K/Qx4nc9jrzS+4t2A=;
        h=From:To:Cc:Subject:Date:From;
        b=IKMJwYC/+492ktq5jXnhJSh8qF/R4yyRj1ezvOzKESN4oAuEH+1Yzo86CvIMsbphV
         Vam1nknPECC7yXu9Yep0DoJqLczRioHRUGzfwG9QHqloDS4+WEBr+xxsgULmzizRG3
         +9VAijXqBznPyuf9g9TUrREgB543hEa+x4Ty5ORdPBgUjD7+TchX8f7srSeuD/7V/U
         qY7jxCGDxx8FDeFDw51mjUj4mMoMSCszm6sHmF+8CMCys9ydMS8LpRGmF1Dv0qT6n5
         P5vdPsnYWWuo5pXVtyebUnMmifwuny8sgB8ZbxZNewPQSEJkEDAD46uY6btlxA8RhT
         4pG626ZYEWoQQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/16] ASoC: soc-card: Add storage for PCI SSID
Date:   Tue,  7 Nov 2023 10:52:20 -0500
Message-ID: <20231107155249.3768098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 47f56e38a199bd45514b8e0142399cba4feeaf1a ]

Add members to struct snd_soc_card to store the PCI subsystem ID (SSID)
of the soundcard.

The PCI specification provides two registers to store a vendor-specific
SSID that can be read by drivers to uniquely identify a particular
"soundcard". This is defined in the PCI specification to distinguish
products that use the same silicon (and therefore have the same silicon
ID) so that product-specific differences can be applied.

PCI only defines 0xFFFF as an invalid value. 0x0000 is not defined as
invalid. So the usual pattern of zero-filling the struct and then
assuming a zero value unset will not work. A flag is included to
indicate when the SSID information has been filled in.

Unlike DMI information, which has a free-format entirely up to the vendor,
the PCI SSID has a strictly defined format and a registry of vendor IDs.

It is usual in Windows drivers that the SSID is used as the sole identifier
of the specific end-product and the Windows driver contains tables mapping
that to information about the hardware setup, rather than using ACPI
properties.

This SSID is important information for ASoC components that need to apply
hardware-specific configuration on PCI-based systems.

As the SSID is a generic part of the PCI specification and is treated as
identifying the "soundcard", it is reasonable to include this information
in struct snd_soc_card, instead of components inventing their own custom
ways to pass this information around.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230912163207.3498161-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-card.h | 37 +++++++++++++++++++++++++++++++++++++
 include/sound/soc.h      | 11 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index 4f2cc4fb56b7f..9a5429260ece5 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -40,6 +40,43 @@ int snd_soc_card_add_dai_link(struct snd_soc_card *card,
 void snd_soc_card_remove_dai_link(struct snd_soc_card *card,
 				  struct snd_soc_dai_link *dai_link);
 
+#ifdef CONFIG_PCI
+static inline void snd_soc_card_set_pci_ssid(struct snd_soc_card *card,
+					     unsigned short vendor,
+					     unsigned short device)
+{
+	card->pci_subsystem_vendor = vendor;
+	card->pci_subsystem_device = device;
+	card->pci_subsystem_set = true;
+}
+
+static inline int snd_soc_card_get_pci_ssid(struct snd_soc_card *card,
+					    unsigned short *vendor,
+					    unsigned short *device)
+{
+	if (!card->pci_subsystem_set)
+		return -ENOENT;
+
+	*vendor = card->pci_subsystem_vendor;
+	*device = card->pci_subsystem_device;
+
+	return 0;
+}
+#else /* !CONFIG_PCI */
+static inline void snd_soc_card_set_pci_ssid(struct snd_soc_card *card,
+					     unsigned short vendor,
+					     unsigned short device)
+{
+}
+
+static inline int snd_soc_card_get_pci_ssid(struct snd_soc_card *card,
+					    unsigned short *vendor,
+					    unsigned short *device)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_PCI */
+
 /* device driver data */
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
 					    void *data)
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3b038c563ae14..e973044143bc9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -977,6 +977,17 @@ struct snd_soc_card {
 #ifdef CONFIG_DMI
 	char dmi_longname[80];
 #endif /* CONFIG_DMI */
+
+#ifdef CONFIG_PCI
+	/*
+	 * PCI does not define 0 as invalid, so pci_subsystem_set indicates
+	 * whether a value has been written to these fields.
+	 */
+	unsigned short pci_subsystem_vendor;
+	unsigned short pci_subsystem_device;
+	bool pci_subsystem_set;
+#endif /* CONFIG_PCI */
+
 	char topology_shortname[32];
 
 	struct device *dev;
-- 
2.42.0

