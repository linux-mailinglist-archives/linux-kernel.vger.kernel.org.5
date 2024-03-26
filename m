Return-Path: <linux-kernel+bounces-118235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF5B88B693
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE471C35AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDC1CAB7;
	Tue, 26 Mar 2024 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TAI5t4t7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D2208BC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415441; cv=none; b=bXw9IuYgaVCQNWHXmUvM0BkT3M4ZAjCPGm43P/IVyf+hMl72XYBVONVvYPofe0kH9UT7ocl8a0Pif+FOVsJOknbly44/aKW3F4vpq/THrKZxwqhvTPqIqC7aZKYnkYnCJV53evRxr5HOw7lDV5bb52hgPObwyKD+bf8ueq76kDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415441; c=relaxed/simple;
	bh=0QsKgJQ19vq8y8tPl++NyerJ36KN8IVJkfJVqeiKsRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2apqrfIzZYNZepNuWdY7HhSOqcN4KWB/z+6c31vW2C+tYpimVBsaaCyeQvYUeyjBtjfGpSGfPjU4DLXY2CFAxRtgeTpgIcBW15UZPnaMDTfntcuWmDCJrWUPmSenCphdmuDaQPtN07kcmT+Ue8TQgWktCfDQ5F5hwjIp2gUcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TAI5t4t7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19iAL003895;
	Mon, 25 Mar 2024 20:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711415384;
	bh=q13WMrsqKgrXXFIBsB6QRe/kJCRfjBQkQH/hg2NF4RY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TAI5t4t7Zwh91K504ahsw8ronbQcgeAvk83jH2SyycqlEEiwW7nvoSRnN9duRaCUd
	 Pe8at9Woxf3eaM9O7YYbSKOWoG1ifmtLtPm4c2h4nIViLWqbfow0IqTR3cFWSH/LvM
	 RVLTiZ4KaFwVcCttMMhmT4x7L03U8NwLZP8khjQQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q19ibB005275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 20:09:44 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 20:09:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 20:09:44 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19AYB120020;
	Mon, 25 Mar 2024 20:09:38 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v1 5/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Date: Tue, 26 Mar 2024 09:09:02 +0800
Message-ID: <20240326010905.2147-5-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240326010905.2147-1-baojun.xu@ti.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add tas2781 spi driver support.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a17c36a36..9aef8b451 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6886,6 +6886,12 @@ static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	comp_generic_fixup(cdc, action, "i2c", "TIAS2781", "-%s:00", 1);
 }
 
+static void tas2781_fixup_spi(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	 comp_generic_fixup(cdc, action, "spi", "TXNW2781", "-%s:00", 2);
+}
+
 static void yoga7_14arb7_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
@@ -7424,6 +7430,7 @@ enum {
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	ALC287_FIXUP_TAS2781_I2C,
+	ALC287_FIXUP_TAS2781_SPI,
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
@@ -9583,6 +9590,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
+	[ALC287_FIXUP_TAS2781_SPI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_spi,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
+	},
 	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = yoga7_14arb7_fixup_i2c,
@@ -9991,6 +10004,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b93, "HP Gemtree", ALC287_FIXUP_TAS2781_SPI),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.40.1


