Return-Path: <linux-kernel+bounces-115854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272E889B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E89B44A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683526463A;
	Mon, 25 Mar 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8ysgDK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9212F585;
	Sun, 24 Mar 2024 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322062; cv=none; b=R5wzGqhLH61yRz8Kd/E8lqJ0t+kEGaEpFoxPFMcoboURgpfoSdWxAkLDCpCjVwiyYerAi/ZxuqIbce9rBt+vc0ZJ7Sa1yxZG+rEKYiXo+UpFPeLfysRLZDyYtJV5TwDCrzKtzDwVKgbB/eXdr7rE2vXDYSaFounGUXGARVi5cYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322062; c=relaxed/simple;
	bh=Gk5ghOKl8huWxjY72DczoFbQq9DR3kSonY4D7kMEmy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq7nDbTFHUrP7T/mMggAX8hcTU8mJhGXBIRaNfDqPjhlVxVR8+M6RsE9mSzTiypeDM5Esw4jOKv8dl7ttqZiOdUbJepmbzyPrtjNo5tVPqEnTJ8wQVWRrQbiAF8GQxe5ptsYq6BBt4uxGgdH1iXsEHiOV4b6AWeDyw+hrqp2LGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8ysgDK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CB9C433F1;
	Sun, 24 Mar 2024 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322062;
	bh=Gk5ghOKl8huWxjY72DczoFbQq9DR3kSonY4D7kMEmy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8ysgDK/ooTaUryYx8rvXggfadFIr2ofzgONovKfo3uU/PpWuC6NxIAxdAXXHg9ya
	 dIKZ2R0c4iTuSoPyiWnRKvRRfo/y4WK7ahLPGSdWSTD1zljZZIkp6u/Sb65/TLE+N2
	 qV4UtzysILafhJva+i0ARYykC/W2NcESKfw3Ax2XSepaApAprfV7WwU8qrQttb3dFT
	 ccOuvzBzawVS4sGYHE+bauGcdIE3s3OdphByiiqHd0iUh3+LWbasXYdMtFhlxKcwqj
	 W6xSsCmCD7z77faOWrWEpbq56qQTq6lEKHvQK0hj3qiHInH7rvZiHd6Hr2u2ibD+4g
	 YDsFGdCt9A8qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/451] wifi: iwlwifi: mvm: don't set replay counters to 0xff
Date: Sun, 24 Mar 2024 19:06:51 -0400
Message-ID: <20240324231207.1351418-136-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

[ Upstream commit d5bd4041cd70faf26fc9a54bd6f172537bbe77f3 ]

The firmware (later) actually uses the values even for keys
that are invalid as far as the host is concerned, later in
rekeying, and then only sets the low 48 bits since the PNs
are only 48 bits over the air. It does, however, compare the
full 64 bits later, obviously causing problems.

Remove the memset and use kzalloc instead to avoid any old
heap data leaking to the firmware. We already init all the
other fields in the struct anyway. This leaves the data set
to zero for any unused fields, so the firmware can look at
them safely even if they're not used right now.

Fixes: 79e561f0f05a ("iwlwifi: mvm: d3: implement RSC command version 5")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240206175739.462101146fef.I10f3855b99417af4247cff04af78dcbc6cb75c9c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 2748459d12279..88f4f429d875c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -461,12 +461,10 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		struct wowlan_key_rsc_v5_data data = {};
 		int i;
 
-		data.rsc = kmalloc(sizeof(*data.rsc), GFP_KERNEL);
+		data.rsc = kzalloc(sizeof(*data.rsc), GFP_KERNEL);
 		if (!data.rsc)
 			return -ENOMEM;
 
-		memset(data.rsc, 0xff, sizeof(*data.rsc));
-
 		for (i = 0; i < ARRAY_SIZE(data.rsc->mcast_key_id_map); i++)
 			data.rsc->mcast_key_id_map[i] =
 				IWL_MCAST_KEY_MAP_INVALID;
-- 
2.43.0


