Return-Path: <linux-kernel+bounces-113674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25602888F93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD701B30139
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A721272CE;
	Sun, 24 Mar 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZzOum+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A783CA7;
	Sun, 24 Mar 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320635; cv=none; b=KGGmMLgGj3Rmb6GatisvWZYqQLgC0hat4oM/nz7j/hBg4FRSXTXDZbLanPghSNr3Egigml7tMgwTyp7UZQSGZLpiPtSmWeGRpFlXAMqTHhF9WEkpf44DZ3WB8UvYrVpiY0whYT1S3nIrHSdgES24MQoNSr4tQkcjwZwQLDoz94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320635; c=relaxed/simple;
	bh=pVlmAalfx/qHJDARgi2MRdk28SfAdK+WoRh5Vt+pmI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIhRtQj83Hy0wFYdFiN1hJiq7Wd2D8HbzMWV7qBQl4seWMn4wwIObWEFgY6pYgtgbafAESf2UBxTe460wyOZq2WmPus9Q7aDUdXlNG4S5GCVBL5p74HexGlajERRvYboxg8CN/Tbv841wb9EZuds0NMz+rKpTteOFzz2n6If9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZzOum+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2116EC43399;
	Sun, 24 Mar 2024 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320633;
	bh=pVlmAalfx/qHJDARgi2MRdk28SfAdK+WoRh5Vt+pmI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZzOum+v03MoPqPCAzrFyJaAA49erQEH6ZGMZS/y7O20FkIeP3V+lkhrYb1TjUJem
	 ugBw7p0vTicVfZ0VZimfyETxRP6NB2NpXpKXHAKH53dUksc5a/4qQHV1hufjB0UY7h
	 fFffrX3pLfF0rPCvw/K1WFCUotZ6t434GsM2wsQqCHechhdP58HDyio1/VoaZyCTqM
	 2cyPBjIsQTTXbCereeMXouuiSDONoZb8SckOTwBEG1MpDB9T3kCgQ0k/m8vVrzvcE+
	 zkTmompMrGq0+zq7JG+xM7bwfpIYEVhhyiPf39YeMhlGUZDWaoRi5igG4Enq6DHyLy
	 B3uS6iS4a/ykA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 195/713] wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
Date: Sun, 24 Mar 2024 18:38:41 -0400
Message-ID: <20240324224720.1345309-196-sashal@kernel.org>
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
index b87173bb61f24..68c3d54f587cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3795,13 +3795,17 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
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


