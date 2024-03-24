Return-Path: <linux-kernel+bounces-112951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0064888000
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342111F24637
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EF3DB9B;
	Sun, 24 Mar 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i00GsFaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B483A0F;
	Sun, 24 Mar 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319764; cv=none; b=gB4yDe3YQTR7jkZKXmM+ef2YwoGY/EQTXjQ7UKUGpS26X7MFaahaxDm1exmdSJK++TSEpJ74iw9O/c0YW0hyTKOlxNVMjAEHdnM03grYd08hQb3jarb0EpfZuOjr3FA3701eUk4bs3kZwRh44PCDiJmLc4X6+il5kKn7LJ/ZVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319764; c=relaxed/simple;
	bh=MOxlhC3dPM+XBhOSTUcc9poorlCAcDLGIwRC0xTng1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkZZvbHYORv1S+bDUUFpjx2Ap2mPBHQiysQAm8S4TYBv/w4Z8DvD0mVWy8Uu5QlAATu38VP7iQzEbHW+aOjKPpIzAmoNfg4q2KXJ/Ung4KZG+CK+ZY69jW7l8SEYnGkIL3KZMl2lNjGg/i6F3okb0lN/4EHGEDxkARDbPnUMuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i00GsFaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6427C43394;
	Sun, 24 Mar 2024 22:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319763;
	bh=MOxlhC3dPM+XBhOSTUcc9poorlCAcDLGIwRC0xTng1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i00GsFaPDH+Mr6og8hryEDAjSsSB3vCdP6vHS6ygEsRRwYArUepz9hyjJMvQD0h41
	 bokrWFI3XIC6SuAtBN47l2TKNE2E/VdKm5uxn4N83hrXy1tdNlIACRdT2D0rxMJcf/
	 F+Si1o+vLioOs9b3zeQMZYMyhulc3KTY4/hCeIzRtYdPWOJHWq3w4ViylUzBoLIvIB
	 EtSa8J5mwSBsjkuFS8JVTmvLBuWEbah3FCFwS08Om6HkDqYhXIj0VNCMK6DvjgXyBu
	 c1zxnwIL9x1xNh2bJwrQNwCTL7lO/Oa3z9N0corvjFs9GS/yYT44juq6yT8WS+7jPM
	 enHoEHzQMt+lA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Wen Gong <quic_wgong@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 064/715] wifi: ath11k: fix a possible dead lock caused by ab->base_lock
Date: Sun, 24 Mar 2024 18:24:03 -0400
Message-ID: <20240324223455.1342824-65-sashal@kernel.org>
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

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit cf2df0080bd59cb97a1519ddefaf59788febdaa5 ]

spin_lock()/spin_unlock() are used in ath11k_reg_chan_list_event() to
acquire/release ab->base_lock. For now this is safe because that
function is only called in soft IRQ context.

But ath11k_reg_chan_list_event() will be called from process
context in an upcoming patch, and this can result in a deadlock if
ab->base_lock is acquired in process context and then soft IRQ occurs
on the same CPU and tries to acquire that lock.

Fix it by using spin_lock_bh() and spin_unlock_bh() instead.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: 69a0fcf8a9f2 ("ath11k: Avoid reg rules update during firmware recovery")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20231218085844.2658-4-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/reg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index adcd9063a59c3..d4fd3509e608c 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -852,13 +852,13 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 	/* Avoid default reg rule updates sent during FW recovery if
 	 * it is already available
 	 */
-	spin_lock(&ab->base_lock);
+	spin_lock_bh(&ab->base_lock);
 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
 	    ab->default_regd[pdev_idx]) {
-		spin_unlock(&ab->base_lock);
+		spin_unlock_bh(&ab->base_lock);
 		goto retfail;
 	}
-	spin_unlock(&ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
 	if (pdev_idx >= ab->num_radios) {
 		/* Process the event for phy0 only if single_pdev_only
@@ -911,7 +911,7 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 		ab->reg_info_store[pdev_idx] = *reg_info;
 	}
 
-	spin_lock(&ab->base_lock);
+	spin_lock_bh(&ab->base_lock);
 	if (ab->default_regd[pdev_idx]) {
 		/* The initial rules from FW after WMI Init is to build
 		 * the default regd. From then on, any rules updated for
@@ -931,7 +931,7 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 		ab->default_regd[pdev_idx] = regd;
 	}
 	ab->dfs_region = reg_info->dfs_region;
-	spin_unlock(&ab->base_lock);
+	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
 
-- 
2.43.0


