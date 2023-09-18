Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524017A4662
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbjIRJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjIRJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:51:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F9A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:51:45 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I4SDSf011029;
        Mon, 18 Sep 2023 04:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=ejl4Y1nl7LgLj6gAZfih6JotjDlB1P0pTI0cmOBZRvM=; b=
        jptbWjMTY+lARBZTqV0PndR4+oElKyXCRhyL/K1KCKX5vXMOdobW3zwMwPUALEkZ
        IdK0Y8B6C7JvlB1Yx25Zq146C/P/0OstsmU1tf6mW819lTs4GOYglVF9B+LVtPdJ
        3PXZsXK4VsB7Qd17F77afcDDcviUR1r395M7dyQ6QS4mRuknW5KGTNKuvqxwKZKs
        x0o/qvF7gHQta0MkAxddBBpMKIOEBAkH04y5j0jPBA8S+SQmhdf6hQ/3PuKWU9mx
        7qqK6fV7VTw1D8JmuasrtYsO9O8prn5XH8YyOjAhlmsq/N5sIRtQhbYLYMMDHAyl
        1ZsVrXt1EmOpHMjIulbG3g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry256e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 04:51:37 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 10:51:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 18 Sep 2023 10:51:35 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.90.238.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 214C911AA;
        Mon, 18 Sep 2023 09:51:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda: cirrus_scodec: Add KUnit test
Date:   Mon, 18 Sep 2023 10:51:29 +0100
Message-ID: <20230918095129.440-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918095129.440-1-rf@opensource.cirrus.com>
References: <20230918095129.440-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: A5xBEYnzhz2qKhKDStBk94IS18f56cRM
X-Proofpoint-ORIG-GUID: A5xBEYnzhz2qKhKDStBk94IS18f56cRM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a KUnit test for cirrus_scodec_get_speaker_id(). It is impractical
to have enough hardware with every possible permutation of speaker id.
So use a test harness to test all theoretically supported options.

The test harness consists of:
- a mock GPIO controller.
- a mock struct device to represent the scodec driver
- software nodes to provide the fwnode info that would normally come
  from ACPI.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/Kconfig              |  12 +
 sound/pci/hda/Makefile             |   2 +
 sound/pci/hda/cirrus_scodec_test.c | 370 +++++++++++++++++++++++++++++
 sound/pci/hda/cs35l56_hda.c        |  10 +
 4 files changed, 394 insertions(+)
 create mode 100644 sound/pci/hda/cirrus_scodec_test.c

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 2980bfef0a4c..706cdc589e6f 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -94,6 +94,18 @@ config SND_HDA_PATCH_LOADER
 config SND_HDA_CIRRUS_SCODEC
 	tristate
 
+config SND_HDA_CIRRUS_SCODEC_KUNIT_TEST
+	tristate "KUnit test for Cirrus side-codec library" if !KUNIT_ALL_TESTS
+	select SND_HDA_CIRRUS_SCODEC
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the cirrus side-codec library.
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+	  If in doubt, say "N".
+
 config SND_HDA_SCODEC_CS35L41
 	tristate
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index aa445af0cf9a..793e296c3f64 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -29,6 +29,7 @@ snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 
 # side codecs
 snd-hda-cirrus-scodec-objs :=		cirrus_scodec.o
+snd-hda-cirrus-scodec-test-objs :=	cirrus_scodec_test.o
 snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o cs35l41_hda_property.o
 snd-hda-scodec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-objs :=	cs35l41_hda_spi.o
@@ -58,6 +59,7 @@ obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 
 # side codecs
 obj-$(CONFIG_SND_HDA_CIRRUS_SCODEC) += snd-hda-cirrus-scodec.o
