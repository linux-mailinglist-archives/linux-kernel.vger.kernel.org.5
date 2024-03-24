Return-Path: <linux-kernel+bounces-116138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC188998E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0000D1C32918
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5CA3AF2F5;
	Mon, 25 Mar 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNVkhzZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88B131192;
	Sun, 24 Mar 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323684; cv=none; b=ayix6cW4LIpUm9WAXjo81CIYpMXBSxwdHUdyXMeUvo+92yy4v9q5ndUskeV4YjUldGExXf4duNFpKzMzIi2Do/lRnHy/ttW4tIGJ10VooRx4t+kNpcTrofM4AdlVuwaOBqCOJ4/z1M7M3nRNoIk505nOy+RXIoyB/fPYeqe8l7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323684; c=relaxed/simple;
	bh=koVwPrZQUSvcHiiHHSXm4PoGQaBqY7IyOELR1RuD3Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auFFCrxOCh3NdCkyPlpLihq9hwGlxtCG/yN1H0YTLzJ25c7YN29WO73tY1px1y4B4GHeFfNzOsE2TlhHqJkSQH0mYgR9wqu74N3ZgKLPTz2yv2o2YkdzU7hSUzIer5f07bu2GiuJAR4nRQgWdMT6FznvmP7Fxq8LH+4x8nJfqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNVkhzZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FBCC43394;
	Sun, 24 Mar 2024 23:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323684;
	bh=koVwPrZQUSvcHiiHHSXm4PoGQaBqY7IyOELR1RuD3Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNVkhzZHJ+rAlFQxV9qXDbTKF/jWQydx3U7Bcs2AdVplET0ASRhVZ7WbbNOZjmNYc
	 yWc2F11pro1FwPpe6lNXZigmMvzd3KCyKQovbjYSoRJenQhTKWDWBnBzudCDpXr4pM
	 L+R2cgi3DS41K4jd4i5XVt67AHN23+tBwkOiiihaySdYUG1asHqSFPD/QeWsZNArK+
	 Q0vFEOgL6Gw9rfUoqtKz4BMVnA4Tl9nuVZcreF02yl6+lmN6p6pLppG339wEi0zX2I
	 ErYI2pEBOD5eCMmh5qYsx4wQ4AY2fZ6ZZgKKz8axqFIwGZBaHWr07UAeF5LGyaA1r1
	 lJQO0pO2GgzLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/238] wifi: iwlwifi: dbg-tlv: ensure NUL termination
Date: Sun, 24 Mar 2024 19:37:24 -0400
Message-ID: <20240324234027.1354210-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index bcaec8a184cd6..299819d2d1904 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -155,6 +155,12 @@ static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
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


