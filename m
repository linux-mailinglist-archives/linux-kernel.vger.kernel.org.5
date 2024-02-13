Return-Path: <linux-kernel+bounces-62597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA7852374
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F66F281C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BDE4500E;
	Tue, 13 Feb 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNL1/eKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4A50A83;
	Tue, 13 Feb 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783554; cv=none; b=dNyW6lJSx5I6E6ynufv20pcRUAnDzsPPCvi1KfQ/8QXSfntu4U+XaDqwTiU3YuHKEHJwqZyAbGxFSHrX4xc0WjyUCBcoggUTOP3vfFMGPmKfRuIRLGwvFe32BA0Xtw3Xc33jcHOkyW/H2FpysX1y6/UCL1K9aXdlPC799SQ4PhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783554; c=relaxed/simple;
	bh=sOQzwAhkYPZG+UlO/veCisNSLpT3rpXQwF1+90vx+DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6e51R8icgYaPwCuvaUk6pd5JnHEvAdQmgOWlmboUgHbd9+Zu84rNdYtB7wpUYLVL3yIZMaGeHCq79/X3rxv0n1oh9ettkR8qpiJVbEkWGasat35QpKisGop9xtrjeiEMoInB4XJd0/ev0D/lHwKRYPkD02OzjVrVhIqv5fwYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNL1/eKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C60C433F1;
	Tue, 13 Feb 2024 00:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783553;
	bh=sOQzwAhkYPZG+UlO/veCisNSLpT3rpXQwF1+90vx+DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNL1/eKnvLLMW/4w+gONfOj1SVJ9K2Kue7XVWMQ1NbPc4QqPddS7CEqkhWB8CEhu6
	 RX1RUwhPL4HEWzzD6HXp3RADpXT4nhUlhpTzkZs9OESoKWUfCv2UzPXNlgpkclihn1
	 OH26VrJk0ekQscK/DyT+uEteuQM6yglEpKQR6L3yLs0cwcSmlP7k1lTXywNS7Q3lvm
	 P/AG+DWyqu6/g7JbLNtY6mc8DcBKqzIuwLDu/LUnPo6eIBU0oGkZhWxo0a6w6fahGI
	 FX5dto9ZKHA/oEr6+4SvWarMlTPtzxPCDpMKL3Jy8ZF9HXYhEZAtwL6aDsGM5X5Kge
	 36qe1+FP3/2Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 28/58] wifi: mac80211: initialize SMPS mode correctly
Date: Mon, 12 Feb 2024 19:17:34 -0500
Message-ID: <20240213001837.668862-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 86b2dac224f963be92634a878888222e1e938f48 ]

The SMPS mode is currently re-initialized too late, since
ieee80211_prep_channel() can be called again after we've
already done ieee80211_setup_assoc_link(), in case there's
some override of the channel configuration. Fix this.

Link: https://msgid.link/20240129195405.d6d74508be18.I0a7303b1ce4d8e5436011951ab624372a445c069@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index dcdaab19efbd..a489aac653c8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -2903,6 +2903,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	/* other links will be destroyed */
 	sdata->deflink.u.mgd.bss = NULL;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 
 	netif_carrier_off(sdata->dev);
 
@@ -5030,9 +5031,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!link)
 		return 0;
 
-	/* will change later if needed */
-	link->smps_mode = IEEE80211_SMPS_OFF;
-
 	/*
 	 * If this fails (possibly due to channel context sharing
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
@@ -7075,6 +7073,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	link->u.mgd.p2p_noa_index = -1;
 	link->u.mgd.conn_flags = 0;
 	link->conf->bssid = link->u.mgd.bssid;
+	link->smps_mode = IEEE80211_SMPS_OFF;
 
 	wiphy_work_init(&link->u.mgd.request_smps_work,
 			ieee80211_request_smps_mgd_work);
-- 
2.43.0


