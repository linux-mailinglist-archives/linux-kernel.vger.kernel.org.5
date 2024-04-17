Return-Path: <linux-kernel+bounces-148052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF88A7D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AADB281221
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C336BFBA;
	Wed, 17 Apr 2024 07:34:12 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E371F516
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339252; cv=none; b=pNMeIAv683y3n0c9qg0Q2MUG1QbzNrH+pAgXvWCLfVct4MfaYEUTZyKLDW3K94xja3TfGGbds+qlJExbS/0lfj9gFfgnvQ414yhuLmtC70VNDajLGfkXHaKXHFLtQgm86WLBQjEaeQsgggY2aCpEI98FppPXkt417vlYo1hPHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339252; c=relaxed/simple;
	bh=DwZ21YpU6DS7qxbUmMpNArY0GTu0rE1pYDwE/6PUoUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aFqZjnNs20soBSYIpEto3FfYwfX4OnNCzcanuaIc0kG3ZrnsbLjI4nE+RQ+TxYltJTpNVU/cPOp/xOrQsApvvGnwtXrlsfbOO3vVCpwid/bUHQ1wsKn5TM2P+ERV0b96Vuunb4ufBXWMWluLRZniGfCKjlVLCdB6Wr3R/qguEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-97-661f77e263d8
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v9 2/8] arm64: tlbflush: add APIs manipulating tlb batch's arch data
Date: Wed, 17 Apr 2024 16:18:41 +0900
Message-Id: <20240417071847.29584-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6jcvk0g10zJS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	wo7NrAV7uCr2/zzE2MB4k6OLkZNDQsBEYlvHPEYY+8nlA+wgNpuAusSNGz+ZQWwRATOJg61/
	wOLMAneZJA70s4HYwgIhEn93tLGC2CwCqhJz/k4Dq+EVMJXYM/8GE8RMeYnVGw6AzeEEmrO5
	eQ1YrxBQzfcTH4FsLqCa92wSr9s6oI6QlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0
	kvNzNzECQ39Z7Z/oHYyfLgQfYhTgYFTi4TWIkksTYk0sK67MPcQowcGsJMLbIiybJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoExu3TtzsuKX3fHfJfw
	/8JdUsyZU6U/nZND/NA3fx2/XP+++8kz5hmW8kpv+Myg13H11MHkv/EM33I7HWfdybYSemF9
	8GtH+gVb901P/UT5qqU0fhxcu/7Mwxufst4nGHMn7P+z8VnlAiHlOwzz5kamx6YV3OzVbbPj
	mXbruFJrYJDgUSmNRD0lluKMREMt5qLiRAAlXqDIeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7NYNJmLos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZSzs2MxasIerYv/PQ4wNjDc5uhg5OSQETCSeXD7ADmKzCahL3LjxkxnEFhEw
	kzjY+gcszixwl0niQD8biC0sECLxd0cbK4jNIqAqMefvNLAaXgFTiT3zbzBBzJSXWL3hANgc
	TqA5m5vXgPUKAdV8P/GRbQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBgbys9s/E
	HYxfLrsfYhTgYFTi4TWIkksTYk0sK67MPcQowcGsJMLbIiybJsSbklhZlVqUH19UmpNafIhR
	moNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cCYvHTzPMOZ3TY+Oydu7l7keF925+t1HTH1
	9ol3JFVP3q348H+59j/JtNr5Nnt7Wa8lt/VMKGkKECmok/eeEZa8dfZbEZmNnz7vbqicuOZT
	CtOEeHWGX63zTs9Vcam/b5zkuUp8G6NIgEH71fV/PruJta/iFnuwre5Wc1hsI3vPw7r1MY22
	j88osRRnJBpqMRcVJwIADhOFE2ACAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to manipulate
tlb batch's arch data.  Even though arm64 does nothing for it, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a75de2665d84..b8c7fbc1c68e 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -347,6 +347,24 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
+	/* Kernel can consider tlb batch always has been done. */
+	return true;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


