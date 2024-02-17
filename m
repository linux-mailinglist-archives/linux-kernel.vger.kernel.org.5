Return-Path: <linux-kernel+bounces-69624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF4858C83
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70511F21AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93651DDEB;
	Sat, 17 Feb 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL7ndm6V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F114F61;
	Sat, 17 Feb 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131929; cv=none; b=jqpiSLC3dJkY0paoHT4LioPYtJxuFo+EX55VxPyWUgaOzXYJhoQLazI5oIleUkbNVk64IdBTLgrR9X0eDcZs03U33Q/MHKvL2BJhZ/Y18EFL8rndCFk1jUR2CTsQyDPHZr4JO4NyXh4rLOOfLqinEsFaqkE2FUFAVMqXfUhTCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131929; c=relaxed/simple;
	bh=3gIhMRxOTlYjhdMs6F0CktjFPYvv26wJULWvOFObDFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/zG0qeIJ6kgFmfhOpdYwCe5L7bQQDgxfW9rEl8g61y+AwQKiOk+QL5Ak7fsHG0YmN5Zn8HZa7+VIjXE/Bm/pWY/fi9F8WF+HaztUz6oue5jHX6zDlng/dJLIrqXr7RfgXh81ZjBoH+hqGWaxz6/qT9S+fGbDSToixwAhN9t4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL7ndm6V; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708131928; x=1739667928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gIhMRxOTlYjhdMs6F0CktjFPYvv26wJULWvOFObDFc=;
  b=RL7ndm6V0Yq88zMVQfVlJeRmPx6sxHSvANYABbOqp5YYvzBVntbcjbth
   4BtDqSzjqO+gYwbBtCKyzGor2My3IgFGcPJW7BsTJatVj/KpxL637/GTC
   yuS9pHm6KicFxA5dHMfJgSAcqVCCWy8GU023zAoQSHKKcS796hfJEe1gF
   ldjgcRY/wD4aARedGGJTDlr+Jz1rPOFR622jciHHo568tl08Zf3RM052a
   zh/F9yIOHN6KbCev961aCk/Ws4cdqJOk0mUlw5zS1HcL7rQg+JM3KWHCJ
   1gdfKUfPBuLjmdkY2ak8sWRzZz05jBLnnjpG07seDMxuhJBHeHI5rKRug
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13671717"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13671717"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="3953433"
Received: from unknown (HELO vcostago-mobl3.lan) ([10.125.18.63])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:05:23 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: sasha.neftin@intel.com,
	richardcochran@gmail.com,
	kurt@linutronix.de,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [iwl-net v1 2/2] igb: Fix missing time sync events
Date: Fri, 16 Feb 2024 17:04:54 -0800
Message-ID: <20240217010455.58258-3-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217010455.58258-1-vinicius.gomes@intel.com>
References: <20240217010455.58258-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "double" clearing of interrupts, which can cause external events
or timestamps to be missed.

The E1000_TSIRC Time Sync Interrupt Cause register can be cleared in two
ways, by either reading it or by writing '1' into the specific cause
bit. This is documented in section 8.16.1.

The following flow was used:
    1. read E1000_TSIRC into 'tsicr';
    2. handle the interrupts present into 'tsirc' and mark them in 'ack';
    3. write 'ack' into E1000_TSICR;

As both (1) and (3) will clear the interrupt cause, if an interrupt
happens between (1) and (3) it will be ignored, causing events to be
missed.

Remove the extra clear in (3).

Fixes: 00c65578b47b ("igb: enable internal PPS for the i210")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cebb44f51d5f..7662c42e35c1 100644
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
2.43.2


