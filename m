Return-Path: <linux-kernel+bounces-99049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21F8782D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C9A1C20CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E94436E;
	Mon, 11 Mar 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFdHBBgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9240BF5;
	Mon, 11 Mar 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169945; cv=none; b=UD0Omk5RmtRv9dytLqeLDAnXlQ/fCVaSqDKpoedPuxEbGQj9h9BkQrDLkiQCEfQEbL3TZ7sLsAXkATIrYjTtV982AJmut5kcdJBfrV8UiPga19hC18gyRJguHT02+vlHSeatPdFzyUkiPexu83tStIT8SCFdI3uw7Cv/BGSPRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169945; c=relaxed/simple;
	bh=olviz3N7KgcKZNdsBQeT6Zs90vm3EAN2EEUiaQCQYdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFS9L7wFgqdq8hgXvOd0rw4EhOwsJbWgzC4re/3pSL+kMdLiA2iRwIs/RlUoPvmPBgFyx2wb5GR9A5ihyy5u7abc6vYZMFViZL7Vf5evue3Y4WbELe5l0jRC61nVeofo50KpiI/vZEbp+pq853TabtaMMahMVQHCGeO7grJe0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFdHBBgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D5C433F1;
	Mon, 11 Mar 2024 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169944;
	bh=olviz3N7KgcKZNdsBQeT6Zs90vm3EAN2EEUiaQCQYdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFdHBBgB+Rz+xQRtQ6l2oS/KJ2HHXNraDmvNKLsHls8wPnBhxS5mp/F8wLzxG2L9q
	 Jkpqxwl48Xsx8w+lBlgc0hQv96hJkLp0Jtaw9Ai0I+NxRLEbBiiwOWeOiFGQ4Aw/dp
	 /hSi1tgnPRmm2QKuOsJh5KJv3vkHBs51g9tjRi57twruB3e3LSUXPgQfTrwPNpqCNs
	 yRg7lKDt92wmSVmHbz8qBer15KVAYl4j32R60YUTKWyvdg2qYRsA+Y16tEO38SSyKY
	 3kV2kUuUD1kSOD+LcL99V0iXZoXhgdGmtOhEppnAMGFmAXzMQV2oJ4bRCzvfSFtt9g
	 OidnsA9QftbWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	yedidya.ben.shimol@intel.com,
	trix@redhat.com,
	gustavoars@kernel.org,
	haim.dreyfuss@intel.com,
	avraham.stern@intel.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 02/23] wifi: iwlwifi: mvm: ensure offloading TID queue exists
Date: Mon, 11 Mar 2024 11:11:42 -0400
Message-ID: <20240311151217.317068-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 78f65fbf421a61894c14a1b91fe2fb4437b3fe5f ]

The resume code path assumes that the TX queue for the offloading TID
has been configured. At resume time it then tries to sync the write
pointer as it may have been updated by the firmware.

In the unusual event that no packets have been send on TID 0, the queue
will not have been allocated and this causes a crash. Fix this by
ensuring the queue exist at suspend time.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240218194912.6632e6dc7b35.Ie6e6a7488c9c7d4529f13d48f752b5439d8ac3c4@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c  |  9 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 28 ++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h |  3 ++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 92c45571bd691..a640860ab7acd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1286,7 +1286,9 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 		mvm->net_detect = true;
 	} else {
-		struct iwl_wowlan_config_cmd wowlan_config_cmd = {};
+		struct iwl_wowlan_config_cmd wowlan_config_cmd = {
+			.offloading_tid = 0,
+		};
 
 		wowlan_config_cmd.sta_id = mvmvif->deflink.ap_sta_id;
 
@@ -1298,6 +1300,11 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 			goto out_noreset;
 		}
 
+		ret = iwl_mvm_sta_ensure_queue(
+			mvm, ap_sta->txq[wowlan_config_cmd.offloading_tid]);
+		if (ret)
+			goto out_noreset;
+
 		ret = iwl_mvm_get_wowlan_config(mvm, wowlan, &wowlan_config_cmd,
 						vif, mvmvif, ap_sta);
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index bba96a9688906..9905925142279 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1502,6 +1502,34 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	return ret;
 }
 
+int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm,
+			     struct ieee80211_txq *txq)
+{
+	struct iwl_mvm_txq *mvmtxq = iwl_mvm_txq_from_mac80211(txq);
+	int ret = -EINVAL;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (likely(test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) ||
+	    !txq->sta) {
+		return 0;
+	}
+
+	if (!iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, txq->tid)) {
+		set_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		ret = 0;
+	}
+
+	local_bh_disable();
+	spin_lock(&mvm->add_stream_lock);
+	if (!list_empty(&mvmtxq->list))
+		list_del_init(&mvmtxq->list);
+	spin_unlock(&mvm->add_stream_lock);
+	local_bh_enable();
+
+	return ret;
+}
+
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 {
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index b33a0ce096d46..3cf8a70274ce8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -571,6 +571,7 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 				       bool disable);
 
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm, struct ieee80211_txq *txq);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-- 
2.43.0


