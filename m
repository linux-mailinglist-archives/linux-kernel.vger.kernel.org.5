Return-Path: <linux-kernel+bounces-134424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827789B154
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEA1F24D98
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68F5FEF9;
	Sun,  7 Apr 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU87h09y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C05FB88;
	Sun,  7 Apr 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495514; cv=none; b=YnJo621egqsfaynVjpT50V9hqdZfoUfCZr/JlnCYQVnsxWgrebYMwJimrN85fNuCQvQtQZnguFJcsBuNGIyszWf1bjyUU7xHO+wexzjMSPIYPLEaR/Vg1e63rMxBRsNrzCIM46wbg9cFCYtRAFv4L6fN55ff0WjKqS53IJnnpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495514; c=relaxed/simple;
	bh=nVUQwkAaY67Iy5mNEiV6os3iDa67GOZDRUbfrDXOo/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atuDvhJI2x9tH/UjKttRrv1ngSrlrDjZwD3LJg5DIuVRd9mNbdhmpY5HrHWO2GaQqV+4aWVHgUFm/QIJqRzxzD3/jnU1xp+ybOD7goPKlTX2mb6urbYx+PkK5aBEYTr35q1c4FpyCsf/CtKJMwdqF+wvHD6YJuZydnYCnF+jywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU87h09y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640AAC433C7;
	Sun,  7 Apr 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495513;
	bh=nVUQwkAaY67Iy5mNEiV6os3iDa67GOZDRUbfrDXOo/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mU87h09ygRxaZRb88cEAQ0O3C2yi4co2DOki0GveWsAgF8tHQpeLF5LETV0RmHLRl
	 Tm863E1W/huZUOJt5g25QEmFOvb33bGD3ZEkpKJHNLU+SENZlSIt8GJQdo3aDtC40f
	 DbQpPQuQc7Ishf6mZ4YSnIGemy4j3k8GIF1xrKhcN/iW1knTRwi9S07+AtGhoeNmdu
	 N3h2vyG7oZoXhj0Ysk7l4SuEkTcGIfNw3iu5Ar7dWcwZHrrqw3zx+w6alsetbfO8kH
	 xvnLmOe1epX0jmC/mNrx4wlwMiaZ81wXhgOq1tuNnf94XQkMKG8OnrlVC72TrS784k
	 VZjuHI9sI1n/Q==
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
	dan.carpenter@linaro.org,
	mukesh.sisodiya@intel.com,
	avraham.stern@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 14/25] wifi: iwlwifi: mvm: guard against invalid STA ID on removal
Date: Sun,  7 Apr 2024 09:11:02 -0400
Message-ID: <20240407131130.1050321-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index 1628bf55458fc..23e64a757cfe8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -855,10 +855,15 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
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


