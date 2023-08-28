Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5378A49D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjH1C2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjH1C2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:28:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DABDA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:28:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S2QBas086370;
        Sun, 27 Aug 2023 21:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693189571;
        bh=Hk//BWZ1e/bzt5of6gi0vR8ytN64Vt0QIGtlPpsxfSo=;
        h=From:To:CC:Subject:Date;
        b=F4SBhjD9z6WdJ/QHdJH6sCuNR2KtUEjRroETtP5VIvL+zcUlKzwIBB+Aw0H8CtJ77
         C1YgfeCROywLsLkWKpRoZggY7aIS2XR9HjPagMA+BunddHvnYpR9jAK2uYy11wBc3X
         VMB7RDttNdUdh41+T6SUJDWivsk3JOy5A1bqKanw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S2QBlv049771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Aug 2023 21:26:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Aug 2023 21:26:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Aug 2023 21:26:10 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S2Q46f130660;
        Sun, 27 Aug 2023 21:26:05 -0500
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <tiwai@suse.de>
CC:     <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <mengdong.lin@intel.com>, <baojun.xu@ti.com>,
        <thomas.gfeller@q-drop.com>, <peeyush@ti.com>, <navada@ti.com>,
        <broonie@kernel.org>, <gentuser@gmail.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v5 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Date:   Mon, 28 Aug 2023 10:25:55 +0800
Message-ID: <20230828022556.578-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate tas2781 configs for Lenovo Laptops. All of the tas2781s in the
laptop will be aggregated as one audio device. The code support realtek
as the primary codec.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v5:
 - Redefine tas2781_generic_fixup, remove hid param
 - TIAS2781 has been used by our customers, see following dstd.dsl. We have
   discussed this with them, they requested TIAS2781 must be supported for
   the laptops already released to market, their new laptop can switch to
   TXNW2781
   Name (_HID, "TIAS2781")  // _HID: Hardware ID
   Name (_UID, Zero)  // _UID: Unique ID
   Method (_SUB, 0, NotSerialized)  // _SUB: Subsystem ID
   {
       If ((SPID == Zero))
       {
          Return ("17AA3886")
       }

       If ((SPID == One))
       {
           Return ("17AA3884")
       }
   }
 - rename calib_data properly
 - use clamp instead of tas2781_hda_clamp
 - Add TXNW2781 support in comp_match_tas2781_dev_name
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
 - Undo Rename "struct cs35l41_dev_name" to "struct scodec_dev_name" for all, this
   data structure seemed useless any more for tas2781
 - Ignore the checkpatch complaints in alc269_fixup_tbl
 - Drop the hunk which is irrelevant with my code in
   alc_fixup_headset_mode_alc255_no_hp_mic
 - Add tiwai@suse.de into Cc list
 - remove useless index
 - combine ALC287_FIXUP_TAS2781_I2C_2 and ALC287_FIXUP_TAS2781_I2C_4 together as
   ALC287_FIXUP_TAS2781_I2C, The code view all the tas2781s in the laptop as one instance.
 - delete the white space at the end of the line in alc_fixup_headset_mode_alc255_no_hp_mic
---
 sound/pci/hda/patch_realtek.c | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc7b7a407638..02f03686c742 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6746,6 +6746,32 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 	return !strcmp(d + n, tmp);
 }
 
+static int comp_match_tas2781_dev_name(struct device *dev,
+	void *data)
+{
+	const char *bus = data;
+	const char *d = dev_name(dev);
+	int n = strlen(bus);
+	char tmp[32];
+
+	/* check the bus name */
+	if (strncmp(d, bus, n))
+		return 0;
+	/* skip the bus number */
+	if (isdigit(d[n]))
+		n++;
+	/* the rest must be exact matching */
+	snprintf(tmp, sizeof(tmp), "-%s:00", "TXNW2781");
+
+	if (!strcmp(d + n, tmp))
+		return 1;
+
+	/* the rest must be exact matching */
+	snprintf(tmp, sizeof(tmp), "-%s:00", "TIAS2781");
+
+	return !strcmp(d + n, tmp);
+}
+
 static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
 				  const char *hid, int count)
 {
@@ -6779,6 +6805,34 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 	}
 }
 
+static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
+	const char *bus)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct alc_spec *spec = cdc->spec;
+	int ret;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->comps[0].codec = cdc;
+		component_match_add(dev, &spec->match,
+			comp_match_tas2781_dev_name, (void *)bus);
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
@@ -6806,6 +6860,12 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0101", 2);
 }
 
+static void tas2781_fixup_i2c(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	 tas2781_generic_fixup(cdc, action, "i2c");
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -7231,6 +7291,7 @@ enum {
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	ALC287_FIXUP_TAS2781_I2C,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9309,6 +9370,12 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -9889,6 +9956,20 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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

