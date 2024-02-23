Return-Path: <linux-kernel+bounces-78627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9886160E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D131F24A67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7A8286E;
	Fri, 23 Feb 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VMDYgNt1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4A82C9C;
	Fri, 23 Feb 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702777; cv=none; b=Jd3cmXrcMKcQFKc89+4lo/VkwdAz9Tpj6dTLxFwuOSJ0cFooL72/p4Hox228gQXITRJqqkL9Q2XK6sM65UmqXuWoKcrRiBQncgVdPn3zFlZImMwVDELolzy1C1qujsmKtHC6xCG0s8ExwkLz5mqXUmQhwR47k1shcQOVlH6BmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702777; c=relaxed/simple;
	bh=wWJUUu1RN/cjxHK7dTeua3UtBDt9H2kC7aCvh/PL8Os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p448MVHKlR5b+BJc1J6O4U4pLQOcKJiMkU7bl6i+Jw2+xkfTVPIUTuUiWrlsk89MM7LJpH1AweCuWYsXweB0h6YpM3zQqTzX3awpUy+6snPWZZdbv67iOU51/j8MwU7/0ieyr3nQBgKV3POShmb8XG6kKVBpfIhv0y8lHhZtLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VMDYgNt1; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N5xe90005825;
	Fri, 23 Feb 2024 09:39:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=xf4aK3VaxucenEoTuHMXauhjAUm7yZY8KlH7f9LC4mY=; b=
	VMDYgNt14zl3MVkPKKyNp/Q8zsGPm3KCPlI+uXGlm8W6RB0thXqsX4PotOoAFw1V
	Fxz6kZaNolPXxmbCzh4htysCG9bTLDtTOSg1ZQuMoRVezAZpGWkam7YGIL39nesQ
	oesqtyymnEwqwmkUGdfMwzEypPlRLwJbVKuZEuJ5fuEA+vUDvLq4bVeexEvc0RY4
	W2XBr0eQLAZ7fvRlM3Y/SvaUf0USi7tQCVxcqqbDco5IImHlTHlfurckEYIoDAdX
	qacMsJe0X0QuhdZfLOS9MsVybgJx78l9xrLFbjO8VGBcAwoV70VUHzQM9LohTL8+
	H/56rBN/jdGZkITEotpNFg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205m5pf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:39:13 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:39:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:39:10 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 721FA820259;
	Fri, 23 Feb 2024 15:39:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 6/6] ASoC: cs-amp-lib: Add KUnit test for calibration helpers
Date: Fri, 23 Feb 2024 15:39:10 +0000
Message-ID: <20240223153910.2063698-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223153910.2063698-1-rf@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dBXltzD6Wcpe0ICfV9g0j5cWFWX9Va1x
X-Proofpoint-GUID: dBXltzD6Wcpe0ICfV9g0j5cWFWX9Va1x
X-Proofpoint-Spam-Reason: safe

Add a KUnit test for the cs-amp-lib library. This has test cases
for cs_amp_get_efi_calibration_data() and cs_amp_write_cal_coeffs().

A KUNIT_STATIC_STUB_REDIRECT() has been added to
cs_amp_get_efi_variable() and cs_amp_write_cal_coeff() so that the
KUnit test can redirect these to test harness functions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h         |  14 +
 sound/soc/codecs/Kconfig           |  13 +
 sound/soc/codecs/Makefile          |   2 +
 sound/soc/codecs/cs-amp-lib-test.c | 715 +++++++++++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib.c      |  18 +-
 5 files changed, 760 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/cs-amp-lib-test.c

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 077fe36885b5..f481148735e1 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -49,4 +49,18 @@ int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 			    const struct cirrus_amp_cal_data *data);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
+
+struct cs_amp_test_hooks {
+	efi_status_t (*get_efi_variable)(efi_char16_t *name,
+					 efi_guid_t *guid,
+					 unsigned long *size,
+					 void *buf);
+
+	int (*write_cal_coeff)(struct cs_dsp *dsp,
+			       const struct cirrus_amp_cal_controls *controls,
+			       const char *ctl_name, u32 val);
+};
+
+extern const struct cs_amp_test_hooks * const cs_amp_test_hooks;
+
 #endif /* CS_AMP_LIB_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 15f287784d8b..0a6d034b67f1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -732,6 +732,19 @@ config SND_SOC_CROS_EC_CODEC
 config SND_SOC_CS_AMP_LIB
 	tristate
 
