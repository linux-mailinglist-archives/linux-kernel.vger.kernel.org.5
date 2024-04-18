Return-Path: <linux-kernel+bounces-149489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C88A91BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529EB2828E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F654672;
	Thu, 18 Apr 2024 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NK0xGSlD"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3353AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413070; cv=none; b=OfNXSoTV638VQ7UrWeYWJITk8LGxnDz8o2T7lnH3PYQwsV5tyUCNnPmiRZp939geiuZFXXEAsF7CFDDNgFl9aI+BYvRo+gKgIBnVsZG/0qHacb1sZs0oHexvmqTr5J/jPsUQahoztWafREeNIeWp7jRAmWbA6xso8DNUKqhN9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413070; c=relaxed/simple;
	bh=0H/hY/3/OFXlOeFs7WDfWj82kmVBxqPisc+eHrNcraM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slfyu4W/xk8REK52a0u23m7X0c94SCEw1cF1vJWmB3oVYqVd9peIZNppR/LjO57EuM5K3Dk1I1sVVgRjwWMJuji+sR/YJHMCoHrctfqV1wmaww0KWEu2+ezbvAX0FDfAOqyuX6hkAn/54YKaUPSKyW3HjVVQYMxlQKEC5+rqoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NK0xGSlD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43I43MDs128724;
	Wed, 17 Apr 2024 23:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713413002;
	bh=S5KMrmk3XdgunGHKlkLZgGl0ODGZNDpEVrJblFUqXuY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NK0xGSlDyvcU0pVL2gtkvQgnByM6sWRHxAqGgXykjb7OrUQrBlU19t869gKkB/JmJ
	 UJV1gBJLw1GbR74ZjiVVWEfNeSt6ywpVs1Ul0SnfkufKEPNEo9FLunkrANIWtSOFkH
	 lbCreSYqfGcE9aOF0R93AASvrC6aYunIHSrZAjU4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43I43MYp016173
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 23:03:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 23:03:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 23:03:21 -0500
Received: from lelvsmtp6.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43I439il070557;
	Wed, 17 Apr 2024 23:03:16 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <13916275206@139.com>,
        <v-po@ti.com>, <niranjan.hy@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v3 1/3] ALSA: hda/tas2781: Modification for add tas2781 driver for SPI
Date: Thu, 18 Apr 2024 12:02:37 +0800
Message-ID: <20240418040240.2337-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240418040240.2337-1-baojun.xu@ti.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Integrate tas2781 configs for HP Laptops. Every tas2781 in the laptop
will work as a single speaker on SPI bus. The code support realtek as
the primary codec.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v3:
 - Move HID up to above /* Non-conforming _HID ... */ in scan.c,
   for avoid misunderstanding.
 - Move HID up to above /* Non-conforming _HID ... */ in
   serial-multi-instantiate.c, for avoid misunderstanding.
 - Change objs to y for snd-hda-scodec-tas2781-spi- in Makefile.
---
 drivers/acpi/scan.c                             |  1 +
 drivers/platform/x86/serial-multi-instantiate.c | 10 ++++++++++
 sound/pci/hda/Kconfig                           | 15 +++++++++++++++
 sound/pci/hda/Makefile                          |  2 ++
 sound/pci/hda/patch_realtek.c                   | 13 +++++++++++++
 5 files changed, 41 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1464324de95..371a42a13fc8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1765,6 +1765,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		{"CSC3557", },
 		{"INT33FE", },
 		{"INT3515", },
+		{"TXNW2781", },
 		/* Non-conforming _HID for Cirrus Logic already released */
 		{"CLSA0100", },
 		{"CLSA0101", },
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 97b9c6392230..2dcf66bb6216 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -368,6 +368,15 @@ static const struct smi_node cs35l57_hda = {
 	.bus_type = SMI_AUTO_DETECT,
 };
 
+static const struct smi_node tas2781_hda = {
+	.instances = {
+		{ "tas2781-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "tas2781-hda", IRQ_RESOURCE_AUTO, 0 },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 /*
  * Note new device-ids must also be added to ignore_serial_bus_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -380,6 +389,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "CSC3556", (unsigned long)&cs35l56_hda },
 	{ "CSC3557", (unsigned long)&cs35l57_hda },
 	{ "INT3515", (unsigned long)&int3515_data },
+	{ "TXNW2781", (unsigned long)&tas2781_hda },
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
 	{ "CLSA0101", (unsigned long)&cs35l41_hda },
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index f806636242ee..f25ad9ea51d9 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -202,6 +202,21 @@ config SND_HDA_SCODEC_TAS2781_I2C
 comment "Set to Y if you want auto-loading the side codec driver"
 	depends on SND_HDA=y && SND_HDA_SCODEC_TAS2781_I2C=m
 
+config SND_HDA_SCODEC_TAS2781_SPI
+	tristate "Build TAS2781 HD-audio side codec support for SPI Bus"
+	depends on SPI_MASTER
+	depends on ACPI
+	depends on EFI
+	depends on SND_SOC
+	select SND_HDA_SCODEC_COMPONENT
+	select CRC32_SARWATE
+	help
+	  Say Y or M here to include TAS2781 SPI HD-audio side codec support
+	  in snd-hda-intel driver, such as ALC287.
+
+comment "Set to Y if you want auto-loading the side codec driver"
+	depends on SND_HDA=y && SND_HDA_SCODEC_TAS2781_SPI=m
+
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 13e04e1f65de..ce5da317578f 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -39,6 +39,7 @@ snd-hda-scodec-cs35l56-spi-objs :=	cs35l56_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
 snd-hda-scodec-component-objs :=	hda_component.o
 snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
+snd-hda-scodec-tas2781-spi-y :=		tas2781_hda_spi.o tas2781_spi_fwlib.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
@@ -70,6 +71,7 @@ obj-$(CONFIG_SND_HDA_SCODEC_CS35L56_SPI) += snd-hda-scodec-cs35l56-spi.o
 obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
 obj-$(CONFIG_SND_HDA_SCODEC_COMPONENT) += snd-hda-scodec-component.o
 obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_I2C) += snd-hda-scodec-tas2781-i2c.o
+obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_SPI) += snd-hda-scodec-tas2781-spi.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdcb28aa9d7b..558c48cc53a1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6895,6 +6895,11 @@ static void cs35l56_fixup_spi_four(struct hda_codec *cdc, const struct hda_fixup
 	comp_generic_fixup(cdc, action, "spi", "CSC3556", "-%s:00-cs35l56-hda.%d", 4);
 }
 
+static void tas2781_fixup_spi_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "spi", "TXNW2781", "-%s:00-tas2781-hda.%d", 2);
+}
+
 static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	/*
@@ -7451,6 +7456,7 @@ enum {
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	ALC287_FIXUP_TAS2781_I2C,
+	ALC245_FIXUP_TAS2781_SPI_2_HP_GPIO_LED,
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
@@ -9614,6 +9620,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
+	[ALC245_FIXUP_TAS2781_SPI_2_HP_GPIO_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_spi_two,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
+	},
 	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = yoga7_14arb7_fixup_i2c,
@@ -10038,6 +10050,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b93, "HP", ALC245_FIXUP_TAS2781_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.40.1


