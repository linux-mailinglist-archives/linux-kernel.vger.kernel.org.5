Return-Path: <linux-kernel+bounces-115390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCF8893C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB3129AA35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C41FC982;
	Mon, 25 Mar 2024 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbVaYrrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5F8527B;
	Sun, 24 Mar 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320665; cv=none; b=UK6f8lodqhgiAjZcEatiNXfHxmsdAM/Es7qZcDEI4sHUGj9S4RAkMtRoeK3Gkft5ke5a/YhcQrN/bvjKbxiZZW9sbJAKzAdIizu2v4Hl5WKsfPIvxEilSualdqKje+KThbXkjLpTifEuxfhF5znZ+t5JDPhKIp2q4ixlbIQl/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320665; c=relaxed/simple;
	bh=lzVnQlyO7tR3vPso14hf/vGA5Oj0nELSAcGLnpQb/UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2Ar7RB8TUwqysSRURKC4uzbs8G73QXwF0cP7qXsUsYnIL+MaVtkuUgYTE5R6beH7wBwpJcboBtI96PVR9yLLFtgBv+graBUDHrS5TTTssCUwr3AvVmuUGWOnqwQAkLh/I4ErZEPH2pkVAfSYfaKNLzZIExDVxjO9EUMBv52ITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbVaYrrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B13C433C7;
	Sun, 24 Mar 2024 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320665;
	bh=lzVnQlyO7tR3vPso14hf/vGA5Oj0nELSAcGLnpQb/UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbVaYrrJbN/6frJmUzVpxcnPr/sc7G0i/FTDT8Ln9LUte+QZnwS2lETbDzbs9ivh5
	 cj3U6ntXJExiKXz9Ot8CgD52xZ7+KbYyTciexVn3IBopIGUO5DMh0rXVNqyHlncf67
	 mYy0dGSkWic1lHmgjceUFNIEB/eKsXnLSex7i/R/6guyii2cNcvxjf2nHMO6GO5Wm9
	 GicViLQv5ZzPm6y1gW38vosiL+o/aLv/oE0V7G7i/f/QBbT0HpN6cdxBkaZDJSusn9
	 5H4EvtnE0Uus/N/iriVRzkl5Wfyctm2NGKGFbZqe7EkCZmwW0JT86crZ7kSx/2J62g
	 9tqR3C+06g9EA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 228/713] wifi: iwlwifi: mvm: fix erroneous queue index mask
Date: Sun, 24 Mar 2024 18:39:14 -0400
Message-ID: <20240324224720.1345309-229-sashal@kernel.org>
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
index 461f26d9214e4..930742e75c02a 100644
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
@@ -1636,12 +1636,18 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
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


