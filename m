Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72927CE5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjJRR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjJRR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:58:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB03D52;
        Wed, 18 Oct 2023 10:57:59 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39I6HpUY023598;
        Wed, 18 Oct 2023 12:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=wqzo3bJq7VNVz3wf1nhTcWoiQ9cewNW6y6XZXvnNUZg=; b=
        GAgnEDoiR/78eDx1LggH0kwCga2tib+bRT/yyB9IqVef1wVpyRXLN9UqJn84rroz
        FujPhXGUyYiWgwelAMkZaX7PhTIasoen5qaPYoTmn/1CV4YeGiTGAN9m4tuWT4P5
        5Ksa7Qk19X/CBKB7qv3lRVtwWcIAs+wQxMrhBPU6wU70pvMK034BqHemm9+Ae8Ak
        1RTS/QQF0pw3FD0NXK2cVs9HrM17ffyTL+eTzrWtZgI+aAdXQFk3yk7RGBS+YIvb
        aBe9PsuC8DrUuJHXgcwkXwJTRg5/tiKHoXzxJp8D2OgH8pcsq9Msd41mxPVG5znR
        eYDvCqs8nCki/VMPxTzcyA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tqrcw6n73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 12:57:54 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 18 Oct
 2023 18:57:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 18 Oct 2023 18:57:52 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 33AC9458;
        Wed, 18 Oct 2023 17:57:51 +0000 (UTC)
From:   James Ogletree <james.ogletree@opensource.cirrus.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/4] Input: cs40l50 - Add support for the CS40L50 haptic driver
Date:   Wed, 18 Oct 2023 17:57:25 +0000
Message-ID: <20231018175726.3879955-5-james.ogletree@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HS4ios6yjPXTA-cXMRGegKvyjDGwX2vR
X-Proofpoint-ORIG-GUID: HS4ios6yjPXTA-cXMRGegKvyjDGwX2vR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ogletree <james.ogletree@cirrus.com>

Introduce support for Cirrus Logic Device CS40L50: a
haptic driver with waveform memory, integrated DSP,
and closed-loop algorithms.

The input driver provides the interface for control of
haptic effects through the device.

Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
---
 MAINTAINERS                        |   1 +
 drivers/input/misc/Kconfig         |  10 +
 drivers/input/misc/Makefile        |   1 +
 drivers/input/misc/cs40l50-vibra.c | 353 +++++++++++++++++++++++++++++
 4 files changed, 365 insertions(+)
 create mode 100644 drivers/input/misc/cs40l50-vibra.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 08e1e9695d49..24a00d8e5c1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4971,6 +4971,7 @@ L:	patches@opensource.cirrus.com
 S:	Supported
 F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 F:	drivers/input/misc/cirrus*
+F:	drivers/input/misc/cs40l*
 F:	drivers/mfd/cs40l*
 F:	include/linux/input/cirrus*
 F:	include/linux/mfd/cs40l*
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f088900f863..938090648126 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -129,6 +129,16 @@ config INPUT_BMA150
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma150.
 
+config INPUT_CS40L50_VIBRA
+	tristate "CS40L50 Haptic Driver support"
+	depends on MFD_CS40L50_CORE
+	help
+	  Say Y here to enable support for Cirrus Logic's CS40L50
+	  haptic driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cs40l50-vibra.
+
 config INPUT_E3X0_BUTTON
 	tristate "NI Ettus Research USRP E3xx Button support."
 	default n
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 6abefc41037b..6b653ed2124f 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
+obj-$(CONFIG_INPUT_CS40L50_VIBRA)	+= cs40l50-vibra.o cirrus_haptics.o
 obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
