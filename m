Return-Path: <linux-kernel+bounces-113191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75B88822F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609481C2260C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0796179FA1;
	Sun, 24 Mar 2024 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6tbMvvp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDD179674;
	Sun, 24 Mar 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319995; cv=none; b=Wa4TwMv6LWwdGKsJVj72cMqsHbEVhZ7h3clVhV46Voy7PLyh8J+dFVKWPYMcJAD3QukqWcJv3nLAZaK1yPXRLLbikBBf64leCNorNRRrPVsHS8LpCs0ixvLfsSuV8EUxn5zf4Lh7z9B0YvKL7ntHLH4pwy+SYiqpLnQzInwP7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319995; c=relaxed/simple;
	bh=pAKBOIgC4EEXttjYElQekc9pn6L7DPK0ZU2LJdE5KMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfiszJT2DKhUeENmNGIyNHWapyT6bUwj2VpsdLkel9+DOyBcjvLt5DFeSe6VOUl0N+idHYVnOgi6iI9r2AYyposJZ+52Gy/wQpG6tgboIG9mL9jPAzKAx/W9T57F73EM4IW8wKJeNLaVw3AVej+q/mF1LF35PaKcsaSFBeRJILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6tbMvvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DA9C433C7;
	Sun, 24 Mar 2024 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319994;
	bh=pAKBOIgC4EEXttjYElQekc9pn6L7DPK0ZU2LJdE5KMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6tbMvvpznLYlMnhweRMgGluhZNxz3Z0YEvROsCeqGlvbjRGgt1AkJGFnZDdZDddl
	 kctywlI9MdOyFPt9Z3ut8guIV5erT/53j2d4Z+h6OPYwcn4L3L/2PloWp0Kxs+nxfb
	 FscoGkEDVBSSmnQOTGAYjHmH4j7Yh7/Ev1ZJ7drSdxC3CRp9ApAMTVDhDJkS3O7OXU
	 cqPzgn+DUoBkJn+YRY8LZUD0cW/pEsTACgKgquHe5yHkFeR0CkuDnLVmJJZ50brSQd
	 YUqb33SYrEtO2dnPOUOYVkYe+Qli3WSUj9aCw9qmthuw0GpNyEu/7WKSUq8iOWd5/Q
	 wUpalK9a4OtQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 300/715] igb: Fix missing time sync events
Date: Sun, 24 Mar 2024 18:27:59 -0400
Message-ID: <20240324223455.1342824-301-sashal@kernel.org>
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
index cebb44f51d5f5..7662c42e35c11 100644
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


