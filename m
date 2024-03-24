Return-Path: <linux-kernel+bounces-113218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3E888266
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BB9B23D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1E17EB82;
	Sun, 24 Mar 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+EFKtew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467D1802CB;
	Sun, 24 Mar 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320019; cv=none; b=mRY7q68liLE+lWcKQsodp+VISsQf4xZDCcrY3ohZDpjLrrOyGPTXuAMAOxI8D/Ahkqt8f+fOKEWxJ08GFpvK6k2ilVLqlulmnbtTWAQHW2ejjYLSV4G2MRS2z061dDJify12WfOp48J0frqFTHS8pctHW55N5zg4koxTinm70BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320019; c=relaxed/simple;
	bh=Hfi/TqPi91TIeYhP6Dc4Tjeb4JsDHT3JQTAvUmwMzY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZdsGp08DKh6pu36kBz3pcVSz/kVdlYIjriRUedTmYlj9/KbxI1eCGtG5VvsspsAsllqchlFsL8KRH+kFE8tnCFaidhLOVUpip7K9tIg7w8v0trcvuR+cIUNNl7dHJTObUfIxpIHPMOse1ovnesBkSOzaxuTCkEg7Z9FnH+Pj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+EFKtew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA87C433A6;
	Sun, 24 Mar 2024 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320019;
	bh=Hfi/TqPi91TIeYhP6Dc4Tjeb4JsDHT3JQTAvUmwMzY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+EFKtew2c+jMMsS6zdlpZSW8ayP1EYmS2IW5fLesSLykYXjgUUneLCFW+rT1vYpg
	 FmByd38kF6RzztZ7JT/Of9+T+4sDPgHZrvQXH2/gg9F1xnkCScE+zqPM3c6bdi5ZHr
	 KHJo5eO1NoyjF26WmCz/45Ru5J0QkRHPMiQOuiK1oiChbHncKP+O6vXY94bQP/KdEl
	 STwUMKnVsbx0lQ6mKKXG5v92bfWCw+r+KLM2Yrep+HdqBwhWBz4NS12DqN9+Rav9iV
	 JhNKDS9cOitOOf6TzPqRsYGUbiq8s1+oHF+v/tFTEhT98zgLB5I//c8JAkSVb+KOYX
	 aWG6JHwpVxN8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 327/715] octeontx2-af: Fix devlink params
Date: Sun, 24 Mar 2024 18:28:26 -0400
Message-ID: <20240324223455.1342824-328-sashal@kernel.org>
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

From: Sunil Goutham <sgoutham@marvell.com>

[ Upstream commit fc1b2901e0feed933aaee273d0b0ca961539f4d7 ]

Devlink param for adjusting NPC MCAM high zone
area is in wrong param list and is not getting
activated on CN10KA silicon.
That patch fixes this issue.

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/af/rvu_devlink.c        | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 1e6fbd98423dc..96c04f7d93f8b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1235,8 +1235,8 @@ static int rvu_af_dl_dwrr_mtu_get(struct devlink *devlink, u32 id,
 enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
-	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
@@ -1434,15 +1434,6 @@ static const struct devlink_param rvu_af_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     rvu_af_dl_dwrr_mtu_get, rvu_af_dl_dwrr_mtu_set,
 			     rvu_af_dl_dwrr_mtu_validate),
-};
-
-static const struct devlink_param rvu_af_dl_param_exact_match[] = {
-	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
-			     "npc_exact_feature_disable", DEVLINK_PARAM_TYPE_STRING,
-			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
-			     rvu_af_npc_exact_feature_get,
-			     rvu_af_npc_exact_feature_disable,
-			     rvu_af_npc_exact_feature_validate),
 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
 			     "npc_mcam_high_zone_percent", DEVLINK_PARAM_TYPE_U8,
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
@@ -1457,6 +1448,15 @@ static const struct devlink_param rvu_af_dl_param_exact_match[] = {
 			     rvu_af_dl_nix_maxlf_validate),
 };
 
+static const struct devlink_param rvu_af_dl_param_exact_match[] = {
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
+			     "npc_exact_feature_disable", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_npc_exact_feature_get,
+			     rvu_af_npc_exact_feature_disable,
+			     rvu_af_npc_exact_feature_validate),
+};
+
 /* Devlink switch mode */
 static int rvu_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
-- 
2.43.0


