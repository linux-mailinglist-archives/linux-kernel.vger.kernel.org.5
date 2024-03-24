Return-Path: <linux-kernel+bounces-114138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA154888F50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B4528F366
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8816133A;
	Sun, 24 Mar 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUBUiJEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0F2036FB;
	Sun, 24 Mar 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321449; cv=none; b=J7l5PcDGFnNzroa+MN59PtlSl0IJ66SN46l1JbEGA2xDg9loc85PAzNnoRp19F7UFa7RFBZLvd72bG0sXv6MttJ5kAcC14vtwIacIVVXnc6acM5J13SSDPCaZQZUmxAQpWhXoSGVodtsrfZJFaq5pwITi1Nq+DwSJUV/a8CulJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321449; c=relaxed/simple;
	bh=1Cj3/gyuMtG/xDvzw0tRMJJxRzza3/X2Qgw+2sze/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etEuRs6q7ghAfy28ql/deKz5ydAkDivxytc+9iRititUr1NwWuhZkBbikupiCSwMbfzDDHW/Pyfelp+UFieWs56KhwO0HgYzXFTS1UndiqvNEh956OfS2X6/+wBWn64FM9IGIDMVeJWC6Yvhy5Lty+ren8r8QA2rUG/hRmu1ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUBUiJEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433ABC433F1;
	Sun, 24 Mar 2024 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321448;
	bh=1Cj3/gyuMtG/xDvzw0tRMJJxRzza3/X2Qgw+2sze/rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUBUiJEhrAQqBHRJrR4iRFriQe5SK1xcLaez0aKU4aP/kjK016tdQdtxn0AhwuOKW
	 qq9G3fmiHWJyyM0feKVE8wlYtkLzfHD4c8UQXMuqUo3uAVwEBGJhSpSYu98zE5kYLE
	 R89R1HQNFRwuCNmxwJDn2wRy2bZ3aj/PVgiOA18RFL6ytcd1jBTqsqAlltOlk1z4NT
	 LTGSB7thZPllnKnoCS/CgdmkMySXqqeD0wkeG2N13hLi4eXApRVbK2ExtF/nyM8bkQ
	 jiVElar2qfhaiDGexLOF/LYvyAFxM+UdUVSYwFHNtY54NYnfKkr3RSgyn0KJt4B9OQ
	 eVnFaqSZEbIfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 172/638] wifi: iwlwifi: fix EWRD table validity check
Date: Sun, 24 Mar 2024 18:53:29 -0400
Message-ID: <20240324230116.1348576-173-sashal@kernel.org>
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
index 564eeb002e8ed..2cda1dcfd059a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -767,7 +767,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
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