+config SND_SOC_CS_AMP_LIB_TEST
+	tristate "KUnit test for Cirrus Logic cs-amp-lib"
+	depends on ACPI || COMPILE_TEST || KUNIT
+	default KUNIT_ALL_TESTS
+	select SND_SOC_CS_AMP_LIB
+	help
+	  This builds KUnit tests for the Cirrus Logic common
+	  amplifier library.
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+	  If in doubt, say "N".
+
 config SND_SOC_CS35L32
 	tristate "Cirrus Logic CS35L32 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0fc40640e5d0..7c075539dc47 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,7 @@ snd-soc-cpcap-objs := cpcap.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cros-ec-codec-objs := cros_ec_codec.o
 snd-soc-cs-amp-lib-objs := cs-amp-lib.o
+snd-soc-cs-amp-lib-test-objs := cs-amp-lib-test.o
 snd-soc-cs35l32-objs := cs35l32.o
 snd-soc-cs35l33-objs := cs35l33.o
 snd-soc-cs35l34-objs := cs35l34.o
@@ -454,6 +455,7 @@ obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CPCAP)	+= snd-soc-cpcap.o
 obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)	+= snd-soc-cros-ec-codec.o
 obj-$(CONFIG_SND_SOC_CS_AMP_LIB)	+= snd-soc-cs-amp-lib.o
