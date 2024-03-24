Return-Path: <linux-kernel+bounces-114337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34869888FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CFC1C2C07F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D27170EA6;
	Sun, 24 Mar 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7XOzLrx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA35212573;
	Sun, 24 Mar 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321720; cv=none; b=SpBJWyx2LGq5r3A4XmQCDcvVle1UkxmqmObWhOCYOTiHKR03tFuOfUyA6UpWp45nSfkNo1pRQgcqP12jy+SnPb4DOFxg4zwQxkBJbW0qDdasPmNn19+5Ci70ec8fLUHTJQOfG8Wx6PVz+fVjcI13IRJ8N+gFW5XKLRbENRyi7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321720; c=relaxed/simple;
	bh=KEA83UpobQFHF0HVpGC3RmHsZkNJGZsXy8B/QLDi5dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXJlvZpMTjYZeraCNCZPyrCJIhnRJRHz2aJdkULpg09IYxpYih/8R0STO9vDlvMVicT1HKsVNY3EsK8kTjcMGHVZiGTLxJpFtxKqldTVBd5EAoquQJvw7OJEahPe8bD7/zJcs5n2grUux899djmZxrVLK1A1BHTlL8Z0Iek2yhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7XOzLrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E908C43390;
	Sun, 24 Mar 2024 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321719;
	bh=KEA83UpobQFHF0HVpGC3RmHsZkNJGZsXy8B/QLDi5dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7XOzLrxjbPGVGuH7p3RwvqSsr+Lg9kVUFjmAA5AS3ErlAm3IoEhU5Q3s/+3m/ibG
	 B1Trj9uRFyeB1mIlYUSp5a1dJZWVohFUU+hbbjW71GSrO3LTyaKSJEaZjz0D86JrQ8
	 ntLCiFyeacrsfzNYc7IfDOAmtALhArsXGM2gQBpz+mi8Hm4bzlzG0b1LSQTRihZhy8
	 OEeCYgT7H8gL7Xn0EIy9ft6HJDAAhPCxbpwSR1SnMgaNDdTZRv0sagxWRBOygTz/5r
	 eCrjre385PUKOswTSwBm4vZwJ/mfiTGMYKNfCd36k4IZhujCDYRfS2G7M/PKIC69Wr
	 z5qD54fAaN4Mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 447/638] crypto: qat - move adf_cfg_services
Date: Sun, 24 Mar 2024 18:58:04 -0400
Message-ID: <20240324230116.1348576-448-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 03c76e8e7a8d0d465838b8eaffcc07bdcc364f4d ]

The file adf_cfg_services.h cannot be included in header files since it
instantiates the structure adf_cfg_services. Move that structure to its
own file and export the symbol.

This does not introduce any functional change.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: df018f82002a ("crypto: qat - fix ring to service map for dcc in 4xxx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |  2 +-
 drivers/crypto/intel/qat/qat_common/Makefile  |  1 +
 .../intel/qat/qat_common/adf_cfg_services.c   | 20 +++++++++++++++++++
 .../intel/qat/qat_common/adf_cfg_services.h   | 14 ++-----------
 4 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cfg_services.c

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index a5691ba0b7244..678b94c8d836a 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -3,6 +3,7 @@
 #include <linux/iopoll.h>
 #include <adf_accel_devices.h>
 #include <adf_cfg.h>
+#include <adf_cfg_services.h>
 #include <adf_clock.h>
 #include <adf_common_drv.h>
 #include <adf_gen4_dc.h>
@@ -11,7 +12,6 @@
 #include <adf_gen4_pm.h>
 #include <adf_gen4_timer.h>
 #include "adf_4xxx_hw_data.h"
-#include "adf_cfg_services.h"
 #include "icp_qat_hw.h"
 
 #define ADF_AE_GROUP_0		GENMASK(3, 0)
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 43622c7fca712..8dbf146de3fa5 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_CRYPTO_DEV_QAT) += intel_qat.o
 intel_qat-objs := adf_cfg.o \
 	adf_isr.o \
 	adf_ctl_drv.o \
+	adf_cfg_services.o \
 	adf_dev_mgr.o \
 	adf_init.o \
 	adf_accel_engine.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
new file mode 100644
index 0000000000000..8e13fe938959b
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+
+#include <linux/export.h>
+#include "adf_cfg_services.h"
+#include "adf_cfg_strings.h"
+
+const char *const adf_cfg_services[] = {
+	[SVC_CY] = ADF_CFG_CY,
+	[SVC_CY2] = ADF_CFG_ASYM_SYM,
+	[SVC_DC] = ADF_CFG_DC,
+	[SVC_DCC] = ADF_CFG_DCC,
+	[SVC_SYM] = ADF_CFG_SYM,
+	[SVC_ASYM] = ADF_CFG_ASYM,
+	[SVC_DC_ASYM] = ADF_CFG_DC_ASYM,
+	[SVC_ASYM_DC] = ADF_CFG_ASYM_DC,
+	[SVC_DC_SYM] = ADF_CFG_DC_SYM,
+	[SVC_SYM_DC] = ADF_CFG_SYM_DC,
+};
+EXPORT_SYMBOL_GPL(adf_cfg_services);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
index b353d40c5c6d0..f78fd697b4bee 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
@@ -16,19 +16,9 @@ enum adf_services {
 	SVC_ASYM_DC,
 	SVC_DC_SYM,
 	SVC_SYM_DC,
+	SVC_COUNT
 };
 
-static const char *const adf_cfg_services[] = {
-	[SVC_CY] = ADF_CFG_CY,
-	[SVC_CY2] = ADF_CFG_ASYM_SYM,
-	[SVC_DC] = ADF_CFG_DC,
-	[SVC_DCC] = ADF_CFG_DCC,
-	[SVC_SYM] = ADF_CFG_SYM,
-	[SVC_ASYM] = ADF_CFG_ASYM,
-	[SVC_DC_ASYM] = ADF_CFG_DC_ASYM,
-	[SVC_ASYM_DC] = ADF_CFG_ASYM_DC,
-	[SVC_DC_SYM] = ADF_CFG_DC_SYM,
-	[SVC_SYM_DC] = ADF_CFG_SYM_DC,
-};
+extern const char *const adf_cfg_services[SVC_COUNT];
 
 #endif
-- 
2.43.0


