Return-Path: <linux-kernel+bounces-113056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80688811D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C4B1C21489
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32C145B22;
	Sun, 24 Mar 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItftEjyu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40954145B03;
	Sun, 24 Mar 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319865; cv=none; b=g6OlPx3NgeyAx+vFYhkemKSiVxMgys55q4/oC/yw9c2D0qSTVV+3Ph2JkcofmE2rfVHy5z5Koi+jo1gNaLjhm32cep/x6FOI6/0mh7HiPz5dU0YQi1DFDTKmuyndLBop7ho/x7mab+76l3lT5LbdYBLJZMa3UiGUXjfxRIsMx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319865; c=relaxed/simple;
	bh=fNXPmhqnFO8SCZHEsOeWlY34U2RBXFyeg4JIchaXuW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7Jr7USs5Q6KtlFIDwFLLh3s38Pb+JDx7qlroIZnf+8/7/YLmOyWzDOxVQrP+aH0Y33lUoLlkFW9XlIwCAUbrqiGgzDA6gVNsEuARSWU4P+xPdBrozEJwZM0VB9wtEZOHffi/sV3nqK/quCfifgltFNfDkeYQ/07PE1j3CrclGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItftEjyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA94C433F1;
	Sun, 24 Mar 2024 22:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319864;
	bh=fNXPmhqnFO8SCZHEsOeWlY34U2RBXFyeg4JIchaXuW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItftEjyukzfgMxMtYVFnzek04J6k3UOT3FcGabLbC6JmO/7o7FSghkmv02Cz9HKiy
	 WYXTZna50Ujs59mjYLX7yqT0Dils21g6bzbq/9H4C4Sfm5ai0RTspF4HpQXDdXdhZr
	 YqMp2w+G6LLI3+ItINbmzeix57vCW0WhhxFDjxv49d8GlRDKIYMWbjPOEkjxodeSxo
	 z0v2BrZtoV3U70PpoZ+oO4dZZuZW6b7PcwVFBp+7awAeXn346PRMeGOM+ymXUExn8i
	 VbyspM58dNVhC4iCI99lbe0xFxG1kvXUq88RIHmSg5ryeQwPWCvKpesxdr84PGhIel
	 n7beQuVBf3mvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 169/715] wifi: iwlwifi: support EHT for WH
Date: Sun, 24 Mar 2024 18:25:48 -0400
Message-ID: <20240324223455.1342824-170-sashal@kernel.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit f51d6431824f0afb9f73d68971d154c47c26b86a ]

sku_cap_11be_enable should be set to true also for WH.

Fixes: e1374ed25324 ("wifi: iwlwifi: Add support for new CNVi (SC)")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Link: https://msgid.link/20240204235836.a6d4097cbaca.I8b00fa7b6226b4116cd91f70fb0b15e79b4dee5a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 2f6774ec37b22..501a8cc2134cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -2097,7 +2097,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
-	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM)
+	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
 		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
-- 
2.43.0


