Return-Path: <linux-kernel+bounces-115396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6F8893C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA371F301FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3D1FEC45;
	Mon, 25 Mar 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEl9XP9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA44144D31;
	Sun, 24 Mar 2024 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320687; cv=none; b=SK2QSiyGUnDVJtvEk7LA4KQeVxplSAyi92AxRAXlN1wntBSOB7jY7Zv1a3i6RFASKQ6KG3k0ywgh9gN21ONohSXswgvXETcPBHIT7Gd2GCzRbfm1UlmIxI6D5rThnJ7BUFQbEkcxWrZ9f81lRN+vMrnfZ9Q9Ykq82tQRPOw1W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320687; c=relaxed/simple;
	bh=SSr5RFektTQL/EnOjOh7JFgVsHETDVqB8XLdmop9QhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvT6Gya/wJjFZFVefwqnYQT5+glyVEXMhO9q6NhOyTIxN7yzHiTlhXI5EgGIc/rYaYqoAmsttNW83Gxlc95GEhAGRUcf6S3iaIzLjCwwP3/LInln45Mm6P/mKbp8DCfNth64Oc1uGnRpBQuLYTnFU5BrLxC9ZDIaNgEjN0xSCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEl9XP9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DECC43390;
	Sun, 24 Mar 2024 22:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320685;
	bh=SSr5RFektTQL/EnOjOh7JFgVsHETDVqB8XLdmop9QhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEl9XP9stM1Ol89iGzDCS2hza65er+VwqMOjBMiuT8omHuijnlpKNar/8QC3kQ9dA
	 c9p6fzAo3pM/JQb9MbVkGzKDSYOk9TgUBOnW7EGCXLX7NNEgyvHLt6D327FxE65pI0
	 qqNr9RgNrtOBZlVPSfZLsOZnCyiNHrrBleN0E20JHQ8dhM/NPcHBtFGH6ANlYJLpgG
	 J+N0LRvcRP1ci/Cxfa1NTXM3Vpp+e/64+hvRP1AOvYsmuQhWaSwQ2Z0eCS6gsV5JbT
	 /Jbcf2Zwcq5A47ZsrsD4r9raG9XG7CSh1Pn4mjndHpfKcegMoHBnCEqYMaNoV8RYMB
	 KokydEyFfFOmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 248/713] wifi: iwlwifi: mvm: Fix the listener MAC filter flags
Date: Sun, 24 Mar 2024 18:39:34 -0400
Message-ID: <20240324224720.1345309-249-sashal@kernel.org>
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


