Return-Path: <linux-kernel+bounces-113672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D828885ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D956284E17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AAB1DF0E9;
	Sun, 24 Mar 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfVjYYf5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131B14389B;
	Sun, 24 Mar 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320630; cv=none; b=k31Vq6bRZCPlwPcZOLL0w3E5xU7h1UsZX8VvJ341OLQVbK/P0M3IoJLxXOhGufkshi4rAqlFp5AGq5dmkc0GMMw4Y7HovEQNayMt+C5YNivTt9iq65/7WVciYlRsSIVfQY/5yHjJzZkgsyV3u64ri6ShYXba7JuIqSehvWoid0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320630; c=relaxed/simple;
	bh=Q33wawuXrNE4Ttm2focUd5VKY7etrwROUKCZsilVbIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC2YuybvcoyxhLUAlKMgEbiSb3x/08x8LCPmTk/FUnpNfHUBnBNTbdeAA0Cez/FYbNNiHI3YnhObfEumkojO+e7LqTV+jbrita04aUeX2NjetfAQ5VeTSbb/EUQtC3ghvhgupZhN6VsQjQJdRli/9DHuIRiwWGh8gIImY68HJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfVjYYf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21345C43390;
	Sun, 24 Mar 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320628;
	bh=Q33wawuXrNE4Ttm2focUd5VKY7etrwROUKCZsilVbIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfVjYYf5Q5SduJZqE0rNVcC5du009Xra7Q2ILQ5GIWyOLo/drhS1IEA9H1VlQG5sE
	 LhgEiRdcUxz7oJ0nWIe3Yzpo9WXAm2VXHLdlUk/5gexoPaHTB4ZDtz5EQBLZWrv9Dq
	 T9ky90agmboGbU53xxKyz9gGrCae8JgVjwaOKwIOcaFGg6C3Pf4YR6LBceqERIyAa7
	 nlWToPE9Q+eMgdwIuEjpWnRC0Q9ReQqIUESwRiYC/0iWxxISB4DYgvxTJVmxX5/DD7
	 BQun5VBCG2qWQ66uI4VRnAUv3Cw1uPrCKeFM1S1bHeUhQgGnVJ/3dYON3mFQxdySVc
	 Yjiz+8rvVYtcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman Gregory <gregory.greenman@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 190/713] wifi: iwlwifi: acpi: fix WPFC reading
Date: Sun, 24 Mar 2024 18:38:36 -0400
Message-ID: <20240324224720.1345309-191-sashal@kernel.org>
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
index dcc4810cb3247..f6ee5afb3320e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1296,7 +1296,6 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 	if (IS_ERR(data))
 		return;
 
-	/* try to read wtas table revision 1 or revision 0*/
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WPFC_WIFI_DATA_SIZE,
 					 &tbl_rev);
@@ -1306,13 +1305,14 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
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
index e9277f6f35821..39106ccb4b9b6 100644
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


