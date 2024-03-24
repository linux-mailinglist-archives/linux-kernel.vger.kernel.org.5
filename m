Return-Path: <linux-kernel+bounces-115627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D308895E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E97B381D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F534C558;
	Mon, 25 Mar 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsdsb9So"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198672036F2;
	Sun, 24 Mar 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321450; cv=none; b=fBgYAbxsl2c6tPn4ttAeVUzVATTE+7jttB4ibFImjvz5NBjFJqlaeQKmo3EB1rTfxupQFDPknS8gIzL1Qs14qp7lP6simrDJwOppirVvPIf7Gqn0LZygErs+loCQRMxfnbWr/2uf+AlSDdw8RSZwuu6Rdk8Mi3svXi6+JartN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321450; c=relaxed/simple;
	bh=EAxgTCF44cVnF3Vp3veA+A0OsIW9qVRQPO4GdFZe8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar3EHmkemNfgpvioQKD2hsjMVFRxSLbal2oqM1FQBeAPk4YQQc8xG3zJAeEqNS9IvhKAyqSzsem0vjwO25UDjIoUfrOt/LiJwp6f5UsAIRz0BPuYMVeTXVFvWfJUX8eoH2BDTpHtxi64gUGBu5OX0GScBFsG9HrMOKq+Zog9ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsdsb9So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4344CC43399;
	Sun, 24 Mar 2024 23:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321449;
	bh=EAxgTCF44cVnF3Vp3veA+A0OsIW9qVRQPO4GdFZe8i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsdsb9SouxQFE4xt2azLLAwbsKrxU7dcjTABKRD5BtFltkCfBvIhyhjjdbK3m5fD+
	 HLPeAm82+MAEIRtToFEOyT5R0r5aCssqXciM6IQmajf3Ilp/v003ocJTRkXOje92wu
	 a9aOp9ioJi35qU1ufA/glPC+JOXXobYIzmWgHkv0FN+A3zX7fOVX1m0JsVVg5N1Xi7
	 5YHotxDCWcdPmPEUOaAsNMvj7S6h5vMcGc8wA3OE0spyNp70g4S1eJ06gAVixyad8f
	 RPfScPCXLYxINQfdofjESSjjvRG+X7bwAhqLF9GeV4/FDwqo5aMt01WJLW/JkX7eP8
	 5scyw+LzBWDZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 173/638] wifi: iwlwifi: mvm: d3: fix IPN byte order
Date: Sun, 24 Mar 2024 18:53:30 -0400
Message-ID: <20240324230116.1348576-174-sashal@kernel.org>
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
index be2602d8c5bfa..dcda7fbb5a7a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2167,7 +2167,10 @@ static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 				 struct iwl_wowlan_igtk_status *data)
 {
+	int i;
+
 	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(sizeof(status->igtk.ipn) != sizeof(data->ipn));
 
 	if (!data->key_len)
 		return;
@@ -2179,7 +2182,10 @@ static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 		+ WOWLAN_IGTK_MIN_INDEX;
 
 	memcpy(status->igtk.key, data->key, sizeof(data->key));
-	memcpy(status->igtk.ipn, data->ipn, sizeof(data->ipn));
+
+	/* mac80211 expects big endian for memcmp() to work, convert */
+	for (i = 0; i < sizeof(data->ipn); i++)
+		status->igtk.ipn[i] = data->ipn[sizeof(data->ipn) - i - 1];
 }
 
 static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
-- 
2.43.0


