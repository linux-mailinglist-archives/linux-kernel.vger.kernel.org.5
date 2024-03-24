Return-Path: <linux-kernel+bounces-115667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D2889D24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5AB1C34E92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25035469F;
	Mon, 25 Mar 2024 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkeTCNnm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98907137C37;
	Sun, 24 Mar 2024 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321569; cv=none; b=RW2kXuysLsHXhBDkaFRP6dGQqwdslOa3fMEKuOK0I8zYa0s1Ftya3df1yBqpfjfCG0eDUTDYu6AD7rRflOsModYkpD7/RofaX3iW1M0XZh1akE6FmFci5FRPNcXGc1cplTu/DDAaLRzAVHpt8wqjDuUdUUaBjnsHO8VX/cv7BBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321569; c=relaxed/simple;
	bh=uBcSLHXRyE6dQb2A9gm9vxlYQW46b9gnve9H65mF034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+jnGemrc/+Y1iyHbiz6RG4S/LaT1ooT1EvuFmPHqV4XvaBd6502hKbGCHjbBdmhCJPBEOpyVkK6dk0Saz5D7z6Er4/LXD8HVSh8shrbE3S9wQeLM8BhraT2YMF5BsQTDniWWJQRd4ZtfcndPzG9sVxfk5jErBwpaHMrt1qoo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkeTCNnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94E8C433A6;
	Sun, 24 Mar 2024 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321568;
	bh=uBcSLHXRyE6dQb2A9gm9vxlYQW46b9gnve9H65mF034=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkeTCNnmz5Z6tH0uWxHeomXAdXFp65O5xJEOTYvXgNRIbKEx2TntKsMalFGE/UFVf
	 zA2uUMkADGZYPdwhpV7EknveHaZLCq3F+JFBosmW4UWQsP1rv/vuByaal4Q6GhKHfl
	 VV2oys+V1gwFX7n7/oBfKJMMG5Fp/yVy7ci9e3Az8sCo/rsq0I0YCZkcjPihPajr48
	 kL1LKO8rQ4mEWzjdnkVWIrGYaN+MA+f8bdYF3Ob9mp+2XC6Ck/YQ98Hdjz4WQxzKPw
	 Jl1AaVioHbVYtmSn0ZLx+xHTl0lRZMDYri7F9Bfg12NadzCa+GUHfjC+0Czl5p2BWU
	 gZ7EitW9YvbEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 296/638] igb: Fix missing time sync events
Date: Sun, 24 Mar 2024 18:55:33 -0400
Message-ID: <20240324230116.1348576-297-sashal@kernel.org>
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

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit ee14cc9ea19ba9678177e2224a9c58cce5937c73 ]

Fix "double" clearing of interrupts, which can cause external events
or timestamps to be missed.

The E1000_TSIRC Time Sync Interrupt Cause register can be cleared in two
ways, by either reading it or by writing '1' into the specific cause
bit. This is documented in section 8.16.1.

The following flow was used:
    1. read E1000_TSIRC into 'tsicr';
    2. handle the interrupts present into 'tsirc' and mark them in 'ack';
    3. write 'ack' into E1000_TSICR;

As both (1) and (3) will clear the interrupt cause, if the same
interrupt happens again between (1) and (3) it will be ignored,
causing events to be missed.

Remove the extra clear in (3).

Fixes: 00c65578b47b ("igb: enable internal PPS for the i210")
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 76b34cee1da3c..11921141b6079 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6985,44 +6985,31 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 ack = 0, tsicr = rd32(E1000_TSICR);
+	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
 			ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= TSINTR_SYS_WRAP;
 	}
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
 		schedule_work(&adapter->ptp_tx_work);
-		ack |= E1000_TSICR_TXTS;
 	}
 
-	if (tsicr & TSINTR_TT0) {
+	if (tsicr & TSINTR_TT0)
 		igb_perout(adapter, 0);
-		ack |= TSINTR_TT0;
-	}
 
-	if (tsicr & TSINTR_TT1) {
+	if (tsicr & TSINTR_TT1)
 		igb_perout(adapter, 1);
-		ack |= TSINTR_TT1;
-	}
 
-	if (tsicr & TSINTR_AUTT0) {
+	if (tsicr & TSINTR_AUTT0)
 		igb_extts(adapter, 0);
-		ack |= TSINTR_AUTT0;
-	}
 
-	if (tsicr & TSINTR_AUTT1) {
+	if (tsicr & TSINTR_AUTT1)
 		igb_extts(adapter, 1);
-		ack |= TSINTR_AUTT1;
-	}
-
-	/* acknowledge the interrupts */
-	wr32(E1000_TSICR, ack);
 }
 
 static irqreturn_t igb_msix_other(int irq, void *data)
-- 
2.43.0