new file mode 100644
index 000000000000..3b3e4cb10de0
--- /dev/null
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS40L50 Advanced Haptic Driver with waveform memory,
+ * integrated DSP, and closed-loop algorithms
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ */
+
+#include <linux/firmware/cirrus/wmfw.h>
+#include <linux/mfd/cs40l50.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+static int cs40l50_add(struct input_dev *dev,
+		       struct ff_effect *effect,
+		       struct ff_effect *old)
+{
+	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
+	u32 len = effect->u.periodic.custom_len;
+
+	if (effect->type != FF_PERIODIC || effect->u.periodic.waveform != FF_CUSTOM) {
+		dev_err(cs40l50->dev, "Type (%#X) or waveform (%#X) unsupported\n",
+			effect->type, effect->u.periodic.waveform);
+		return -EINVAL;
+	}
+
+	memcpy(&cs40l50->haptics.add_effect, effect, sizeof(struct ff_effect));
+
+	cs40l50->haptics.add_effect.u.periodic.custom_data = kcalloc(len,
+								     sizeof(s16),
+								     GFP_KERNEL);
+	if (!cs40l50->haptics.add_effect.u.periodic.custom_data)
+		return -ENOMEM;
+
+	if (copy_from_user(cs40l50->haptics.add_effect.u.periodic.custom_data,
+			   effect->u.periodic.custom_data, sizeof(s16) * len)) {
+		cs40l50->haptics.add_error = -EFAULT;
+		goto out_free;
+	}
+
+	queue_work(cs40l50->haptics.vibe_wq, &cs40l50->haptics.add_work);
+	flush_work(&cs40l50->haptics.add_work);
+
+out_free:
+	kfree(cs40l50->haptics.add_effect.u.periodic.custom_data);
+	cs40l50->haptics.add_effect.u.periodic.custom_data = NULL;
+
+	return cs40l50->haptics.add_error;
+}
+
+static int cs40l50_playback(struct input_dev *dev, int effect_id, int val)
+{
+	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
+
+	if (val > 0) {
+		cs40l50->haptics.start_effect = &dev->ff->effects[effect_id];
+		queue_work(cs40l50->haptics.vibe_wq,
+			   &cs40l50->haptics.vibe_start_work);
+	} else {
+		queue_work(cs40l50->haptics.vibe_wq,
+			   &cs40l50->haptics.vibe_stop_work);
+	}
+
+	return 0;
+}
+
+static int cs40l50_erase(struct input_dev *dev, int effect_id)
+{
+	struct cs40l50_private *cs40l50 = input_get_drvdata(dev);
+
+	cs40l50->haptics.erase_effect = &dev->ff->effects[effect_id];
+
+	queue_work(cs40l50->haptics.vibe_wq, &cs40l50->haptics.erase_work);
+	flush_work(&cs40l50->haptics.erase_work);
+
+	return cs40l50->haptics.erase_error;
+}
+
+static const struct reg_sequence cs40l50_int_vamp_seq[] = {
+	{ CS40L50_BST_LPMODE_SEL,	CS40L50_DCM_LOW_POWER },
+	{ CS40L50_BLOCK_ENABLES2,	CS40L50_OVERTEMP_WARN },
+};
+
+static const struct reg_sequence cs40l50_irq_mask_seq[] = {
+	{ CS40L50_IRQ1_MASK_2,	CS40L50_IRQ_MASK_2_OVERRIDE },
+	{ CS40L50_IRQ1_MASK_20,	CS40L50_IRQ_MASK_20_OVERRIDE },
+};
+
+static int cs40l50_hw_init(struct cs40l50_private *cs40l50)
+{
+	int error;
+
+	error = regmap_multi_reg_write(cs40l50->regmap,
+				       cs40l50_int_vamp_seq,
+				       ARRAY_SIZE(cs40l50_int_vamp_seq));
+	if (error)
+		return error;
+
+	error = cs_hap_pseq_multi_write(&cs40l50->haptics,
+					cs40l50_int_vamp_seq,
+					ARRAY_SIZE(cs40l50_int_vamp_seq),
+					false, PSEQ_OP_WRITE_FULL);
+	if (error)
+		return error;
+
+	error = regmap_multi_reg_write(cs40l50->regmap, cs40l50_irq_mask_seq,
+				       ARRAY_SIZE(cs40l50_irq_mask_seq));
+	if (error)
+		return error;
+
+	return cs_hap_pseq_multi_write(&cs40l50->haptics, cs40l50_irq_mask_seq,
+				       ARRAY_SIZE(cs40l50_irq_mask_seq), false,
+				       PSEQ_OP_WRITE_FULL);
+}
+
+static const struct cs_dsp_client_ops cs40l50_cs_dsp_client_ops;
+
+static const struct cs_dsp_region cs40l50_dsp_regions[] = {
+	{
+		.type = WMFW_HALO_PM_PACKED,
+		.base = CS40L50_DSP1_PMEM_0
+	},
+	{
+		.type = WMFW_HALO_XM_PACKED,
+		.base = CS40L50_DSP1_XMEM_PACKED_0
+	},
+	{
+		.type = WMFW_HALO_YM_PACKED,
+		.base = CS40L50_DSP1_YMEM_PACKED_0
+	},
+	{
+		.type = WMFW_ADSP2_XM,
+		.base = CS40L50_DSP1_XMEM_UNPACKED24_0
+	},
+	{
+		.type = WMFW_ADSP2_YM,
+		.base = CS40L50_DSP1_YMEM_UNPACKED24_0
+	},
+};
+
+static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
+{
+	cs40l50->dsp.num = 1;
+	cs40l50->dsp.type = WMFW_HALO;
+	cs40l50->dsp.dev = cs40l50->dev;
+	cs40l50->dsp.regmap = cs40l50->regmap;
+	cs40l50->dsp.base = CS40L50_CORE_BASE;
+	cs40l50->dsp.base_sysinfo = CS40L50_SYS_INFO_ID;
+	cs40l50->dsp.mem = cs40l50_dsp_regions;
+	cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
+	cs40l50->dsp.no_core_startstop = true;
+	cs40l50->dsp.client_ops = &cs40l50_cs_dsp_client_ops;
+
+	return cs_dsp_halo_init(&cs40l50->dsp);
+}
+
+static struct cs_hap_bank cs40l50_banks[] = {
+	{
+		.bank =		WVFRM_BANK_RAM,
+		.base_index =	CS40L50_RAM_BANK_INDEX_START,
+		.max_index =	CS40L50_RAM_BANK_INDEX_START,
+	},
+	{
+		.bank =		WVFRM_BANK_ROM,
+		.base_index =	CS40L50_ROM_BANK_INDEX_START,
+		.max_index =	CS40L50_ROM_BANK_INDEX_END,
+	},
+	{
+		.bank =		WVFRM_BANK_OWT,
+		.base_index =	CS40L50_RTH_INDEX_START,
+		.max_index =	CS40L50_RTH_INDEX_END,
+	},
+};
+
+static int cs40l50_cs_hap_init(struct cs40l50_private *cs40l50)
+{
+	cs40l50->haptics.regmap = cs40l50->regmap;
+	cs40l50->haptics.dev = cs40l50->dev;
+	cs40l50->haptics.banks = cs40l50_banks;
+	cs40l50->haptics.dsp.gpio_base_reg = CS40L50_GPIO_BASE;
+	cs40l50->haptics.dsp.owt_base_reg = CS40L50_OWT_BASE;
+	cs40l50->haptics.dsp.owt_offset_reg = CS40L50_OWT_NEXT;
+	cs40l50->haptics.dsp.owt_size_reg = CS40L50_OWT_SIZE;
+	cs40l50->haptics.dsp.mailbox_reg = CS40L50_DSP_MBOX;
+	cs40l50->haptics.dsp.pseq_reg = CS40L50_POWER_ON_SEQ;
+	cs40l50->haptics.dsp.push_owt_cmd = CS40L50_OWT_PUSH;
+	cs40l50->haptics.dsp.delete_owt_cmd = CS40L50_OWT_DELETE;
+	cs40l50->haptics.dsp.stop_cmd = CS40L50_STOP_PLAYBACK;
+	cs40l50->haptics.dsp.pseq_size = CS40L50_PSEQ_SIZE;
+	cs40l50->haptics.runtime_pm = true;
+
+	return cs_hap_init(&cs40l50->haptics);
+}
+
+static void cs40l50_upload_wt(const struct firmware *bin, void *context)
+{
+	struct cs40l50_private *cs40l50 = context;
+	u32 nwaves;
+
+	mutex_lock(&cs40l50->lock);
+
+	if (cs40l50->wmfw) {
+		if (regmap_write(cs40l50->regmap, CS40L50_CCM_CORE_CONTROL,
+				 CS40L50_CLOCK_DISABLE))
+			goto err_mutex;
+
+		if (regmap_write(cs40l50->regmap, CS40L50_RAM_INIT,
+				 CS40L50_RAM_INIT_FLAG))
+			goto err_mutex;
+
+		if (regmap_write(cs40l50->regmap, CS40L50_PWRMGT_CTL,
+				 CS40L50_MEM_RDY_HW))
+			goto err_mutex;
+	}
+
+	cs_dsp_power_up(&cs40l50->dsp, cs40l50->wmfw, "cs40l50.wmfw",
+			bin, "cs40l50.bin", "cs40l50");
+
+	if (cs40l50->wmfw) {
+		if (regmap_write(cs40l50->regmap, CS40L50_CCM_CORE_CONTROL,
+				 CS40L50_CLOCK_ENABLE))
+			goto err_mutex;
+	}
+
+	if (regmap_read(cs40l50->regmap, CS40L50_NUM_OF_WAVES, &nwaves))
+		goto err_mutex;
+
+	cs40l50->haptics.banks[WVFRM_BANK_RAM].max_index += (nwaves - 1);
+
+err_mutex:
+	mutex_unlock(&cs40l50->lock);
+	release_firmware(bin);
+	release_firmware(cs40l50->wmfw);
+}
+
+static void cs40l50_upload_patch(const struct firmware *wmfw, void *context)
+{
+	struct cs40l50_private *cs40l50 = context;
+
+	cs40l50->wmfw = wmfw;
+
+	if (request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT, CS40L50_WT,
+				    cs40l50->dev, GFP_KERNEL,
+				    cs40l50, cs40l50_upload_wt))
+		release_firmware(cs40l50->wmfw);
+}
+
+static int cs40l50_input_init(struct cs40l50_private *cs40l50)
+{
+	int error;
+
+	cs40l50->input = devm_input_allocate_device(cs40l50->dev);
+	if (!cs40l50->input)
+		return -ENOMEM;
+
+	cs40l50->input->id.product = cs40l50->devid & 0xFFFF;
+	cs40l50->input->id.version = cs40l50->revid;
+	cs40l50->input->name = "cs40l50_vibra";
+
+	input_set_drvdata(cs40l50->input, cs40l50);
+	input_set_capability(cs40l50->input, EV_FF, FF_PERIODIC);
+	input_set_capability(cs40l50->input, EV_FF, FF_CUSTOM);
+
+	error = input_ff_create(cs40l50->input, FF_MAX_EFFECTS);
+	if (error)
+		return error;
+
+	cs40l50->input->ff->upload = cs40l50_add;
+	cs40l50->input->ff->playback = cs40l50_playback;
+	cs40l50->input->ff->erase = cs40l50_erase;
+
+	INIT_LIST_HEAD(&cs40l50->haptics.effect_head);
+
+	error = input_register_device(cs40l50->input);
+	if (error)
+		goto err_free_dev;
+
+	return cs40l50_cs_hap_init(cs40l50);
+
+err_free_dev:
+	input_free_device(cs40l50->input);
+	return error;
+}
+static int cs40l50_vibra_probe(struct platform_device *pdev)
+{
+	struct cs40l50_private *cs40l50 = dev_get_drvdata(pdev->dev.parent);
+	int error;
+
+	error = cs40l50_input_init(cs40l50);
+	if (error)
+		return error;
+
+	error = cs40l50_hw_init(cs40l50);
+	if (error)
+		goto err_input;
+
+	error = cs40l50_cs_dsp_init(cs40l50);
+	if (error)
+		goto err_input;
+
+	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+					CS40L50_FW, cs40l50->dev,
+					GFP_KERNEL, cs40l50,
+					cs40l50_upload_patch);
+	if (error)
+		goto err_dsp;
+
+	return 0;
+
+err_dsp:
+	cs_dsp_remove(&cs40l50->dsp);
+err_input:
+	input_unregister_device(cs40l50->input);
+	cs_hap_remove(&cs40l50->haptics);
+
+	return error;
+}
+
+static int cs40l50_vibra_remove(struct platform_device *pdev)
+{
+	struct cs40l50_private *cs40l50 = dev_get_drvdata(pdev->dev.parent);
+
+	input_unregister_device(cs40l50->input);
+	cs_hap_remove(&cs40l50->haptics);
+
+	if (cs40l50->dsp.booted)
+		cs_dsp_power_down(&cs40l50->dsp);
+	if (&cs40l50->dsp)
+		cs_dsp_remove(&cs40l50->dsp);
+
+	return 0;
+}
+
+static const struct platform_device_id cs40l50_id_vibra[] = {
+	{"cs40l50-vibra", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cs40l50_id_vibra);
+
+static struct platform_driver cs40l50_vibra_driver = {
+	.probe		= cs40l50_vibra_probe,
+	.remove		= cs40l50_vibra_remove,
+	.id_table	= cs40l50_id_vibra,
+	.driver		= {
+		.name	= "cs40l50-vibra",
+	},
+};
+module_platform_driver(cs40l50_vibra_driver);
+
+MODULE_DESCRIPTION("CS40L50 Advanced Haptic Driver");
+MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

