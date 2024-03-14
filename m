Return-Path: <linux-kernel+bounces-102918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50487B856
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCB41F2163D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46915491;
	Thu, 14 Mar 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="YUYigs8X"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC7FC05
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400261; cv=none; b=oPYPfQXHGb/Qn6P36iaiLFIBuD/wND0ScTMXC+F//v+c7urbBFQjtQ8Mqhjzv7Bq0uGa8NNLdmhNZzWnM1YmjAH+T54zXm8n5XHHyE+h03NSuYpctmepw5QViUjn8kT6zBfr9Hmq+SbySa1+su8LFqcs77E3TheMLbJRi0zo5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400261; c=relaxed/simple;
	bh=GWKuSrTWmIS6pThKyUYmnhONhinJfOqFlZ9/TygxLVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc4yMNLqlYseii0Dc93R9I+jm+9EU7mTm0O5vy1CEYDlqkvXQnfWG4023P54Z+hWrQNsdHWey3Lag4/Snj3ShL1Ly858pfzK2fc3RNOM0FB/TySjj8R+lt/yjqRf/o598lEWZ70x9ZKhVhfIgPZOnzTsi82GQWjapkZxNUzl84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=YUYigs8X; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B6DC11E88B;
	Thu, 14 Mar 2024 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1710399887; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GEQArPt1kn/Khi/Y6aFVKGpGzNy0MfkExrWMzBfSx18=;
	b=YUYigs8XxcrfutRhhvYyYa32DNKhhlNl4Y55dN5qDsljcj3jP1hXw/JgDSABfM4V02EF/L
	gJaIcBdewYXmDek2Xv0wx55JL8urYYkmrNTaNbKU7d7mMPxyQjG9ISMGfLa9uL5vJVsEqI
	t82UgJZ6tqLTJqpVCS3Up3cy1UX1HpoK2k1qSVqgbZNejw0tDE5Jr98fbwYtLGbXc7cAI7
	4DvuPtjzvztV5DnrPh3jhYyMkV2NzXg8wPgmKh909pVzjsTGEIDNWkllZI6v8Pb8q1gH+m
	M+u3Qo0cFXfjfZzIs8VuUXoQpMqNskCS7w0rAAk2bo0o3JdFCHCWup72Awxf9w==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 1/4] soc: amlogic: meson-gx-socinfo: move common code to header file
Date: Thu, 14 Mar 2024 09:59:51 +0300
Message-ID: <20240314070433.4151931-2-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314070433.4151931-1-adeep@lexina.in>
References: <20240314070433.4151931-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Move common constants and inline functions from meson-gx-socinfo driver
to header file. Create new structures for store meson64 cpu_id and chip_id.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 120 ++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 136 ++----------------
 2 files changed, 134 insertions(+), 122 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h

diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
new file mode 100644
index 000000000000..3ebb80972fc7
--- /dev/null
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Copyright (c) 2024 JetHome
+ * Author: Neil Armstrong <neil.armstrong@linaro.org>
+ * Author: Viacheslav Bocharov <adeep@lexina.in>
+ *
+ */
+
+#ifndef _MESON_GX_SOCINFO_INTERNAL_H_
+#define _MESON_GX_SOCINFO_INTERNAL_H_
+
+#include <linux/types.h>
+
+#define AO_SEC_SD_CFG8		0xe0
+#define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
+
+union meson_cpu_id {
+	struct { // cpu_id v1
+		u32 layout_ver:4;
+		u32 reserved:4;
+		u32 chip_rev:8;
+		u32 pack_id:8;
+		u32 major_id:8;
+	} v1;
+	struct { // cpu_id v2
+		u32 major_id:8;
+		u32 chip_rev:8;
+		u32 pack_id:8;
+		u32 reserved:4;
+		u32 layout_ver:4;
+	} v2;
+	u32	raw;
+};
+
+struct meson_sm_chip_id {
+	u32 version;
+	union meson_cpu_id cpu_id;
+	u8 serial[12];
+};
+
+static const struct meson_gx_soc_id {
+	const char *name;
+	unsigned int id;
+} soc_ids[] = {
+	{ "GXBB", 0x1f },
+	{ "GXTVBB", 0x20 },
+	{ "GXL", 0x21 },
+	{ "GXM", 0x22 },
+	{ "TXL", 0x23 },
+	{ "TXLX", 0x24 },
+	{ "AXG", 0x25 },
+	{ "GXLX", 0x26 },
+	{ "TXHD", 0x27 },
+	{ "G12A", 0x28 },
+	{ "G12B", 0x29 },
+	{ "SM1", 0x2b },
+	{ "A1", 0x2c },
+};
+
+static const struct meson_gx_package_id {
+	const char *name;
+	unsigned int major_id;
+	unsigned int pack_id;
+	unsigned int pack_mask;
+} soc_packages[] = {
+	{ "S905", 0x1f, 0, 0x20 }, /* pack_id != 0x20 */
+	{ "S905H", 0x1f, 0x3, 0xf }, /* pack_id & 0xf == 0x3 */
+	{ "S905M", 0x1f, 0x20, 0xf0 }, /* pack_id == 0x20 */
+	{ "S905D", 0x21, 0, 0xf0 },
+	{ "S905X", 0x21, 0x80, 0xf0 },
+	{ "S905W", 0x21, 0xa0, 0xf0 },
+	{ "S905L", 0x21, 0xc0, 0xf0 },
+	{ "S905M2", 0x21, 0xe0, 0xf0 },
+	{ "S805X", 0x21, 0x30, 0xf0 },
+	{ "S805Y", 0x21, 0xb0, 0xf0 },
+	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
+	{ "962X", 0x24, 0x10, 0xf0 },
+	{ "962E", 0x24, 0x20, 0xf0 },
+	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113D", 0x25, 0x22, 0xff },
+	{ "S905D2", 0x28, 0x10, 0xf0 },
+	{ "S905Y2", 0x28, 0x30, 0xf0 },
+	{ "S905X2", 0x28, 0x40, 0xf0 },
+	{ "A311D", 0x29, 0x10, 0xf0 },
+	{ "S922X", 0x29, 0x40, 0xf0 },
+	{ "S905D3", 0x2b, 0x4, 0xf5 },
+	{ "S905X3", 0x2b, 0x5, 0xf5 },
+	{ "S905X3", 0x2b, 0x10, 0x3f },
+	{ "S905D3", 0x2b, 0x30, 0x3f },
+	{ "A113L", 0x2c, 0x0, 0xf8 },
+};
+
+static inline const char *socinfo_v1_to_package_id(union meson_cpu_id socinfo)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
+		if (soc_packages[i].major_id == socinfo.v1.major_id &&
+		    soc_packages[i].pack_id ==
+				(socinfo.v1.pack_id & soc_packages[i].pack_mask))
+			return soc_packages[i].name;
+	}
+
+	return "Unknown";
+}
+
+static inline const char *socinfo_v1_to_soc_id(union meson_cpu_id socinfo)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(soc_ids) ; ++i) {
+		if (soc_ids[i].id == socinfo.v1.major_id)
+			return soc_ids[i].name;
+	}
+
+	return "Unknown";
+}
+
+#endif /* _MESON_GX_SOCINFO_INTERNAL_H_ */
diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6abb730344ab..006f3b09940d 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -12,118 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
-#include <linux/bitfield.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
-#define AO_SEC_SD_CFG8		0xe0
-#define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
-
-#define SOCINFO_MAJOR	GENMASK(31, 24)
-#define SOCINFO_PACK	GENMASK(23, 16)
-#define SOCINFO_MINOR	GENMASK(15, 8)
-#define SOCINFO_MISC	GENMASK(7, 0)
-
-static const struct meson_gx_soc_id {
-	const char *name;
-	unsigned int id;
-} soc_ids[] = {
-	{ "GXBB", 0x1f },
-	{ "GXTVBB", 0x20 },
-	{ "GXL", 0x21 },
-	{ "GXM", 0x22 },
-	{ "TXL", 0x23 },
-	{ "TXLX", 0x24 },
-	{ "AXG", 0x25 },
-	{ "GXLX", 0x26 },
-	{ "TXHD", 0x27 },
-	{ "G12A", 0x28 },
-	{ "G12B", 0x29 },
-	{ "SM1", 0x2b },
-	{ "A1", 0x2c },
-};
-
-static const struct meson_gx_package_id {
-	const char *name;
-	unsigned int major_id;
-	unsigned int pack_id;
-	unsigned int pack_mask;
-} soc_packages[] = {
-	{ "S905", 0x1f, 0, 0x20 }, /* pack_id != 0x20 */
-	{ "S905H", 0x1f, 0x3, 0xf }, /* pack_id & 0xf == 0x3 */
-	{ "S905M", 0x1f, 0x20, 0xf0 }, /* pack_id == 0x20 */
-	{ "S905D", 0x21, 0, 0xf0 },
-	{ "S905X", 0x21, 0x80, 0xf0 },
-	{ "S905W", 0x21, 0xa0, 0xf0 },
-	{ "S905L", 0x21, 0xc0, 0xf0 },
-	{ "S905M2", 0x21, 0xe0, 0xf0 },
-	{ "S805X", 0x21, 0x30, 0xf0 },
-	{ "S805Y", 0x21, 0xb0, 0xf0 },
-	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
-	{ "962X", 0x24, 0x10, 0xf0 },
-	{ "962E", 0x24, 0x20, 0xf0 },
-	{ "A113X", 0x25, 0x37, 0xff },
-	{ "A113D", 0x25, 0x22, 0xff },
-	{ "S905D2", 0x28, 0x10, 0xf0 },
-	{ "S905Y2", 0x28, 0x30, 0xf0 },
-	{ "S905X2", 0x28, 0x40, 0xf0 },
-	{ "A311D", 0x29, 0x10, 0xf0 },
-	{ "S922X", 0x29, 0x40, 0xf0 },
-	{ "S905D3", 0x2b, 0x4, 0xf5 },
-	{ "S905X3", 0x2b, 0x5, 0xf5 },
-	{ "S905X3", 0x2b, 0x10, 0x3f },
-	{ "S905D3", 0x2b, 0x30, 0x3f },
-	{ "A113L", 0x2c, 0x0, 0xf8 },
-};
-
-static inline unsigned int socinfo_to_major(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_MAJOR, socinfo);
-}
-
-static inline unsigned int socinfo_to_minor(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_MINOR, socinfo);
-}
-
-static inline unsigned int socinfo_to_pack(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_PACK, socinfo);
-}
-
-static inline unsigned int socinfo_to_misc(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_MISC, socinfo);
-}
-
-static const char *socinfo_to_package_id(u32 socinfo)
-{
-	unsigned int pack = socinfo_to_pack(socinfo);
-	unsigned int major = socinfo_to_major(socinfo);
-	int i;
-
-	for (i = 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
-		if (soc_packages[i].major_id == major &&
-		    soc_packages[i].pack_id ==
-				(pack & soc_packages[i].pack_mask))
-			return soc_packages[i].name;
-	}
-
-	return "Unknown";
-}
-
-static const char *socinfo_to_soc_id(u32 socinfo)
-{
-	unsigned int id = socinfo_to_major(socinfo);
-	int i;
-
-	for (i = 0 ; i < ARRAY_SIZE(soc_ids) ; ++i) {
-		if (soc_ids[i].id == id)
-			return soc_ids[i].name;
-	}
-
-	return "Unknown";
-}
+#include "meson-gx-socinfo-internal.h"
 
 static int __init meson_gx_socinfo_init(void)
 {
@@ -131,7 +23,7 @@ static int __init meson_gx_socinfo_init(void)
 	struct soc_device *soc_dev;
 	struct device_node *np;
 	struct regmap *regmap;
-	unsigned int socinfo;
+	union meson_cpu_id socinfo;
 	struct device *dev;
 	int ret;
 
@@ -160,11 +52,11 @@ static int __init meson_gx_socinfo_init(void)
 		return -ENODEV;
 	}
 
