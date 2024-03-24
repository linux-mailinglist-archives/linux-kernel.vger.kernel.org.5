Return-Path: <linux-kernel+bounces-113082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DF3888153
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECEEB221A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D214E2EB;
	Sun, 24 Mar 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBS70aGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9714E2D4;
	Sun, 24 Mar 2024 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319891; cv=none; b=ZWVfTLOJJAonDk4Fj1NcBB+WfYbgcL+62QWsrxEP/00zpIyG+mkfJ94JZxtkyQQc7mjTWsb8iclUHKYYxCrGyzs0S7AOUUtgkBhEQgoVcNrcLhuJWLTsSJvhzccSPZmWOewvSXBZFS8IUAQGzHYo8EmGj4GgLfgnP0O73h5BznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319891; c=relaxed/simple;
	bh=SSr5RFektTQL/EnOjOh7JFgVsHETDVqB8XLdmop9QhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGwI5LeLSDP3HgvOE82+y57qSEUN62idepRlyj8gbTkEynXJaRbbFOiB7UbH/p4pDXyVMUl4MoeTKMRn+iZYsVvN3DKIG1hRQj6Ly2kNTOfpKVrrbXL3sG6uMowW40KJQzSVecKPXXmveLmdFQCQeRl8OARcMGdj80kjGknCIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBS70aGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7842C433A6;
	Sun, 24 Mar 2024 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319889;
	bh=SSr5RFektTQL/EnOjOh7JFgVsHETDVqB8XLdmop9QhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBS70aGWtx2ui+RCdZC+KwQeradPQXfrwstGuq5Hirvp18mcE4gBN3rcVPkriwBNg
	 NofTPsRkStKX1K+pBQOZ53VWIsDn+TbduVLKebeq8/tEZXFB2xFTru+zShDRT7Mmwk
	 2Fxmgr8/Te2mjBekeDMg0+cDblefto1gPEvPt+mRWfdxkDsVFH0j1QFmhqyUL79JvD
	 JiF1Vy6l7/B3Amc9dJt0ftkur1XgrxaaCIR+HGztTGQBABf5ifE/JQOYH7YlmRNLgt
	 JJ0x9paAVMo8j8YjtZ2ApXPxdJ4F5FrRKbeW+agtVBkYTmQLNLvl/h/JNGAQd0Ke+i
	 DKPipPJ2mYYfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 194/715] wifi: iwlwifi: mvm: Fix the listener MAC filter flags
Date: Sun, 24 Mar 2024 18:26:13 -0400
Message-ID: <20240324223455.1342824-195-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 4cdb86487e3eaddb4b3a7df30ae709e810aac84b ]

One of the flags was from the wrong API.

Fixes: 9be162a7b670 ("wifi: iwlwifi: mvm: add support for the new MAC CTXT command")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240208185302.a338c30ec4e9.Ic2813cdeba4443c692d462fc4859392f069d7e33@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index f313a8d771e42..ad78c69cc6cb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -167,7 +167,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
 
 	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_PROMISC |
-				       MAC_FILTER_IN_CONTROL_AND_MGMT |
+				       MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT |
 				       MAC_CFG_FILTER_ACCEPT_BEACON |
 				       MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
 				       MAC_CFG_FILTER_ACCEPT_GRP);
-- 
2.43.0


