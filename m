Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335CA780791
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353582AbjHRI5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358840AbjHRI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:56:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268330E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:56:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37I8u9gp111465;
        Fri, 18 Aug 2023 03:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692348969;
        bh=ycG2s0EH/v+/Q43NwZDY00uESfEcJQueT6IXOQh7MUo=;
        h=From:To:CC:Subject:Date;
        b=UJa9xOJQ3eDxe8m2UDnfBwdUtXLopOP0KcvJYrqT3LklM2FF9DH6kwZ8xT1D5YAI8
         ILqfLGVN7XywbxNJYaa1MXJpuC3Q5yUuM/Hhy24TCMH71vw3DVZ+vNeJzfqGHabmn/
         ZbRTQK2n2cOjN9xNR3JdGG3dWBus+RqdDxh96J9o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37I8u9Ep004374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 03:56:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 03:56:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 03:56:08 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37I8u2aN005166;
        Fri, 18 Aug 2023 03:56:03 -0500
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
Subject: [PATCH v3 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Date:   Fri, 18 Aug 2023 16:55:57 +0800
Message-ID: <20230818085558.1431-1-shenghao-ding@ti.com>
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

Create tas2781 side codec HDA driver for Lenovo Laptops. The quantity
of the speakers has been define in ACPI. All of the tas2781s in the
laptop will be aggregated as one audio speaker. The code supports
realtek codec as the primary codec. Code offers several controls for
digtial/analog gain setting during playback, and other for eq params
setting in case of different audio profiles, such as music, voice,
movie, etc.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v3:
 - oprimize the indentation
 - fix the ambiguous error message
 - The check of the given value to kcontrol's put func is in the sound/tas2781-comlib.c
 - In tasdevice_info_programs, corrected max value
 - Seperate snd_kcontrol_new tas2781_dsp_controls into two standalone kcontrol.
 - All the controls set as const static
 - Add static for page_array & rgno_array
 - Remove uncessary blank lines
 - Add descriptions for tas2781_save_calibration
 - remove global addr handling in the code
 - checking subid in switch statement in function tas2781_hda_bind
 - add force firmware load Kcontrol
 - rename the kcontrol name to be more undertandable
 - remove Superfluous cast in tasdevice_fw_ready
 - correct weird line break in function tas2781_acpi_get_i2c_resource
 - correct Referencing adev after acpi_dev_put() in tas2781_hda_read_acpi
 - As to checking the given value in tasdevice_set_profile_id, it seems done
   by the tasdevice_info_profile
 - replace strcpy with strscpy in tas2781_hda_read_acpi
 - rewrite the subid judgement
 - Add tiwai@suse.de into Cc list
 - remove the cast in tas2781_acpi_get_i2c_resource
 - remove else in tas2781_acpi_get_i2c_resource
 - fix the return value in tasdevice_set_profile_id
 - remove unneeded NL in tasdevice_config_get
 - Unifiy the comment style
 - remove ret = 0 in tasdevice_fw_ready
 - remove ret in tas2781_save_calibration
 - remove unused ret in tas2781_hda_playback
 - add force firmware load Kcontrol
---
 sound/pci/hda/Kconfig           |  15 +
 sound/pci/hda/Makefile          |   2 +
 sound/pci/hda/tas2781_hda_i2c.c | 858 ++++++++++++++++++++++++++++++++
 3 files changed, 875 insertions(+)
 create mode 100644 sound/pci/hda/tas2781_hda_i2c.c

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 886255a03e8b..e66257277492 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -130,6 +130,21 @@ config SND_HDA_SCODEC_CS35L41_SPI
 comment "Set to Y if you want auto-loading the side codec driver"
 	depends on SND_HDA=y && SND_HDA_SCODEC_CS35L41_SPI=m
 
+config SND_HDA_SCODEC_TAS2781_I2C
+	tristate "Build TAS2781 HD-audio side codec support for I2C Bus"
+	depends on I2C
+	depends on ACPI
+	depends on SND_SOC
+	select SND_SOC_TAS2781_COMLIB
+	select SND_SOC_TAS2781_FMWLIB
+	select CRC32_SARWATE
+	help
+	  Say Y or M here to include TAS2781 I2C HD-audio side codec support
+	  in snd-hda-intel driver, such as ALC287.
+
+comment "Set to Y if you want auto-loading the side codec driver"
+	depends on SND_HDA=y && SND_HDA_SCODEC_TAS2781_I2C=m
+
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 00d306104484..1c76609690d6 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -32,6 +32,7 @@ snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o
 snd-hda-scodec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-objs :=	cs35l41_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
+snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
@@ -56,6 +57,7 @@ obj-$(CONFIG_SND_HDA_SCODEC_CS35L41) += snd-hda-scodec-cs35l41.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_I2C) += snd-hda-scodec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_SPI) += snd-hda-scodec-cs35l41-spi.o
 obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
+obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_I2C) += snd-hda-scodec-tas2781-i2c.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
new file mode 100644
index 000000000000..4ccbe12ad451
--- /dev/null
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// TAS2781 HDA I2C driver
+//
+// Copyright 2023 Texas Instruments, Inc.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+
+#include <linux/acpi.h>
+#include <linux/crc8.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/hda_codec.h>
+#include <sound/soc.h>
+#include <sound/tas2781.h>
+#include <sound/tlv.h>
+#include <sound/tas2781-tlv.h>
+
+#include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_component.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+
+#define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
+
+/* No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD
+ * Define two controls, one is Volume control callbacks, the other is
+ * flag setting control callbacks.
+ */
+
+/* Volume control callbacks for tas2781 */
+#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinvert, \
+	xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_range, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xreg, .shift = xshift, \
+		 .rshift = xshift, .min = xmin, .max = xmax, \
+		 .invert = xinvert} }
+
+/* Flag control callbacks for tas2781 */
+#define ACARD_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = xname, \
+	.info = snd_ctl_boolean_mono_info, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = xdata }
+
+enum calib_data {
+	R0_VAL = 0,
+	INV_R0,
+	R0LOW,
+	POWER,
+	TLIM,
+	CALIB_MAX
+};
+
+static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
+{
+	struct tasdevice_priv *tas_priv = data;
+	struct acpi_resource_i2c_serialbus *sb;
+
+	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
+		if (tas_priv->ndev < TASDEVICE_MAX_CHANNELS &&
+			sb->slave_address != TAS2781_GLOBAL_ADDR) {
+			tas_priv->tasdevice[tas_priv->ndev].dev_addr =
+				(unsigned int)sb->slave_address;
+			tas_priv->ndev++;
+		}
+	}
+	return 1;
+}
+
+static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
+{
+	struct acpi_device *adev;
+	struct device *physdev;
+	LIST_HEAD(resources);
+	const char *sub;
+	int ret;
+
+	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+	if (!adev) {
+		dev_err(p->dev,
+			"Failed to find an ACPI device for %s\n", hid);
+		return -ENODEV;
+	}
+
+	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
+	if (ret < 0)
+		goto err;
+
+	acpi_dev_free_resource_list(&resources);
+	strscpy(p->dev_name, hid, sizeof(p->dev_name));
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+
+	/* No side-effect to the playback even if subsystem_id is NULL*/
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub))
+		sub = NULL;
+
+	p->acpi_subsystem_id = sub;
+
+	put_device(physdev);
+
+	return 0;
+
+err:
+	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
+	put_device(physdev);
+
+	return ret;
+}
+
+static void tas2781_hda_playback_hook(struct device *dev, int action)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+
+	dev_dbg(tas_priv->dev, "%s: action = %d\n", __func__, action);
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		mutex_lock(&tas_priv->codec_lock);
+		tasdevice_tuning_switch(tas_priv, 0);
+		mutex_unlock(&tas_priv->codec_lock);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		mutex_lock(&tas_priv->codec_lock);
+		tasdevice_tuning_switch(tas_priv, 1);
+		mutex_unlock(&tas_priv->codec_lock);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		break;
+	default:
+		dev_dbg(tas_priv->dev, "Playback action not supported: %d\n",
+			action);
+		break;
+	}
+}
+
+static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_priv->rcabin.ncfgs - 1;
+
+	return 0;
+}
+
+static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
+
+	return 0;
+}
+
+static int tasdevice_hda_clamp(int val, int max)
+{
+	if (val > max)
+		val = max;
+
+	if (val < 0)
+		val = 0;
+	return val;
+}
+
+static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	int nr_profile = ucontrol->value.integer.value[0];
+	int max = tas_priv->rcabin.ncfgs - 1;
+	int val, ret = 0;
+
+	val = tasdevice_hda_clamp(nr_profile, max);
+
+	if (tas_priv->rcabin.profile_cfg_id != nr_profile) {
+		tas_priv->rcabin.profile_cfg_id = nr_profile;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_fw->nr_programs - 1;
+
+	return 0;
+}
+
+static int tasdevice_info_config(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_fw->nr_configurations - 1;
+
+	return 0;
+}
+
+static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->cur_prog;
+
+	return 0;
+}
+
+static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+	int nr_program = ucontrol->value.integer.value[0];
+	int max = tas_fw->nr_programs - 1;
+	int val, ret = 0;
+
+	val = tasdevice_hda_clamp(nr_program, max);
+
+	if (tas_priv->cur_prog != nr_program) {
+		tas_priv->cur_prog = nr_program;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
+
+	return 0;
+}
+
+static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+	int nr_config = ucontrol->value.integer.value[0];
+	int max = tas_fw->nr_configurations - 1;
+	int val, ret = 0;
+
+	val = tasdevice_hda_clamp(nr_config, max);
+
+	if (tas_priv->cur_conf != nr_config) {
+		tas_priv->cur_conf = nr_config;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+/*
+ * tas2781_digital_getvol - get the volum control
+ * @kcontrol: control pointer
+ * @ucontrol: User data
+ * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
+ * depends on internal regmap mechanism.
+ * tas2781 contains book and page two-level register map, especially
+ * book switching will set the register BXXP00R7F, after switching to the
+ * correct book, then leverage the mechanism for paging to access the
+ * register.
+ */
+static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_digital_getvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_amp_getvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	/* The check of the given value is in tasdevice_digital_putvol. */
+	return tasdevice_digital_putvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	/* The check of the given value is in tasdevice_amp_putvol. */
+	return tasdevice_amp_putvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_force_fwload_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = (int)tas_priv->force_fwload_status;
+	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
+			tas_priv->force_fwload_status ? "ON" : "OFF");
+
+	return 0;
+}
+
+static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	bool change, val = (bool)ucontrol->value.integer.value[0];
+
+	if (tas_priv->force_fwload_status == val)
+		change = false;
+	else {
+		change = true;
+		tas_priv->force_fwload_status = val;
+	}
+	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
+		tas_priv->force_fwload_status ? "ON" : "OFF");
+
+	return change;
+}
+
+static const struct snd_kcontrol_new tas2781_snd_controls[] = {
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
+		1, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, amp_vol_tlv),
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
+		0, 0, 200, 1, tas2781_digital_getvol,
+		tas2781_digital_putvol, dvc_tlv),
+	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
+		tas2781_force_fwload_get, tas2781_force_fwload_put),
+};
+
+static const struct snd_kcontrol_new tas2781_prof_ctrl = {
+	.name = "Speaker Profile Id",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = tasdevice_info_profile,
+	.get = tasdevice_get_profile_id,
+	.put = tasdevice_set_profile_id,
+};
+
+static const struct snd_kcontrol_new tas2781_dsp_prog_ctrl = {
+	.name = "Speaker Program Id",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = tasdevice_info_programs,
+	.get = tasdevice_program_get,
+	.put = tasdevice_program_put,
+};
+
+static const struct snd_kcontrol_new tas2781_dsp_conf_ctrl = {
+	.name = "Speaker Config Id",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = tasdevice_info_config,
+	.get = tasdevice_config_get,
+	.put = tasdevice_config_put,
+};
+
+static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
+{
+	static const unsigned char page_array[CALIB_MAX] = {
+		0x17, 0x18, 0x18, 0x0d, 0x18
+	};
+	static const unsigned char rgno_array[CALIB_MAX] = {
+		0x74, 0x0c, 0x14, 0x3c, 0x7c
+	};
+	unsigned char *data;
+	int i, j, rc;
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		data = tas_priv->cali_data.data +
+			i * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+		for (j = 0; j < CALIB_MAX; j++) {
+			rc = tasdevice_dev_bulk_write(tas_priv, i,
+				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
+				&(data[4 * j]), 4);
+			if (rc < 0)
+				dev_err(tas_priv->dev,
+					"chn %d calib %d bulk_wr err = %d\n",
+					i, j, rc);
+		}
+	}
+}
+
+/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
+ * Calibrate data is done by manufacturer in the factory. These data are used
+ * by Algo for calucating the speaker temperature, speaker membrance excursion
+ * and f0 in real time during playback.
+ */
+static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
+{
+	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
+		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static efi_char16_t efi_name[] = L"CALI_DATA";
+	struct tm *tm = &tas_priv->tm;
+	unsigned int attr, crc;
+	unsigned int *tmp_val;
+	efi_status_t status;
+
+	/* Lenovo devices */
+	if (tas_priv->catlog_id == LENOVO)
+		efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
+			0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
+
+	tas_priv->cali_data.total_sz = 0;
+	/* Get real size of UEFI variable */
+	status = efi.get_variable(efi_name, &efi_guid, &attr,
+		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		/* Allocate data buffer of data_size bytes */
+		tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
+			tas_priv->cali_data.total_sz, GFP_KERNEL);
+		if (!tas_priv->cali_data.data)
+			return -ENOMEM;
+		/* Get variable contents into buffer */
+		status = efi.get_variable(efi_name, &efi_guid, &attr,
+			&tas_priv->cali_data.total_sz,
+			tas_priv->cali_data.data);
+		if (status != EFI_SUCCESS)
+			return -EINVAL;
+	}
+
+	tmp_val = (unsigned int *)tas_priv->cali_data.data;
+
+	crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
+	dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+		crc, tmp_val[21]);
+
+	if (crc == tmp_val[21]) {
+		time64_to_tm(tmp_val[20], 0, tm);
+		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
+			tm->tm_year, tm->tm_mon, tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		tas2781_apply_calib(tas_priv);
+	} else
+		tas_priv->cali_data.total_sz = 0;
+
+	return 0;
+}
+
+static void tasdev_fw_ready(const struct firmware *fmw, void *context)
+{
+	struct tasdevice_priv *tas_priv = context;
+	struct hda_codec *codec = tas_priv->codec;
+	int i, ret;
+
+	pm_runtime_get_sync(tas_priv->dev);
+	mutex_lock(&tas_priv->codec_lock);
+
+	ret = tasdevice_rca_parser(tas_priv, fmw);
+	if (ret)
+		goto out;
+
+	ret = snd_ctl_add(codec->card,
+		snd_ctl_new1(&tas2781_prof_ctrl, tas_priv));
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to add KControl %s = %d\n",
+			tas2781_prof_ctrl.name, ret);
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
+		ret = snd_ctl_add(codec->card,
+			snd_ctl_new1(&tas2781_snd_controls[i], tas_priv));
+		if (ret) {
+			dev_err(tas_priv->dev,
+				"Failed to add KControl %s = %d\n",
+				tas2781_snd_controls[i].name, ret);
+			goto out;
+		}
+	}
+
+	tasdevice_dsp_remove(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
+		codec->core.subsystem_id & 0xffff);
+	ret = tasdevice_dsp_parser(tas_priv);
+	if (ret) {
+		dev_err(tas_priv->dev, "dspfw load %s error\n",
+			tas_priv->coef_binaryname);
+		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+
+	ret = snd_ctl_add(codec->card,
+		snd_ctl_new1(&tas2781_dsp_prog_ctrl, tas_priv));
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to add KControl %s = %d\n",
+			tas2781_dsp_prog_ctrl.name, ret);
+		goto out;
+	}
+
+	ret = snd_ctl_add(codec->card,
+		snd_ctl_new1(&tas2781_dsp_conf_ctrl, tas_priv));
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to add KControl %s = %d\n",
+			tas2781_dsp_conf_ctrl.name, ret);
+		goto out;
+	}
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	tasdevice_prmg_load(tas_priv, 0);
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	tas2781_save_calibration(tas_priv);
+
+out:
+	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
+		/*If DSP FW fail, kcontrol won't be created */
+		tasdevice_config_info_remove(tas_priv);
+		tasdevice_dsp_remove(tas_priv);
+	}
+	mutex_unlock(&tas_priv->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+	pm_runtime_mark_last_busy(tas_priv->dev);
+	pm_runtime_put_autosuspend(tas_priv->dev);
+}
+
+static int tas2781_hda_bind(struct device *dev, struct device *master,
+	void *master_data)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+	struct hda_codec *codec;
+	unsigned int subid;
+	int ret;
+
+	if (!comps || tas_priv->index < 0 ||
+		tas_priv->index >= HDA_MAX_COMPONENTS)
+		return -EINVAL;
+
+	comps = &comps[tas_priv->index];
+	if (comps->dev)
+		return -EBUSY;
+
+	codec = comps->codec;
+	subid = codec->core.subsystem_id >> 16;
+
+	switch (subid) {
+	case 0x17aa:
+		tas_priv->catlog_id = LENOVO;
+		break;
+	default:
+		tas_priv->catlog_id = OTHERS;
+		break;
+	}
+
+	pm_runtime_get_sync(dev);
+
+	comps->dev = dev;
+
+	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
+
+	ret = tascodec_init(tas_priv, codec, tasdev_fw_ready);
+	if (ret)
+		return ret;
+
+	comps->playback_hook = tas2781_hda_playback_hook;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static void tas2781_hda_unbind(struct device *dev,
+	struct device *master, void *master_data)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+
+	if (comps[tas_priv->index].dev == dev)
+		memset(&comps[tas_priv->index], 0, sizeof(*comps));
+
+	tasdevice_config_info_remove(tas_priv);
+	tasdevice_dsp_remove(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+}
+
+static const struct component_ops tas2781_hda_comp_ops = {
+	.bind = tas2781_hda_bind,
+	.unbind = tas2781_hda_unbind,
+};
+
+static void tas2781_hda_remove(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(tas_priv->dev);
+	pm_runtime_disable(tas_priv->dev);
+
+	component_del(tas_priv->dev, &tas2781_hda_comp_ops);
+
+	pm_runtime_put_noidle(tas_priv->dev);
+
+	tasdevice_remove(tas_priv);
+}
+
+static int tas2781_hda_i2c_probe(struct i2c_client *clt)
+{
+	struct tasdevice_priv *tas_priv;
+	const char *device_name;
+	int ret;
+
+	if (strstr(dev_name(&clt->dev), "TIAS2781"))
+		device_name = "TIAS2781";
+	else
+		return -ENODEV;
+
+	tas_priv = tasdevice_kzalloc(clt);
+	if (!tas_priv)
+		return -ENOMEM;
+
+	tas_priv->irq_info.irq = clt->irq;
+	ret = tas2781_read_acpi(tas_priv, device_name);
+	if (ret)
+		return dev_err_probe(tas_priv->dev, ret,
+			"Platform not supported\n");
+
+	ret = tasdevice_init(tas_priv);
+	if (ret)
+		goto err;
+
+	pm_runtime_set_autosuspend_delay(tas_priv->dev, 3000);
+	pm_runtime_use_autosuspend(tas_priv->dev);
+	pm_runtime_mark_last_busy(tas_priv->dev);
+	pm_runtime_set_active(tas_priv->dev);
+	pm_runtime_get_noresume(tas_priv->dev);
+	pm_runtime_enable(tas_priv->dev);
+
+	pm_runtime_put_autosuspend(tas_priv->dev);
+
+	ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
+	if (ret) {
+		dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
+		pm_runtime_disable(tas_priv->dev);
+		goto err;
+	}
+
+	tas2781_reset(tas_priv);
+err:
+	if (ret)
+		tas2781_hda_remove(&clt->dev);
+	return ret;
+}
+
+static void tas2781_hda_i2c_remove(struct i2c_client *clt)
+{
+	tas2781_hda_remove(&clt->dev);
+}
+
+static int tas2781_runtime_suspend(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	int i;
+
+	dev_dbg(tas_priv->dev, "Runtime Suspend\n");
+
+	mutex_lock(&tas_priv->codec_lock);
+
+	if (tas_priv->playback_started) {
+		tasdevice_tuning_switch(tas_priv, 1);
+		tas_priv->playback_started = false;
+	}
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		tas_priv->tasdevice[i].cur_book = -1;
+		tas_priv->tasdevice[i].cur_prog = -1;
+		tas_priv->tasdevice[i].cur_conf = -1;
+	}
+
+	regcache_cache_only(tas_priv->regmap, true);
+	regcache_mark_dirty(tas_priv->regmap);
+
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return 0;
+}
+
+static int tas2781_runtime_resume(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	unsigned long calib_data_sz =
+		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+	int ret;
+
+	dev_dbg(tas_priv->dev, "Runtime Resume\n");
+
+	mutex_lock(&tas_priv->codec_lock);
+
+	regcache_cache_only(tas_priv->regmap, false);
+	ret = regcache_sync(tas_priv->regmap);
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to restore register cache: %d\n", ret);
+		goto out;
+	}
+
+	tasdevice_prmg_load(tas_priv, tas_priv->cur_prog);
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	if (tas_priv->cali_data.total_sz > calib_data_sz)
+		tas2781_apply_calib(tas_priv);
+
+out:
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return ret;
+}
+
+static int tas2781_system_suspend(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(tas_priv->dev, "System Suspend\n");
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Shutdown chip before system suspend */
+	regcache_cache_only(tas_priv->regmap, false);
+	tasdevice_tuning_switch(tas_priv, 1);
+	regcache_cache_only(tas_priv->regmap, true);
+	regcache_mark_dirty(tas_priv->regmap);
+
+	/*
+	 * Reset GPIO may be shared, so cannot reset here.
+	 * However beyond this point, amps may be powered down.
+	 */
+	return 0;
+}
+
+static int tas2781_system_resume(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	unsigned long calib_data_sz =
+		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+	int i, ret;
+
+	dev_dbg(tas_priv->dev, "System Resume\n");
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&tas_priv->codec_lock);
+
+	for (i = 0; i < tas_priv->ndev; i++) {
+		tas_priv->tasdevice[i].cur_book = -1;
+		tas_priv->tasdevice[i].cur_prog = -1;
+		tas_priv->tasdevice[i].cur_conf = -1;
+	}
+	tas2781_reset(tas_priv);
+	tasdevice_prmg_load(tas_priv, tas_priv->cur_prog);
+
+	/* If calibrated data occurs error, dsp will still work with default
+	 * calibrated data inside algo.
+	 */
+	if (tas_priv->cali_data.total_sz > calib_data_sz)
+		tas2781_apply_calib(tas_priv);
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tas2781_hda_pm_ops = {
+	RUNTIME_PM_OPS(tas2781_runtime_suspend, tas2781_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(tas2781_system_suspend, tas2781_system_resume)
+};
+
+static const struct i2c_device_id tas2781_hda_i2c_id[] = {
+	{ "tas2781-hda", 0 },
+	{}
+};
+
+static const struct acpi_device_id tas2781_acpi_hda_match[] = {
+	{"TIAS2781", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
+
+static struct i2c_driver tas2781_hda_i2c_driver = {
+	.driver = {
+		.name		= "tas2781-hda",
+		.acpi_match_table = tas2781_acpi_hda_match,
+		.pm		= &tas2781_hda_pm_ops,
+	},
+	.id_table	= tas2781_hda_i2c_id,
+	.probe_new	= tas2781_hda_i2c_probe,
+	.remove		= tas2781_hda_i2c_remove,
+};
+module_i2c_driver(tas2781_hda_i2c_driver);
+
+MODULE_DESCRIPTION("TAS2781 HDA Driver");
+MODULE_AUTHOR("Shenghao Ding, TI, <shenghao-ding@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_TAS2781_FMWLIB);
-- 
2.34.1

