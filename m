Return-Path: <linux-kernel+bounces-114979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13281888C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCCF298F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7E31BFC15;
	Mon, 25 Mar 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0X9ZgLN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84617AF90;
	Sun, 24 Mar 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323712; cv=none; b=VD0Dapy2JVGzcUoxYQm7cnyKZ/lWiQ7Nji+QLhmWEsw8k2lZ3ysEO28BtXmPhVBK7uo5TmUh03cFqbYlKhvRVXQXhqWV1Xrw6XyL8lGxvRm3YQ8dNTpv7u2poGtyJUzUIOS2sQuHqX/3wSUz6w12J/ssuPIc+nC8K18/O7nIkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323712; c=relaxed/simple;
	bh=ract1cdDgR5IG6/X6Zoa8+kpV1nTRt1KjDzuWGwiT4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsgO3G+/1889E/LBCysvsfzRXJ6cMl+k7lZJybfDl5z1FXYX7JD9FALRtjADBFbixxzvVTZ6Y8NuxAt9TKCKyLUkNRvb42X1q03uksgwFrXHWzlPGg9WuX2ZZnIVzLXWgE8MyNe3e/+cVUXuBH1KRnudUW+BvBof9DNcTOeYGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0X9ZgLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8356EC43390;
	Sun, 24 Mar 2024 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323711;
	bh=ract1cdDgR5IG6/X6Zoa8+kpV1nTRt1KjDzuWGwiT4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0X9ZgLNjTUvI3cbT8p0Fk7Y618cbORHCHEOfMyQ5+L0rLLcSbhNbvDvAdzxasIE6
	 Ibgbk/Pqoo7TX8qd1MD07ipz46tFOYeXlscWsAnJvp9O5TGmqMnfuHmczbWSKWn3CV
	 Du64FjYwmg4QumBmRQN5eF1E80ddLuIrnLCs6ihEOIOq93wGFZ5qKIE6tDriJrIB/D
	 neO5sjnTh/DhDPBBk8nHoMXAhAQBhFoEtG9gd3KKVw++2OM5Ez5BN4LaYpwRJm+XWF
	 Gy7CKhJ1qJ/nMUuVBRkpqR9Z1Na1Vhi/XOhg/XEzk25mWAYOk4zK54fLHqj10fIukJ
	 2vbfFf9ZwsfUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruud Bos <kernel.hbk@gmail.com>,
	Gurucharan G <gurucharanx.g@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 084/238] igb: move PEROUT and EXTTS isr logic to separate functions
Date: Sun, 24 Mar 2024 19:37:52 -0400
Message-ID: <20240324234027.1354210-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ruud Bos <kernel.hbk@gmail.com>

[ Upstream commit cf99c1dd7b7729091043374b90807c7a5f9fd9b1 ]

Remove code duplication in the tsync interrupt handler function by moving
this logic to separate functions. This keeps the interrupt handler readable
and allows the new functions to be extended for adapter types other than
i210.

Signed-off-by: Ruud Bos <kernel.hbk@gmail.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: ee14cc9ea19b ("igb: Fix missing time sync events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 81 +++++++++++++----------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 01176c86be125..05dde67a69dd0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6762,12 +6762,52 @@ void igb_update_stats(struct igb_adapter *adapter)
 	}
 }
 
