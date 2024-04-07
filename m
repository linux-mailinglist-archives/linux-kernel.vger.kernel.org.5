Return-Path: <linux-kernel+bounces-134448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1E89B19F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913401C208EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE33D0A4;
	Sun,  7 Apr 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqKPLFed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81381720;
	Sun,  7 Apr 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495573; cv=none; b=KvlVpnCIg+6Fqx5D7gCID2FGbpp30BllpWWBu+6JtIvqtrgXctp5Bkp2WjYLxa/05We14sgExq2FiHsBl7NfR5asTZ9ideESrs8sYzvd18q4tp8MM+UhD5eY1Muza2j9p2CGvNjBbEUbLDNeLF2yc3N/KuAjoqFvMDEw8gW62/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495573; c=relaxed/simple;
	bh=Wp16SEaUqiBlbRrODh8PW9//FIKwbH4jF5nuV2QQ+q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXoq7y6HKIiw3wJAwinOtnewT4pXqXaQQz1pH8wsbJEg1H3qARJOLMmnXHUZdS/mMUIa2yQ18xZzy98yn4wwop+JOX8MaYtY3RHHzEcKGSDn+WEyA52bKUm1r6ZerwxPpZqGF+eOFVgiHCiRCJ+pEa2Ub6dWyHc8yjaJ5XqWq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqKPLFed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A8C43394;
	Sun,  7 Apr 2024 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495573;
	bh=Wp16SEaUqiBlbRrODh8PW9//FIKwbH4jF5nuV2QQ+q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqKPLFedaTab7X7A6S5rCuUBGVZfz4CpABx9VMfR6qQh4d+cpOPMrdwQxk0ooUEbL
	 qBY+HbhKI864g+FZxpBZfZxQcLLeX9EBAeVTCTFvYaujV9kQZ44OhSoMVAig5i4MZo
	 ACkpttIy19MaoJ6eFpoYeDRDUdSzl4RvyuaV6v7fVAMF1gjNg0hqPbQWYnM3zx5rNw
	 Gdd5+bZGikkBCxCsgBmyiiEAC9yae97yVNQb85rdIWSQvg/WqDLFlCoZIhIQYMMZuk
	 xAaZpwktvGEN2gAygmKLYj3IywO8Y9xpOlVskGUEzB0iCQufvvdabKXH9D1//FyaGS
	 FlyBzDGlZ9Iww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	emmanuel.grumbach@intel.com,
	avraham.stern@intel.com,
	dan.carpenter@linaro.org,
	mukesh.sisodiya@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/22] wifi: iwlwifi: mvm: guard against invalid STA ID on removal
Date: Sun,  7 Apr 2024 09:12:12 -0400
Message-ID: <20240407131231.1051652-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 17f64517bf5c26af56b6c3566273aad6646c3c4f ]

Guard against invalid station IDs in iwl_mvm_mld_rm_sta_id as that would
result in out-of-bounds array accesses. This prevents issues should the
driver get into a bad state during error handling.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240320232419.d523167bda9c.I1cffd86363805bf86a95d8bdfd4b438bb54baddc@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 1ccbe8c1eeb42..278454c116fee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -853,10 +853,15 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id)
 {
-	int ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (WARN_ON(sta_id == IWL_MVM_INVALID_STA))
+		return 0;
+
+	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
+
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta_id], NULL);
 	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[sta_id], NULL);
 	return ret;
-- 
2.43.0


