Return-Path: <linux-kernel+bounces-115371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF9889B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859261F3602C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2171F10D2;
	Mon, 25 Mar 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4UYPiMp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D9143899;
	Sun, 24 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320630; cv=none; b=smmeKy3bQsHpklrrEp1RPsHQXw6gs2NpC6R7D9aU7qMSxY+vU3NrxRnZpLUi+Iamkt4obkfmrNXJvoSLcSqyZBpgyHhisK0cfi48IIAYjgonAcHNug8a1OApy2wDXYXB/3Y0VRmsi7mwxYJu1rkT8dWV3uS1kLB9x7loDTg2zU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320630; c=relaxed/simple;
	bh=hqGZ4LC/p9yLhUx80JTHDn5iP1OAqL/6mwd8bLXnsaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFxMSTk6DGbxR0BSoWAUVeWllyhQn2L4NLrFGhOPjIG2FZ8ImtUT1MTHDornnttpB7z5YrYI6UxrKCIypbXJDb1tWvl3HdwpFK2I01vQnOZb8XCcpjDjbQURpUwDQiCh/cOhZOo8s4LOpZGaACJ5SSfAgMruD9R3zXrI3kk20gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4UYPiMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2A9C433F1;
	Sun, 24 Mar 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320630;
	bh=hqGZ4LC/p9yLhUx80JTHDn5iP1OAqL/6mwd8bLXnsaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4UYPiMpqrR+vqc+iGkUrT0PYhu9kHFkNGZmBhYAUJj7N0c8+62rD38aP1IY/0NwA
	 LhlzNYWLq2pEEvC9kisR69m3pP3nIzmwtiPUXhCcttAZ2KbhNGCcCOxaatZ9v5xd/k
	 X03AX31uwgxYbbEeMD8D1NSmOi68clQPa5FA98vwokeploiN1Olh9NKiPFugQ7/pZv
	 xsE2gn4GpLqjDBScK+9VogGsaS+U8rBvUySHocKpPCRw56NtkQhgY559ZWjcBwXBTf
	 DWtjmGxSL1wNylQVRd3PaN6h33AMUYN27sGCmwUQGAtJiUiUxW0zSPeuleltnKIhNi
	 rfKjd1Jw05q3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 192/713] wifi: iwlwifi: fix EWRD table validity check
Date: Sun, 24 Mar 2024 18:38:38 -0400
Message-ID: <20240324224720.1345309-193-sashal@kernel.org>
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
index f6ee5afb3320e..e161b44539069 100644
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


