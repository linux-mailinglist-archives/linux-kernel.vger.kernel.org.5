Return-Path: <linux-kernel+bounces-40047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF4283D955
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CA22904D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246D17582;
	Fri, 26 Jan 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ORhvMPla"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395314265;
	Fri, 26 Jan 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268636; cv=none; b=SVls+rzxiuExjSsb88M9S1TbDSJwTGKzSEzr66YA34Xt+L8sKHoIa7fU9xAqmEKa5vAypbPRbUyIfnp0+xBLYM9BQ4v47/BO4/wuURz8HoL9sVTM9CJMz9Zo1WjciZnl8XSB3zIpiP9PsnOiUlnuczc1OUVQt4LTeM+F2zUrPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268636; c=relaxed/simple;
	bh=aMFNEHURVJkKdqp4qghm6tQhsHtXoLfSATP3Qw8Drlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMqHMso8SVZDcppF72u7IDH83GjBXKvvR/9lv2LGJ8IYRd/GytcRHHRkthHz9zWm3hoOCsAIKPIPGQwZWqDPVxlcoePBwjcQQjMhRgt/M53Y/YVL2t5mlOfHOLJYrwnR7q7uSCtiYPn/5y1O0LV5M4ANKGoA3vua5t7DIW1nXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ORhvMPla; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q5FRfx020176;
	Fri, 26 Jan 2024 05:30:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=UPXkoRw2vL+RtRC57FFTWGm0OZI2iZrGhiK9uMrNTrg=; b=
	ORhvMPlaWGm7fBEaTeHOtsT6S0jDRvc6nNw/xbTjIEKe7DBHsINsiWCxQUEq/OAm
	JfmVL2wRX2fKPD0/Nkp3j7DQY2lIn3bPOSkmn06eE+WhAy+FI4sUM28zx1eK6LwK
	r3qpicZ8q5zN56xeAxc60lTmIEWvpccN2ckCXDVJNrHgSYKbx19oww/F2lT2lb40
	So0+KxZyCySNu4VOxmQsCjaE6mXUwvoyMGFUZbIwboKWpPbcDJtrGdssey/sMQvG
	vdepZ2RUqFGoQe1WemF5Q1rw3eBIJCGz0ew2cWGwdrifIzTC87Tfp0Q8WDpEASxI
	0JPfyufNZcnJ+MFY8JipOQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhksnq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 05:30:20 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 11:30:17 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 26 Jan 2024 11:30:17 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (LONNG2L6RQ3.ad.cirrus.com [198.90.238.116])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B3BDD820243;
	Fri, 26 Jan 2024 11:30:17 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 3/4] ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker ID
Date: Fri, 26 Jan 2024 11:30:06 +0000
Message-ID: <20240126113007.4084-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
References: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RnJ3qOuBtr-VW9y0VbZv5XTu_CKkcNm6
X-Proofpoint-GUID: RnJ3qOuBtr-VW9y0VbZv5XTu_CKkcNm6
X-Proofpoint-Spam-Reason: safe

Laptops 103C8C66, 103C8C67, 103C8C68, 103C8C6A use a dual speaker id
system where each speaker has its own speaker id.
The generic configuration table doesn't support this, so it needs its
own function.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 6714740b85c8..5f8c214699d6 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -335,6 +335,42 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 	return 0;
 }
 
+/*
+ * Systems 103C8C66, 103C8C67, 103C8C68, 103C8C6A use a dual speaker id system - each speaker has
+ * its own speaker id.
+ */
+static int hp_i2c_int_2amp_dual_spkid(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+				      const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+
+	/* If _DSD exists for this laptop, we cannot support it through here */
+	if (acpi_dev_has_props(cs35l41->dacpi))
+		return -ENOENT;
+
+	/* check I2C address to assign the index */
+	cs35l41->index = id == 0x40 ? 0 : 1;
+	cs35l41->channel_index = 0;
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+	if (cs35l41->index == 0)
+		cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 1);
+	else
+		cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
+	hw_cfg->spk_pos = cs35l41->index;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->valid = true;
+
+	hw_cfg->bst_type = CS35L41_INT_BOOST;
+	hw_cfg->bst_ind = 1000;
+	hw_cfg->bst_ipk = 4100;
+	hw_cfg->bst_cap = 24;
+	hw_cfg->gpio1.func = CS35L41_NOT_USED;
+	hw_cfg->gpio1.valid = true;
+
+	return 0;
+}
+
 /*
  * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
  * And devices created by serial-multi-instantiate don't have their device struct
@@ -414,6 +450,10 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "103C8C4F", generic_dsd_config },
 	{ "CSC3551", "103C8C50", generic_dsd_config },
 	{ "CSC3551", "103C8C51", generic_dsd_config },
+	{ "CSC3551", "103C8C66", hp_i2c_int_2amp_dual_spkid },
+	{ "CSC3551", "103C8C67", hp_i2c_int_2amp_dual_spkid },
+	{ "CSC3551", "103C8C68", hp_i2c_int_2amp_dual_spkid },
+	{ "CSC3551", "103C8C6A", hp_i2c_int_2amp_dual_spkid },
 	{ "CSC3551", "103C8CDD", generic_dsd_config },
 	{ "CSC3551", "103C8CDE", generic_dsd_config },
 	{ "CSC3551", "104312AF", generic_dsd_config },
-- 
2.34.1


