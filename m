Return-Path: <linux-kernel+bounces-115385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E38889F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D1B2FECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224F1FA834;
	Mon, 25 Mar 2024 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePWeB+A1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A701442E6;
	Sun, 24 Mar 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320654; cv=none; b=jBxReacfLbIDrhecdPuWn6LG/kZ8aVk4kCXOTAezVHxIILa7AHkfKgoKF2kkLuxJt1Lz/LWooU8uNInyhonEWxn/09ZBk/ctif40tRlykIrpEQLDMM1A80jBJUeU3vsohDSlBYEl60GclpQqG6HLgU6L+E4C6Jx+asPvzGeVRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320654; c=relaxed/simple;
	bh=PHIqATS6bo6NV3wlkFnksqK/ycv/FqII4kw6233kAUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpIOXirBG7lanqutSUuojUs+P26/7aNWPBXeIBNQOSioObQ19wAjAJGPoGMS1AkBnAesQWPPLsPNzSKdp36KpCBAIS05wQc5b/1JfWhSEzdlGoTN9aar81ievymEtp7jhpjL/v+7uDN0yFNzyHliR0BMQttFRt8H0Qj+EmK9ZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePWeB+A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC15C43390;
	Sun, 24 Mar 2024 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320653;
	bh=PHIqATS6bo6NV3wlkFnksqK/ycv/FqII4kw6233kAUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePWeB+A1fFnDdMcgw5SHVhV3Wpt+/5Un4u0XpnhrSiCZ6ikM2QfSRaw78pRYnWRep
	 Wj7XVJhFrRXtZ+YLDiGHmNBcE6dqtzDBFo8/SlOXRQNbZxM7xJEXMMDmPmVfNqsmBO
	 ijdMnPxKy3elhDOA26Hf4jGqwkPp8jkvqZ00tra8TbQ9l2t4mCHyJR8o/6C9N29agf
	 AIMy144Dvev2OcLiQBnNx5nCutvQo3RtVoz47qdQtqpy4o3UDmOqvbijv6rlGNffAB
	 7WhAOTZyzbXl7s1EoCmTo78z84NPAOHwGpXQ3kyy1rDA0xoZWCjgE978AvEKAKO0ib
	 e44qxoyfesV2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 215/713] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
Date: Sun, 24 Mar 2024 18:39:01 -0400
Message-ID: <20240324224720.1345309-216-sashal@kernel.org>
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

From: Kang Yang <quic_kangyang@quicinc.com>

[ Upstream commit 019b58dcb6ed267e17b7efd03ec8575c1b67d942 ]

During calculate vdev_stats_id, will compare vdev_stats_id with
ATH12K_INVAL_VDEV_STATS_ID by '<='. If vdev_stats_id is relatively
small, then assign ATH12K_INVAL_VDEV_STATS_ID to vdev_stats_id.

This logic is incorrect. Firstly, should use '>=' instead of '<=' to
check if this u8 variable exceeds the max valid range.

Secondly, should use the maximum value as comparison value.

Correct comparison symbols and use the maximum value
ATH12K_MAX_VDEV_STATS_ID for comparison.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240130040303.370590-3-quic_kangyang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 54693e247cb31..237fb8e7cfa46 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5261,7 +5261,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
 	do {
 		if (ab->free_vdev_stats_id_map & (1LL << vdev_stats_id)) {
 			vdev_stats_id++;
-			if (vdev_stats_id <= ATH12K_INVAL_VDEV_STATS_ID) {
+			if (vdev_stats_id >= ATH12K_MAX_VDEV_STATS_ID) {
 				vdev_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
 				break;
 			}
-- 
2.43.0


