Return-Path: <linux-kernel+bounces-113013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3948880C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98691281B80
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B01353F4;
	Sun, 24 Mar 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so3dOg46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B294D9FE;
	Sun, 24 Mar 2024 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319824; cv=none; b=L0cvC+K6KqywiiDNj1V0wKA/pDbRZWHs0CIs6ouph3FFvverdgl7uVztOQfTxluCGz7H4j3cyqe6lgU/70PVHG5DGmUavrG/fDzDzbwWMsyGO2hjtPVKj9E6imZPjDmHM+bHr+68xefH2Pfu2wCjfAOMPp4R76HMH1pXuIoKo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319824; c=relaxed/simple;
	bh=KO8U+3kFg3Bhq9PhySBL+icUpyYJRdIbG31x0XFRssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOHjQshuQ+dBp/BhmmbtzxqxVlqv4zd8eUr5BJnA9zHSOQEuv4kB5dwjX6MWkzYftraXMKV6ZD9I57F7UJuwFu3/c4p8iZz0uqZrXMHfs3EabaTXjqm+kgtlpDV33RuoPdsWBpRi2vW9OeOVGzXVynYIWkUa0euMiQupfXQfKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so3dOg46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B547C43399;
	Sun, 24 Mar 2024 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319824;
	bh=KO8U+3kFg3Bhq9PhySBL+icUpyYJRdIbG31x0XFRssg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so3dOg46Wus2pk/VDih58Kpi9JxT+iokXS6HtoOxaQYdinYQOXhbaoyJBWQUhtOND
	 iMDmzssIVWp3jkV+COCQT8hnm7e0l4n9yL/v3PRqpYYwD+70bk+Imy456/2Xn9S8V8
	 l1MMaDeFzjCPM74V+PldDplnOsTZP/dC04ySm4gm6CAGFtdDGLnDjsI3dRIPVbULmT
	 nMR6/eyX0xHAqQHL4qmIlM9GUc0+C+jtgYXvoJdcE5wLAV9mf9s4KmoIwsaiHHy9jy
	 EbieDA939jliej59EUSVpDmz9bf7NyYQ2M1hV1ODaKyRBlCvH7vCz2HHByP3fobFcJ
	 Vuulc65JfxCKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 126/715] wifi: iwlwifi: dbg-tlv: ensure NUL termination
Date: Sun, 24 Mar 2024 18:25:05 -0400
Message-ID: <20240324223455.1342824-127-sashal@kernel.org>
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
index 72075720969c0..3442dfab50b53 100644
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


