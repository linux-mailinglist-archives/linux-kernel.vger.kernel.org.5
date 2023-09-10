Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D322799CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbjIJH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjIJH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:28:07 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1381B8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 00:28:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38A7RGoY124287;
        Sun, 10 Sep 2023 02:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694330836;
        bh=cuEQ4MnBvMHeuWnFcZZThMScU6eHr7VCSZ2kRdLbUCU=;
        h=From:To:CC:Subject:Date;
        b=yZKEupIkqUpo76Tx14Ikdm2O/0wWfoUJ2JM8BTa+hyqq924pSO7jlJOtlaDRaeDT9
         t9PyIicAcRM73JpbW0R+3/O5P9hLj2AkkdIsznu9SbFveXK87u5GBoeuZa5o6ciOpl
         ARPuULmEjE1KbETPucxPngBucYntbY42c6HF7AHw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38A7RGJa068077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Sep 2023 02:27:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 02:27:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 02:27:16 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38A7R9Rt002459;
        Sun, 10 Sep 2023 02:27:10 -0500
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
Subject: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and TIAS2781
Date:   Sun, 10 Sep 2023 15:27:03 +0800
Message-ID: <20230910072704.1359-1-shenghao-ding@ti.com>
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

Support ACPI_ID both TXNW2781 and TIAS2781, TXNW2781 is the only one legal
ACPI ID, TIAS2781 is the widely-used ACPI ID named by our customers, so
far it is not registered. We have discussed this with them, they requested
TIAS2781 must be supported for the laptops already released to market,
their new laptops will switch to TXNW2781.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v1:
 - Add TXNW2781 into tas2781_acpi_hda_match and move it to the top
 - Redefine tas2781_generic_fixup, remove hid param
 - TIAS2781 has been used by our customers, see following dstd.dsl. We
    have discussed this with them, they requested TIAS2781 must be
    supported for the laptops already released to market, their new
    laptops will switch to TXNW2781
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
 - Add TXNW2781 support in comp_match_tas2781_dev_name
---
 sound/pci/hda/patch_realtek.c   | 36 ++++++++++++++++++---------------
 sound/pci/hda/tas2781_hda_i2c.c | 33 ++++++++++++++++++------------
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b7e78bfcff..6dae58a8ef 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6770,24 +6770,35 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 	return !strcmp(d + n, tmp);
 }
 
+/* TIAS2781 is the unofficial ACPI id, but widely used in current devices.
+ * TXNW2781 is the official ACPI id, and will be used in the new devices.
+ * Check TIAS2781 or TXNW2781
+ */
 static int comp_match_tas2781_dev_name(struct device *dev,
 	void *data)
 {
-	struct scodec_dev_name *p = data;
+	const char c[][10] = { "TXNW2781", "TIAS2781" };
 	const char *d = dev_name(dev);
-	int n = strlen(p->bus);
+	const char *bus = data;
+	int n = strlen(bus), i;
 	char tmp[32];
 
 	/* check the bus name */
-	if (strncmp(d, p->bus, n))
+	if (strncmp(d, bus, n))
 		return 0;
 	/* skip the bus number */
 	if (isdigit(d[n]))
 		n++;
-	/* the rest must be exact matching */
-	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
 
-	return !strcmp(d + n, tmp);
+	for (i = 0; i < ARRAY_SIZE(c); i++) {
+		/* the rest must be exact matching */
+		snprintf(tmp, sizeof(tmp), "-%s:00", c[i]);
+
+		if (!strcmp(d + n, tmp))
+			return 1;
+	}
+
+	return 0;
 }
 
 static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
@@ -6824,24 +6835,17 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 }
 
 static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
-	const char *bus, const char *hid)
+	const char *bus)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	struct scodec_dev_name *rec;
 	int ret;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
-		if (!rec)
-			return;
-		rec->bus = bus;
-		rec->hid = hid;
-		rec->index = 0;
 		spec->comps[0].codec = cdc;
 		component_match_add(dev, &spec->match,
-			comp_match_tas2781_dev_name, rec);
+			comp_match_tas2781_dev_name, (void *)bus);
 		ret = component_master_add_with_match(dev, &comp_master_ops,
 			spec->match);
 		if (ret)
@@ -6888,7 +6892,7 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
-	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
+	 tas2781_generic_fixup(cdc, action, "i2c");
 }
 
 /* for alc295_fixup_hp_top_speakers */
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb80280293..8493952305 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -65,6 +65,16 @@ enum calib_data {
 	CALIB_MAX
 };
 
+/* TIAS2781 is the unofficial ACPI id, but widely used in current devices.
+ * TXNW2781 is the official ACPI id, and will be used in the new devices.
+ */
+static const struct acpi_device_id tas2781_acpi_hda_match[] = {
+	{"TIAS2781", 0 },
+	{"TXNW2781", 1 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
+
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 {
 	struct tasdevice_priv *tas_priv = data;
@@ -644,20 +654,23 @@ static void tas2781_hda_remove(struct device *dev)
 static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 {
 	struct tasdevice_priv *tas_priv;
-	const char *device_name;
-	int ret;
+	int ret, i;
 
-	if (strstr(dev_name(&clt->dev), "TIAS2781"))
-		device_name = "TIAS2781";
-	else
-		return -ENODEV;
+	/* Check TIAS2781 or TXNW2781 */
+	for (i = 0; i < ARRAY_SIZE(tas2781_acpi_hda_match); i++)
+		if (strstr(dev_name(&clt->dev), tas2781_acpi_hda_match[i].id))
+			break;
+
+	if (i == ARRAY_SIZE(tas2781_acpi_hda_match))
+		return dev_err_probe(tas_priv->dev, -ENODEV,
+			"Device not available\n");
 
 	tas_priv = tasdevice_kzalloc(clt);
 	if (!tas_priv)
 		return -ENOMEM;
 
 	tas_priv->irq_info.irq = clt->irq;
-	ret = tas2781_read_acpi(tas_priv, device_name);
+	ret = tas2781_read_acpi(tas_priv, tas2781_acpi_hda_match[i].id);
 	if (ret)
 		return dev_err_probe(tas_priv->dev, ret,
 			"Platform not supported\n");
@@ -822,12 +835,6 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 	{}
 };
 
-static const struct acpi_device_id tas2781_acpi_hda_match[] = {
-	{"TIAS2781", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
-
 static struct i2c_driver tas2781_hda_i2c_driver = {
 	.driver = {
 		.name		= "tas2781-hda",
-- 
2.34.1

