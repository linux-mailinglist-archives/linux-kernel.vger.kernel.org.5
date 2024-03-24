Return-Path: <linux-kernel+bounces-114139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464528888A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F5728662F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B231241911;
	Sun, 24 Mar 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbk1ws4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACF132C1B;
	Sun, 24 Mar 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321451; cv=none; b=KZK8pt/DSg166v9d/+ZCo3BN+D8H8wuvkoUrv+PDrQyZocKTGPnOOqu9OdEdZ6eJqIljIXnKd3g4x4iZKjJYw+8iocJZNJqZo5SLQXfzPFuiTdVsQlWojxLu7CZV4P8gbhLz/eEpwDroqyRwuML7mf7vnsm6MnX4MroHnxAzbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321451; c=relaxed/simple;
	bh=PR4e4+tENh3LjRnzHYHnM5a0gYdn00lyatdQN8TvQLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KovMkpOotKiqvID7ND4oLhoesqsHH1ea700uY+CMqQEHBO1W752Y1mrJMW4Xw09a8+v1nosILVaKstWqndbvGpmfKpkxfdTRv6qoetwJKw33oa006cYs3zvbxwQfDnUFkRQTfgFqbHIVsMK6UrHv+3GrK7zq/OweGRP2s2MUCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbk1ws4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F571C433C7;
	Sun, 24 Mar 2024 23:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321450;
	bh=PR4e4+tENh3LjRnzHYHnM5a0gYdn00lyatdQN8TvQLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cbk1ws4dKcdqOs5AH0eGP1HVgHyM/9yCpIDIStioJ8LkwvXF9Qf8orwqCEU+AZsb9
	 DUYpeieOP0XUrHrEZkP5dP/Fo1rERMJrOYPxZQAuX846f3UfzhIXfNI58Ahx4ZIzH2
	 cP8P6dJZXvdCVVsWFIWB9CzWfO2+PK0Wgr8m1R+vFdbMFJGS4U+N7aaR2ujd+93B4P
	 cZwveoqytHHJyuUzdkUzYfGGgejrwA3kSSyjwseUl+Tf1AkeH3XCMMq48d2XzfLu6i
	 6OGf8sAXq2u4tI9fLuXAH+ZNDGiJyX9GpGdkh9YNLHHhd6anCwA26SKPZT6OJNY+Yx
	 xnfwZtL1D1VSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/638] wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
Date: Sun, 24 Mar 2024 18:53:31 -0400
Message-ID: <20240324230116.1348576-175-sashal@kernel.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 0fcdf55fced7121c43fa576433986f1c04115b73 ]

ADD_STA resets the link quality data inside the firmware. This is not
supposed to happen and has been fixed for newer devices. For older
devices (AX201 and down), this makes us send frames with rates that are
not in the TLC table.

Fixes: 5a86dcb4a908 ("wifi: iwlwifi: mvm: update station's MFP flag after association")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240129211905.1deca7eaff14.I597abd7aab36fdab4aa8311a48c98a3d5bd433ba@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 42da8e94900cf..ee6487af95f04 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3781,13 +3781,17 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 	mvm_sta->authorized = true;
 
-	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
-
 	/* MFP is set by default before the station is authorized.
 	 * Clear it here in case it's not used.
 	 */
-	if (!sta->mfp)
-		return callbacks->update_sta(mvm, vif, sta);
+	if (!sta->mfp) {
+		int ret = callbacks->update_sta(mvm, vif, sta);
+
+		if (ret)
+			return ret;
+	}
+
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	return 0;
 }
-- 
2.43.0


