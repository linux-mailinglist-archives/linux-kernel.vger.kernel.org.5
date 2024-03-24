Return-Path: <linux-kernel+bounces-113691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B62788860E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D528F30D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4D1E305F;
	Sun, 24 Mar 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbliT4kx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BE8562D;
	Sun, 24 Mar 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320668; cv=none; b=iQLk6andfOMdXgISgEg93Ipoccru7WRlfbfTzhcV/qSipcbMFN/uZLc5BG58/eG18kr+NoTUF3K0slP/wy8h+03dn+T1XGc7MkBu3c1QiQv1QS2V0o7EZxT2mB7gI+x09+WfI+i9bv8YBFKeKfGqFnE+aivdVSRl6PqFtprYP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320668; c=relaxed/simple;
	bh=CbQovSnh/dktStb/N3qtE47FhWbJduvRic0p8lPpiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URL1UkjysjxeB/FlFFHq9lnDZHwxLCwet/2B0f5biUQTNUhov4v/LSOQgiQ7Omi+/b+tfQ5slr2H9jzpfJ1q4LYoymFEnIKVmx3WoetQUO9O7Nxm3rDKkEkn759hTx12XhVb6mDOPIx+F42o5oIWCXpHxLaueWTy9zuCp1o4TzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbliT4kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA7C433C7;
	Sun, 24 Mar 2024 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320667;
	bh=CbQovSnh/dktStb/N3qtE47FhWbJduvRic0p8lPpiL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbliT4kxIxD9FH8NR6dKQiUcdvjQYY7zg0PE4UF7P0REIoumleuFy0Mtj7L3cvIrj
	 TJznvPgKLLsnwLKs6zCASKVyBfWtZdk2bHfYlvDP6pMu8mD05zqUc10+El7Eiz6OPd
	 fItVfobIdOQIpucFUoMbMtN0kYlJMqkg8EhfIAeaRUhi6M9DFjVvRGvoeaJrS3+lnd
	 0ycDNQLE2iUPG24ZQ33sHzq6YTVak7MZA8z7oJL0OI911knQp3RqL4QVdeaYENAv07
	 mO01MwomI//94uFn8V9+dOUSqA4q2ITltLZSH0fhK6G6OWPLwpNrX91SMBGjgFAM8j
	 BBZLUlJJLkKzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 230/713] wifi: iwlwifi: mvm: don't set replay counters to 0xff
Date: Sun, 24 Mar 2024 18:39:16 -0400
Message-ID: <20240324224720.1345309-231-sashal@kernel.org>
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
index 626e9b94a6624..d99a712e7f44d 100644
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


