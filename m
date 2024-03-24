Return-Path: <linux-kernel+bounces-115631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD029889CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF8A1C34784
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F820405C;
	Mon, 25 Mar 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHJ62vqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D313442C;
	Sun, 24 Mar 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321466; cv=none; b=ggBKEphDAvkuLCrmxvRa+gl3Si8xkIx1xCNM/BD7bA/jzyondkvhloh5GPflHGeu/e/HwBUvFgAQoEE1T7FzGQbCOr8gL+nCklCtKOpmD+VfgT6ID3LHI0V8JPG/dDtwkfRIRHVzqvkrd+1TLWgqZObCRt7/aAJ5wOUvGSMWtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321466; c=relaxed/simple;
	bh=VnDGuHcYbqcpbVk8puKi+ZQ95N/HIblnKNAGwmVKMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCobHww0/y1hSqtj0i+cOCGT1pMKvI2O6PKoB1xakYYToLLJrP/np63UUgXposs5C1Mkw89RGdQvznBUTIVg7Ic3Xgp5ractn1/gw0Uxd7LEAQgiIUTlpmgTi0x3mRKNmNlY4f3rpoAem/fmlEZHd8pCsR6q2kXBiAG3UhdfOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHJ62vqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15599C43601;
	Sun, 24 Mar 2024 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321465;
	bh=VnDGuHcYbqcpbVk8puKi+ZQ95N/HIblnKNAGwmVKMX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHJ62vqUS9+F9HP0n6cHZ++438xzmdd6TSBCouIMzBLxKv1D1qMQEoU6PUe2SIXKW
	 AmnbqRPCGYEKufQtej+bzN11JgxhkjK0Og/e84uyAMyipc+pujfu4bBkz0fqHh+H4Q
	 GQzamUbRgrK+/XjI8V/gsxTU/aJDYCdIA/d9iivtVWzgALKffqnfR1CQ3ru68NMKid
	 kL/D+tXjrXiTYozYkS/fd7AMHIzU3TqR47zJF0anpx2KoDWVZ4aL4or0Oz72TKh3DN
	 dMsuhhDmUEtOut3eHzzTr9Zn9hpEO1vAlPdCnKo8y8oHpCBMs6Xo+lVQ8VMqz2jin5
	 uBFRfyqiDkLlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 190/638] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
Date: Sun, 24 Mar 2024 18:53:47 -0400
Message-ID: <20240324230116.1348576-191-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index a8a71478baea8..61435e4489b9f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5152,7 +5152,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
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