+static void igb_perout(struct igb_adapter *adapter, int tsintr_tt)
+{
+	int pin = ptp_find_pin(adapter->ptp_clock, PTP_PF_PEROUT, tsintr_tt);
+	struct e1000_hw *hw = &adapter->hw;
+	struct timespec64 ts;
+	u32 tsauxc;
+
+	if (pin < 0 || pin >= IGB_N_PEROUT)
+		return;
+
+	spin_lock(&adapter->tmreg_lock);
+	ts = timespec64_add(adapter->perout[pin].start,
+			    adapter->perout[pin].period);
+	/* u32 conversion of tv_sec is safe until y2106 */
+	wr32((tsintr_tt == 1) ? E1000_TRGTTIML1 : E1000_TRGTTIML0, ts.tv_nsec);
+	wr32((tsintr_tt == 1) ? E1000_TRGTTIMH1 : E1000_TRGTTIMH0, (u32)ts.tv_sec);
+	tsauxc = rd32(E1000_TSAUXC);
+	tsauxc |= TSAUXC_EN_TT0;
+	wr32(E1000_TSAUXC, tsauxc);
+	adapter->perout[pin].start = ts;
+	spin_unlock(&adapter->tmreg_lock);
+}
+
+static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
+{
+	int pin = ptp_find_pin(adapter->ptp_clock, PTP_PF_EXTTS, tsintr_tt);
+	struct e1000_hw *hw = &adapter->hw;
+	struct ptp_clock_event event;
+	u32 sec, nsec;
+
+	if (pin < 0 || pin >= IGB_N_EXTTS)
+		return;
+
+	nsec = rd32((tsintr_tt == 1) ? E1000_AUXSTMPL1 : E1000_AUXSTMPL0);
+	sec  = rd32((tsintr_tt == 1) ? E1000_AUXSTMPH1 : E1000_AUXSTMPH0);
+	event.type = PTP_CLOCK_EXTTS;
+	event.index = tsintr_tt;
+	event.timestamp = sec * 1000000000ULL + nsec;
+	ptp_clock_event(adapter->ptp_clock, &event);
+}
+
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	u32 ack = 0, tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
-	struct timespec64 ts;
-	u32 ack = 0, tsauxc, sec, nsec, tsicr = rd32(E1000_TSICR);
 
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
@@ -6783,51 +6823,22 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 	}
 
 	if (tsicr & TSINTR_TT0) {
-		spin_lock(&adapter->tmreg_lock);
-		ts = timespec64_add(adapter->perout[0].start,
-				    adapter->perout[0].period);
-		/* u32 conversion of tv_sec is safe until y2106 */
-		wr32(E1000_TRGTTIML0, ts.tv_nsec);
-		wr32(E1000_TRGTTIMH0, (u32)ts.tv_sec);
-		tsauxc = rd32(E1000_TSAUXC);
-		tsauxc |= TSAUXC_EN_TT0;
-		wr32(E1000_TSAUXC, tsauxc);
-		adapter->perout[0].start = ts;
-		spin_unlock(&adapter->tmreg_lock);
+		igb_perout(adapter, 0);
 		ack |= TSINTR_TT0;
 	}
 
 	if (tsicr & TSINTR_TT1) {
-		spin_lock(&adapter->tmreg_lock);
-		ts = timespec64_add(adapter->perout[1].start,
-				    adapter->perout[1].period);
-		wr32(E1000_TRGTTIML1, ts.tv_nsec);
-		wr32(E1000_TRGTTIMH1, (u32)ts.tv_sec);
-		tsauxc = rd32(E1000_TSAUXC);
-		tsauxc |= TSAUXC_EN_TT1;
-		wr32(E1000_TSAUXC, tsauxc);
-		adapter->perout[1].start = ts;
-		spin_unlock(&adapter->tmreg_lock);
+		igb_perout(adapter, 1);
 		ack |= TSINTR_TT1;
 	}
 
 	if (tsicr & TSINTR_AUTT0) {
-		nsec = rd32(E1000_AUXSTMPL0);
-		sec  = rd32(E1000_AUXSTMPH0);
-		event.type = PTP_CLOCK_EXTTS;
-		event.index = 0;
-		event.timestamp = sec * 1000000000ULL + nsec;
-		ptp_clock_event(adapter->ptp_clock, &event);
+		igb_extts(adapter, 0);
 		ack |= TSINTR_AUTT0;
 	}
 
 	if (tsicr & TSINTR_AUTT1) {
-		nsec = rd32(E1000_AUXSTMPL1);
-		sec  = rd32(E1000_AUXSTMPH1);
-		event.type = PTP_CLOCK_EXTTS;
-		event.index = 1;
-		event.timestamp = sec * 1000000000ULL + nsec;
-		ptp_clock_event(adapter->ptp_clock, &event);
+		igb_extts(adapter, 1);
 		ack |= TSINTR_AUTT1;
 	}
 
-- 
2.43.0


