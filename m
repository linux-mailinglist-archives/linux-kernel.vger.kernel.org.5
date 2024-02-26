Return-Path: <linux-kernel+bounces-80447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87116866880
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08C71C213FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889D1B94D;
	Mon, 26 Feb 2024 03:06:39 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BFD14A98
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916798; cv=none; b=oIca/1t4UWGcj1esqA+48on9q56Cr8AJoik/GwqyHTIY/czuDyNhMbBCWtNpMTWncN4AhNMJ+3/3Q/uglNkHX8F6Ju2l0qcbjEOEj9XkpRY7ST0ScPg65EJjADrJ5tShfgY48AXwcYy4YqSz+ImjM3v5QPbkMp8oCJwLo6eMOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916798; c=relaxed/simple;
	bh=o7dB2cnQ4DdAIbh4UuP8+5q3qGaOJJ7booLY7nqK98M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E8iuh9JmgfZvHFcQ8KfA8h5TEwL/YzYtBmTSxJq70JWeCJOALNmtw67eBLdBsOSCB5zBidO2AeGJ3t26RXxXVKUSw4VLCBhMRYGNfmHN0FHIk0GjDI2I5kx6aB5PoU5389s1xpHwDQh1HI6WXf8zaCrKPft4RCeCYG3b3ju73y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-37-65dc002fa99c
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
Subject: [RESEND PATCH v8 4/8] x86/tlb, mm/rmap: Separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Mon, 26 Feb 2024 12:06:09 +0900
Message-Id: <20240226030613.22366-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnka4Bw51Ug69hFnPWr2Gz+LzhH5vF
	iw3tjBZf1/9itnj6qY/F4vKuOWwW99b8Z7U4v2stq8WOpfuYLC4dWMBkcbz3AJPF/Huf2Sw2
	b5rKbHF8ylRGi98/gIpPzprM4iDg8b21j8Vj56y77B4LNpV6bF6h5bF4z0smj02rOtk8Nn2a
	xO7x7tw5do8TM36zeMw7Gejxft9VNo+tv+w8GqdeY/P4vEkugC+KyyYlNSezLLVI3y6BK+Po
	nXtsBXM4K87/msrUwHiJvYuRk0NCwETiy4WXrDD2i387wOJsAuoSN278ZAaxRQTMJA62/gGL
	MwvcZZI40M/WxcjBISyQI7HvaxpImEVAVWL3z6dgJbwCphJrX55mgRgpL7F6wwFmkHJOoDHv
	/xuChIWASv72XmXsYuQCKvnMJrGqfSYjRL2kxMEVN1gmMPIuYGRYxSiUmVeWm5iZY6KXUZmX
	WaGXnJ+7iREY9Mtq/0TvYPx0IfgQowAHoxIP74IPt1OFWBPLiitzDzFKcDArifCGy9xMFeJN
	SaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cCoaNMdsOrB5+U9
	3HeTbrvb1c+c+/aLqmXDNIFjH5Wu+Nz++fVNOtPBeha2+pf9+rLaV7a+fzFj9s3EELXrDVzM
	olvN17zXLw336ExxtExueXIyNeHsqeCHBQKTDk2+23kygy1r8/J2MU/ti5uyIj5vuc1h/90l
	c23cTyN1/5OLHoW2hc5++3y/EktxRqKhFnNRcSIATFW9xnYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfVYP09Y4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZRy9c4+tYA5nxflfU5kaGC+xdzFyckgImEi8+LcDzGYTUJe4ceMnM4gtImAm
	cbD1D1icWeAuk8SBfrYuRg4OYYEciX1f00DCLAKqErt/PgUr4RUwlVj78jQLxEh5idUbDjCD
	lHMCjXn/3xAkLARU8rf3KuMERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAoN4We2f
	iTsYv1x2P8QowMGoxMO74MPtVCHWxLLiytxDjBIczEoivOEyN1OFeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGL209/65XXXWKmDGn+p/C/+LPHXn3rCp
	uvOp7YIZoYk8inLKSj33ZebM2cfpl5Hhf+inK1/xR+v5ZzjOXA/q3Gd443yZlcOa84uuLThy
	LO6y++o6FgVZgcKfLGJn7dccLRXedev7mYx3Z2bZTU+WL1zryTJlRirjrd9rBWaGRa5+lutY
	wbx7ursSS3FGoqEWc1FxIgA7DuZGXgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to avoid
redundant TLB flushes by manipulating tlb batch's arch data after
arch_tlbbatch_flush(). However, we cannot because the data is getting
cleared inside arch_tlbbatch_flush(). So separated the part clearing the
tlb batch's arch data out of arch_tlbbatch_flush().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/mm/tlb.c | 2 --
 mm/rmap.c         | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..941f41df02f3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1268,8 +1268,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index da36f23ff7b0..b484d659d0c1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -643,6 +643,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


