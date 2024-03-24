Return-Path: <linux-kernel+bounces-116039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8987889520
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6728F1F305A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886B2716DC;
	Mon, 25 Mar 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TghkjD04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9C130A62;
	Sun, 24 Mar 2024 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323426; cv=none; b=XpM/MAU1Tvv6NxaKtVIl5ZIlLidsJB1R/X2+fHsSFZ7AW8LKoudlW56jmUuCjElbMSYSBTl2b4KsyzEH2kd5eVM8Cd4B44iTJKtn2RJ7WbHNB0NUW4POCCjAO2vBbgZMAQUA6C9oJ4iM9hKdWNQnB8J4tNfaTct10mkzIix6vuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323426; c=relaxed/simple;
	bh=xkio9LXk8a0yfT3MbDjP1BmFDPz+zLGtJQWcPfiV0CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RheqyF95/w2/U4UKEMx0byyOAtfYP3KWM9XX82V6E3napSAQ7/l+m1iFNOo3E/WMCSUtnxrbDy9zjje6iR3FM3RgOVkuut1cdSgLlo60YrwXKhBVIBYiwFLKhHlk+OgQQiQjUo5lKzyGEzPdHCojMBDl0t+TewMcQj0pKGhybuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TghkjD04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA55C43390;
	Sun, 24 Mar 2024 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323425;
	bh=xkio9LXk8a0yfT3MbDjP1BmFDPz+zLGtJQWcPfiV0CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TghkjD04cLSSD4KJzUi1tHE3Vfs91rqI3yoVyFGc+aQ7lICj6Vx9PgyTE8Rr6xebS
	 sJnPXxMXlvdDu6DWDzpxBmAy6chv0ISeo4xsPtrIo/UCcwbOkl51UaDBkkpkGDI22a
	 fz/Zz0fKJyyBYevwo3ZqQSwI+Py4MFHLxoVHN2THMi+QW2jWk8SKGZTLpGQ1A0ZiIf
	 14wgy6+Kdy57Yl8ebGQbI7bqUgrrnQpcubXD/2K3xorytycedhwf2cwCSIpHSryCvy
	 OOdhwUmvApg7bEL70gmGXQLXs1M8y8pl+rUD7zg7MxYuAhduYu4J/+fGs1pHyeBmcD
	 5Oxt8rY9gnqKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 127/317] igb: Fix missing time sync events
Date: Sun, 24 Mar 2024 19:31:47 -0400
Message-ID: <20240324233458.1352854-128-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index eec0ad98c445f..03a4da6a14478 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6800,44 +6800,31 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
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