+obj-$(CONFIG_SND_SOC_CS_AMP_LIB_TEST)	+= snd-soc-cs-amp-lib-test.o
 obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
 obj-$(CONFIG_SND_SOC_CS35L33)	+= snd-soc-cs35l33.o
 obj-$(CONFIG_SND_SOC_CS35L34)	+= snd-soc-cs35l34.o
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
new file mode 100644
index 000000000000..be7af2fbe469
--- /dev/null
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// KUnit test for the Cirrus common amplifier library.
+//
+// Copyright (C) 2024 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/firmware/cirrus/wmfw.h>
+#include <linux/gpio/driver.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <sound/cs-amp-lib.h>
+
+#define TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test, fn_ptr, replacement_fn)		\
+	do {									\
+		typecheck_fn(typeof(fn_ptr), replacement_fn);			\
+		__kunit_activate_static_stub(test, fn_ptr, replacement_fn);	\
+	} while (0)
+
+struct cs_amp_lib_test_priv {
+	struct platform_device amp_pdev;
+
+	struct cirrus_amp_efi_data *cal_blob;
+	struct list_head ctl_write_list;
+};
+
+struct cs_amp_lib_test_ctl_write_entry {
+	struct list_head list;
+	unsigned int value;
+	char name[16];
+};
+
+struct cs_amp_lib_test_param {
+	int num_amps;
+	int amp_index;
+};
+
+static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	unsigned int blob_size;
+
+	blob_size = offsetof(struct cirrus_amp_efi_data, data) +
+		    sizeof(struct cirrus_amp_cal_data) * num_amps;
+
+	priv->cal_blob = kunit_kzalloc(test, blob_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+
+	priv->cal_blob->size = blob_size;
+	priv->cal_blob->count = num_amps;
+
+	get_random_bytes(priv->cal_blob->data, sizeof(struct cirrus_amp_cal_data) * num_amps);
+}
+
+static u64 cs_amp_lib_test_get_target_uid(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	const struct cs_amp_lib_test_param *param = test->param_value;
+	u64 uid;
+
+	uid = priv->cal_blob->data[param->amp_index].calTarget[1];
+	uid <<= 32;
+	uid |= priv->cal_blob->data[param->amp_index].calTarget[0];
+
+	return uid;
+}
+
+/* Redirected get_efi_variable to simulate that the file is too short */
+static efi_status_t cs_amp_lib_test_get_efi_variable_nohead(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    unsigned long *size,
+							    void *buf)
+{
+	if (!buf) {
+		*size = offsetof(struct cirrus_amp_efi_data, data) - 1;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	return EFI_NOT_FOUND;
+}
+
+/* Should return -EOVERFLOW if the header is larger than the EFI data */
+static void cs_amp_lib_test_cal_data_too_short_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable_nohead);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0, 0, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -EOVERFLOW);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/* Redirected get_efi_variable to simulate that the count is larger than the file */
+static efi_status_t cs_amp_lib_test_get_efi_variable_bad_count(efi_char16_t *name,
+							       efi_guid_t *guid,
+							       unsigned long *size,
+							       void *buf)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	if (!buf) {
+		/*
+		 * Return a size that is shorter than required for the
+		 * declared number of entries.
+		 */
+		*size = priv->cal_blob->size - 1;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	memcpy(buf, priv->cal_blob, priv->cal_blob->size - 1);
+
+	return EFI_SUCCESS;
+}
+
+/* Should return -EOVERFLOW if the entry count is larger than the EFI data */
+static void cs_amp_lib_test_cal_count_too_big_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable_bad_count);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0, 0, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -EOVERFLOW);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/* Redirected get_efi_variable to simulate that the variable not found */
+static efi_status_t cs_amp_lib_test_get_efi_variable_none(efi_char16_t *name,
+							  efi_guid_t *guid,
+							  unsigned long *size,
+							  void *buf)
+{
+	return EFI_NOT_FOUND;
+}
+
+/* If EFI doesn't contain a cal data variable the result should be -ENOENT */
+static void cs_amp_lib_test_no_cal_data_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable_none);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0, 0, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/* Redirected get_efi_variable to simulate reading a cal data blob */
+static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
+						     efi_guid_t *guid,
+						     unsigned long *size,
+						     void *buf)
+{
+	static const efi_char16_t expected_name[] = L"CirrusSmartAmpCalibrationData";
+	static const efi_guid_t expected_guid =
+		EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, name);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, size);
+
+	KUNIT_EXPECT_MEMEQ(test, name, expected_name, sizeof(expected_name));
+	KUNIT_EXPECT_MEMEQ(test, guid, &expected_guid, sizeof(expected_guid));
+
+	if (!buf) {
+		*size = priv->cal_blob->size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	KUNIT_ASSERT_GE_MSG(test, ksize(buf), priv->cal_blob->size, "Buffer to small");
+
+	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
+
+	return EFI_SUCCESS;
+}
+
+/* Get cal data block for a given amp, matched by target UID. */
+static void cs_amp_lib_test_get_efi_cal_by_uid_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	const struct cs_amp_lib_test_param *param = test->param_value;
+	struct cirrus_amp_cal_data result_data;
+	u64 target_uid;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, param->num_amps);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	target_uid = cs_amp_lib_test_get_target_uid(test);
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, target_uid, -1, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+
+	KUNIT_EXPECT_EQ(test, result_data.calTarget[0], target_uid & 0xFFFFFFFFULL);
+	KUNIT_EXPECT_EQ(test, result_data.calTarget[1], target_uid >> 32);
+	KUNIT_EXPECT_EQ(test, result_data.calTime[0],
+			      priv->cal_blob->data[param->amp_index].calTime[0]);
+	KUNIT_EXPECT_EQ(test, result_data.calTime[1],
+			      priv->cal_blob->data[param->amp_index].calTime[1]);
+	KUNIT_EXPECT_EQ(test, result_data.calAmbient,
+			      priv->cal_blob->data[param->amp_index].calAmbient);
+	KUNIT_EXPECT_EQ(test, result_data.calStatus,
+			      priv->cal_blob->data[param->amp_index].calStatus);
+	KUNIT_EXPECT_EQ(test, result_data.calR,
+			      priv->cal_blob->data[param->amp_index].calR);
+}
+
+/* Get cal data block for a given amp index without checking target UID. */
+static void cs_amp_lib_test_get_efi_cal_by_index_unchecked_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	const struct cs_amp_lib_test_param *param = test->param_value;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, param->num_amps);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0,
+					      param->amp_index, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+
+	KUNIT_EXPECT_EQ(test, result_data.calTime[0],
+			      priv->cal_blob->data[param->amp_index].calTime[0]);
+	KUNIT_EXPECT_EQ(test, result_data.calTime[1],
+			      priv->cal_blob->data[param->amp_index].calTime[1]);
+	KUNIT_EXPECT_EQ(test, result_data.calAmbient,
+			      priv->cal_blob->data[param->amp_index].calAmbient);
+	KUNIT_EXPECT_EQ(test, result_data.calStatus,
+			      priv->cal_blob->data[param->amp_index].calStatus);
+	KUNIT_EXPECT_EQ(test, result_data.calR,
+			      priv->cal_blob->data[param->amp_index].calR);
+}
+
+/* Get cal data block for a given amp index with checked target UID. */
+static void cs_amp_lib_test_get_efi_cal_by_index_checked_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	const struct cs_amp_lib_test_param *param = test->param_value;
+	struct cirrus_amp_cal_data result_data;
+	u64 target_uid;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, param->num_amps);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	target_uid = cs_amp_lib_test_get_target_uid(test);
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, target_uid,
+					      param->amp_index, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+
+	KUNIT_EXPECT_EQ(test, result_data.calTime[0],
+			      priv->cal_blob->data[param->amp_index].calTime[0]);
+	KUNIT_EXPECT_EQ(test, result_data.calTime[1],
+			      priv->cal_blob->data[param->amp_index].calTime[1]);
+	KUNIT_EXPECT_EQ(test, result_data.calAmbient,
+			      priv->cal_blob->data[param->amp_index].calAmbient);
+	KUNIT_EXPECT_EQ(test, result_data.calStatus,
+			      priv->cal_blob->data[param->amp_index].calStatus);
+	KUNIT_EXPECT_EQ(test, result_data.calR,
+			      priv->cal_blob->data[param->amp_index].calR);
+}
+
+/*
+ * Get cal data block for a given amp index with checked target UID.
+ * The UID does not match so the result should be -ENOENT.
+ */
+static void cs_amp_lib_test_get_efi_cal_by_index_uid_mismatch_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	const struct cs_amp_lib_test_param *param = test->param_value;
+	struct cirrus_amp_cal_data result_data;
+	u64 target_uid;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, param->num_amps);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	/* Get a target UID that won't match the entry */
+	target_uid = ~cs_amp_lib_test_get_target_uid(test);
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, target_uid,
+					      param->amp_index, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/*
+ * Get cal data block for a given amp, where the cal data does not
+ * specify calTarget so the lookup falls back to using the index
+ */
+static void cs_amp_lib_test_get_efi_cal_by_index_fallback_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	const struct cs_amp_lib_test_param *param = test->param_value;
+	struct cirrus_amp_cal_data result_data;
+	static const u64 bad_target_uid = 0xBADCA100BABABABAULL;
+	int i, ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, param->num_amps);
+
+	/* Make all the target values zero so they are ignored */
+	for (i = 0; i < priv->cal_blob->count; ++i) {
+		priv->cal_blob->data[i].calTarget[0] = 0;
+		priv->cal_blob->data[i].calTarget[1] = 0;
+	}
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, bad_target_uid,
+					      param->amp_index, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+
+	KUNIT_EXPECT_EQ(test, result_data.calTime[0],
+			      priv->cal_blob->data[param->amp_index].calTime[0]);
+	KUNIT_EXPECT_EQ(test, result_data.calTime[1],
+			      priv->cal_blob->data[param->amp_index].calTime[1]);
+	KUNIT_EXPECT_EQ(test, result_data.calAmbient,
+			      priv->cal_blob->data[param->amp_index].calAmbient);
+	KUNIT_EXPECT_EQ(test, result_data.calStatus,
+			      priv->cal_blob->data[param->amp_index].calStatus);
+	KUNIT_EXPECT_EQ(test, result_data.calR,
+			      priv->cal_blob->data[param->amp_index].calR);
+}
+
+/*
+ * If the target UID isn't present in the cal data, and there isn't an
+ * index to fall back do, the result should be -ENOENT.
+ */
+static void cs_amp_lib_test_get_efi_cal_uid_not_found_noindex_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	static const u64 bad_target_uid = 0xBADCA100BABABABAULL;
+	int i, ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Make all the target values != bad_target_uid */
+	for (i = 0; i < priv->cal_blob->count; ++i) {
+		priv->cal_blob->data[i].calTarget[0] &= ~(bad_target_uid & 0xFFFFFFFFULL);
+		priv->cal_blob->data[i].calTarget[1] &= ~(bad_target_uid >> 32);
+	}
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, bad_target_uid, -1,
+					      &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/*
+ * If the target UID isn't present in the cal data, and the index is
+ * out of range, the result should be -ENOENT.
+ */
+static void cs_amp_lib_test_get_efi_cal_uid_not_found_index_not_found_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	static const u64 bad_target_uid = 0xBADCA100BABABABAULL;
+	int i, ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Make all the target values != bad_target_uid */
+	for (i = 0; i < priv->cal_blob->count; ++i) {
+		priv->cal_blob->data[i].calTarget[0] &= ~(bad_target_uid & 0xFFFFFFFFULL);
+		priv->cal_blob->data[i].calTarget[1] &= ~(bad_target_uid >> 32);
+	}
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, bad_target_uid, 99,
+					      &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/*
+ * If the target UID isn't given, and the index is out of range, the
+ * result should be -ENOENT.
+ */
+static void cs_amp_lib_test_get_efi_cal_no_uid_index_not_found_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0, 99, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/* If neither the target UID or the index is given the result should be -ENOENT. */
+static void cs_amp_lib_test_get_efi_cal_no_uid_no_index_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0, -1, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+/*
+ * If the UID is passed as 0 this must not match an entry with an
+ * unpopulated calTarget
+ */
+static void cs_amp_lib_test_get_efi_cal_zero_not_matched_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int i, ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 8);
+
+	/* Make all the target values zero so they are ignored */
+	for (i = 0; i < priv->cal_blob->count; ++i) {
+		priv->cal_blob->data[i].calTarget[0] = 0;
+		priv->cal_blob->data[i].calTarget[1] = 0;
+	}
+
+	/* Redirect calls to get EFI data */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->get_efi_variable,
+					  cs_amp_lib_test_get_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_pdev.dev, 0, -1, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->get_efi_variable);
+}
+
+static const struct cirrus_amp_cal_controls cs_amp_lib_test_calibration_controls = {
+	.alg_id =	0x9f210,
+	.mem_region =	WMFW_ADSP2_YM,
+	.ambient =	"CAL_AMBIENT",
+	.calr =		"CAL_R",
+	.status =	"CAL_STATUS",
+	.checksum =	"CAL_CHECKSUM",
+};
+
+static int cs_amp_lib_test_write_cal_coeff(struct cs_dsp *dsp,
+					   const struct cirrus_amp_cal_controls *controls,
+					   const char *ctl_name, u32 val)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cs_amp_lib_test_ctl_write_entry *entry;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctl_name);
+	KUNIT_EXPECT_PTR_EQ(test, controls, &cs_amp_lib_test_calibration_controls);
+
+	entry = kunit_kzalloc(test, sizeof(*entry), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, entry);
+
+	INIT_LIST_HEAD(&entry->list);
+	strscpy(entry->name, ctl_name, sizeof(entry->name));
+	entry->value = val;
+
+	list_add_tail(&entry->list, &priv->ctl_write_list);
+
+	return 0;
+}
+
+static void cs_amp_lib_test_write_cal_data_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cs_amp_lib_test_ctl_write_entry *entry;
+	struct cirrus_amp_cal_data data;
+	struct cs_dsp *dsp;
+	int ret;
+
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dsp);
+	dsp->dev = &priv->amp_pdev.dev;
+
+	get_random_bytes(&data, sizeof(data));
+
+	/* Redirect calls to write firmware controls */
+	TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test,
+					  cs_amp_test_hooks->write_cal_coeff,
+					  cs_amp_lib_test_write_cal_coeff);
+
+	ret = cs_amp_write_cal_coeffs(dsp, &cs_amp_lib_test_calibration_controls, &data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	kunit_deactivate_static_stub(test, cs_amp_test_hooks->write_cal_coeff);
+
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&priv->ctl_write_list), 4);
+
+	/* Checksum control must be written last */
+	entry = list_last_entry(&priv->ctl_write_list, typeof(*entry), list);
+	KUNIT_EXPECT_STREQ(test, entry->name, cs_amp_lib_test_calibration_controls.checksum);
+	KUNIT_EXPECT_EQ(test, entry->value, data.calR + 1);
+	list_del(&entry->list);
+
+	entry = list_first_entry(&priv->ctl_write_list, typeof(*entry), list);
+	KUNIT_EXPECT_STREQ(test, entry->name, cs_amp_lib_test_calibration_controls.ambient);
+	KUNIT_EXPECT_EQ(test, entry->value, data.calAmbient);
+	list_del(&entry->list);
+
+	entry = list_first_entry(&priv->ctl_write_list, typeof(*entry), list);
+	KUNIT_EXPECT_STREQ(test, entry->name, cs_amp_lib_test_calibration_controls.calr);
+	KUNIT_EXPECT_EQ(test, entry->value, data.calR);
+	list_del(&entry->list);
+
+	entry = list_first_entry(&priv->ctl_write_list, typeof(*entry), list);
+	KUNIT_EXPECT_STREQ(test, entry->name, cs_amp_lib_test_calibration_controls.status);
+	KUNIT_EXPECT_EQ(test, entry->value, data.calStatus);
+}
+
+static void cs_amp_lib_test_dev_release(struct device *dev)
+{
+}
+
+static int cs_amp_lib_test_case_init(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv;
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, cs_amp_test_hooks);
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	test->priv = priv;
+	INIT_LIST_HEAD(&priv->ctl_write_list);
+
+	/* Create dummy amp driver dev */
+	priv->amp_pdev.name = "cs_amp_lib_test_drv";
+	priv->amp_pdev.id = -1;
+	priv->amp_pdev.dev.release = cs_amp_lib_test_dev_release;
+	ret = platform_device_register(&priv->amp_pdev);
+	KUNIT_ASSERT_GE_MSG(test, ret, 0, "Failed to register amp platform device\n");
+
+	return 0;
+}
+
+static void cs_amp_lib_test_case_exit(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	if (priv->amp_pdev.name)
+		platform_device_unregister(&priv->amp_pdev);
+}
+
+static const struct cs_amp_lib_test_param cs_amp_lib_test_get_cal_param_cases[] = {
+	{ .num_amps = 2, .amp_index = 0 },
+	{ .num_amps = 2, .amp_index = 1 },
+
+	{ .num_amps = 3, .amp_index = 0 },
+	{ .num_amps = 3, .amp_index = 1 },
+	{ .num_amps = 3, .amp_index = 2 },
+
+	{ .num_amps = 4, .amp_index = 0 },
+	{ .num_amps = 4, .amp_index = 1 },
+	{ .num_amps = 4, .amp_index = 2 },
+	{ .num_amps = 4, .amp_index = 3 },
+
+	{ .num_amps = 5, .amp_index = 0 },
+	{ .num_amps = 5, .amp_index = 1 },
+	{ .num_amps = 5, .amp_index = 2 },
+	{ .num_amps = 5, .amp_index = 3 },
+	{ .num_amps = 5, .amp_index = 4 },
+
+	{ .num_amps = 6, .amp_index = 0 },
+	{ .num_amps = 6, .amp_index = 1 },
+	{ .num_amps = 6, .amp_index = 2 },
+	{ .num_amps = 6, .amp_index = 3 },
+	{ .num_amps = 6, .amp_index = 4 },
+	{ .num_amps = 6, .amp_index = 5 },
+
+	{ .num_amps = 8, .amp_index = 0 },
+	{ .num_amps = 8, .amp_index = 1 },
+	{ .num_amps = 8, .amp_index = 2 },
+	{ .num_amps = 8, .amp_index = 3 },
+	{ .num_amps = 8, .amp_index = 4 },
+	{ .num_amps = 8, .amp_index = 5 },
+	{ .num_amps = 8, .amp_index = 6 },
+	{ .num_amps = 8, .amp_index = 7 },
+};
+
+static void cs_amp_lib_test_get_cal_param_desc(const struct cs_amp_lib_test_param *param,
+					       char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "num_amps:%d amp_index:%d",
+		 param->num_amps, param->amp_index);
+}
+
+KUNIT_ARRAY_PARAM(cs_amp_lib_test_get_cal, cs_amp_lib_test_get_cal_param_cases,
+		  cs_amp_lib_test_get_cal_param_desc);
+
+static struct kunit_case cs_amp_lib_test_cases[] = {
+	/* Tests for getting calibration data from EFI */
+	KUNIT_CASE(cs_amp_lib_test_cal_data_too_short_test),
+	KUNIT_CASE(cs_amp_lib_test_cal_count_too_big_test),
+	KUNIT_CASE(cs_amp_lib_test_no_cal_data_test),
+	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_uid_not_found_noindex_test),
+	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_uid_not_found_index_not_found_test),
+	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_no_uid_index_not_found_test),
+	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_no_uid_no_index_test),
+	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_zero_not_matched_test),
+	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_uid_test,
+			 cs_amp_lib_test_get_cal_gen_params),
+	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_unchecked_test,
+			 cs_amp_lib_test_get_cal_gen_params),
+	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_checked_test,
+			 cs_amp_lib_test_get_cal_gen_params),
+	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_uid_mismatch_test,
+			 cs_amp_lib_test_get_cal_gen_params),
+	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_fallback_test,
+			 cs_amp_lib_test_get_cal_gen_params),
+
+	/* Tests for writing calibration data */
+	KUNIT_CASE(cs_amp_lib_test_write_cal_data_test),
+
+	{ } /* terminator */
+};
+
+static struct kunit_suite cs_amp_lib_test_suite = {
+	.name = "snd-soc-cs-amp-lib-test",
+	.init = cs_amp_lib_test_case_init,
+	.exit = cs_amp_lib_test_case_exit,
+	.test_cases = cs_amp_lib_test_cases,
+};
+
+kunit_test_suite(cs_amp_lib_test_suite);
+
+MODULE_IMPORT_NS(SND_SOC_CS_AMP_LIB);
+MODULE_DESCRIPTION("KUnit test for Cirrus Logic amplifier library");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 4e2e5157a73f..01ef4db5407d 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -6,6 +6,7 @@
 //               Cirrus Logic International Semiconductor Ltd.
 
 #include <asm/byteorder.h>
