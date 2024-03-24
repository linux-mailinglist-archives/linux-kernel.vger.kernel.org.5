Return-Path: <linux-kernel+bounces-114766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F3E88925A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFC3B32A48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A521A852;
	Mon, 25 Mar 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LscAOKvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBA17557A;
	Sun, 24 Mar 2024 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323379; cv=none; b=pdSsDHAuq5YJIzeZ3oHFJg5mNb22nzAS6K/CCMr9Tgtxhzfau/ZXwaHl1JWgfs0N3nKMjKPkEsH1uDWVgvlkns+c+HE7pFqYhHF43Bw/jNX7keu2gtB7b0pqqcUDzXQuOkLnHqv22PhKpOSk88UZW+G1hSsK5jJjP63W0emA77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323379; c=relaxed/simple;
	bh=TupQ8eyn7/dVfYP6ZIVgExANMk6jJM8HzYOFyaH/OCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYTRODSW9rYr4RUFI8xKBXGhH0vgiMVixnfJW0OtMlMFnxXyrGWFWEBOdxy2ewlj24ZS1rpwdaCgIvsQQmnfm2aArtIFi8VvhufNHZV9dkrKy5dk0u1Vd1VYsmWABOX09naUre6Rhwrn56UGmHK3EZrnG1tCeqv5IuQMmc9SfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LscAOKvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B97C433C7;
	Sun, 24 Mar 2024 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323378;
	bh=TupQ8eyn7/dVfYP6ZIVgExANMk6jJM8HzYOFyaH/OCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LscAOKvJaeja/wG3S99Hg2i0iY1xcjkQ7nO1MMAKbprQ/cEUeJ0YwP0IZsp0t8F1q
	 TxCU/ORFn6OZO8IblNZrm2KALrQqs4dh5+Uv09bmpMtAgxvuU78mKJJOfmWvdLR7Mn
	 ZwCTObrLay4JuDpiker9QdczjVgWzC1K1B7LjlZQZxgZAfMqA0fAWrKWC4K1aU/rhm
	 lD8xRJ+ciRTOV7WD/1eDkUiV48aROVMnzDa/HLJ4CnTdcDYKNSu29SRGNVjStq3OLR
	 w6FbcSq7YWunvvkyyaIugie1CS/bWKSw6xzRajBnG3WYs/FiYCWoF00137IMqr0QP1
	 eGQ9yxapMb6Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 078/317] wifi: iwlwifi: dbg-tlv: ensure NUL termination
Date: Sun, 24 Mar 2024 19:30:58 -0400
Message-ID: <20240324233458.1352854-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

[ Upstream commit ea1d166fae14e05d49ffb0ea9fcd4658f8d3dcea ]

The iwl_fw_ini_debug_info_tlv is used as a string, so we must
ensure the string is terminated correctly before using it.

Fixes: a9248de42464 ("iwlwifi: dbg_ini: add TLV allocation new API support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240128084842.be15e858ee89.Ibff93429cf999eafc7b26f3eef4c055dc84984a0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 8a610c518082a..fe3239c4607e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -99,6 +99,12 @@ static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
 	if (le32_to_cpu(tlv->length) != sizeof(*debug_info))
 		return -EINVAL;
 
+	/* we use this as a string, ensure input was NUL terminated */
+	if (strnlen(debug_info->debug_cfg_name,
+		    sizeof(debug_info->debug_cfg_name)) ==
+			sizeof(debug_info->debug_cfg_name))
+		return -EINVAL;
+
 	IWL_DEBUG_FW(trans, "WRT: Loading debug cfg: %s\n",
 		     debug_info->debug_cfg_name);
 
-- 
2.43.0


