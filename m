Return-Path: <linux-kernel+bounces-114224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3F88893C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B36B21DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D12530E6;
	Sun, 24 Mar 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsDio8bD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07104137C39;
	Sun, 24 Mar 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321570; cv=none; b=tNLtTXitA3dYTuhz/cJxDPxzAyDYlU6yyhZrzd3/UUhD7jUA7ZQlF/zQndsDQIaSqeipmSia8k/Bb7N6b0IgbtWs3Qw+uTJ7HuB1YzGY2Xl4LhtWMJ7AH1K3Qu3ILEWp8zcwlsBgcsQkVh2VbxOCSe3lI5YYCXAdmGhrx52/OBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321570; c=relaxed/simple;
	bh=Pyt0ViNt/NxQb9umfa1yxApnmliIPJZW05Akdhj054A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul5BAh6KoI1Ifv6+FLsp3acwTOEdZ1gZpjfNiReOjDgmkTH1K6aYrorink/goGJPK8RqzZEBNHg2zT2IdP3q54kFalTLruy1wme501lgQUlzbMg1Bx15npPlTpPemYQebc0EdwEsz6BtnMIF2TGKPjecpBswLngcysyXEoR2CF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsDio8bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC48EC433C7;
	Sun, 24 Mar 2024 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321569;
	bh=Pyt0ViNt/NxQb9umfa1yxApnmliIPJZW05Akdhj054A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsDio8bDSmppirD5E8Q6fjXbMBtqAglwb8sTuipTPnbqVUtFkt9mMMaOeqyVT83xS
	 Yy6Q58J/GxEebYUYmUTGjhpfFmxPwwQ1Q/QhSU7vm6EZnOwK8JCag0YYns7IyVyKUQ
	 hwL2iSn1lCeVLToTIA5SlZODRt8hOgNXz+joHPG6U0HVC0hakcon1TG52npBk69J1f
	 Lg4lk+nQ41bVaOCOp3r9QpBprBOEoYk4q5C58wtk5I7x31ptkxyEEBkB/MXyAgVxk1
	 TuPnhp+TUAiIyrRde7o4n0381EFn8snditL/cHfbKHB7LPl5kSOKtdT3HpA4woDoBM
	 6GedQEORlugyw==
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
Subject: [PATCH 6.6 297/638] ice: fix stats being updated by way too large values
Date: Sun, 24 Mar 2024 18:55:34 -0400
Message-ID: <20240324230116.1348576-298-sashal@kernel.org>
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
index d23f2ebddeb45..8ebb6517f6b96 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6557,6 +6557,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *net_stats, *stats_prev;
 	struct rtnl_link_stats64 *vsi_stats;
+	struct ice_pf *pf = vsi->back;
 	u64 pkts, bytes;
 	int i;
 
@@ -6602,21 +6603,18 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
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