+#include <kunit/static_stub.h>
 #include <linux/dev_printk.h>
 #include <linux/efi.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
@@ -27,6 +28,8 @@ static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 	__be32 beval = cpu_to_be32(val);
 	int ret;
 
+	KUNIT_STATIC_STUB_REDIRECT(cs_amp_write_cal_coeff, dsp, controls, ctl_name, val);
+
 	if (IS_REACHABLE(CONFIG_FW_CS_DSP)) {
 		mutex_lock(&dsp->pwr_lock);
 		cs_ctl = cs_dsp_get_ctl(dsp, ctl_name, controls->mem_region, controls->alg_id);
@@ -84,7 +87,7 @@ int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 			    const struct cirrus_amp_cal_controls *controls,
 			    const struct cirrus_amp_cal_data *data)
 {
-	if (IS_REACHABLE(CONFIG_FW_CS_DSP))
+	if (IS_REACHABLE(CONFIG_FW_CS_DSP) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
 		return _cs_amp_write_cal_coeffs(dsp, controls, data);
 	else
 		return -ENODEV;
@@ -98,6 +101,8 @@ static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 {
 	u32 attr;
 
+	KUNIT_STATIC_STUB_REDIRECT(cs_amp_get_efi_variable, name, guid, size, buf);
+
 	if (IS_ENABLED(CONFIG_EFI))
 		return efi.get_variable(name, guid, &attr, size, buf);
 
@@ -250,13 +255,22 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data)
 {
-	if (IS_ENABLED(CONFIG_EFI))
+	if (IS_ENABLED(CONFIG_EFI) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
 		return _cs_amp_get_efi_calibration_data(dev, target_uid, amp_index, out_data);
 	else
 		return -ENOENT;
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_get_efi_calibration_data, SND_SOC_CS_AMP_LIB);
 
+static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
+	.get_efi_variable = cs_amp_get_efi_variable,
+	.write_cal_coeff = cs_amp_write_cal_coeff,
+};
+
+const struct cs_amp_test_hooks * const cs_amp_test_hooks =
+	PTR_IF(IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST), &cs_amp_test_hook_ptrs);
+EXPORT_SYMBOL_NS_GPL(cs_amp_test_hooks, SND_SOC_CS_AMP_LIB);
+
 MODULE_DESCRIPTION("Cirrus Logic amplifier library");
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
-- 
2.30.2


