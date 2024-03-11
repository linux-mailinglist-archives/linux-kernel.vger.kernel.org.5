Return-Path: <linux-kernel+bounces-99050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCB8782D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794FCB2110D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A242069;
	Mon, 11 Mar 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxzU0qPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FC446BA;
	Mon, 11 Mar 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169949; cv=none; b=pgIn4Pd8oOA/+7oYdNWoT4QeZHEyh8PiVfFu/w0HTmGWMYtvtvEu3AZE7zB0k6wca6/PAyNTUqnabLTM7KAOL9KSDBvHWbcM46SWxi4dg/d+8J2TqdmI/w6jd1omBh6As1OH7itjHiACabPNtI06abkQLgKJpHgLo8CFrfMTiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169949; c=relaxed/simple;
	bh=O3gGOkuRyZFboL0fmOL3hrmSbPvbiXSEcZC/rrfIDxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIQPpCCt1CZI6OoyTVyt4J6y2WVf6oKsb7HUbwFiXxfjMwd0fivDFjCl9VWF1VugOBbv1hRXYh9/N/HCcEc1S7g51M3yuMXLd6rVlvOFD6h33ppVNMdVuofL1/GZFAMhyekcYGcby0crB2Fs+BzdiGKOKOSlQ00ixmm7znfR1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxzU0qPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3529C43390;
	Mon, 11 Mar 2024 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169949;
	bh=O3gGOkuRyZFboL0fmOL3hrmSbPvbiXSEcZC/rrfIDxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxzU0qPUZyyNm55U3p9c4XPVxwQEnDZfZy0QEIcMWSdUlReaogqnbIaEFsjFKVlxn
	 Aizp4MrkhhigJZ3Uvro8M/i6ll/X0uF6KmuLVJjP/vSU5iIjQ2MF6hrTQXRrUtzPKN
	 CEg9dIATnulJwweUfVjXMWMfa18g2vRFDsIHiDMM5gieo2T/aHwLBEIqRx3Whovs7t
	 tX9IHZSQ6SeWeJ2H4uKaENVe0MDq2kRbHFbP9QMFnHQJ3jcin3DAUhkP2KdgNxcpq8
	 hAXepW88wiMl4Riv4WEOCaQXuEMVIO3dozcv/NzHxdU+cvuw9EviI2qL/ymoIpyPjV
	 zqN3UOLyB6Z3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	ilan.peer@intel.com,
	mukesh.sisodiya@intel.com,
	avraham.stern@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 03/23] wifi: iwlwifi: mvm: fix the TXF mapping for BZ devices
Date: Mon, 11 Mar 2024 11:11:43 -0400
Message-ID: <20240311151217.317068-3-sashal@kernel.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit d3433d1bb7bde449035f54b7000361ce151bad07 ]

Those devices' fifos are numbered differently.
Because of that, we were looking at the size of the VO fifo size to
determine the size of the A-MSDU which led to a lower throughput.

Note that for those devices the only user of the AC -> fifo mapping is
the size limitation of A-MSDU.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240218194912.da336ca2fa0a.I73e44d5fc474ebb6f275b9008950e59c012f33b2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h   | 12 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  8 ++++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
index 9c69d36743846..e6c0f928a6bbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2019-2021, 2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2019-2021, 2023-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -66,6 +66,16 @@ enum iwl_gen2_tx_fifo {
 	IWL_GEN2_TRIG_TX_FIFO_VO,
 };
 
+enum iwl_bz_tx_fifo {
+	IWL_BZ_EDCA_TX_FIFO_BK,
+	IWL_BZ_EDCA_TX_FIFO_BE,
+	IWL_BZ_EDCA_TX_FIFO_VI,
+	IWL_BZ_EDCA_TX_FIFO_VO,
+	IWL_BZ_TRIG_TX_FIFO_BK,
+	IWL_BZ_TRIG_TX_FIFO_BE,
+	IWL_BZ_TRIG_TX_FIFO_VI,
+	IWL_BZ_TRIG_TX_FIFO_VO,
+};
 /**
  * enum iwl_tx_queue_cfg_actions - TXQ config options
  * @TX_QUEUE_CFG_ENABLE_QUEUE: enable a queue
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index c4f96125cf33a..25a5a31e63c2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -31,6 +31,17 @@ const u8 iwl_mvm_ac_to_gen2_tx_fifo[] = {
 	IWL_GEN2_TRIG_TX_FIFO_BK,
 };
 
+const u8 iwl_mvm_ac_to_bz_tx_fifo[] = {
+	IWL_BZ_EDCA_TX_FIFO_VO,
+	IWL_BZ_EDCA_TX_FIFO_VI,
+	IWL_BZ_EDCA_TX_FIFO_BE,
+	IWL_BZ_EDCA_TX_FIFO_BK,
+	IWL_BZ_TRIG_TX_FIFO_VO,
+	IWL_BZ_TRIG_TX_FIFO_VI,
+	IWL_BZ_TRIG_TX_FIFO_BE,
+	IWL_BZ_TRIG_TX_FIFO_BK,
+};
+
 struct iwl_mvm_mac_iface_iterator_data {
 	struct iwl_mvm *mvm;
 	struct ieee80211_vif *vif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f2af3e5714090..3be67f0ff74f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1574,12 +1574,16 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_gen2_tx_fifo[];
+extern const u8 iwl_mvm_ac_to_bz_tx_fifo[];
 
 static inline u8 iwl_mvm_mac_ac_to_tx_fifo(struct iwl_mvm *mvm,
 					   enum ieee80211_ac_numbers ac)
 {
-	return iwl_mvm_has_new_tx_api(mvm) ?
-		iwl_mvm_ac_to_gen2_tx_fifo[ac] : iwl_mvm_ac_to_tx_fifo[ac];
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		return iwl_mvm_ac_to_bz_tx_fifo[ac];
+	if (iwl_mvm_has_new_tx_api(mvm))
+		return iwl_mvm_ac_to_gen2_tx_fifo[ac];
+	return iwl_mvm_ac_to_tx_fifo[ac];
 }
 
 struct iwl_rate_info {
-- 
2.43.0


