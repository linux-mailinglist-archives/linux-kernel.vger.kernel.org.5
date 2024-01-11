Return-Path: <linux-kernel+bounces-23086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DF782A783
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E992860BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B186FC6;
	Thu, 11 Jan 2024 06:23:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A26AA1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e3-659f85c87bb7
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	xhao@linux.alibaba.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [v5 2/7] arm64: tlbflush: Add APIs manipulating tlb batch's arch data
Date: Thu, 11 Jan 2024 15:07:52 +0900
Message-Id: <20240111060757.13563-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111060757.13563-1-byungchul@sk.com>
References: <20240111060757.13563-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnke6J1vmpBo0XuCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	bN40ldni9w+gujlTrCxOzprM4iDg8b21j8VjwaZSj80rtDwW73nJ5LFpVSebx6ZPk9g93p07
	x+5xYsZvFo+dDy095p0M9Hi/7yqbx9Zfdh6fN8l5vJv/li2AL4rLJiU1J7MstUjfLoErY0/f
	Q/aC2VwVm963szUw7uXoYuTkkBAwkVi95T4jjP3z/Hk2EJtNQF3ixo2fzCC2iICZxMHWP+xd
	jFwczAIPmCTmvl0B1iAs4CdxovMeWAOLgKrE5s5/QHEODl4BU4l9d7khZspLrN5wAGwOJ9Cc
	C4dngZUIAZU8aquDKHnPJjHjdxaELSlxcMUNlgmMvAsYGVYxCmXmleUmZuaY6GVU5mVW6CXn
	525iBIb8sto/0TsYP10IPsQowMGoxMP7YNG8VCHWxLLiytxDjBIczEoivAqf56QK8aYkVlal
	FuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYOy/Md98R+93NWHb1nTB
	5I07nv+bIDa/+7VCMI/Lg1N9SU/YrWXCmrNO7CpfsTkwVCyyhyFgWlLI9d+vFz4SdjZRlrsV
	//N5lm6a6l+DTof1xvuYlk5x/iX1/P2Z824e7du+9ZeUKbydJHYp4H9968KHzmJal6xnzY9Q
	EXv8ezrX7Igwy0l1lkosxRmJhlrMRcWJABhXxAt1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrHuidX6qQaeyxZz1a9gsPm/4x2bx
	YkM7o8XX9b+YLZ5+6mOxODz3JKvF5V1z2CzurfnPanF+11pWix1L9zFZXDqwgMni+q6HjBbH
	ew8wWWzeNJXZ4vcPoLo5U6wsTs6azOIg6PG9tY/FY8GmUo/NK7Q8Fu95yeSxaVUnm8emT5PY
	Pd6dO8fucWLGbxaPnQ8tPeadDPR4v+8qm8fiFx+YPLb+svP4vEnO4938t2wB/FFcNimpOZll
	qUX6dglcGXv6HrIXzOaq2PS+na2BcS9HFyMnh4SAicTP8+fZQGw2AXWJGzd+MoPYIgJmEgdb
	/7B3MXJxMAs8YJKY+3YFI0hCWMBP4kTnPbAGFgFVic2d/4DiHBy8AqYS++5yQ8yUl1i94QDY
	HE6gORcOzwIrEQIqedRWN4GRawEjwypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAAF5W+2fi
	DsYvl90PMQpwMCrx8Bq8nJcqxJpYVlyZe4hRgoNZSYRX4fOcVCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbG1p2sx89pmE9wTEpPNe97IPWpeA07l8Pv
	0PNuPVd6hcpuHZgy0bn+/5QNm3vWRJXKLVDb+E4i2EFNxN6OSVhhUTLH50UlpYJt676FXTw1
	h8f16YFrYftv5wipMm8zWXg3I5Z72gnxuU92sc2o+RTO36m6v9dt5gGz9Icfju++af+VL8Ta
	ea6VEktxRqKhFnNRcSIAq273dFwCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to manipulate
tlb batch's arch data. Even though arm64 does nothing with it, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bb2c2833a987..4f2094843e7a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -328,6 +328,25 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+
+	return false;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


