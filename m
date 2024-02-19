Return-Path: <linux-kernel+bounces-70748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16F859BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18B01C21339
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739ED200AD;
	Mon, 19 Feb 2024 06:04:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D8200AA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322666; cv=none; b=HD8P4n+G5YoXTx/CujnkNvnoJYCHbSb+KcpVhwDDRahpyGK5HHK26OGHsy6ckmHvZwdm2u6dx9tcTydS/ILlhGoZoIQ6xy91Zfd/sC/nlta9NyFJl2XUBGMWSZfnHuSAsPp0hnHEseq9RZeG60Oa1mfxeIhRBfAsQRTfzA0tllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322666; c=relaxed/simple;
	bh=uWSWIWkD3opthclWyKeivuFFBZgLyDaadr0FCXFpy+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Br4HMSObp2CE7G1sotOuPOWx9UQHis0QNGhpJ6YmImet3U9vfqGAQKH3R1Uk8rsSXsaQj5g8tRKj8pkNGS6paCmH6H/8FSyy7eXUBcisLPEuR9nJ8AWSY1iwlcCjWqElS+9JvPdrw3Q3jtC5yP/wrULBKhFeHMWosHHb4Y46KlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-c2-65d2ef61c11d
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
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
Subject: [PATCH v8 2/8] arm64: tlbflush: Add APIs manipulating tlb batch's arch data
Date: Mon, 19 Feb 2024 15:04:01 +0900
Message-Id: <20240219060407.25254-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219060407.25254-1-byungchul@sk.com>
References: <20240219060407.25254-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnkW7i+0upBhuf6lnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK2NP30P2gtlcFZvet7M1MO7l6GLk5JAQMJH4dPspK4y95ORdJhCbTUBd4saN
	n8wgtoiAmcTB1j/sXYxcHMwCH5kkVn/vYAFJCAuESPT/PMUGYrMIqErMfbwHLM4rYCqxdhdE
	s4SAvMTqDQeAbA4OTqBBuw8KgYSFgEpOXJ3MBFHSzC7xZ3I2hC0pcXDFDZYJjLwLGBlWMQpl
	5pXlJmbmmOhlVOZlVugl5+duYgRGw7LaP9E7GD9dCD7EKMDBqMTDmyFyKVWINbGsuDL3EKME
	B7OSCK9704VUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxS
	DYy1bcxrf3Of9latynp5JX5OwH8TP445ypzzMn6uEvv8pMn7oOe5WTtXMNhrMm1puKsSe0Ps
	++oXUmdd1d4kf+NOkD9yoOXNxS9HFuu/fNb/ZbGv7sXjQmxLLkSZzD50UJ912TUmx+Z9a0MV
	zVX1vn/5PPPPZ2eWhviTMQf3vhA1OlBwdN5p3ZAZSizFGYmGWsxFxYkAZHZPDYICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrJv4/lKqwbw+BYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZe/oeshfM5qrY9L6drYFxL0cXIyeHhICJxJKTd5lAbDYB
	dYkbN34yg9giAmYSB1v/sHcxcnEwC3xkklj9vYMFJCEsECLR//MUG4jNIqAqMffxHrA4r4Cp
	xNpdEM0SAvISqzccALI5ODiBBu0+KAQSFgIqOXF1MtMERq4FjAyrGEUy88pyEzNzTPWKszMq
	8zIr9JLzczcxAoN7We2fiTsYv1x2P8QowMGoxMObIXIpVYg1say4MvcQowQHs5IIr3vThVQh
	3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRskSc8uF23zK
	TO9Y9P8PCgibwjbDKcaIebG+E+vNFGGO52H7Snq22SdZCeTnTHLJUNkZE6nTt327UoeyVST/
	Q4vy3BnzOwPWBU96bZky69A7d6fP85y05u6t6bmTsVtOcknqevGPp31u17GWnxZ+n3lN+r3x
	xNaTrTuVHjTyy3oGfn3E4xCoxFKckWioxVxUnAgAtvSl22oCAAA=
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


