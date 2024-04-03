Return-Path: <linux-kernel+bounces-129298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B3896853
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E191C20EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57C12E1D1;
	Wed,  3 Apr 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2tCLqZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288C6BFB1;
	Wed,  3 Apr 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131841; cv=none; b=aE8hRn8oxiMLgHCYrPKkYRfZtkc5/wK7F0ad+hDjec/lfSezzzeZ7s5tlOS+BGjVlqhhiyUAG+jRt3Zdn6A/eULcPciezlWWr7tFf/XuoNlXv1i2ubRKpV8DUhTt52++MOzzAQIb2H/ICcHcpBz6/Eexw+zRKchITl4zFDYzI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131841; c=relaxed/simple;
	bh=scbLLLDqtrB9TaspkSSOEEh23gE81TK8M2IdXp0yn2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HU8O+S0Vc/UjwVto2Q9AQasaJtSqes4fODfai2mxiPJBzehbm39iLefXORHthlwXIdR0M0ZFWFow2pQHYHOhAox/txK2e1zWjyLG/gR7IhSHqCRNecw7JGtMUidye4XvgjeZn2E1bn9kmtqaFVRSd8HV5ZjAmhqHRyvSu1C+Jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2tCLqZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC647C433C7;
	Wed,  3 Apr 2024 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131841;
	bh=scbLLLDqtrB9TaspkSSOEEh23gE81TK8M2IdXp0yn2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2tCLqZ2Mkwj4qfJTjl79pz7c0Tt3i5UN6ga1h8uC00fXrcBHxHzGGRhT6HqpvSgr
	 IoIWUE80Zo58Or0oBB/b+muUKZUu6HVnTIEIaIXZ0FIGnB2GxRLmeKff0PN5g67z+2
	 zIYFmkhntrN2+arCH1D8e+p3riteZk2wwdjmZhVLgl/Pxya+dssrpLbeREiqj+z8wQ
	 ns4ftkDpvpz/uiMNnWkTsaboZ944P5MfndEcfTnCEvjvYIC+Zag+v69V1RbekmcjgI
	 gcI0yXQWXBt5IhEPBs8ntNzeIOwMgJhTDbU/uxkTjItRkMuf7d3WwgabKyGK1JFiFw
	 INEG+PwSnHLeg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 21/34] iwlegacy: don't warn for unused variables with DEBUG_FS=n
Date: Wed,  3 Apr 2024 10:06:39 +0200
Message-Id: <20240403080702.3509288-22-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The reference to il_rate_mcs is inside of an #ifdef, causing a W=1 warning:

drivers/net/wireless/intel/iwlegacy/4965-rs.c:189:38: error: unused variable 'il_rate_mcs' [-Werror,-Wunused-const-variable]
static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT] = {

Replace the #ifdef with a PTR_IF() for better compile time analysis.
The dead code will still get eliminated, but the warning goes away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c | 15 ++-------------
 drivers/net/wireless/intel/iwlegacy/common.h  |  2 --
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 718efb1aa1b0..1aa2cee5d131 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -132,15 +132,8 @@ static void il4965_rs_fill_link_cmd(struct il_priv *il,
 static void il4965_rs_stay_in_table(struct il_lq_sta *lq_sta,
 				    bool force_search);
 
-#ifdef CONFIG_MAC80211_DEBUGFS
 static void il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta,
 				    u32 *rate_n_flags, int idx);
-#else
-static void
-il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
-{
-}
-#endif
 
 /*
  * The following tables contain the expected throughput metrics for all rates
@@ -2495,8 +2488,6 @@ il4965_rs_free_sta(void *il_r, struct ieee80211_sta *sta, void *il_sta)
 	D_RATE("leave\n");
 }
 
-#ifdef CONFIG_MAC80211_DEBUGFS
-
 static void
 il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
 {
@@ -2758,7 +2749,6 @@ il4965_rs_add_debugfs(void *il, void *il_sta, struct dentry *dir)
 	debugfs_create_u8("tx_agg_tid_enable", 0600, dir,
 			  &lq_sta->tx_agg_tid_en);
 }
-#endif
 
 /*
  * Initialization of rate scaling information is done by driver after
@@ -2781,9 +2771,8 @@ static const struct rate_control_ops rs_4965_ops = {
 	.free = il4965_rs_free,
 	.alloc_sta = il4965_rs_alloc_sta,
 	.free_sta = il4965_rs_free_sta,
-#ifdef CONFIG_MAC80211_DEBUGFS
-	.add_sta_debugfs = il4965_rs_add_debugfs,
-#endif
+	.add_sta_debugfs = PTR_IF(IS_ENABLED(CONFIG_DEBUG_FS),
+				  il4965_rs_add_debugfs),
 };
 
 int
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 69687fcf963f..b9f1daf0901b 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -2804,9 +2804,7 @@ struct il_lq_sta {
 	struct il_scale_tbl_info lq_info[LQ_SIZE];	/* "active", "search" */
 	struct il_traffic_load load[TID_MAX_LOAD_COUNT];
 	u8 tx_agg_tid_en;
-#ifdef CONFIG_MAC80211_DEBUGFS
 	u32 dbg_fixed_rate;
-#endif
 	struct il_priv *drv;
 
 	/* used to be in sta_info */
-- 
2.39.2


