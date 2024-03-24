Return-Path: <linux-kernel+bounces-113017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38258880CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57171C21124
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4548137779;
	Sun, 24 Mar 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+kxftCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93B4DA19;
	Sun, 24 Mar 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319828; cv=none; b=Mv9yIWagYDiqPKyAFzS77ZnnPjqUV/gN2eBZwTsF1ZSrH50ieEh4ZQ0Fck/ZZXVk6pYMk+RGpD7QcDEpM1eOj9j54LkmFIiz8gifXIoNUJQHrHwlXV1lDHMHODzqh1FNFHf4L/QnN9yBtWNYFozqZto6XmYi6MflS0UH1VYJz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319828; c=relaxed/simple;
	bh=soa6+wLeSx4p3+23fyg42wBQs0Dyods3SJnIOwXqhOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzIgkKcQiSkX/9QPoaJRXwo8ZGI28J61IjILdmrlZiZU/YZTUsOwlqVowd4FuzGOo69hnQelwAe/Fwxg8krNqqSOFUiUqdGktMin9EVMHVxjyFsB2qwLFJNyDccXkcnD9INo+ckiJXfUTOpBbhQSs3BPRvH9LYqhp/udJZAoQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+kxftCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32325C433F1;
	Sun, 24 Mar 2024 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319827;
	bh=soa6+wLeSx4p3+23fyg42wBQs0Dyods3SJnIOwXqhOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+kxftCPmHa7z4xRbwuP/kKSIuyFrilWnxuC3UnpawXp/bRGzU+QwfrUr+3dMHxg6
	 v3GREJlCfRt/SJ9y0Q48KLYH+2TiE3sf2AijFf5FgaFOMtATqCSPBdsdNZx7R61zO4
	 apA4iyNcNyVuB3jpY55YVXN1x8fr3ynXM+k4Zo7cXOvfQJgizjCo3Vn272k1HXfbJ2
	 jQjpD7KKI+YMzeakq8NQ5TspaihO131QcFyzz4z6IjNKfMJVV/86EX3DUktPpLSEIT
	 uBbXnZ4m9rm4talft75NxOfYNvtqCm09NElTLP7cXr7GpfezcHDa/pXrIfSYiYjAWN
	 CJmOxClLxtGAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 130/715] wifi: iwlwifi: mvm: d3: fix IPN byte order
Date: Sun, 24 Mar 2024 18:25:09 -0400
Message-ID: <20240324223455.1342824-131-sashal@kernel.org>
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
index 05b64176859e8..03d0c9ab73fc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2200,7 +2200,10 @@ static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 				 struct iwl_wowlan_igtk_status *data)
 {
+	int i;
+
 	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(sizeof(status->igtk.ipn) != sizeof(data->ipn));
 
 	if (!data->key_len)
 		return;
@@ -2212,7 +2215,10 @@ static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 		+ WOWLAN_IGTK_MIN_INDEX;
 
 	memcpy(status->igtk.key, data->key, sizeof(data->key));
-	memcpy(status->igtk.ipn, data->ipn, sizeof(data->ipn));
+
+	/* mac80211 expects big endian for memcmp() to work, convert */
+	for (i = 0; i < sizeof(data->ipn); i++)
+		status->igtk.ipn[i] = data->ipn[sizeof(data->ipn) - i - 1];
 }
 
 static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
-- 
2.43.0


