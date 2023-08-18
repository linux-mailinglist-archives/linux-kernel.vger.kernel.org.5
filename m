Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6D78079C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358823AbjHRI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358817AbjHRI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:59:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5C2D65
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:59:07 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37I8wjqh111851;
        Fri, 18 Aug 2023 03:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692349125;
        bh=IXZVlCWxbzmhuyWWtDi7VI8A9Ah0nR3egkYua2H3tCs=;
        h=From:To:CC:Subject:Date;
        b=KPUFEuNcxIW1lSTca69SOFthdX3g5vHGiiL4xoB/AfS6/o1tye7ObqBZivmcDVxIg
         kfnBMS9hKBW3YYIfj1rTYTATW38+M3IGJhD6y7hAU3D5ovY1R9BwkETRilSlhFLE9n
         0GjZPnl78PTQilLdImuuF39WvUYTzsVPzMFom5i8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37I8wj8c119775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 03:58:45 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 03:58:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 03:58:45 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37I8wdeh043219;
        Fri, 18 Aug 2023 03:58:40 -0500
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <tiwai@suse.de>
CC:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <mengdong.lin@intel.com>, <baojun.xu@ti.com>,
        <thomas.gfeller@q-drop.com>, <peeyush@ti.com>, <navada@ti.com>,
        <broonie@kernel.org>, <gentuser@gmail.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v4 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Date:   Fri, 18 Aug 2023 16:58:35 +0800
Message-ID: <20230818085836.1442-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate tas2781 configs for Lenovo Laptops. All of the tas2781s in the
laptop will be aggregated as one audio device. The code support realtek
as the primary codec. Rename "struct cs35l41_dev_name" to
"struct scodec_dev_name" for all other side codecs instead of the certain
one.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v4:
 - | Reported-by: kernel test robot <lkp@intel.com>
   | Closes:
   | https://lore.kernel.org/oe-kbuild-all/202308172137.SthCPFbA-lkp@intel.
   | com/
 - remove workaround code for 0x17aa38be, laptop vendor will fix it in acpi.
 - rename comp_match_tas2781_dev_name to avoid indentation
 - simplify the check of vendor id with Lenovo
 - ThinkPad is one of Lenovo's brands, I was suggested me to use
   ALC269_FIXUP_THINKPAD_ACPI.
 - Add comments on ACARD_SINGLE_RANGE_EXT_TLV
 - Add the range check for tas_priv->tasdevice[] in tas2781_acpi_get_i2c_res.
 - remove acpi_subsystem_id
 - Issue in Laptop 0x17aa38be ACPI talbe caused codec->bus->pci->subsystem_device
   is not equal to (codec->core.subsystem_id & 0xffff) in snd_hda_pick_fixup.
   The former is 0x3802 and the latter is 0x38be leads to getting the wrong
   fixup_id and enter into the wrong entry. Although, this issue has been raised
   to the laptop manufacturer, but the ACPI table is locked, cannot be changed
   any more. Correct the wrong entry in the code.
 - Rename "struct cs35l41_dev_name" to "struct scodec_dev_name" for all
   other side codecs instead of one certain codec.
 - Ignore the checkpatch complaints in alc269_fixup_tbl
 - Drop the hunk which is irrelevant with my code in
   alc_fixup_headset_mode_alc255_no_hp_mic
 - Add tiwai@suse.de into Cc list
 - remove useless index
 - combine ALC287_FIXUP_TAS2781_I2C_2 and ALC287_FIXUP_TAS2781_I2C_4 together as
   ALC287_FIXUP_TAS2781_I2C, The code view all the tas2781s in the laptop as one instance.
 - delete the white space at the end of the line in alc_fixup_headset_mode_alc255_no_hp_mic
---
 sound/pci/hda/patch_realtek.c | 88 +++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 44fccfb93cff..ba1b02ed184a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6721,7 +6721,7 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 	}
 }
 
-struct cs35l41_dev_name {
+struct scodec_dev_name {
 	const char *bus;
 	const char *hid;
 	int index;
@@ -6730,7 +6730,7 @@ struct cs35l41_dev_name {
 /* match the device name in a slightly relaxed manner */
 static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 {
-	struct cs35l41_dev_name *p = data;
+	struct scodec_dev_name *p = data;
 	const char *d = dev_name(dev);
 	int n = strlen(p->bus);
 	char tmp[32];
@@ -6746,12 +6746,32 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 	return !strcmp(d + n, tmp);
 }
 
+static int comp_match_tas2781_dev_name(struct device *dev,
+	void *data)
+{
+	struct scodec_dev_name *p = data;
+	const char *d = dev_name(dev);
+	int n = strlen(p->bus);
+	char tmp[32];
+
+	/* check the bus name */
+	if (strncmp(d, p->bus, n))
+		return 0;
+	/* skip the bus number */
+	if (isdigit(d[n]))
+		n++;
+	/* the rest must be exact matching */
+	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
+
+	return !strcmp(d + n, tmp);
+}
+
 static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
 				  const char *hid, int count)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	struct cs35l41_dev_name *rec;
+	struct scodec_dev_name *rec;
 	int ret, i;
 
 	switch (action) {
@@ -6779,6 +6799,41 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 	}
 }
 
+static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
+	const char *bus, const char *hid)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct alc_spec *spec = cdc->spec;
+	struct scodec_dev_name *rec;
+	int ret;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
+		if (!rec)
+			return;
+		rec->bus = bus;
+		rec->hid = hid;
+		rec->index = 0;
+		spec->comps[0].codec = cdc;
+		component_match_add(dev, &spec->match,
+			comp_match_tas2781_dev_name, rec);
+		ret = component_master_add_with_match(dev, &comp_master_ops,
+			spec->match);
+		if (ret)
+			codec_err(cdc,
+				"Fail to register component aggregator %d\n",
+				ret);
+		else
+			spec->gen.pcm_playback_hook =
+				comp_generic_playback_hook;
+		break;
+	case HDA_FIXUP_ACT_FREE:
+		component_master_del(dev, &comp_master_ops);
+		break;
+	}
+}
+
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 2);
@@ -6806,6 +6861,12 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0101", 2);
 }
 
+static void tas2781_fixup_i2c(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -7231,6 +7292,7 @@ enum {
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	ALC287_FIXUP_TAS2781_I2C,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9309,6 +9371,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC287_FIXUP_TAS2781_I2C] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_i2c,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9884,6 +9952,20 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual powe mode2 YC", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38c3, "Y980 DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38cb, "Y790 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.34.1

