Return-Path: <linux-kernel+bounces-114767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33A889117
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CDE2884B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6281B7F6F;
	Mon, 25 Mar 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXQsLs3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87F5A10A;
	Sun, 24 Mar 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323379; cv=none; b=sA0loK3xIsvx84uUaxriQov3932dz985sFgWBj4upAYGPFTiPDswe2vaFl+6hiTOcenjaooybbG9y6Jt4sXzB8gPGcyqeyoOIcu0CtAEeIlMYD8Ac8GdpqtclxNkL3XCdD/4fxYWAIcEbaTSHeK0WO1rjzLJGe/N2wIA7UhKFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323379; c=relaxed/simple;
	bh=CPWd2wkM0tXZLpS+U7hIaux1VywiMZsUyNyuil1yD5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7/a1ui1vZteIeEt0KAaVx/nGc7KACfvHYxNcwqb6IjmyaHcZSgLGilPHjnryfKEO3gvCVW8t877iHJ3a+caN9+u8Yw745/rBIhH8EbtLdems8jvsPzJDKz3AgsBlD53MjnLEUrvvyvglYC2r4f2tc7PDboPZYw+266fT2ZEmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXQsLs3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551FC433B1;
	Sun, 24 Mar 2024 23:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323379;
	bh=CPWd2wkM0tXZLpS+U7hIaux1VywiMZsUyNyuil1yD5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXQsLs3ptCbkwMDIX3ItP3qAyvnFCNtZrsFT2ltSA2sTp9OXjjcDTJAao4CGSmOYE
	 hmqaRctPyFF9UHuyPRAH+ft4t6jB73KV37qr+DBKTYphDCMA+bU2AdhGTmsdWEfhtq
	 N/t5eCRSltTg03PTHEMuhfHwSHpE6z+Svq7uA7a2/XBHyQrNnlMc6fr21J/XpH2VoU
	 hHuv7D2dPIJ/qwxOt2jjIO5+ZY5QC0l2C5mJffxugiPUSmFnaY9Cm7OZTI2eFcv/XH
	 SEDAFlRGnpsUbaQsrmxN4eRaEdLI5/uIP8pDMzSdIHW4E6c/Zpqq7RwRjJkxQVtlPw
	 fovgapojEKk2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 079/317] wifi: iwlwifi: fix EWRD table validity check
Date: Sun, 24 Mar 2024 19:30:59 -0400
Message-ID: <20240324233458.1352854-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f0e0d4ccbc091..0b1c6bf729c3e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -674,7 +674,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
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


