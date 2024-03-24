Return-Path: <linux-kernel+bounces-114963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD2888C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BE1F288B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727317A93C;
	Mon, 25 Mar 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUZ/Puij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743D131190;
	Sun, 24 Mar 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323686; cv=none; b=f6Yy6R1XbE6ZkAOx/9F+Q3ybxP/i4nrSxO8vtTKph39GLKoZr6PFW/KWZcrkMO9nan509V4LbmRBoPslkvdSURCt0boQVA9bGTQbyiOjls/nBJsq+msasqZs0B8TA32ygResLsqd5GMErQisVexLRpWLiUhDP7s0eZXk9FeOY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323686; c=relaxed/simple;
	bh=zt3XDLC8wxPBuetOHkGtbdT0IDzOCoaaZ61c/INRY2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYIw+Msz98j7id+nSIEkQULfiy/Up0xv6ncy1TvLSOGyI9tFxyyN/SymAkX/9VN+a4yCcemejswzRfbsAhlA2/NyzHebkY+TM6K9sShUtxbNVnu6GtGJpz/DIG0yhWBWt9nWDmSTbDLPTqC2efhInwY4+poIIX8FFgMd9R2Kx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUZ/Puij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB11C433C7;
	Sun, 24 Mar 2024 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323685;
	bh=zt3XDLC8wxPBuetOHkGtbdT0IDzOCoaaZ61c/INRY2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUZ/Puij1zOkb6NZhLxH+XWw9TnX1Qaa7pZnJkx50CrM60DPswkG64MjzvXH0RLtk
	 ujmVeMsIn8ZHZn29YNr5NDnq7tRv2S+PJL6AmQSIw8qUWC9GOKZbw5hVle33oTc3yG
	 8Nb9m8XlF3QQNOAYxJWZClb6gRmPVmTZtH5oKRcRErP/6WiM3atdN0ctAgcZSDlC6f
	 Rm2PPPgugejBBolr/3OrWLuF0ks2+bkJyggmz0/ab89vkf2gQ5HSScvNonwR5/c5+6
	 BQEFRnjNIz/NHVRm4GTucWQy5EfKaL+DdVVb+vrNAyVLAjFpDQ2rYxHO/9v5Iv9nDU
	 EvM1VWIY/gWBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/238] wifi: iwlwifi: fix EWRD table validity check
Date: Sun, 24 Mar 2024 19:37:25 -0400
Message-ID: <20240324234027.1354210-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit c8d8f3911135921ace8e939ea0956b55f74bf8a0 ]

EWRD ACPI table contains up to 3 additional sar profiles.
According to the BIOS spec, the table contains a n_profile
variable indicating how many additional profiles exist in the
table.
Currently we check that n_profiles is not <= 0.
But according to the BIOS spec, 0 is a valid value,
and it can't be < 0 anyway because we receive that from ACPI as
an unsigned integer.

Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://msgid.link/20240129211905.448ea2f40814.Iffd2aadf8e8693e6cb599bee0406a800a0c1e081@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 5e4faf9ce4bbe..fc35f8f84376c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -555,7 +555,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	 * from index 1, so the maximum value allowed here is
 	 * ACPI_SAR_PROFILES_NUM - 1.
 	 */
-	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
+	if (n_profiles >= ACPI_SAR_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out_free;
 	}
-- 
2.43.0


