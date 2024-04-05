Return-Path: <linux-kernel+bounces-132395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82A899400
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B57F1F28E59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9A1BC5C;
	Fri,  5 Apr 2024 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAjQ2HNl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B640219ED
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289574; cv=none; b=O+6kLK4wzLS1ZUh2PIFWF6ap7/fg6WMmaRCOEbP3ZmLIz8xfQExm6BI8loAZpYBle7Ely1wcsieSvM0+ocYyugkOtTM3hJCqKOMIgVvrXXeJV0ZdZDQophGKxcvaVEPynQtqrqQwhqPM5m8FdQv/s5n8RQMZbjxqHX9ND4XElCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289574; c=relaxed/simple;
	bh=tqCO+FVI9ETB2HPwXZSB0Uz92J7lDLuKf0WRxJDi7tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QykUVsfnK0M3daP5VNU5w2eR0itfB3qSbafiqBvLsreNWQyggwZw0p2tmn4rjdYSZ+pgRnjDNdmcfR0Fb8u4ZBj9mqu+hFErSYMo/2jTNsi9I0NBGU7+lUAhM6AEBvLzMBGp8u6EQIEYHoxrzh96zPvuVj/a2GgTVG6/Pbc9Gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAjQ2HNl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712289572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYmXT8Avy+Zcc2QpgcoW8U4GC/NL+3hkzsAYkxZjE7g=;
	b=aAjQ2HNlGbn6fB9FTIHMzbA9RAuRYTVA6Prd5zCdt7mXsYWoQZXEQQXSiJPGuYrfq2Rv4A
	oPw0tHIKeg6S9+3uyQT0kw1hiRB//ZYN6id5r/SwIBGD3LZP72CQAOWLXyXlnKUaRdcMQm
	YDW99UbNHwQaP4ls//TC6/9p/2BwSEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-qL2eug5oNlKW6wDCdH6aFA-1; Thu, 04 Apr 2024 23:59:28 -0400
X-MC-Unique: qL2eug5oNlKW6wDCdH6aFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE63180C764;
	Fri,  5 Apr 2024 03:59:27 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B809510E4B;
	Fri,  5 Apr 2024 03:59:22 +0000 (UTC)
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
Subject: [PATCH v3 2/3] arm64: tlb: Improve __TLBI_VADDR_RANGE()
Date: Fri,  5 Apr 2024 13:58:51 +1000
Message-ID: <20240405035852.1532010-3-gshan@redhat.com>
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

The macro returns the operand of TLBI RANGE instruction. A mask needs
to be applied to each individual field upon producing the operand, to
avoid the adjacent fields can interfere with each other when invalid
arguments have been provided. The code looks more tidy at least with
a mask and FIELD_PREP().

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/tlbflush.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a75de2665d84..243d71f7bc1f 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -142,17 +142,24 @@ static inline unsigned long get_trans_granule(void)
  * EL1, Inner Shareable".
  *
  */
-#define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)			\
-	({									\
-		unsigned long __ta = (baddr);					\
-		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;		\
-		__ta &= GENMASK_ULL(36, 0);					\
-		__ta |= __ttl << 37;						\
-		__ta |= (unsigned long)(num) << 39;				\
-		__ta |= (unsigned long)(scale) << 44;				\
-		__ta |= get_trans_granule() << 46;				\
-		__ta |= (unsigned long)(asid) << 48;				\
-		__ta;								\
+#define TLBIR_ASID_MASK		GENMASK_ULL(63, 48)
+#define TLBIR_TG_MASK		GENMASK_ULL(47, 46)
+#define TLBIR_SCALE_MASK	GENMASK_ULL(45, 44)
+#define TLBIR_NUM_MASK		GENMASK_ULL(43, 39)
+#define TLBIR_TTL_MASK		GENMASK_ULL(38, 37)
+#define TLBIR_BADDR_MASK	GENMASK_ULL(36,  0)
+
+#define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)		\
+	({								\
+		unsigned long __ta = 0;					\
+		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;	\
+		__ta |= FIELD_PREP(TLBIR_BADDR_MASK, baddr);		\
+		__ta |= FIELD_PREP(TLBIR_TTL_MASK, __ttl);		\
+		__ta |= FIELD_PREP(TLBIR_NUM_MASK, num);		\
+		__ta |= FIELD_PREP(TLBIR_SCALE_MASK, scale);		\
+		__ta |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());	\
+		__ta |= FIELD_PREP(TLBIR_ASID_MASK, asid);		\
+		__ta;							\
 	})
 
 /* These macros are used by the TLBI RANGE feature. */
-- 
2.44.0


