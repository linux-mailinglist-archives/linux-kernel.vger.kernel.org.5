Return-Path: <linux-kernel+bounces-114135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005178888A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91A81F28D20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF609241906;
	Sun, 24 Mar 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyvBL+wj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD0132C1A;
	Sun, 24 Mar 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321446; cv=none; b=rCj52g877/Ek5LgYHr3C4z+zcdpPGsvVI+1XkLmaZboE0i+rS7s2zRh/fWnBMrjfCfvONKoOV/cKciL6N1fVDr0E/oGmu150N0tl1/Fb2g+fL4hYSEUlHrNj7X/NFJ+p06Ol3ffDEpoVbq8PE0ucCIIPMwDFL7qVdLjn1hX6gNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321446; c=relaxed/simple;
	bh=3NJO/MHNGf2S5Gtqb+H+tZFf4q92FhwDuxwLBOacOzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub72COkZ+TrDyKvbbCRd8JMW9XJx3c/T6xLXG60jVLMpByHRlhv5kbJbmENiB5Ft4eYjDiostjzASLy5or2KPZhDEjyUJtNIrKlFshZndMjOSgyXehtEletb0RSy7PsJxoRBkODzk/gapT4IvCDh5d1D/cdhtb5L00F3Jncl+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyvBL+wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D83C43394;
	Sun, 24 Mar 2024 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321445;
	bh=3NJO/MHNGf2S5Gtqb+H+tZFf4q92FhwDuxwLBOacOzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyvBL+wj0dAs8jwtTMxDN975uNS2NqjlGlUXP+zPPg95RUUqwu/TGqQmG1FN744wI
	 sfvDV0gf+eXzWYqEgsRJEbaw9o9wzGcfEMCQPLwrhCueS+E3igLRT2NMwVAxP2e/xl
	 7ls4s5Pg2AaODV+JRj5/XTynxNSPBtCtt2I3E3P2pLmEGZaGc+eGOWa+NOOFW/m4kI
	 GsrnSndGQJ/fUg1qCNKIpi9/DwutvN+roz/akjIRD4S0cuwsUCM7vie92DDsI1Tv98
	 c02NysQEO1i2aVt/1EGW5LL5JjV4frIlNzn3jZDIqtSeLLxqmRg1AixQ0hJulnvF3d
	 bJcQNDCK1dkjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 169/638] wifi: iwlwifi: dbg-tlv: ensure NUL termination
Date: Sun, 24 Mar 2024 18:53:26 -0400
Message-ID: <20240324230116.1348576-170-sashal@kernel.org>
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
index 1df60d51905b3..a97ed7cbe4d14 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -103,6 +103,12 @@ static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
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


