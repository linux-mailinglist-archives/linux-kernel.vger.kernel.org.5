Return-Path: <linux-kernel+bounces-57515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789C84DA0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76E7B2406C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBDB692E6;
	Thu,  8 Feb 2024 06:26:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09467C73
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373587; cv=none; b=rYdVGgM4t25FZPzLbfvQBoUlIcVnaetqF2CP+YspyFU5OdmRV07QU6yKbKEpoBxUsQ6PYKJqcQmCq8o9RbKu3aDmbZQrpukRjPQBXfaKmcSm64dvKvTzkQhQLPOMcMwn8rrpdEO8M2o+2Tuqu8/Qur/4sHzCpeC/29FBLvLd2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373587; c=relaxed/simple;
	bh=uWSWIWkD3opthclWyKeivuFFBZgLyDaadr0FCXFpy+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a9I0NTGlEph5Rjlny1HOLl1kY+e8QVvZSfIDvsaN1odJM1WyBLoVLm+G+DWTZWeDUnILz461oH5fUCt1OZvghmb5+FE1zT/trHBDdSa5Jaog/VdZrVOUBe7ASMkT+I8LG3xjuFo7hBt9EW4ERcEVfFasp4MfOlU7H3dPHClJFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-78-65c4740bfdae
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
Subject: [RESEND PATCH v7 2/8] arm64: tlbflush: Add APIs manipulating tlb batch's arch data
Date: Thu,  8 Feb 2024 15:26:02 +0900
Message-Id: <20240208062608.44351-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208062608.44351-1-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXC9ZZnkS53yZFUgyktnBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AdRxctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yHu/mv2UL4I/isklJ
	zcksSy3St0vgytjT95C9YDZXxab37WwNjHs5uhg5OSQETCTOTJ/ECGOv7ehjB7HZBNQlbtz4
	yQxiiwiYSRxs/QMU5+JgFvjIJLH6ewcLSEJYIFri06v5YA0sAqoS3etWsIHYvAKmEjuv7GKD
	GCovsXrDAbBBnECDdm47xQpiCwHVvJg9mQ1kqIRAM7vExZYZTBANkhIHV9xgmcDIu4CRYRWj
	UGZeWW5iZo6JXkZlXmaFXnJ+7iZGYEQsq/0TvYPx04XgQ4wCHIxKPLwnyg+nCrEmlhVX5h5i
	lOBgVhLhNdtxIFWINyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMH
	p1QDY6XuocZDPQ9WCp7qPbe6OWXZyXuH9zdyq5T6fI459VHlsJPyi/XmATz7t7M++nDgpHNn
	fPCcW9Pf3DI/VqNjXlT5+keX6Pf1aad/h4jP4o/mznz9pkf4YcJfttd/CplixRtkpTZ3zDY5
	WtabJRNgqOqh1zLh8aoIM6O2L9evl71+yu83P/9ntBJLcUaioRZzUXEiAC+gwCiEAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC5WfdrMtVciTVoKHB2mLO+jVsFp83/GOz
	eLGhndHi6/pfzBZPP/WxWByee5LV4vKuOWwW99b8Z7U4v2stq8WOpfuYLC4dWMBkcX3XQ0aL
	470HmCzm3/vMZrF501Rmi+NTpjJa/P4B1HFy1mQWByGP7619LB47Z91l91iwqdRj8wotj8V7
	XjJ5bFrVyeax6dMkdo93586xe5yY8ZvFY97JQI/3+66yeSx+8YHJY+svO4/GqdfYPD5vkvN4
	N/8tW4BAFJdNSmpOZllqkb5dAlfGnr6H7AWzuSo2vW9na2Dcy9HFyMkhIWAisbajjx3EZhNQ
	l7hx4ycziC0iYCZxsPUPUJyLg1ngI5PE6u8dLCAJYYFoiU+v5oM1sAioSnSvW8EGYvMKmErs
	vLKLDWKovMTqDQfABnECDdq57RQriC0EVPNi9mS2CYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZl
	Vugl5+duYgSG97LaPxN3MH657H6IUYCDUYmH90T54VQh1sSy4srcQ4wSHMxKIrxmOw6kCvGm
	JFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTA+9LU/HLTn3JX+
	pOi5gd9Smm6+Vpi8f+b69xP2tb+0rq9Mdc76xquX+GrCe+FWFnPlz0Ib83LcuQSYdjnmsxyQ
	17bxUWM/1n84PbRs8sXXTPWpau23m4USPTZVCpcKGRsGzbxqeSFti5GukNKb5JSaR2diEifO
	/Rp+Y1fF+3uNZd/+v7nq9kqJpTgj0VCLuag4EQDAObukawIAAA==
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


