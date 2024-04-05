Return-Path: <linux-kernel+bounces-132396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54732899402
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144C91F28E92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887661CD35;
	Fri,  5 Apr 2024 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiJkjqAL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C84224DD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289582; cv=none; b=QxNBL14Z9hjuS21Wz1KTWBSPxw+M7N0msgl223gm0pWbNmdcM4dm9sTHGaAgDvJLgwm7KIzo+U2xnlStUK0pZCtzTIxgw1TfRnwpCGX8bqv49VPw0JWl/d3xuCuq2YNf6Z1nODS/n8SWsyXPukPdNrD3BqX4YSAW45p1VsSJPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289582; c=relaxed/simple;
	bh=eexRtYaYPi0C1DSitKbERuKeE88vQCPBmPp0sBPAu1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQgdatVYNyVs+R+7a1dKGEjFrjzRcaAzjTqSy8euxy9TIcuFocKkkmaWTNSvCIUVvUKyq7GGxKJr5PzC4VALQ14kvQktSV1ZydusaLLI3QD15zFkiqaOcHDlTH6QOzpapWUJUHSy/EGNBQGgdukiz8puBLwlZVgfSMrSsXZnt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiJkjqAL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712289580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkWvcTbJzSkExYMycNfVCal76y0x/9U7Vke5yfGSfCI=;
	b=AiJkjqAL0LMgJQewmtP1hvy4wfazzuKM2/8+U4fom3SR8fizSGMYgZ5TPalUM8SN8JuWoA
	AXWHkP1LCrnBEmjQzQZWh9DJ/fmBz5da2ZZla+KN8fkdPmQrCnrOhoDjmoA3L7c+MsZa9F
	7FAAaFrNxywf33k6+mJR8by63V6TuKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-TR7JNRopNS-Cp8U1D4Uj8w-1; Thu, 04 Apr 2024 23:59:34 -0400
X-MC-Unique: TR7JNRopNS-Cp8U1D4Uj8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BF88101A520;
	Fri,  5 Apr 2024 03:59:33 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7176B1074E;
	Fri,  5 Apr 2024 03:59:28 +0000 (UTC)
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
Subject: [PATCH v3 3/3] arm64: tlb: Allow range operation for MAX_TLBI_RANGE_PAGES
Date: Fri,  5 Apr 2024 13:58:52 +1000
Message-ID: <20240405035852.1532010-4-gshan@redhat.com>
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

MAX_TLBI_RANGE_PAGES pages is covered by SCALE#3 and NUM#31 and it's
supported now. Allow TLBI RANGE operation when the number of pages is
equal to MAX_TLBI_RANGE_PAGES in __flush_tlb_range_nosync().

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/tlbflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 243d71f7bc1f..95fbc8c05607 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -446,11 +446,11 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
 	 * When not uses TLB range ops, we can handle up to
 	 * (MAX_DVM_OPS - 1) pages;
 	 * When uses TLB range ops, we can handle up to
-	 * (MAX_TLBI_RANGE_PAGES - 1) pages.
+	 * MAX_TLBI_RANGE_PAGES pages.
 	 */
 	if ((!system_supports_tlb_range() &&
 	     (end - start) >= (MAX_DVM_OPS * stride)) ||
-	    pages >= MAX_TLBI_RANGE_PAGES) {
+	    pages > MAX_TLBI_RANGE_PAGES) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
-- 
2.44.0


