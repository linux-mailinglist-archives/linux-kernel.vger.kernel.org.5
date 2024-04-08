Return-Path: <linux-kernel+bounces-135238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D538689BD92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FE12842BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7CD64CFC;
	Mon,  8 Apr 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nu/qa6hv"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD65FEF9;
	Mon,  8 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573580; cv=none; b=FbKpIq2HGc7NnqI8ewSKfh70fjGJXarWG8hWJRCwlFqeuBfDP/tYsWptRLxfXlkZvPR0kzUcV4PuRbX4WpwgoOxixHWRj+UVOBtfse3CzgNIoO+xHI19mUXuAbQVs/DH0nWpKAASsbtkErL8/J2EZSnVlyylCpkhLSiJyWcggc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573580; c=relaxed/simple;
	bh=nPXVmptz56OdLEho6OfeI9Emay8PrdaXJx7f3Ty6vxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIfegbIPwkLe7pO0sx5f4sNTcCIByT4lhR1HU9/z2UEPcr1P0650BccwzvQRd3cG/neeJcet2IEj3HKr+ZQyqMxz8Y52U/8h6JjbgIWf3dE+owIRrEuZdIkYjszcZfDEfXqjJ3b5tAYtDrZ7HtND7jCbPU75IS1pUKgmKjrFhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nu/qa6hv; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385o0CV020277;
	Mon, 8 Apr 2024 05:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Ybaj5RNqmFluk/TOgHFDrpuyU98eEXfpsybGrhMcO78=; b=
	nu/qa6hvqjt3Nj2p/N+kYUujZ8ReKl2OVSIo9L0Gl8SrCJ/x5IJ+AOi/QVB3FWJb
	zKbKKz1lwSMkiaLSNHlsJjBuoHSzv1l1c+ZS0AHVesuIUqrr+8meLousuLn7uyjn
	7MKwPtItGAeh1YeAlMJKmOwBmbP12/7ukWRM0bzxNX/NHIRybucbeltJAxFO1aWI
	XYwNDk2nc8jrzvuXMkd+OjHdGfO/LRFjK5G72hksKB/VEYpQMdcenkq3s/flm2eK
	GCYsu746pGr7ESmmUpzFiUs8YQJpUeyymVYKJcOgGMUw7PqDdrnhNAIhm9XDVqn9
	KknY4CAK8f7x64CUPod+Mw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjhp0e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 05:24:18 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 11:24:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 11:24:16 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3398682024A;
	Mon,  8 Apr 2024 10:18:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/4] regmap: Add regmap_read_bypassed()
Date: Mon, 8 Apr 2024 11:18:00 +0100
Message-ID: <20240408101803.43183-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408101803.43183-1-rf@opensource.cirrus.com>
References: <20240408101803.43183-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: r1mKnv9K2x_btF63HBeaMCNqcEF-X3EN
X-Proofpoint-GUID: r1mKnv9K2x_btF63HBeaMCNqcEF-X3EN
X-Proofpoint-Spam-Reason: safe

Add a regmap_read_bypassed() to allow reads from the hardware registers
while the regmap is in cache-only mode.

This patch is a prerequisite for a bugfix to the ASoC cs35l56 driver.

A typical use for this is to keep the cache in cache-only mode until
the hardware has reached a valid state, but one or more status registers
must be polled to determine when this state is reached.

For example, firmware download on the cs35l56 can take several seconds if
there are multiple amps sharing limited bus bandwidth. This is too long
to block in probe() so it is done as a background task. The device must
be soft-reset to reboot the firmware and during this time the registers are
not accessible, so the cache should be in cache-only. But the driver must
poll a register to detect when reboot has completed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
---
I have a kunit test case for this. But it's based on top of a chain of
other changes I've made to the regmap kunit test, so I'll send it with
that chain.
---
 drivers/base/regmap/regmap.c | 37 ++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h       |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 5cb425f6f02d..0a34dd3c4f38 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2838,6 +2838,43 @@ int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val)
 }
 EXPORT_SYMBOL_GPL(regmap_read);
 
+/**
+ * regmap_read_bypassed() - Read a value from a single register direct
+ *			    from the device, bypassing the cache
+ *
+ * @map: Register map to read from
+ * @reg: Register to be read from
+ * @val: Pointer to store read value
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+int regmap_read_bypassed(struct regmap *map, unsigned int reg, unsigned int *val)
+{
+	int ret;
+	bool bypass, cache_only;
+
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	bypass = map->cache_bypass;
+	cache_only = map->cache_only;
+	map->cache_bypass = true;
+	map->cache_only = false;
+
+	ret = _regmap_read(map, reg, val);
+
+	map->cache_bypass = bypass;
+	map->cache_only = cache_only;
+
+	map->unlock(map->lock_arg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_read_bypassed);
+
 /**
  * regmap_raw_read() - Read raw data from the device
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index b743241cfb7c..d470303b1bbb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1230,6 +1230,7 @@ int regmap_multi_reg_write_bypassed(struct regmap *map,
 int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 			   const void *val, size_t val_len);
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
+int regmap_read_bypassed(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
 int regmap_noinc_read(struct regmap *map, unsigned int reg,
@@ -1739,6 +1740,13 @@ static inline int regmap_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_read_bypassed(struct regmap *map, unsigned int reg,
+				       unsigned int *val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 				  void *val, size_t val_len)
 {
-- 
2.39.2


