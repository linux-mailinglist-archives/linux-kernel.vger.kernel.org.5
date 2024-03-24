Return-Path: <linux-kernel+bounces-113763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08562888677
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27941F24971
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A39212D1F0;
	Sun, 24 Mar 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfiAkPN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DC146583;
	Sun, 24 Mar 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320778; cv=none; b=sDWReW5GENWjuHyKBAtuM2btd7eHwRJiER75+wyNVLQUjBVIsyszGMF0553MC4TS2bAOlzBht+0dBMuh+ax2/zSVY0GJHHYJFlkjpOAd50i+8rC3g73nvwxKXFLbEl73YGuWVwCAZRIWTTQP2VFZMxbHORgUQa4nYIxT8kQBoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320778; c=relaxed/simple;
	bh=SyyvxpOBiscFYM8hG/1wtsgj6jCx4t5ztVWGGSs0e6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVQ5rv8nTaNrRpkBV6qMPopbEG1qS3lw0HdiUbMyAsnMctp2LVerjWDSvtzwDsKNZkdMCNtFozNPu/xE8Nm3vSfNBqhhI/0nIDI4KKRTK/hQLGz5I/bXYgVgEIMtrcl0OzxDuZWjecJDbh7PzX/ExOZUWqBIjxvbzbEaDv29fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfiAkPN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFCAC43394;
	Sun, 24 Mar 2024 22:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320776;
	bh=SyyvxpOBiscFYM8hG/1wtsgj6jCx4t5ztVWGGSs0e6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfiAkPN3Me1MXd5XYxHY5yGuQVjiHB4tMWEs93n6xdpZ14fUJboS8H5U1EEOLio5b
	 rQCHLqjOcUiLsTwkK09HkNN+StjmpPSTxByO7oauSODgwsDkyj8s1XrKHdgH06A8Wu
	 darwpCFJYsRcPW/z4uGmb4g+BqDVAcLM82zk5sKamivzF8VaZ+aqMMtuQNFxgyr4V+
	 xkT/anZiWGmOUnHBo9bJSgcGVaa8IV/ud4w2k3MXE/8w1nJ0ig32zh32rmR5R2wnzA
	 VO5wnHeTd9WP9CYcZxajEgDmKEPM0IW0hhRbg40E7dZBkYCTa9rIh15rsaL8rTdhXq
	 gStPCswK79E4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Naama Meir <naamax.meir@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 340/713] igc: Fix missing time sync events
Date: Sun, 24 Mar 2024 18:41:06 -0400
Message-ID: <20240324224720.1345309-341-sashal@kernel.org>
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

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 244ae992e3e80e5c9c272c77324c831148457f95 ]

Fix "double" clearing of interrupts, which can cause external events
or timestamps to be missed.

The IGC_TSIRC Time Sync Interrupt Cause register can be cleared in two
ways, by either reading it or by writing '1' into the specific cause
bit. This is documented in section 8.16.1.

The following flow was used:
 1. read IGC_TSIRC into 'tsicr';
 2. handle the interrupts present in 'tsirc' and mark them in 'ack';
 3. write 'ack' into IGC_TSICR;

As both (1) and (3) will clear the interrupt cause, if the same
interrupt happens again between (1) and (3) it will be ignored,
causing events to be missed.

Remove the extra clear in (3).

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # Intel i225
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 58ffddc6419ad..45716d271d955 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5304,25 +5304,22 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -5336,7 +5333,6 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		wr32(IGC_TSAUXC, tsauxc);
 		adapter->perout[0].start = ts;
 		spin_unlock(&adapter->tmreg_lock);
-		ack |= IGC_TSICR_TT0;
 	}
 
 	if (tsicr & IGC_TSICR_TT1) {
@@ -5350,7 +5346,6 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		wr32(IGC_TSAUXC, tsauxc);
 		adapter->perout[1].start = ts;
 		spin_unlock(&adapter->tmreg_lock);
-		ack |= IGC_TSICR_TT1;
 	}
 
 	if (tsicr & IGC_TSICR_AUTT0) {
@@ -5360,7 +5355,6 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
 		event.index = 0;
 		event.timestamp = sec * NSEC_PER_SEC + nsec;
 		ptp_clock_event(adapter->ptp_clock, &event);
-		ack |= IGC_TSICR_AUTT0;
 	}
 
 	if (tsicr & IGC_TSICR_AUTT1) {
@@ -5370,11 +5364,7 @@ static void igc_tsync_interrupt(struct igc_adapter *adapter)
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
2.43.0


