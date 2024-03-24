Return-Path: <linux-kernel+bounces-113192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F3888231
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D1B1F21D19
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB4179FC4;
	Sun, 24 Mar 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/Ict50e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CE179FA9;
	Sun, 24 Mar 2024 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319996; cv=none; b=uU+5TBuqU/Ya0n0KiqAytUq+mIpW2nlbZN7Pg84BubWqH8IM2mF9FzJdbQICcWZzwwPC32M2h38m7h6WfNWyvHcPWGlux+ZM+3UWzzjszIYFu4ZV6qz+wA5K8CT3MvkpcNgxGesG8+kOCPI/HQ9rDxwkxPwPz4qgYIRVUe18u7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319996; c=relaxed/simple;
	bh=Dt4ST1YsLTZdXovoH8qxzKx5QKkoan5vCwg9Px+ARL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lULTCoiHiD/J4b1WmAoWbnpaOrsXmpf30rxRtovKaJcEnazt3m9npmVIsUkmvC7GuOsn88fpYOk+2OgRtuT7+JDtJhnKRCx4Ke2XKLO7detEcC48jY43XqzQP167aIwJGWXLa8mxGW/RAKXSqfFcmEAlcm3XdtEy5dbHkwU3tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/Ict50e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8D9C43390;
	Sun, 24 Mar 2024 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319996;
	bh=Dt4ST1YsLTZdXovoH8qxzKx5QKkoan5vCwg9Px+ARL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/Ict50eh4tg+B1We8GrAJtFLUMTrWN1hp+6t2rNSFpLXzRvtdE1mi1w1AYF1pApB
	 7dkRp9zpzjugl8zC2wPJnIb/VB0rslczl83L4oXjOItPXfL7wfspg3RJ9mgpRYB4H9
	 ffZoGwqsX/tiQEUvhnMtGih0PtCQtrGF7zqb8CeVOdqiVCGUg6gAWZi1FPsczlVvPW
	 M6ON8Q6X46cLIRbvbJ98hNnktlHqwVixQonGhxnQgFlCoXsT43X3ialZjUANWeScsV
	 H1BUoDqzAfDCbuP5QlQRzYQppITNdo8kLdvgQiguUQjUUNTgQNtZ9hoF8VsAwJlpsw
	 pKTJEKiFTZAfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>,
	Christian Rohmann <christian.rohmann@inovex.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 301/715] ice: fix stats being updated by way too large values
Date: Sun, 24 Mar 2024 18:28:00 -0400
Message-ID: <20240324223455.1342824-302-sashal@kernel.org>
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

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

[ Upstream commit 257310e998700e60382fbd3f4fd275fdbd9b2aaf ]

Simplify stats accumulation logic to fix the case where we don't take
previous stat value into account, we should always respect it.

Main netdev stats of our PF (Tx/Rx packets/bytes) were reported orders of
magnitude too big during OpenStack reconfiguration events, possibly other
reconfiguration cases too.

The regression was reported to be between 6.1 and 6.2, so I was almost
certain that on of the two "preserve stats over reset" commits were the
culprit. While reading the code, it was found that in some cases we will
increase the stats by arbitrarily large number (thanks to ignoring "-prev"
part of condition, after zeroing it).

Note that this fixes also the case where we were around limits of u64, but
that was not the regression reported.

Full disclosure: I remember suggesting this particular piece of code to
Ben a few years ago, so blame on me.

Fixes: 2fd5e433cd26 ("ice: Accumulate HW and Netdev statistics over reset")
Reported-by: Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>
Link: https://lore.kernel.org/intel-wired-lan/VI1PR02MB439744DEDAA7B59B9A2833FE912EA@VI1PR02MB4397.eurprd02.prod.outlook.com
Reported-by: Christian Rohmann <christian.rohmann@inovex.de>
Link: https://lore.kernel.org/intel-wired-lan/f38a6ca4-af05-48b1-a3e6-17ef2054e525@inovex.de
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index df6a68ab747ee..6d256dbcb77d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6737,6 +6737,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *net_stats, *stats_prev;
 	struct rtnl_link_stats64 *vsi_stats;
+	struct ice_pf *pf = vsi->back;
 	u64 pkts, bytes;
 	int i;
 
@@ -6782,21 +6783,18 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	net_stats = &vsi->net_stats;
 	stats_prev = &vsi->net_stats_prev;
 
-	/* clear prev counters after reset */
-	if (vsi_stats->tx_packets < stats_prev->tx_packets ||
-	    vsi_stats->rx_packets < stats_prev->rx_packets) {
-		stats_prev->tx_packets = 0;
-		stats_prev->tx_bytes = 0;
-		stats_prev->rx_packets = 0;
-		stats_prev->rx_bytes = 0;
+	/* Update netdev counters, but keep in mind that values could start at
+	 * random value after PF reset. And as we increase the reported stat by
+	 * diff of Prev-Cur, we need to be sure that Prev is valid. If it's not,
+	 * let's skip this round.
+	 */
+	if (likely(pf->stat_prev_loaded)) {
+		net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
+		net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
+		net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
+		net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
 	}
 
-	/* update netdev counters */
-	net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
-	net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
-	net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
-	net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
-
 	stats_prev->tx_packets = vsi_stats->tx_packets;
 	stats_prev->tx_bytes = vsi_stats->tx_bytes;
 	stats_prev->rx_packets = vsi_stats->rx_packets;
-- 
2.43.0


