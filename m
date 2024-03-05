Return-Path: <linux-kernel+bounces-91670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E38714DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA561F230B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347729437;
	Tue,  5 Mar 2024 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxaZ+Ypv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E433E8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613518; cv=none; b=nez6R2JKBB0YcQZfErOUm0FxXOB0Y1QYY85zBT80dOmlC3ptmm3Ig13QAHKYdjab2L7f9rdKcfpWzrOGHoRjDGX3/ovEYFmjJ+2Q0dujGsQVMXtf1KyUJdK4pQsz8FJGnSbKJnSGS7/OB+SE2HPlnOD1h8mAzm5jhoisHksHNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613518; c=relaxed/simple;
	bh=N7l6PogKSPgMXEy2CH0FOs7lvcKgL9n5xVZQYxFTBVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ld4qHitdlpWFQXl14b821hfXu0LeyYlSMBNZVU65hc5AfgwgUZ0cbkwQiDPleq0l5G22pu/lgskK9mAAAGHZGfWNTJGC5GSuLGW4tZKvZkc3NmRfizxDw/YcKKKtnIB0wtweu2G2OAzZahp0FvHqSlnuni+rLjv7tRfRdVW1bvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxaZ+Ypv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdT2Q0TeX0+DskPh7cQ9GWjsaXoSWZfTenFAEBHiO1c=;
	b=OxaZ+Ypvdvd3gr/9EpnLgv+lOJpS0SWQyoj1K4wQLxwUx+CSnFeV+Zl8TLvgjMCgU9VHHA
	6AYAL0OYx72kaCG8Aqnp7pUXaQjaOTvoXLrgwo7ia3ho2vWYKOfOO/IM/MGHC0+Bh4tbMB
	qIjrE4VxBGKdJC0Q0k59lVNTQuvjwnY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-cAgx3rZoNfqMGBlxB6YwXw-1; Mon, 04 Mar 2024 23:38:31 -0500
X-MC-Unique: cAgx3rZoNfqMGBlxB6YwXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63FC0185AD0B;
	Tue,  5 Mar 2024 04:38:30 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68DA5C1F086;
	Tue,  5 Mar 2024 04:38:23 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 04/10] mm/x86: Replace pgd_large() with pgd_leaf()
Date: Tue,  5 Mar 2024 12:37:44 +0800
Message-ID: <20240305043750.93762-5-peterx@redhat.com>
In-Reply-To: <20240305043750.93762-1-peterx@redhat.com>
References: <20240305043750.93762-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Peter Xu <peterx@redhat.com>

pgd_leaf() is a global API while pgd_large() is not.  Always use
the global pgd_leaf(), then drop pgd_large().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 4 ++--
 arch/x86/mm/pti.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 69ed0ea0641b..d6e993a5659f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1418,8 +1418,8 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
-#define pgd_leaf	pgd_large
-static inline int pgd_large(pgd_t pgd) { return 0; }
+#define pgd_leaf	pgd_leaf
+static inline int pgd_leaf(pgd_t pgd) { return 0; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index dc0a81f5f60e..c17aab24c1b3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -185,7 +185,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 
 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
 	}
-	BUILD_BUG_ON(pgd_large(*pgd) != 0);
+	BUILD_BUG_ON(pgd_leaf(*pgd) != 0);
 
 	return p4d_offset(pgd, address);
 }
-- 
2.44.0


