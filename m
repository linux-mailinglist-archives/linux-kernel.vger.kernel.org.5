Return-Path: <linux-kernel+bounces-115632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631CC889CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095EE2C5BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649534D44B;
	Mon, 25 Mar 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDrT9S1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FB2046D9;
	Sun, 24 Mar 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321470; cv=none; b=E+9v5iw53+y0gxqhNWXt4NbHGr8xtikgpWxrMfEEq0U2kD/yU4BRNDV8yimYUp9PBfYRP1hrejrtn6hK16L5TXzRfeW95Z2CGdTV06KeEPAUPHJAxZ/LptQU1/e/p45aNo5C+pjWN7UZVwY/k90qkGFdlsPfzi8+fLVsbLS+2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321470; c=relaxed/simple;
	bh=9j85DeQwPR2N+dsNzupi9Gy9qs2sENg92covwYsd3jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUA5F/GUvTGec53D6w2X2JerxcRYuheA1KIj38NJ5MYmXrCSPOReLPhFfFUjHPKKHLtaI9qO7W/m0o9XWO1sjsboGBX7bVsGDjtWFjZVJ88Rykk+8v8HB0o32VV908ldgDcR9DflQky0IFYpb+nV9pXxgs4vGaRtyUFO88/s4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDrT9S1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B157C43390;
	Sun, 24 Mar 2024 23:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321470;
	bh=9j85DeQwPR2N+dsNzupi9Gy9qs2sENg92covwYsd3jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDrT9S1nDnQ8T/2ZJE3sBVVf678RAmLl2tvCSA8O+aVUxbyF591++Fp9hLjLt53kM
	 NY2yngWSRFt1OxF8kXXZchwsDCsZ9RDIn/ADxSkIybhsT6S7YYEDc40/i0vDjkMm2c
	 AGpZD91C41cn7xLl5kFBn1eCrPNaQcxr0x3+pPCQT4SgbWCEfN/xAeUS3gWxxuRR/o
	 1pFQqrlJ8Eop2hnARaAZXAL9LB9f8em6g817xot7SLa+H5xsrou9ZHKmYp7dkJ1aAm
	 bpilBSEq1pb/VEHjxvcOg3YTMAw+d//5C0yYPASGcFhsUI1RXrjwbDU19jyEJymZVP
	 dL66NUE8epOTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 195/638] wifi: iwlwifi: support EHT for WH
Date: Sun, 24 Mar 2024 18:53:52 -0400
Message-ID: <20240324230116.1348576-196-sashal@kernel.org>
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
index 878d9416a1085..26870fc12df81 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -2038,7 +2038,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
-	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM)
+	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
 		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
-- 
2.43.0