-	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo);
+	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo.raw);
 	if (ret < 0)
 		return ret;
 
-	if (!socinfo) {
+	if (!socinfo.raw) {
 		pr_err("%s: invalid chipid value\n", __func__);
 		return -EINVAL;
 	}
@@ -175,13 +67,13 @@ static int __init meson_gx_socinfo_init(void)
 
 	soc_dev_attr->family = "Amlogic Meson";
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
-					   socinfo_to_major(socinfo),
-					   socinfo_to_minor(socinfo),
-					   socinfo_to_pack(socinfo),
-					   socinfo_to_misc(socinfo));
+					   socinfo.v1.major_id,
+					   socinfo.v1.chip_rev,
+					   socinfo.v1.pack_id,
+					   (socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
 	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
-					 socinfo_to_soc_id(socinfo),
-					 socinfo_to_package_id(socinfo));
+					 socinfo_v1_to_soc_id(socinfo),
+					 socinfo_v1_to_package_id(socinfo));
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
@@ -194,10 +86,10 @@ static int __init meson_gx_socinfo_init(void)
 
 	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
 			soc_dev_attr->soc_id,
-			socinfo_to_major(socinfo),
-			socinfo_to_minor(socinfo),
-			socinfo_to_pack(socinfo),
-			socinfo_to_misc(socinfo));
+			socinfo.v1.major_id,
+			socinfo.v1.chip_rev,
+			socinfo.v1.pack_id,
+			(socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
 
 	return 0;
 }
-- 
2.43.2


