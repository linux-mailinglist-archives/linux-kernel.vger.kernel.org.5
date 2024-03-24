Return-Path: <linux-kernel+bounces-115501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5414889BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457211F20E38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2723451A;
	Mon, 25 Mar 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijidGH+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BA1EBD53;
	Sun, 24 Mar 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320939; cv=none; b=XpxR1GX2KP/iJCsG4AR2m1P8GBfUCqNofG3yEZvWXuxkBahuSRsEj6+uH+6NQbvEWjMOUVDURWqEkw3jSJkzOaOZpEgEt/WatjMrip70Za8YQbe/6rYRmhZhdEErXb7u5Fb7yfTu06DD9l6MKLavHzJGKgCsJatq2PAmdJjulOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320939; c=relaxed/simple;
	bh=Kuw7+MXs4yS0Akus5Na0CQgBL6R6Lr5yfB+0HGzMRbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/Bv3aiqP15kQ4TweEnr/0Azo3jQyA/63DHS5hxMInwHvIVlRpzEiYN6BcLKoLM5jOyPBy4EQvfLe03y8gYeW1AQzf75G7ALnxYrarrPzfwcdIp4mWryDkVOpPvPyWagnt90IphvFcviSzJASTzGu54mV2E8k6GqbF8qcROGzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijidGH+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416ACC433F1;
	Sun, 24 Mar 2024 22:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320939;
	bh=Kuw7+MXs4yS0Akus5Na0CQgBL6R6Lr5yfB+0HGzMRbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijidGH+2Tzvnxq38pvr98Ccj+WN/Ibqf+16M8W59aOUW1twUt8Q7/OfM9Su3dQ5xZ
	 zZxhC63g8TE5ZU+ZVhe8AQDjtWCwcpmOjVgnRDl3idRSZbfXtXeY7HS7M6IvQhsnso
	 NGrAJF9gxWIFWE2LQjjPQWMJhVE21VRkK9JdVe4Fvi/E13aE4qgbEbaLaaYwNyHhxf
	 Gcv1+MsZKDC31zZMzMOYZTRt7B+KVqUKmTwSCjvQ5hWicjssPidCJaBfgG64NQ029J
	 b3n2GZ6lg1sQZo9Ym2D3FbsCnCPsQpo9MylgG8Euo79PIW6E8FYEyqChf1Qkjxf94z
	 Ncb1qpRCXhBmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <jie.wang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 502/713] crypto: qat - relocate and rename get_service_enabled()
Date: Sun, 24 Mar 2024 18:43:48 -0400
Message-ID: <20240324224720.1345309-503-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jie Wang <jie.wang@intel.com>

[ Upstream commit 4db87a5f9e3026d72e03bbdf1dac1dc5303e37f7 ]

Move the function get_service_enabled() from adf_4xxx_hw_data.c to
adf_cfg_services.c and rename it as adf_get_service_enabled().
This function is not specific to the 4xxx and will be used by
other QAT drivers.

This does not introduce any functional change.

Signed-off-by: Jie Wang <jie.wang@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: df018f82002a ("crypto: qat - fix ring to service map for dcc in 4xxx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 29 ++-----------------
 .../intel/qat/qat_common/adf_cfg_services.c   | 27 +++++++++++++++++
 .../intel/qat/qat_common/adf_cfg_services.h   |  4 +++
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 0faedb5b2eb5a..9763402cd486b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -120,29 +120,6 @@ static struct adf_hw_device_class adf_4xxx_class = {
 	.instances = 0,
 };
 
-static int get_service_enabled(struct adf_accel_dev *accel_dev)
-{
-	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
-	int ret;
-
-	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
-				      ADF_SERVICES_ENABLED, services);
-	if (ret) {
-		dev_err(&GET_DEV(accel_dev),
-			ADF_SERVICES_ENABLED " param not found\n");
-		return ret;
-	}
-
-	ret = match_string(adf_cfg_services, ARRAY_SIZE(adf_cfg_services),
-			   services);
-	if (ret < 0)
-		dev_err(&GET_DEV(accel_dev),
-			"Invalid value of " ADF_SERVICES_ENABLED " param: %s\n",
-			services);
-
-	return ret;
-}
-
 static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
 	return ADF_4XXX_ACCELERATORS_MASK;
@@ -275,7 +252,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
 	}
 
-	switch (get_service_enabled(accel_dev)) {
+	switch (adf_get_service_enabled(accel_dev)) {
 	case SVC_CY:
 	case SVC_CY2:
 		return capabilities_sym | capabilities_asym;
@@ -311,7 +288,7 @@ static enum dev_sku_info get_sku(struct adf_hw_device_data *self)
 
 static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
-	switch (get_service_enabled(accel_dev)) {
+	switch (adf_get_service_enabled(accel_dev)) {
 	case SVC_DC:
 		return thrd_to_arb_map_dc;
 	case SVC_DCC:
@@ -420,7 +397,7 @@ static u32 uof_get_num_objs(void)
 
 static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev)
 {
-	switch (get_service_enabled(accel_dev)) {
+	switch (adf_get_service_enabled(accel_dev)) {
 	case SVC_CY:
 	case SVC_CY2:
 		return adf_fw_cy_config;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
index 8e13fe938959b..2680522944684 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
@@ -2,6 +2,9 @@
 /* Copyright(c) 2023 Intel Corporation */
 
 #include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include "adf_cfg.h"
 #include "adf_cfg_services.h"
 #include "adf_cfg_strings.h"
 
@@ -18,3 +21,27 @@ const char *const adf_cfg_services[] = {
 	[SVC_SYM_DC] = ADF_CFG_SYM_DC,
 };
 EXPORT_SYMBOL_GPL(adf_cfg_services);
+
+int adf_get_service_enabled(struct adf_accel_dev *accel_dev)
+{
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
+	int ret;
+
+	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
+				      ADF_SERVICES_ENABLED, services);
+	if (ret) {
+		dev_err(&GET_DEV(accel_dev),
+			ADF_SERVICES_ENABLED " param not found\n");
+		return ret;
+	}
+
+	ret = match_string(adf_cfg_services, ARRAY_SIZE(adf_cfg_services),
+			   services);
+	if (ret < 0)
+		dev_err(&GET_DEV(accel_dev),
+			"Invalid value of " ADF_SERVICES_ENABLED " param: %s\n",
+			services);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adf_get_service_enabled);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
index f78fd697b4bee..c6b0328b0f5b0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
@@ -5,6 +5,8 @@
 
 #include "adf_cfg_strings.h"
 
+struct adf_accel_dev;
+
 enum adf_services {
 	SVC_CY = 0,
 	SVC_CY2,
@@ -21,4 +23,6 @@ enum adf_services {
 
 extern const char *const adf_cfg_services[SVC_COUNT];
 
+int adf_get_service_enabled(struct adf_accel_dev *accel_dev);
+
 #endif
-- 
2.43.0


