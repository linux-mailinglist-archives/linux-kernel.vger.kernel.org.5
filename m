Return-Path: <linux-kernel+bounces-114136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A868888A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBDD1F29130
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE01241086;
	Sun, 24 Mar 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6Pgxw/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386122036E2;
	Sun, 24 Mar 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321447; cv=none; b=Dy5S2xWUaPaXNNx9PfMSGLpdGpQZy4KAx//pQhYqLSUfvJTJGDiV2tkCvCkryFEcz5yvKg3ZEE3jXSapaRaNO0Va6EgtZVVg9FqLE+CXCyZeLYRG3vXwABBGgJ1ZOaWzipXKXM6SsgNZDDyuRerzZC6SiVKniSTPH1FBhaFnLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321447; c=relaxed/simple;
	bh=SGO2kyJXIwyHGUHYTB8Mekda7zhCYJ9gH/C8Rm4iJRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCJT40jzx+ZYWiTHqUAhXAP8hf5DKNZGiVGBA3BOX0x19HfIfUQz2+pDbQC+lXTFd7anMlkO5JHj4AUvMmG8w/wqyBn8gI6S/b4jWwvg4zBQzA6v0qO7JXrZH7orctRu+IF9HnbRDcN9jtonb7NAYY/sZsmUZ4JXQqeBJ+G59oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6Pgxw/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6FEC43390;
	Sun, 24 Mar 2024 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321446;
	bh=SGO2kyJXIwyHGUHYTB8Mekda7zhCYJ9gH/C8Rm4iJRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6Pgxw/pM5sjEf+50D0Yimq29buhkw2/bf8Qzop95fqth2K6Hz075UpbzxeIIL2iX
	 Z5BymbA/v0iUKSok/CsrErcCrS+73zLzJNhKG7hCFEKTmXeK1fJmiJVTgcWHApSVV9
	 VE+a9XnDDUC5UdGmSwD708W7VtIPKihKsJiYEefkO7IaSuspAJBBiElHSq6PnapqoA
	 /WNUG0AQd8c0Mcyx8sOhxI2sBubDA+Z+2xXQWxOjIc8j99h2FxKNCr2C15lSff1B18
	 6hwBBLX7OTFpSqRsJgxeNbGSgl9lpQnHCCOzDPVruQ32Nk9WMmOJOjqDXeeUzRg1A3
	 tSOL+GSx6Mzwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman Gregory <gregory.greenman@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 170/638] wifi: iwlwifi: acpi: fix WPFC reading
Date: Sun, 24 Mar 2024 18:53:27 -0400
Message-ID: <20240324230116.1348576-171-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 296f3e926716ded8dc29e349d2b042b362f96515 ]

The code reading the WPFC table needs to take into account
the domain type (first element in the package), shouldn't
leak the memory if it fails, and has a bad comment. Fix all
these issues.

Fixes: c4c954547755 ("wifi: iwlwifi: implement WPFC ACPI table loading")
Reported-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman Gregory <gregory.greenman@intel.com>
Link: https://msgid.link/20240128084842.2afeb476b62d.I200568dc42a277e21c12be99d5aaa39b009d45da@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 359397a617153..564eeb002e8ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1268,7 +1268,6 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 	if (IS_ERR(data))
 		return;
 
-	/* try to read wtas table revision 1 or revision 0*/
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WPFC_WIFI_DATA_SIZE,
 					 &tbl_rev);
@@ -1278,13 +1277,14 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 	if (tbl_rev != 0)
 		goto out_free;
 
-	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) != ACPI_WPFC_WIFI_DATA_SIZE);
+	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) !=
+		     ACPI_WPFC_WIFI_DATA_SIZE - 1);
 
 	for (i = 0; i < ARRAY_SIZE(filters->filter_cfg_chains); i++) {
-		if (wifi_pkg->package.elements[i].type != ACPI_TYPE_INTEGER)
-			return;
+		if (wifi_pkg->package.elements[i + 1].type != ACPI_TYPE_INTEGER)
+			goto out_free;
 		tmp.filter_cfg_chains[i] =
-			cpu_to_le32(wifi_pkg->package.elements[i].integer.value);
+			cpu_to_le32(wifi_pkg->package.elements[i + 1].integer.value);
 	}
 
 	IWL_DEBUG_RADIO(fwrt, "Loaded WPFC filter config from ACPI\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index c36c62d6414de..8784e50407be8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -56,7 +56,7 @@
 #define ACPI_EWRD_WIFI_DATA_SIZE_REV2	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 3)
-#define ACPI_WPFC_WIFI_DATA_SIZE	4 /* 4 filter config words */
+#define ACPI_WPFC_WIFI_DATA_SIZE	5 /* domain and 4 filter config words */
 
 /* revision 0 and 1 are identical, except for the semantics in the FW */
 #define ACPI_GEO_NUM_BANDS_REV0		2
-- 
2.43.0


