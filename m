Return-Path: <linux-kernel+bounces-5936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC878191AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07919287482
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDFC39AC4;
	Tue, 19 Dec 2023 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b="HZDwUo/H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08039AC7;
	Tue, 19 Dec 2023 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brun.one
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
	s=s1; h=MIME-Version:Message-ID:Date:Subject:Cc:To:From:In-Reply-To:
	References:From:To:Subject:Date:Message-ID:Reply-To;
	bh=zv1tp5EJGy8vjqEhUz2XKQPecD+fBNOlCqIMeS8hFok=; b=HZDwUo/HPafCCF6LR6WBQcfZB0
	W/7uxNvRnhBNOfvvH7YLkV34y29UK0zD7dytiRTcakH0Lo20grPg17B1cnOTAx2jf5Xsam/Ev+Qt2
	rO2K5x/z+iZbMB8nFA9KYKeJDoXTmFv0RQsJUTbUmybP/X+T4h3PZNjKu+F9eAdlrwAsYSQHZWYU3
	v5+NKDpn+uuQhfFyWRX5QlOAXvCqHFvz8ylnFp8OEok11hNlH+OOx8ruh2a7v7xF0pzsQbACubwqc
	7r32ZKNkXe780MnPvE1iA+rO6HkCCjCh/vePDlQHjm7eR3g99EQDUVQ1fLVj7YUMIrp48gGBY74oY
	Al4B57rA==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
	by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lorenz@dolansoft.org>)
	id 1rFgUr-000rhY-1N;
	Tue, 19 Dec 2023 20:15:21 +0000
From: Lorenz Brun <lorenz@brun.one>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Add HP override
Date: Tue, 19 Dec 2023 21:15:11 +0100
Message-ID: <20231219201513.2172580-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org

This adds an override for a series of notebooks using a common config
taken from HP's proprietary Windows driver (csaudioext).

This has been tested on a HP 15-ey0xxxx device (subsystem 103C8A31)
together with another Realtek quirk and the calibration files from the
proprietary driver.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 sound/pci/hda/cs35l41_hda_property.c | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c83328971728..8135ea532a94 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -6,6 +6,7 @@
 //
 // Author: Stefan Binding <sbinding@opensource.cirrus.com>
 
+#include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/string.h>
 #include "cs35l41_hda_property.h"
@@ -81,6 +82,42 @@ static int hp_vision_acpi_fix(struct cs35l41_hda *cs35l41, struct device *physde
 	return 0;
 }
 
+/*
+ * HP 2-channel I2C configuration with internal boost (4.1A inductor current) with no _DSD,
+ * reset GPIO can still be extracted from ACPI by index. Covers HP configurations 251, 252,
+ * 253, 254, 351, 352 and 353 in the proprietary driver (csaudioext).
+ */
+static int hp_i2c_2ch_vbst_ipk41(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			      const char *hid)
+{
+	// In case a valid _DSD exists, use that instead of the override. This stops applying
+	// the override in case HP ever fixes their firmware.
+	if (device_property_count_u32(physdev, "cirrus,dev-index") > 0)
+		return -ENOENT;
+
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+
+	cs35l41->index = id == 0x40 ? 0 : 1;
+	cs35l41->channel_index = 0;
+	// Get reset GPIO (shared for both instances) from ACPI GpioIo at index 0.
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+	// Speaker ID GPIO is ACPI GpioIo index 1.
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 1);
+
+	hw_cfg->spk_pos = cs35l41->index ? 1 : 0; // left:right
+	hw_cfg->gpio1.func = CS35L41_NOT_USED;
+	hw_cfg->gpio1.valid = true;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->bst_type = CS35L41_INT_BOOST;
+	hw_cfg->bst_ind = 1000;
+	hw_cfg->bst_ipk = 4100;
+	hw_cfg->bst_cap = 10; // Exact value unknown, maps into correct range
+	hw_cfg->valid = true;
+
+	return 0;
+}
+
 struct cs35l41_prop_model {
 	const char *hid;
 	const char *ssid;
@@ -92,6 +129,28 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
 	{ "CSC3551", "103C89C6", hp_vision_acpi_fix },
+	{ "CSC3551", "103C8A28", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A29", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A2A", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A2B", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A2C", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A2D", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A2E", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A30", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8A31", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BB3", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BB4", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BDF", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE0", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE1", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE2", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE9", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BDD", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BDE", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE3", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE5", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8BE6", hp_i2c_2ch_vbst_ipk41 },
+	{ "CSC3551", "103C8B3A", hp_i2c_2ch_vbst_ipk41 },
 	{}
 };
 
-- 
2.42.0


