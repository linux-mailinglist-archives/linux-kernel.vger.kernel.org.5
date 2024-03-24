Return-Path: <linux-kernel+bounces-115362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BB889B19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AC22A4831
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0D1EF7E1;
	Mon, 25 Mar 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/kuYKvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668381D790B;
	Sun, 24 Mar 2024 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320602; cv=none; b=Eq/GVnxfQys/DHvK1i2GrNkFhBlGY8ch756OMrLQrjKhCTMG54eXBJzjjlKWd/NFoUXMXiVrIkNGng25Fcjd5bOqfXFhCHNO5tOhdGsL4PEyXEfG+a42NK6KE3U8mPmlkJwC6JEpVXEzCTu0fakSpx8mOOfi346haIo/HA6xrVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320602; c=relaxed/simple;
	bh=EPE3KJHALwKYBv9q4+tuusSD1a706QD3ySJFjaQeZ6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcVpTa0mljOh+VE3Sp3FzKCFWvayRqHH9mz/d7DemRRvqwCiLb4J5/rlybBYmfze/UKFCeeOwdCTVWgvNaUA4dNeQtYZ/VLzXooONZ2dr7ouzcQO0/cOk497/QwkQ08TiNPKdPvgFCdgRDu6zrYacxi71OmQ+qHZc+lezXOk7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/kuYKvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C442C43399;
	Sun, 24 Mar 2024 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320601;
	bh=EPE3KJHALwKYBv9q4+tuusSD1a706QD3ySJFjaQeZ6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/kuYKvEXkvmM2vjlkbEMt7CJh8wNVFQXwIluIRH8RLRVE3nEttulYHA/v2FjPTEM
	 Mbv3bsXzCol1DW6RIqLvlNjPFL+BdqIlQbunF5lM7Ac/GWh5HXve8nQo47SoLPUcuq
	 g3FBisK+MNcLMTnwVU3v1LIrL2sBnGXJRv6u1KyJrI3QXuruVilDlUPJwqJxzxITNH
	 Z03u11QpIO8VrgO5k0TUky7+bWcPJDZgnwvDAlW4ejVgwP4vkt15nL967wQ6EsJol/
	 PnmIChrnkM5hZGimShCN4d66Vk1lGNB9jEQn9b3hZCI73EC37QS0l5lmy3XnA4C452
	 dLC/lzrSiH44Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 162/713] wifi: iwlwifi: change link id in time event to s8
Date: Sun, 24 Mar 2024 18:38:08 -0400
Message-ID: <20240324224720.1345309-163-sashal@kernel.org>
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

[ Upstream commit 6c8ce23854b66db94d88e0957e531cb074806c16 ]

Link ID in time event data is -1 when the time event is cleared.
Change the type of the link ID in the time event data structure
and in the affected function from unsigned to signed.

Fixes: 135065837310 ("wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://msgid.link/20240123200528.50d4941f946c.Iea990b118c69bc3e1eb61c1d134c9d470b3a17ac@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3be67f0ff74f7..1e33de05d2e2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -121,7 +121,7 @@ struct iwl_mvm_time_event_data {
 	 * if the te is in the time event list or not (when id == TE_MAX)
 	 */
 	u32 id;
-	u8 link_id;
+	s8 link_id;
 };
 
  /* Power management */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 2e653a417d626..98c64ae315e68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -692,7 +692,7 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 /* Determine whether mac or link id should be used, and validate the link id */
 static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif,
-				       u32 link_id)
+				       s8 link_id)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
@@ -716,7 +716,7 @@ static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 
 static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 					      struct ieee80211_vif *vif,
-					      u32 id, u32 link_id)
+					      u32 id, s8 link_id)
 {
 	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
 	struct iwl_mvm_session_prot_cmd cmd = {
@@ -745,7 +745,7 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	struct ieee80211_vif *vif = te_data->vif;
 	struct iwl_mvm_vif *mvmvif;
 	enum nl80211_iftype iftype;
-	unsigned int link_id;
+	s8 link_id;
 
 	if (!vif)
 		return false;
@@ -1297,7 +1297,7 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->time_event_data;
 	const u16 notif[] = { WIDE_ID(MAC_CONF_GROUP, SESSION_PROTECTION_NOTIF) };
 	struct iwl_notification_wait wait_notif;
-	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, link_id);
+	int mac_link_id = iwl_mvm_get_session_prot_id(mvm, vif, (s8)link_id);
 	struct iwl_mvm_session_prot_cmd cmd = {
 		.id_and_color = cpu_to_le32(mac_link_id),
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
-- 
2.43.0


