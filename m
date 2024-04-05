Return-Path: <linux-kernel+bounces-132394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E908A8993FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E511C25509
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BFB20313;
	Fri,  5 Apr 2024 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF1uQ6zZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE181C687
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289569; cv=none; b=FBzoJV12VwX4uPCIk85ezhZahtU6m0p0yiZ2LP1B0fTpzoNsaZLG8uSWUID/dSs7K/HWumS9dT1ICjrDz4XUwb7DzFk9J8Wi4ljq/t1JR+bEAi9/T2SvmPvlY3YpIzcGwtdCX+tZBYs68W0NqfMA/yfZXKiphqGckOJjFWG9+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289569; c=relaxed/simple;
	bh=V6zZXPXTQAmdzVwn41jpO/kf6FDGbJ5A8Xm0xuqlxs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsbfcQ4B6zEPQ55RPr4Kzh95pU9pfWsrL40iCyfUDSkVGzjakIQoJ6PuXkkD7/C7u+scsK21kCM8zLNuxhL9+7PcX/6ufPBmN9CJiJEVzHRJ741s+fHEGPysWPnFpzujv+3/vD3FTPzwKJJ8DdCFB4Y79cir9gLbM9b+m2GWYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hF1uQ6zZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712289566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfON1P+dLIFQmcdyYKrrSwwYlw+DrgIv8HXKoEFTMJA=;
	b=hF1uQ6zZplgex3PDKnJ7jRr8R5iTwxQgdIRrxu9Hl7lThXMKYA9WhVCqd2XLdSRSY0Dts+
	gfuU0sBS9e9ncY2PWdhY2+xxqwmfE+Vhw7RaZtTPIsbCaw5+Hoa8H6/bjJG1dqvM7h/wYj
	rAYw2TQJvqyGUNyeOHUVQ0Xr7KKE9ZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-qo3j-dSOMAizrvl5OBlFhg-1; Thu, 04 Apr 2024 23:59:23 -0400
X-MC-Unique: qo3j-dSOMAizrvl5OBlFhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26F988007A1;
	Fri,  5 Apr 2024 03:59:22 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A1EBC1074E;
	Fri,  5 Apr 2024 03:59:16 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	gshan@redhat.com,
	akpm@linux-foundation.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	ryan.roberts@arm.com,
	apopple@nvidia.com,
	rananta@google.com,
	mark.rutland@arm.com,
	v-songbaohua@oppo.com,
	yangyicong@hisilicon.com,
	shahuang@redhat.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v3 1/3] arm64: tlb: Fix TLBI RANGE operand
Date: Fri,  5 Apr 2024 13:58:50 +1000
Message-ID: <20240405035852.1532010-2-gshan@redhat.com>
In-Reply-To: <20240405035852.1532010-1-gshan@redhat.com>
References: <20240405035852.1532010-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
pages are collected by VMM and the page table entries become write
protected during live migration. Unfortunately, the operand passed
to the TLBI RANGE instruction isn't correctly sorted out due to the
commit 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()").
It leads to crash on the destination VM after live migration because
TLBs aren't flushed completely and some of the dirty pages are missed.

For example, I have a VM where 8GB memory is assigned, starting from
0x40000000 (1GB). Note that the host has 4KB as the base page size.
In the middile of migration, kvm_tlb_flush_vmid_range() is executed
to flush TLBs. It passes MAX_TLBI_RANGE_PAGES as the argument to
__kvm_tlb_flush_vmid_range() and __flush_s2_tlb_range_op(). SCALE#3
and NUM#31, corresponding to MAX_TLBI_RANGE_PAGES, isn't supported
by __TLBI_RANGE_NUM(). In this specific case, -1 has been returned
from __TLBI_RANGE_NUM() for SCALE#3/2/1/0 and rejected by the loop
in the __flush_tlb_range_op() until the variable @scale underflows
and becomes -9, 0xffff708000040000 is set as the operand. The operand
is wrong since it's sorted out by __TLBI_VADDR_RANGE() according to
invalid @scale and @num.

Fix it by extending __TLBI_RANGE_NUM() to support the combination of
SCALE#3 and NUM#31. With the changes, [-1 31] instead of [-1 30] can
be returned from the macro, meaning the TLBs for 0x200000 pages in the
above example can be flushed in one shoot with SCALE#3 and NUM#31. The
macro TLBI_RANGE_MASK is dropped since no one uses it any more. The
comments are also adjusted accordingly.

Fixes: 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()")
Cc: stable@kernel.org # v6.6+
Reported-by: Yihuang Yu <yihyu@redhat.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/tlbflush.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 3b0e8248e1a4..a75de2665d84 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -161,12 +161,18 @@ static inline unsigned long get_trans_granule(void)
 #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
 
 /*
- * Generate 'num' values from -1 to 30 with -1 rejected by the
- * __flush_tlb_range() loop below.
+ * Generate 'num' values from -1 to 31 with -1 rejected by the
+ * __flush_tlb_range() loop below. Its return value is only
+ * significant for a maximum of MAX_TLBI_RANGE_PAGES pages. If
+ * 'pages' is more than that, you must iterate over the overall
+ * range.
  */
-#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
-#define __TLBI_RANGE_NUM(pages, scale)	\
-	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
+#define __TLBI_RANGE_NUM(pages, scale)					\
+	({								\
+		int __pages = min((pages),				\
+				  __TLBI_RANGE_PAGES(31, (scale)));	\
+		(__pages >> (5 * (scale) + 1)) - 1;			\
+	})
 
 /*
  *	TLB Invalidation
@@ -379,10 +385,6 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
  * 3. If there is 1 page remaining, flush it through non-range operations. Range
  *    operations can only span an even number of pages. We save this for last to
  *    ensure 64KB start alignment is maintained for the LPA2 case.
- *
- * Note that certain ranges can be represented by either num = 31 and
- * scale or num = 0 and scale + 1. The loop below favours the latter
- * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
  */
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user, lpa2)	\
-- 
2.44.0


