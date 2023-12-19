Return-Path: <linux-kernel+bounces-4874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E7818333
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D5D1F24EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68DC14A87;
	Tue, 19 Dec 2023 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecYOVDfq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D614267;
	Tue, 19 Dec 2023 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702973855; x=1734509855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gA33C88lLypI/mnTgB5T0KSA6Hi+/UFBm/D8v5cDsfs=;
  b=ecYOVDfqfOrCpJTwzva/tGq0FpWb4/NYUsA3fxM0Jk2sbWeu5D1AeaZO
   UJp3vnW+O7HRF7x2AgYkzIpV0N70fOpRbbRHh0KQ4qZeXQ2MmBDRaweO+
   +BE/InksEctLEkDcYjKL7xnrNvpjm0ER08Ew0eAd1KLt4HpA2CiPOctDv
   z1fN1TrCowOzSx58IhITkBTBuR9TbKMLgL9a9FrcHCOeSfd45+4Vt5n50
   leEKigNbhw5b8fdR5ahX7GeSFOlgjm2/hMZgf+5ptIeHpRG/TIzMWU5bw
   0RuODxCnZCE3BQh4iMhm3WKitPYr386Qx6z82JRjO6bKC2k/j7nTGqh9c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375114471"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375114471"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779399580"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="779399580"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:34 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id EFAC4580E34;
	Tue, 19 Dec 2023 00:17:31 -0800 (PST)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net 4/4] net/sched: taprio: get corrected value of cycle_time and interval
Date: Tue, 19 Dec 2023 03:14:53 -0500
Message-Id: <20231219081453.718489-5-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a new field, correction_active to determine the entry's correction
state. This field is required due to specific flow like
find_entry_to_transmit() -> get_interval_end_time() which retrieves
the interval for each entry. During positive cycle time correction,
it's known that the last entry interval requires correction.
However, for negative correction, the affected entry is unknown, which
is why this new field is necessary.

Note that in some cases where the original values are required,
such as in dump_schedule() and setup_first_end_time(), direct calls
to cycle_time and interval are retained without using the new functions.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a3c71be21af2..d11ddb1f554c 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -61,6 +61,7 @@ struct sched_entry {
 	u32 gate_mask;
 	u32 interval;
 	u8 command;
+	bool correction_active;
 };
 
 struct sched_gate_list {
@@ -220,6 +221,14 @@ static bool sched_switch_pending(const struct sched_gate_list *oper)
 	return oper->cycle_time_correction != CYCLE_TIME_CORRECTION_UNSPEC;
 }
 
+static s64 get_cycle_time(const struct sched_gate_list *oper)
+{
+	if (sched_switch_pending(oper))
+		return oper->cycle_time + oper->cycle_time_correction;
+	else
+		return oper->cycle_time;
+}
+
 /* Get how much time has been already elapsed in the current cycle. */
 static s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
 {
@@ -227,11 +236,20 @@ static s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
 	s32 time_elapsed;
 
 	time_since_sched_start = ktime_sub(time, sched->base_time);
-	div_s64_rem(time_since_sched_start, sched->cycle_time, &time_elapsed);
+	div_s64_rem(time_since_sched_start, get_cycle_time(sched), &time_elapsed);
 
 	return time_elapsed;
 }
 
+static u32 get_interval(const struct sched_entry *entry,
+			const struct sched_gate_list *oper)
+{
+	if (entry->correction_active)
+		return entry->interval + oper->cycle_time_correction;
+	else
+		return entry->interval;
+}
+
 static ktime_t get_interval_end_time(struct sched_gate_list *sched,
 				     struct sched_gate_list *admin,
 				     struct sched_entry *entry,
@@ -240,8 +258,9 @@ static ktime_t get_interval_end_time(struct sched_gate_list *sched,
 	s32 cycle_elapsed = get_cycle_time_elapsed(sched, intv_start);
 	ktime_t intv_end, cycle_ext_end, cycle_end;
 
-	cycle_end = ktime_add_ns(intv_start, sched->cycle_time - cycle_elapsed);
-	intv_end = ktime_add_ns(intv_start, entry->interval);
+	cycle_end = ktime_add_ns(intv_start,
+				 get_cycle_time(sched) - cycle_elapsed);
+	intv_end = ktime_add_ns(intv_start, get_interval(entry, sched));
 	cycle_ext_end = ktime_add(cycle_end, sched->cycle_time_extension);
 
 	if (ktime_before(intv_end, cycle_end))
@@ -348,7 +367,7 @@ static struct sched_entry *find_entry_to_transmit(struct sk_buff *skb,
 	if (!sched)
 		return NULL;
 
-	cycle = sched->cycle_time;
+	cycle = get_cycle_time(sched);
 	cycle_elapsed = get_cycle_time_elapsed(sched, time);
 	curr_intv_end = ktime_sub_ns(time, cycle_elapsed);
 	cycle_end = ktime_add_ns(curr_intv_end, cycle);
@@ -362,7 +381,7 @@ static struct sched_entry *find_entry_to_transmit(struct sk_buff *skb,
 			break;
 
 		if (!(entry->gate_mask & BIT(tc)) ||
-		    packet_transmit_time > entry->interval)
+		    packet_transmit_time > get_interval(entry, sched))
 			continue;
 
 		txtime = entry->next_txtime;
@@ -540,7 +559,8 @@ static long get_packet_txtime(struct sk_buff *skb, struct Qdisc *sch)
 		 * interval starts.
 		 */
 		if (ktime_after(transmit_end_time, interval_end))
-			entry->next_txtime = ktime_add(interval_start, sched->cycle_time);
+			entry->next_txtime =
+				ktime_add(interval_start, get_cycle_time(sched));
 	} while (sched_changed || ktime_after(transmit_end_time, interval_end));
 
 	entry->next_txtime = transmit_end_time;
@@ -1033,6 +1053,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 
 			oper->cycle_end_time = new_base_time;
 			end_time = new_base_time;
+			next->correction_active = true;
 
 			update_open_gate_duration(next, oper, num_tc,
 						  new_gate_duration);
@@ -1133,6 +1154,7 @@ static int fill_sched_entry(struct taprio_sched *q, struct nlattr **tb,
 	}
 
 	entry->interval = interval;
+	entry->correction_active = false;
 
 	return 0;
 }
-- 
2.25.1


