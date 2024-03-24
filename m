Return-Path: <linux-kernel+bounces-113045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CAA888108
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB5E1C21330
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011E1420D2;
	Sun, 24 Mar 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiRBAtin"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3E524DC;
	Sun, 24 Mar 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319855; cv=none; b=jsqTp/gWa6yk/ydjPvB47UMZHzOyyAtGu72A0kLa9MTO0WWviuvFeeDL7BemcbTrQoALZ8iqfg9tk3MXxuR1p+u3HHAIu0P6pxpYOSjEyY47dIb8nW3u8PtD53TcMK569khxv6jd6gbQhEKgISeiDQSF+VqQ9QtZlE9VzBUemj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319855; c=relaxed/simple;
	bh=bm0nHDz5om7WHLyihz32vRBvx8OpXaA6YLsgeYe1SWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFNhR25EXgvplKITzl8KYZH4CH+0TpviXCtPiUAtm+09YTDEO4uKg+gqDmsIMKIHOgl/cnzk38FUltZ8zYGMSvV0NsY0Vr6M6ZltmK+e2tbw40aP5RtPS0fWfVMt+ZV6loV0FOB59xGP8Gu1fc29s54KyOc9CDXjmYmqPAzUF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiRBAtin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5850FC433F1;
	Sun, 24 Mar 2024 22:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319855;
	bh=bm0nHDz5om7WHLyihz32vRBvx8OpXaA6YLsgeYe1SWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiRBAtinypgsGzN5wca30VlofG/R/wJKJFTzaWflYm4Q26ChWM4JgcklHs5RHBqYG
	 Yw7nEK87RdSpAJlIa4S0eE0et2EqQ4Batvo7ulYY/RK9UqRp2kZVqpkPZyN6IEAt1v
	 wI2a3rZ+rwDaOxZgE3EZEh+PjVjAvSdv6Vc5hF4hVAOCTrUA7uaVGgLusvCrtKuwt4
	 jROiQxJInTAEzSohc0YDJXPN+fgu6Mxnlusv9/RUX4d7w6B/GRSzkJh2KbscDcHP8I
	 4NEOouYEkmbZvlETsyLOlQybQSnhCOtR3jGfek7tTo7kwW3Uv8FOS5FNcUJ4eicHTw
	 wObajVDRmWwaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 158/715] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
Date: Sun, 24 Mar 2024 18:25:37 -0400
Message-ID: <20240324223455.1342824-159-sashal@kernel.org>
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
index f4e5dc363472b..b965fc46ad89a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5269,7 +5269,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
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


