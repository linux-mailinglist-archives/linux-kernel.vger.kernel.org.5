Return-Path: <linux-kernel+bounces-114338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814A5888A37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56AEB29C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8F171083;
	Sun, 24 Mar 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUkueWGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0021257E;
	Sun, 24 Mar 2024 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321721; cv=none; b=LB8gD9Iw2u8Dku3ipIXh51O3AWQ14xlflsRO77zX9QOtrzYysVN/9984li/w6ptmv5wfWNiBoePhuCTnHuxaSVrsP//EAAD+cCNc5lmRTtdr4Kf3GzANIdJW9mwm0k5mnKZaDJBXSPepc8B1BYDXDXlf1uaw2Dj5vcYpyZYG9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321721; c=relaxed/simple;
	bh=DRaaWuTQtA1aRLU+d7j/c7F83YDmV0bYKSGrVeNKZAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0I4v/K6T2n4zAFkQn4KaHtNm5ibzDJzL6fuyEvMzuYOl/xZYcxUXnhTkgZ0HvDTj6ZFUPRgPRB8PVt9tFFGrqJ4s0h/xWkkYzoXwIq0jChJ9hOjstPzCJ2gCN5gvlP05gXaqiTSETeqoiY0lYWp69Gz9kzMMjm7aPXb+OW5gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUkueWGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58389C43399;
	Sun, 24 Mar 2024 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321720;
	bh=DRaaWuTQtA1aRLU+d7j/c7F83YDmV0bYKSGrVeNKZAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUkueWGQ4vpRdzw+laznOupzocciHm2UBH+F/PkKtZhn7zTs6G2LS3Fsqcjz+PpDu
	 /7Yyep1GR2lG8AjT4pttrZWsOPJ36qk71D3hANurf+aSmMN2Ee8LXurvXSMt/eKD9O
	 EHFTucZS0f3fTy4JLhcy3WVuOHZBcxuItdBJKSH2E8cxqqEK02QxMnzF0loMSVCqQH
	 0RBqrbi1ovFXdetVkpTI+q9L1SQBfaPObezfOfAVh7G1MI+OrxQuOL4c6rY/LMR4jq
	 La4GLER30Np/MAg+Pjk3EqvoscLjTTqBxpD2I2Ki4mrwOpneZRH1b10Zw+OlqXJxCj
	 EDHjViISdSdMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jie Wang <jie.wang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 448/638] crypto: qat - relocate and rename get_service_enabled()
Date: Sun, 24 Mar 2024 18:58:05 -0400
Message-ID: <20240324230116.1348576-449-sashal@kernel.org>
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
index 678b94c8d836a..524fdcf3d973b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -118,29 +118,6 @@ static struct adf_hw_device_class adf_4xxx_class = {
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
@@ -273,7 +250,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 		capabilities_dc &= ~ICP_ACCEL_CAPABILITIES_CNV_INTEGRITY64;
 	}
 
-	switch (get_service_enabled(accel_dev)) {
+	switch (adf_get_service_enabled(accel_dev)) {
 	case SVC_CY:
 	case SVC_CY2:
 		return capabilities_sym | capabilities_asym;
@@ -309,7 +286,7 @@ static enum dev_sku_info get_sku(struct adf_hw_device_data *self)
 
 static const u32 *adf_get_arbiter_mapping(struct adf_accel_dev *accel_dev)
 {
-	switch (get_service_enabled(accel_dev)) {
+	switch (adf_get_service_enabled(accel_dev)) {
 	case SVC_DC:
 		return thrd_to_arb_map_dc;
 	case SVC_DCC:
@@ -400,7 +377,7 @@ static u32 uof_get_num_objs(void)
 
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


