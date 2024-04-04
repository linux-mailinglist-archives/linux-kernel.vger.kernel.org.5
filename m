Return-Path: <linux-kernel+bounces-130953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D5898109
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B031F27663
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC93F8D4;
	Thu,  4 Apr 2024 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flsclDoe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BE208AF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209013; cv=none; b=Kd2ixgK4+Hi42RKNKJJJCcrF3PivSpBUIfVvE2Xpy/EZ51NvZ57q8Wmwwf1ke3qEGRtVsHU3/nNsUdp7YyAi9u1rJ5X+R1h/I4vsT7Qjb0p13QDfYctCpCVL8vIUJPVdu0XZ6RotKF1klvduiu3v4jXdRxsW+ersisc/q1M7tGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209013; c=relaxed/simple;
	bh=e2UkbrpTf22IFPHoFtrIy4zTQ7fkEobzTOSvRbSRK88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TrLNRQpUlE9w8o9oEsT2tMT7A0fYkylHK57grSJBzY4eefIXfDbwGkykeqfwNpjyd0acFzKOv2Ju0iQ9o71qTvw6DkFckVi5JjO6IjjJRPfYOcSls8RIUJRdAfhLhsovg9f6x3vjM5Wnklmgu6eBwwizisChNsXJvdqk9T/eaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flsclDoe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712209010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LL2XQ7hEe6OczrUjeKipczxOMjastOcHJJRdeukLPoY=;
	b=flsclDoeqpU3ZWc4+pf/sVfFam983DNGBHsbpACSu3Tzti4CmC0tzAUSsoxBjlvIB5wlue
	s+iuIbXXMXLnu6Hh5qmtHWJFnLkg9Ue6KeYtgJHbmUBDA4Pnp4oornBwxXcwFOfrSWnUPr
	H7/dGuiejTpLVMd3Juf+Er7g9XBVeFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-Gy-8i4_mN2K0mT2btVx12g-1; Thu, 04 Apr 2024 01:36:43 -0400
X-MC-Unique: Gy-8i4_mN2K0mT2btVx12g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF10485CBA6;
	Thu,  4 Apr 2024 05:36:42 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF036C017A0;
	Thu,  4 Apr 2024 05:36:36 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	apopple@nvidia.com,
	rananta@google.com,
	yangyicong@hisilicon.com,
	v-songbaohua@oppo.com,
	yezhenyu2@huawei.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2] arm64: tlb: Fix TLBI RANGE operand
Date: Thu,  4 Apr 2024 15:36:24 +1000
Message-ID: <20240404053624.1485237-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
bitmap is collected by VMM and the corresponding PTEs need to be
write-protected during live migration. Unfortunately, the operand
passed to the TLBI RANGE instruction isn't correctly sorted out by
commit d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64").
It leads to crash on the destination VM after live migration because
TLBs aren't flushed completely and some of the dirty pages are missed.

For example, I have a VM where 8GB memory is assigned, starting from
0x40000000 (1GB). Note that the host has 4KB as the base page size.
All TLBs for VM can be covered by one TLBI RANGE operation. However,
the operand 0xffff708000040000 is set for scale -9, and  -1 is returned
from __TLBI_RANGE_NUM() for scale 3/2/1/0 and rejected by the loop in
__flush_tlb_range_op(). __TLBI_RANGE_NUM() isn't expected to work
like this because all the pages should be covered by scale 3/2/1/0,
plus an additional page if needed.

Fix the macro __TLBI_RANGE_NUM() so that the correct NUM and TLBI RANGE
operand are provided for each scale level. With the changes, [-1 31]
instead of [-1 30] can be returned from the macro, meaning the TLBs for
0x200000 pages (8GB memory) can be flushed in one shoot at scale 3. The
macro TLBI_RANGE_MASK is dropped since no one uses it any more.

Fixes: d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64")
Cc: stable@kernel.org # v5.10+
Reported-by: Yihuang Yu <yihyu@redhat.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Improve __TLBI_RANGE_NUM() as Marc suggested
---
 arch/arm64/include/asm/tlbflush.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 3b0e8248e1a4..cd9b71c30366 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -161,12 +161,17 @@ static inline unsigned long get_trans_granule(void)
 #define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
 
 /*
- * Generate 'num' values from -1 to 30 with -1 rejected by the
+ * Generate 'num' values from -1 to 31 with -1 rejected by the
  * __flush_tlb_range() loop below.
  */
-#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
-#define __TLBI_RANGE_NUM(pages, scale)	\
-	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
+#define __TLBI_RANGE_NUM(pages, scale)					\
+	({								\
+		int __pages = min((pages),				\
+				  __TLBI_RANGE_PAGES(31, (scale)));	\
+		int __numplus1 = __pages >> (5 * (scale) + 1);		\
+									\
+		(__numplus1 - 1);					\
+	})
 
 /*
  *	TLB Invalidation
-- 
2.44.0


