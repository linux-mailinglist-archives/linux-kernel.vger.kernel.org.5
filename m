Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05997F4742
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjKVM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjKVM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:57:07 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37161D54;
        Wed, 22 Nov 2023 04:56:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFAD0540A1;
        Wed, 22 Nov 2023 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1700657813; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=wZJcknLSQE6kdQ1bjcwbk6f5DDGjp+KGewdb43Z6bVU=;
        b=emeAcex7MTdNQYItOcD8oAXdXllmUPtwiSxVek/oU9dagw+hjG40EtoNTlqEiT7PBGGv5p
        Tw4A+4EwhwpzNK1NR/cVAvuAupb1zlpevsD16mCUDfSv9ZVHyGUO18dFsA5DCQg1LAPI4I
        NPRHb+VTA2Ny2NYi5koOIEOIkBIhdd1O/5t5Cc1riemheMwILWzeZiyZlCWf/5/RpWg/kF
        WYQXLYhgeDqDKV5g09aPS0h1kkKUmqUWbJDEPU3fOwKwU7rNU8R5d+Mx+IUZXFgyfhILUA
        2fuzAv46AropR7GHODaAOFlMsO9A/Bxinw1qPAO2ZJsrTWqVcNIfZgM1xmM2nw==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/5] soc: amlogic: meson-gx-socinfo: move common code to header file
Date:   Wed, 22 Nov 2023 15:56:39 +0300
Message-Id: <20231122125643.1717160-2-adeep@lexina.in>
In-Reply-To: <20231122125643.1717160-1-adeep@lexina.in>
References: <20231122125643.1717160-1-adeep@lexina.in>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5915; h=from:subject; bh=5lDOXBX94eQyb3bj1qrCKOVZy2f8VFuTwJBZrTGTfS8=; b=owGbwMvMwCHmnhFhrJcZuJTxtFoSQ2rstyNT4n5meL12Twx8OXWtnueVUnEp3foo/U9SB7vuSBuU Rhh1lLIwiHEwyIopsoR1BE3d57H64sQFRgdg5rAygQxh4OIUgIn8DGZk+LejpoBpQ8nKiNOrzVZUpu b879gglvdhlYes3MZpbh65LYwM5w9JLb2bZGIlyvTLPu7tPHfFMEWpIMmF4Vx6TelTxNPZAQ==
X-Developer-Key: i=adeep@lexina.in; a=openpgp; fpr=E2FA1A767ACB0716E02E3E7AEE36B110025A8DFA
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common constants and inline functions from meson-gx-socinfo driver
to header file

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 99 +++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 80 +--------------
 2 files changed, 100 insertions(+), 79 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h

diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
new file mode 100644
index 000000000000..884cf8fb580f
--- /dev/null
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Copyright (C) 2023 JetHome
+ *
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Author: Viacheslav Bocharov <adeep@lexina.in>
+ */
+
+#ifndef _MESON_GX_SOCINFO_INTERNAL_H_
+#define _MESON_GX_SOCINFO_INTERNAL_H_
+
+#include <linux/bitfield.h>
+
+#define AO_SEC_SD_CFG8		0xe0
+#define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
+
+#define SOCINFO_MAJOR	GENMASK(31, 24)
+#define SOCINFO_PACK	GENMASK(23, 16)
+#define SOCINFO_MINOR	GENMASK(15, 8)
+#define SOCINFO_MISC	GENMASK(7, 0)
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
+	{ "A113X", 0x25, 0x43, 0xff },
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
+
+static inline unsigned int socinfo_to_major(u32 socinfo)
+{
+	return FIELD_GET(SOCINFO_MAJOR, socinfo);
+}
+
+static inline unsigned int socinfo_to_minor(u32 socinfo)
+{
+	return FIELD_GET(SOCINFO_MINOR, socinfo);
+}
+
+static inline unsigned int socinfo_to_pack(u32 socinfo)
+{
+	return FIELD_GET(SOCINFO_PACK, socinfo);
+}
+
+static inline unsigned int socinfo_to_misc(u32 socinfo)
+{
+	return FIELD_GET(SOCINFO_MISC, socinfo);
+}
+
+#endif /* _MESON_GX_SOCINFO_INTERNAL_H_ */
+
diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6abb730344ab..9d7921c0fb91 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -16,85 +16,7 @@
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
+#include "meson-gx-socinfo-internal.h"
 
 static const char *socinfo_to_package_id(u32 socinfo)
 {
-- 
2.34.1

