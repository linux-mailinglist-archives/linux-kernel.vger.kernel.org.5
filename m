Return-Path: <linux-kernel+bounces-69623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD2858C81
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5024D1F21549
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC21BF20;
	Sat, 17 Feb 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bldAiIvn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CF1D6A7;
	Sat, 17 Feb 2024 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131927; cv=none; b=DI+ERv1r0tY6goXOYSjx99shn8fbIO2Xa/Yp/JghKltun16gzLjxURfr6CUMH6GRyecU4/3dqEObC5BI70kSkUxRHMyRKE3wZ1eg0SBlL7ySW9D+tIPWvvD2Agt1WbVrZqkS7roZxso3rsIPFBqi8xa91UvdR8Ri4OmVT8ubU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131927; c=relaxed/simple;
	bh=ivnHudNctr+yr4ZcagAZOnpK2Hrl418Jm+Umryp/9E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M36VeiwPOmxwtgrq1tGefzVcaOb+UqNmN0tR3YyoFByxf6AIEpVqsn+zPDaOp7L0X45C25hC8mdEauGsBljXbGSs8l4oQvhI1NLu7C31bwMoqjhcNRxb8sBS+Y7SxOeE2Jzaq7afMJh8hXOuwwPM3m9Hw1DD9sCyBST9WOYE84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bldAiIvn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708131926; x=1739667926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivnHudNctr+yr4ZcagAZOnpK2Hrl418Jm+Umryp/9E8=;
  b=bldAiIvnJ3lZQi3R9fhmzxJAJTdkcajBaNT1j5WVohGgTLoPuYGhoBfl
   TFWTiZop696HXnoHb72T2TBqHzKeyUxcn2cBJWKaz5lbK3Ao7DubmJPTo
   1yakYiiXQtN5OSqHGQeknp/FhNs6rhlY7Uvxj2lenE1n1u/2UiYN9lPgB
   73xLLp4yb5U6ImIH7zOBA1jH9okxiAaXa3LmFKm2by/U1v0VYFR8UPQRC
   0PmbGdhy1hgCEdmML+RGySCykAl1+S9yt6rrJuMHOihE1IrVvbvKYApr2
   RLMq3IcRwzsy+EoPYu7aI1O0f+ZcCWUmPKvPI/zkkfzdvEVgQyQez5v13
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13671711"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13671711"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="3953427"
Received: from unknown (HELO vcostago-mobl3.lan) ([10.125.18.63])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:05:22 -0800
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
Subject: [iwl-net v1 1/2] igc: Fix missing time sync events
Date: Fri, 16 Feb 2024 17:04:53 -0800
Message-ID: <20240217010455.58258-2-vinicius.gomes@intel.com>
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

The IGC_TSIRC Time Sync Interrupt Cause register can be cleared in two
ways, by either reading it or by writing '1' into the specific cause
bit. This is documented in section 8.16.1.

The following flow was used:
 1. read IGC_TSIRC into 'tsicr';
 2. handle the interrupts present in 'tsirc' and mark them in 'ack';
 3. write 'ack' into IGC_TSICR;

As both (1) and (3) will clear the interrupt cause, if an interrupt
happens between (1) and (3) it will be ignored, causing events to be
missed.

Remove the extra clear in (3).

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba8d3fe186ae..39b6a8d64de3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5302,25 +5302,22 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 
 static void igc_tsync_interrupt(struct igc_adapter *adapter)
 {
-	u32 ack, tsauxc, sec, nsec, tsicr;
 	struct igc_hw *hw = &adapter->hw;
+	u32 tsauxc, sec, nsec, tsicr;
 	struct ptp_clock_event event;
 	struct timespec64 ts;
 
 	tsicr = rd32(IGC_TSICR);
-	ack = 0;
 
 	if (tsicr & IGC_TSICR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
 			ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= IGC_TSICR_SYS_WRAP;
 	}
 
 	if (tsicr & IGC_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
 		igc_ptp_tx_tstamp_event(adapter);
-		ack |= IGC_TSICR_TXTS;
 	}
 
 	if (tsicr & IGC_TSICR_TT0) {
@@ -5334,7 +5331,6 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		wr32(IGC_TSAUXC, tsauxc);
 		adapter->perout[0].start = ts;
 		spin_unlock(&adapter->tmreg_lock);
-		ack |= IGC_TSICR_TT0;
 	}
 
 	if (tsicr & IGC_TSICR_TT1) {
@@ -5348,7 +5344,6 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		wr32(IGC_TSAUXC, tsauxc);
 		adapter->perout[1].start = ts;
 		spin_unlock(&adapter->tmreg_lock);
-		ack |= IGC_TSICR_TT1;
 	}
 
 	if (tsicr & IGC_TSICR_AUTT0) {
@@ -5358,7 +5353,6 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		event.index = 0;
 		event.timestamp = sec * NSEC_PER_SEC + nsec;
 		ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= IGC_TSICR_AUTT0;
 	}
 
 	if (tsicr & IGC_TSICR_AUTT1) {
@@ -5368,11 +5362,7 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		event.index = 1;
 		event.timestamp = sec * NSEC_PER_SEC + nsec;
 		ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= IGC_TSICR_AUTT1;
 	}
-
-	/* acknowledge the interrupts */
-	wr32(IGC_TSICR, ack);
 }
 
 /**
-- 
2.43.2


