Return-Path: <linux-kernel+bounces-115374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0548893C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163D429A18D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D31F30BB;
	Mon, 25 Mar 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXdGEi/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52E143896;
	Sun, 24 Mar 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320631; cv=none; b=bqlTCByMmzZgQt3CZv5EKQQfSt/F4jnN/mdHD0ijF+0HTArL8zE0FLTjpeCNlXqrZLfdAIKy9Gjwdzz+9/YAVaIPmDTwXsedFg2Zplc2xAfGk4jYgN9ea6DYSK3YT9E1UZQ3Xi32ujOUjf8HkTry6WJBd09fJ+7wJ43lHQKn26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320631; c=relaxed/simple;
	bh=Gr8RHeqjQz3w4DuVn8wa+fzTUgznUlmVnLsF6Wg5gGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDk32RL8UktLfnDlmv5mATecr4elkjvVBk4iOBHyr4HQwSuAwNtx+6IoiNDIkhBQOFNjBvylNGzy8Or7Bhsotq8Bov8Jp2iCP4QG50SaCf7SldS0E8Ydsioc8MzSmIbQhL8aGeBZ5Yy/5PXC55Ykt6OL3fCWI7ZkgywqbgRbU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXdGEi/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B97C433C7;
	Sun, 24 Mar 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320631;
	bh=Gr8RHeqjQz3w4DuVn8wa+fzTUgznUlmVnLsF6Wg5gGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXdGEi/3Ie4T1liy/yozZTOzBUU91zQaeqqmVmhCSNChtFrl8EPhdbvgivXuljNx3
	 8DFLzGK2kL8wxxnHLH92gRRkc62kgmR+akccmO2LBtxWZRih+OsD5nGyznpPt+iUgl
	 VERpS7kaqiXcGC1VFaKnWH4fuZg8S5PTlp1CaJRFuD2p/P+rD4Mv3bnfACLe5YYYGv
	 dQk5xCv12nocSk+2mPcuj3reYzvzDDZosvyDR49H9SMoLcbwbvM2BSPdKoY+/309RK
	 +K8A7PQQQohDBIuQdTBaotAaognqhWa6NHMDTcBe5jRvxsIIuxsFK7aCgc0c9kmY8V
	 c8KY6a0MNp23w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 193/713] wifi: iwlwifi: mvm: d3: fix IPN byte order
Date: Sun, 24 Mar 2024 18:38:39 -0400
Message-ID: <20240324224720.1345309-194-sashal@kernel.org>
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

[ Upstream commit 0c769cb6b9f364423c255f117774c9ecd5bf23ea ]

The IPN is reported by the firmware in 6 bytes little endian,
but mac80211 expects big endian so it can do memcmp() on it.
We used to store this as a u64 which was filled in the right
way, but never used. When implementing that it's used, we
changed it to just be 6 bytes, but lost the conversion. Add
it back.

Fixes: 04f78e242fff ("wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240129211905.138ed8a698e3.I1b66c386e45b5392696424ec636474bff86fd5ef@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a640860ab7acd..626e9b94a6624 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2207,7 +2207,10 @@ static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 				 struct iwl_wowlan_igtk_status *data)
 {
+	int i;
+
 	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(sizeof(status->igtk.ipn) != sizeof(data->ipn));
 
 	if (!data->key_len)
 		return;
@@ -2219,7 +2222,10 @@ static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 		+ WOWLAN_IGTK_MIN_INDEX;
 
 	memcpy(status->igtk.key, data->key, sizeof(data->key));
-	memcpy(status->igtk.ipn, data->ipn, sizeof(data->ipn));
+
+	/* mac80211 expects big endian for memcmp() to work, convert */
+	for (i = 0; i < sizeof(data->ipn); i++)
+		status->igtk.ipn[i] = data->ipn[sizeof(data->ipn) - i - 1];
 }
 
 static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
-- 
2.43.0