+obj-$(CONFIG_SND_HDA_CIRRUS_SCODEC_KUNIT_TEST) += snd-hda-cirrus-scodec-test.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41) += snd-hda-scodec-cs35l41.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_I2C) += snd-hda-scodec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_SPI) += snd-hda-scodec-cs35l41-spi.o
diff --git a/sound/pci/hda/cirrus_scodec_test.c b/sound/pci/hda/cirrus_scodec_test.c
new file mode 100644
index 000000000000..5eb590cd4fe2
--- /dev/null
+++ b/sound/pci/hda/cirrus_scodec_test.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// KUnit test for the Cirrus side-codec library.
+//
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <kunit/test.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "cirrus_scodec.h"
+
+struct cirrus_scodec_test_gpio {
+	unsigned int pin_state;
+	struct gpio_chip chip;
+};
+
+struct cirrus_scodec_test_priv {
+	struct platform_device amp_pdev;
+	struct platform_device *gpio_pdev;
+	struct cirrus_scodec_test_gpio *gpio_priv;
+};
+
+static int cirrus_scodec_test_gpio_get_direction(struct gpio_chip *chip,
+						 unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static int cirrus_scodec_test_gpio_direction_in(struct gpio_chip *chip,
+						unsigned int offset)
+{
+	return 0;
+}
+
+static int cirrus_scodec_test_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct cirrus_scodec_test_gpio *gpio_priv = gpiochip_get_data(chip);
+
+	return !!(gpio_priv->pin_state & BIT(offset));
+}
+
+static int cirrus_scodec_test_gpio_direction_out(struct gpio_chip *chip,
+						 unsigned int offset, int value)
+{
+	return -EOPNOTSUPP;
+}
+
+static void cirrus_scodec_test_gpio_set(struct gpio_chip *chip, unsigned int offset,
+					int value)
+{
+}
+
+static int cirrus_scodec_test_gpio_set_config(struct gpio_chip *gc,
+					      unsigned int offset,
+					      unsigned long config)
+{
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_OUTPUT:
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		return -EOPNOTSUPP;
+	default:
+		return 0;
+	}
+}
+
+static const struct gpio_chip cirrus_scodec_test_gpio_chip = {
+	.label			= "cirrus_scodec_test_gpio",
+	.owner			= THIS_MODULE,
+	.request		= gpiochip_generic_request,
+	.free			= gpiochip_generic_free,
+	.get_direction		= cirrus_scodec_test_gpio_get_direction,
+	.direction_input	= cirrus_scodec_test_gpio_direction_in,
+	.get			= cirrus_scodec_test_gpio_get,
+	.direction_output	= cirrus_scodec_test_gpio_direction_out,
+	.set			= cirrus_scodec_test_gpio_set,
+	.set_config		= cirrus_scodec_test_gpio_set_config,
+	.base			= -1,
+	.ngpio			= 32,
+};
+
+static int cirrus_scodec_test_gpio_probe(struct platform_device *pdev)
+{
+	struct cirrus_scodec_test_gpio *gpio_priv;
+	int ret;
+
+	gpio_priv = devm_kzalloc(&pdev->dev, sizeof(*gpio_priv), GFP_KERNEL);
+	if (!gpio_priv)
+		return -ENOMEM;
+
+	/* GPIO core modifies our struct gpio_chip so use a copy */
+	gpio_priv->chip = cirrus_scodec_test_gpio_chip;
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio_priv->chip, gpio_priv);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add gpiochip\n");
+
+	dev_set_drvdata(&pdev->dev, gpio_priv);
+
+	return 0;
+}
+
+static struct platform_driver cirrus_scodec_test_gpio_driver = {
+	.driver.name	= "cirrus_scodec_test_gpio_drv",
+	.probe		= cirrus_scodec_test_gpio_probe,
+};
+
+/* software_node referencing the gpio driver */
+static const struct software_node cirrus_scodec_test_gpio_swnode = {
+	.name = "cirrus_scodec_test_gpio",
+};
+
+static int cirrus_scodec_test_create_gpio(struct kunit *test)
+{
+	struct cirrus_scodec_test_priv *priv = test->priv;
+	int ret;
+
+	priv->gpio_pdev = platform_device_alloc(cirrus_scodec_test_gpio_driver.driver.name, -1);
+	if (!priv->gpio_pdev)
+		return -ENOMEM;
+
+	ret = device_add_software_node(&priv->gpio_pdev->dev, &cirrus_scodec_test_gpio_swnode);
+	if (ret) {
+		platform_device_put(priv->gpio_pdev);
+		KUNIT_FAIL(test, "Failed to add swnode to gpio: %d\n", ret);
+		return ret;
+	}
+
+	ret = platform_device_add(priv->gpio_pdev);
+	if (ret) {
+		platform_device_put(priv->gpio_pdev);
+		KUNIT_FAIL(test, "Failed to add gpio platform device: %d\n", ret);
+		return ret;
+	}
+
+	priv->gpio_priv = dev_get_drvdata(&priv->gpio_pdev->dev);
+	if (!priv->gpio_priv) {
+		platform_device_put(priv->gpio_pdev);
+		KUNIT_FAIL(test, "Failed to get gpio private data: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cirrus_scodec_test_set_gpio_ref_arg(struct software_node_ref_args *arg,
+						int gpio_num)
+{
+	struct software_node_ref_args template =
+		SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, gpio_num, 0);
+
+	*arg = template;
+}
+
+static int cirrus_scodec_test_set_spkid_swnode(struct kunit *test,
+					       struct device *dev,
+					       struct software_node_ref_args *args,
+					       int num_args)
+{
+	const struct property_entry props_template[] = {
+		PROPERTY_ENTRY_REF_ARRAY_LEN("spk-id-gpios", args, num_args),
+		{ }
+	};
+	struct property_entry *props;
+	struct software_node *node;
+
+	node = kunit_kzalloc(test, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	props = kunit_kzalloc(test, sizeof(props_template), GFP_KERNEL);
+	if (!props)
+		return -ENOMEM;
+
+	memcpy(props, props_template, sizeof(props_template));
+	node->properties = props;
+
+	return device_add_software_node(dev, node);
+}
+
+struct cirrus_scodec_test_spkid_param {
+	int num_amps;
+	int gpios_per_amp;
+	int num_amps_sharing;
+};
+
+static void cirrus_scodec_test_spkid_parse(struct kunit *test)
+{
+	struct cirrus_scodec_test_priv *priv = test->priv;
+	const struct cirrus_scodec_test_spkid_param *param = test->param_value;
+	int num_spk_id_refs = param->num_amps * param->gpios_per_amp;
+	struct software_node_ref_args *refs;
+	struct device *dev = &priv->amp_pdev.dev;
+	unsigned int v;
+	int i, ret;
+
+	refs = kunit_kcalloc(test, num_spk_id_refs, sizeof(*refs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, refs);
+
+	for (i = 0, v = 0; i < num_spk_id_refs; ) {
+		cirrus_scodec_test_set_gpio_ref_arg(&refs[i++], v++);
+
+		/*
+		 * If amps are sharing GPIOs repeat the last set of
+		 * GPIOs until we've done that number of amps.
+		 * We have done all GPIOs for an amp when i is a multiple
+		 * of gpios_per_amp.
+		 * We have done all amps sharing the same GPIOs when i is
+		 * a multiple of (gpios_per_amp * num_amps_sharing).
+		 */
+		if (!(i % param->gpios_per_amp) &&
+		    (i % (param->gpios_per_amp * param->num_amps_sharing)))
+			v -= param->gpios_per_amp;
+	}
+
+	ret = cirrus_scodec_test_set_spkid_swnode(test, dev, refs, num_spk_id_refs);
+	KUNIT_EXPECT_EQ_MSG(test, ret, 0, "Failed to add swnode\n");
+
+	for (i = 0; i < param->num_amps; ++i) {
+		for (v = 0; v < (1 << param->gpios_per_amp); ++v) {
+			/* Set only the GPIO bits used by this amp */
+			priv->gpio_priv->pin_state =
+				v << (param->gpios_per_amp * (i / param->num_amps_sharing));
+
+			ret = cirrus_scodec_get_speaker_id(dev, i, param->num_amps, -1);
+			KUNIT_EXPECT_EQ_MSG(test, ret, v,
+					    "get_speaker_id failed amp:%d pin_state:%#x\n",
+					    i, priv->gpio_priv->pin_state);
+		}
+	}
+}
+
+static void cirrus_scodec_test_no_spkid(struct kunit *test)
+{
+	struct cirrus_scodec_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_pdev.dev;
+	int ret;
+
+	ret = cirrus_scodec_get_speaker_id(dev, 0, 4, -1);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+}
+
+static void cirrus_scodec_test_dev_release(struct device *dev)
+{
+}
+
+static int cirrus_scodec_test_case_init(struct kunit *test)
+{
+	struct cirrus_scodec_test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	test->priv = priv;
+
+	/* Create dummy GPIO */
+	ret = cirrus_scodec_test_create_gpio(test);
+	if (ret < 0)
+		return ret;
+
+	/* Create dummy amp driver dev */
+	priv->amp_pdev.name = "cirrus_scodec_test_amp_drv";
+	priv->amp_pdev.id = -1;
+	priv->amp_pdev.dev.release = cirrus_scodec_test_dev_release;
+	ret = platform_device_register(&priv->amp_pdev);
+	KUNIT_ASSERT_GE_MSG(test, ret, 0, "Failed to register amp platform device\n");
+
+	return 0;
+}
+
+static void cirrus_scodec_test_case_exit(struct kunit *test)
+{
+	struct cirrus_scodec_test_priv *priv = test->priv;
+
+	if (priv->amp_pdev.name)
+		platform_device_unregister(&priv->amp_pdev);
+
+	if (priv->gpio_pdev) {
+		device_remove_software_node(&priv->gpio_pdev->dev);
+		platform_device_unregister(priv->gpio_pdev);
+	}
+}
+
+static int cirrus_scodec_test_suite_init(struct kunit_suite *suite)
+{
+	int ret;
+
+	/* Register mock GPIO driver */
+	ret = platform_driver_register(&cirrus_scodec_test_gpio_driver);
+	if (ret < 0) {
+		kunit_err(suite, "Failed to register gpio platform driver, %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cirrus_scodec_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&cirrus_scodec_test_gpio_driver);
+}
+
+static const struct cirrus_scodec_test_spkid_param cirrus_scodec_test_spkid_param_cases[] = {
+	{ .num_amps = 2, .gpios_per_amp = 1, .num_amps_sharing = 1 },
+	{ .num_amps = 2, .gpios_per_amp = 2, .num_amps_sharing = 1 },
+	{ .num_amps = 2, .gpios_per_amp = 3, .num_amps_sharing = 1 },
+	{ .num_amps = 2, .gpios_per_amp = 4, .num_amps_sharing = 1 },
+	{ .num_amps = 3, .gpios_per_amp = 1, .num_amps_sharing = 1 },
+	{ .num_amps = 3, .gpios_per_amp = 2, .num_amps_sharing = 1 },
+	{ .num_amps = 3, .gpios_per_amp = 3, .num_amps_sharing = 1 },
+	{ .num_amps = 3, .gpios_per_amp = 4, .num_amps_sharing = 1 },
+	{ .num_amps = 4, .gpios_per_amp = 1, .num_amps_sharing = 1 },
+	{ .num_amps = 4, .gpios_per_amp = 2, .num_amps_sharing = 1 },
+	{ .num_amps = 4, .gpios_per_amp = 3, .num_amps_sharing = 1 },
+	{ .num_amps = 4, .gpios_per_amp = 4, .num_amps_sharing = 1 },
+
+	/* Same GPIO shared by all amps */
+	{ .num_amps = 2, .gpios_per_amp = 1, .num_amps_sharing = 2 },
+	{ .num_amps = 2, .gpios_per_amp = 2, .num_amps_sharing = 2 },
+	{ .num_amps = 2, .gpios_per_amp = 3, .num_amps_sharing = 2 },
+	{ .num_amps = 2, .gpios_per_amp = 4, .num_amps_sharing = 2 },
+	{ .num_amps = 3, .gpios_per_amp = 1, .num_amps_sharing = 3 },
+	{ .num_amps = 3, .gpios_per_amp = 2, .num_amps_sharing = 3 },
+	{ .num_amps = 3, .gpios_per_amp = 3, .num_amps_sharing = 3 },
+	{ .num_amps = 3, .gpios_per_amp = 4, .num_amps_sharing = 3 },
+	{ .num_amps = 4, .gpios_per_amp = 1, .num_amps_sharing = 4 },
+	{ .num_amps = 4, .gpios_per_amp = 2, .num_amps_sharing = 4 },
+	{ .num_amps = 4, .gpios_per_amp = 3, .num_amps_sharing = 4 },
+	{ .num_amps = 4, .gpios_per_amp = 4, .num_amps_sharing = 4 },
+
+	/* Two sets of shared GPIOs */
+	{ .num_amps = 4, .gpios_per_amp = 1, .num_amps_sharing = 2 },
+	{ .num_amps = 4, .gpios_per_amp = 2, .num_amps_sharing = 2 },
+	{ .num_amps = 4, .gpios_per_amp = 3, .num_amps_sharing = 2 },
+	{ .num_amps = 4, .gpios_per_amp = 4, .num_amps_sharing = 2 },
+};
+
+static void cirrus_scodec_test_spkid_param_desc(const struct cirrus_scodec_test_spkid_param *param,
+						char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "amps:%d gpios_per_amp:%d num_amps_sharing:%d",
+		 param->num_amps, param->gpios_per_amp, param->num_amps_sharing);
+}
+
+KUNIT_ARRAY_PARAM(cirrus_scodec_test_spkid, cirrus_scodec_test_spkid_param_cases,
+		  cirrus_scodec_test_spkid_param_desc);
+
+static struct kunit_case cirrus_scodec_test_cases[] = {
+	KUNIT_CASE_PARAM(cirrus_scodec_test_spkid_parse, cirrus_scodec_test_spkid_gen_params),
+	KUNIT_CASE(cirrus_scodec_test_no_spkid),
+	{ } /* terminator */
+};
+
+static struct kunit_suite cirrus_scodec_test_suite = {
+	.name = "snd-hda-scodec-cs35l56-test",
+	.suite_init = cirrus_scodec_test_suite_init,
+	.suite_exit = cirrus_scodec_test_suite_exit,
+	.init = cirrus_scodec_test_case_init,
+	.exit = cirrus_scodec_test_case_exit,
+	.test_cases = cirrus_scodec_test_cases,
+};
+
+kunit_test_suite(cirrus_scodec_test_suite);
+
+MODULE_IMPORT_NS(SND_HDA_CIRRUS_SCODEC);
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 44f5ca0e73e3..d3cfdad7dd76 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1035,6 +1035,16 @@ const struct dev_pm_ops cs35l56_hda_pm_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_hda_pm_ops, SND_HDA_SCODEC_CS35L56);
 
+#if IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_KUNIT_TEST)
+/* Hooks to export static function to KUnit test */
+
+int cs35l56_hda_test_hook_get_speaker_id(struct device *dev, int amp_index, int num_amps)
+{
+	return cs35l56_hda_get_speaker_id(dev, amp_index, num_amps);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_hda_test_hook_get_speaker_id, SND_HDA_SCODEC_CS35L56);
+#endif
+
 MODULE_DESCRIPTION("CS35L56 HDA Driver");
 MODULE_IMPORT_NS(SND_HDA_CIRRUS_SCODEC);
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
-- 
2.30.2

