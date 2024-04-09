Return-Path: <linux-kernel+bounces-136148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E889D07E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB96F1F24F64
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B527548FC;
	Tue,  9 Apr 2024 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VUczROhi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4465548EB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630976; cv=none; b=KblskgnwoAV1SItclFbxqiIpk3aBzxL+shZ+MyvcxytU46mfvwLKMVwBae3gDg9vzj3sqzBthXCk3CZZl8ED3uMQPyDF6YGfRWa7vEnpdDoIbunrXYYtKpFQFArYEVVd7hjUK3HOd/kjvaYL5FCmCNGYV/s2d3ag8p6gsBL/CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630976; c=relaxed/simple;
	bh=LeW9OIKroU071bWJnu0IrhjbBgzF+qwbMY11vrlAK4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEV9jMTJ0zxhXEI8KGAweEwGqe6cOzvAFUryaFUloZ3IU3KUMQFu7u14cFcHydRL2jr+dd9asexxRvlF5tKOR/p51Z9OD/ERzHnYFC71Mpt0YOStxeD1q6HsMTS64WncsLqYCkyn/vH+3TyrT1dsX/oc2Mi+mQb98wHjbI+ELfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VUczROhi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4392muKQ032536;
	Mon, 8 Apr 2024 21:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712630936;
	bh=PBYcI+eUvuPJSlis+LbqzPyhawPi5qpYU1Px9zqxqCo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VUczROhiq1s4nbb4zyrt8DlqGZw1liI66TUihmUASlaPuSc28LvShb7x3HICJBT4p
	 n9jB4BArlu+iBsqyuDm6VNvXfm/zOV+7YSEYGWJaEGmlLo73hst0sncrg2GwGfKsWE
	 Li0C3o2uecf6xCqizBl+H+pUkUHO09w6wA0A9PzE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4392mu4T021169
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 21:48:56 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 21:48:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 21:48:56 -0500
Received: from lelvsmtp6.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4392miks024930;
	Mon, 8 Apr 2024 21:48:51 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v2 1/3] ALSA: hda/tas2781: Modification for add tas2781 driver for SPI
Date: Tue, 9 Apr 2024 10:48:13 +0800
Message-ID: <20240409024816.1180-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240409024816.1180-1-baojun.xu@ti.com>
References: <20240409024816.1180-1-baojun.xu@ti.com>
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
 - Change depends on SPI to SPI_MASTER in sound/pci/hda/Kconfig
 - Add select SND_HDA_SCODEC_COMPONENT in sound/pci/hda/Kconfig
 - Change comp_generic_fixup() 5th parameter from "-%s:00" to
   "-%s:00-tas2781-hda.%d" in sound/pci/hda/patch_realtek.c
 - Change chain_id from ALC285_FIXUP_THINKPAD_HEADSET_JACK to
   ALC285_FIXUP_HP_GPIO_LED in sound/pci/hda/patch_realtek.c
 - Remove project name "Gemtree"
---
 drivers/acpi/scan.c                             |  1 +
 drivers/platform/x86/serial-multi-instantiate.c | 10 ++++++++++
 sound/pci/hda/Kconfig                           | 15 +++++++++++++++
 sound/pci/hda/Makefile                          |  2 ++
 sound/pci/hda/patch_realtek.c                   | 15 +++++++++++++++
 5 files changed, 43 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92695..8166343f26d0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1766,6 +1766,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		{"INT33FE", },
 		{"INT3515", },
 		/* Non-conforming _HID for Cirrus Logic already released */
+		{"TXNW2781", },
 		{"CLSA0100", },
 		{"CLSA0101", },
 	/*
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 97b9c6392230..f54636b576d1 100644
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
@@ -383,6 +392,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
 	{ "CLSA0101", (unsigned long)&cs35l41_hda },
+	{ "TXNW2781", (unsigned long)&tas2781_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
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
index 13e04e1f65de..9785cddb4845 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -39,6 +39,7 @@ snd-hda-scodec-cs35l56-spi-objs :=	cs35l56_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
 snd-hda-scodec-component-objs :=	hda_component.o
 snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
+snd-hda-scodec-tas2781-spi-objs :=	tas2781_hda_spi.o tas2781_spi_fwlib.o
 
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
index cdcb28aa9d7b..4945309f45ae 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6913,6 +6913,13 @@ static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	comp_generic_fixup(cdc, action, "i2c", "TIAS2781", "-%s:00", 1);
 }
 
+static void tas2781_fixup_spi(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "spi", "TXNW2781",
+		"-%s:00-tas2781-hda.%d", 2);
+}
+
 static void yoga7_14arb7_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
@@ -7451,6 +7458,7 @@ enum {
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	ALC287_FIXUP_TAS2781_I2C,
+	ALC245_FIXUP_TAS2781_SPI_2,
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
@@ -9614,6 +9622,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
+	[ALC245_FIXUP_TAS2781_SPI_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_spi,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
+	},
 	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = yoga7_14arb7_fixup_i2c,
@@ -10038,6 +10052,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b93, "HP", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.40.1


