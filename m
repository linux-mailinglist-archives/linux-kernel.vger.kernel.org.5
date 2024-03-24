Return-Path: <linux-kernel+bounces-113060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83582888125
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421D41F24B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C31474B6;
	Sun, 24 Mar 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e40wPAE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9A14601C;
	Sun, 24 Mar 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319868; cv=none; b=I8gI2E15/ph+QvMuUbGL+QhF5AAYec73JpXHKzf5a+60l/pUN7uRNK7l3oayxWd8QMdp06ByhAr9uqD90c1srQCxepzkQq3js97ZIC1UKTpJSqXYmW4Em6QmGZNXiTFZD70pS5iA+yL7bHgYdiKfTnP4R3Rnk77HnyJfg38hSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319868; c=relaxed/simple;
	bh=vRIH/teENEUyKZXX8+33/a5ZC/EJzFWpJ0jYowbh0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqUJCLwfI2oagdSl8WtBEnL7UpSFZ1W3eD5LLy7tIucLrN8HMQFVksRmnERtN+95PrGS5zPdhJ1tX0SwutyedYqplVyFaw3SQrUBlUavn+ZTM+HpUyTBQng7fHrIGlasxTwXg2CiMf7XrTVaEn1j0TNMl0E1ktdS2Id8yy1Olak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e40wPAE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D637CC43390;
	Sun, 24 Mar 2024 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319868;
	bh=vRIH/teENEUyKZXX8+33/a5ZC/EJzFWpJ0jYowbh0yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e40wPAE6HfiV9K1GnaKzRF6YhDdzwbHabW9FLzU2ta8iaEvpHv+qKQqHGljsCc4mG
	 TcMF4O1llrxwFanvLkVP767/1i/cWdVBbvfm6fhsVI2gJWonXd3uDnhiKtQxm4hAag
	 GSKRwXoWF/S4jNZjuaK+fZp1TEb4E91ulpW8rkm5xnMWX4yGyQk0X/G2ye7QOFgSxL
	 D1Yar70tMZq9ku4A3WMDFBCYu8lLI7iG/rq0vv3oU+CLJw2oRFS8oUhkaDKgAzkqxI
	 FNhXQROXURwhaCszm7oEXmHfsbpErqsrNDaw+SNNC5GyvLqV+azXMDWU6W3IWLG8oC
	 0F9ZrtEgzpKpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 173/715] wifi: iwlwifi: mvm: don't set replay counters to 0xff
Date: Sun, 24 Mar 2024 18:25:52 -0400
Message-ID: <20240324223455.1342824-174-sashal@kernel.org>
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
index 03d0c9ab73fc0..2a08369238f23 100644
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


