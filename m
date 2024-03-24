Return-Path: <linux-kernel+bounces-114156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6F08888C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA1B1C279B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8F1552F5;
	Sun, 24 Mar 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnolIbIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97513175C;
	Sun, 24 Mar 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321472; cv=none; b=l6j8YLrfwIWPVI2eS9qwUx5yziwbxnywlv1HQj/+tV+x9K0mlPEznVrKCZfgq8cKnoAj26QxstMym2FIC8xuI/ZnjIeqM301vA7hdCoGN6zL3wqDqeLycok09wC06k5UDcGLQp4h+2vAa8JnFrL9z67NFWs6Mplqo8mfWxLFRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321472; c=relaxed/simple;
	bh=fcxe7umDdK20O7WND9Wo9ymjWrQaKNZP7RPx6aJX31Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaATB4J+0pO1pxj7G1sEhB8Cw+ubqrV0RzGdeTnq9U+y2pAoYz+jTrWowHz4tZ1QWRVbZxVzkevptvNUyybcdeENauxl+yvY34Em0IHpV7PrHZZWGO7dIfvplodkwBL+0AEarZBJSuJtVWtgXT4hggvxWvS30cyg0sBHCpREiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnolIbIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FF9C433F1;
	Sun, 24 Mar 2024 23:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321471;
	bh=fcxe7umDdK20O7WND9Wo9ymjWrQaKNZP7RPx6aJX31Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnolIbIsX5xxG8QXHXK9+KrGBtRucZr9eqPMF8+WvAGN+Ta1T2THM8Vb2NiaDF8Km
	 ITIAO9cUG2l8cWzAdfjIjhWwbnau+WRghQkg5vK+KUWGqeB14q06QcrYno8LRCx8d8
	 StxV1tV8ivF3LxyISz5zjV3Oc4T8zZSrcoZbWGPYBdODjDtaqXdU8MLXHJSVkhLXcG
	 2RwySM0g9ukAOLnLEuqSrhHFXjDwSkzow5a8geRzzYst/YID7jyK8bi8q+iKygNrJV
	 i0Xan0bgX6WO4S+plEwbILg3cZUPVC94zC6AMiAOv8lX7nnM7JpC9dMoz9C/atnVn5
	 oI6VXcZ4neISA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 196/638] wifi: iwlwifi: mvm: fix erroneous queue index mask
Date: Sun, 24 Mar 2024 18:53:53 -0400
Message-ID: <20240324230116.1348576-197-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 2e0e766bd8a7f14f10c3e70b8203c4c1e6d9ec76 ]

When retrieving the queue index ("SCD SSN") from the TX response,
it's currently masked with 0xFFF. However, now that we have queues
longer than 4k, that became wrong, so make the mask depend on the
hardware family.

This fixes an issue where if we get a single frame reclaim while
in the top half of an 8k long queue, we'd reclaim-wrap the queue
twice (once on this and then again on the next non-single reclaim)
which at least triggers the WARN_ON_ONCE() in iwl_txq_reclaim(),
but could have other negative side effects (such as unmapping a
frame that wasn't transmitted yet, and then taking an IOMMU fault)
as well.

Fixes: 7b3e42ea2ead ("iwlwifi: support multiple tfd queue max sizes for different devices")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240205211151.4148a6ef54e0.I733a70f679c25f9f99097a8dcb3a1f8165da6997@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 4ea3aabc64883..3adb1acc07191 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1616,12 +1616,18 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
  * of the batch. This is why the SSN of the SCD is written at the end of the
  * whole struct at a variable offset. This function knows how to cope with the
  * variable offset and returns the SSN of the SCD.
+ *
+ * For 22000-series and lower, this is just 12 bits. For later, 16 bits.
  */
 static inline u32 iwl_mvm_get_scd_ssn(struct iwl_mvm *mvm,
 				      struct iwl_mvm_tx_resp *tx_resp)
 {
-	return le32_to_cpup((__le32 *)iwl_mvm_get_agg_status(mvm, tx_resp) +
-			    tx_resp->frame_count) & 0xfff;
+	u32 val = le32_to_cpup((__le32 *)iwl_mvm_get_agg_status(mvm, tx_resp) +
+			       tx_resp->frame_count);
+
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return val & 0xFFFF;
+	return val & 0xFFF;
 }
 
 static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
-- 
2.43.0


