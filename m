Return-Path: <linux-kernel+bounces-129098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058F8964E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957A11F23A95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD84778B;
	Wed,  3 Apr 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAke3zN5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0D17C64
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127006; cv=none; b=EU0924Ook0sj9j96OgWDlfDV2saaFvwCXWAqXA87Gwr2baArDDZtLIdF+wn7Wj3lNVzGrXmeqCebpWhkP3YacVZm7uPycw/5KmvM1cJnZKy1AW3nBKsr/fLF1SyzBpPDOTzyDg382+SN1U6p45EVk1yb2mnXgBhrsdgBfBSx3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127006; c=relaxed/simple;
	bh=vAd3eDrBGIEIBL0EqzSfwZ7ValaoEk3VWTmlQq7RBGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3IzBKPxNARnxgLOlJ4ZhJ1o1cHTOKgzXMOiOS6E+G8RVbn2e4EOE+mYqZNtaKT8tx1n73hfbs6SNQLA/XSTMS3T3u7cz3p/jPmuy5lLvzVuIQMC8r+/d69rsMDxLnA7XKgo5JTbRtr2JMvLIOL+/zZ2fQjjsMEFHlnEAdxQlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAke3zN5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712127002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8OA5M2JySvtjyWS+tMniT9ifxm3Iouz7728YRKZW3ys=;
	b=IAke3zN5/t6joXJUPXHkNdwyFZS+ZKd2qlTKq0JmL81pW2tyw+Au15g+GR1haIFZZ+3OrX
	ukaR2rv/fH54wLtGkyk7zpR+K19mNIbCPwkVHlci383v54YZvmGvIycVpnuB2Kj5v7LkIR
	CV3nw/zP/LXMnr1QylXvwvgeL++0pJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-FpJhxRD0MiaZGxQMtnZNtQ-1; Wed, 03 Apr 2024 02:49:56 -0400
X-MC-Unique: FpJhxRD0MiaZGxQMtnZNtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 286F4920701;
	Wed,  3 Apr 2024 06:49:56 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B99152166B4F;
	Wed,  3 Apr 2024 06:49:50 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	apopple@nvidia.com,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	rananta@google.com,
	yangyicong@hisilicon.com,
	v-songbaohua@oppo.com,
	yezhenyu2@huawei.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH] arm64: tlb: Fix TLBI RANGE operand
Date: Wed,  3 Apr 2024 16:49:29 +1000
Message-ID: <20240403064929.1438475-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
bitmap is collected by VMM and the corresponding PTEs need to be
write-protected again. Unfortunately, the operand passed to the TLBI
RANGE instruction isn't correctly sorted out by commit d1d3aa98b1d4
("arm64: tlb: Use the TLBI RANGE feature in arm64"). It leads to
crash on the destination VM after live migration because some of the
dirty pages are missed.

For example, I have a VM where 8GB memory is assigned, starting from
0x40000000 (1GB). Note that the host has 4KB as the base page size.
All TLBs for VM can be covered by one TLBI RANGE operation. However,
I receives 0xffff708000040000 as the operand, which is wrong and the
correct one should be 0x00007f8000040000. From the wrong operand, we
have 3 and 1 for SCALE (bits[45:44) and NUM (bits943:39], only 1GB
instead of 8GB memory is covered.

Fix the macro __TLBI_RANGE_NUM() so that the correct NUM and TLBI
RANGE operand are provided.

Fixes: d1d3aa98b1d4 ("arm64: tlb: Use the TLBI RANGE feature in arm64")
Cc: stable@kernel.org # v5.10+
Reported-by: Yihuang Yu <yihyu@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 3b0e8248e1a4..07c4fb4b82b4 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -166,7 +166,7 @@ static inline unsigned long get_trans_granule(void)
  */
 #define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
 #define __TLBI_RANGE_NUM(pages, scale)	\
-	((((pages) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK) - 1)
+	((((pages) >> (5 * (scale) + 1)) - 1) & TLBI_RANGE_MASK)
 
 /*
  *	TLB Invalidation
-- 
2.44.0


