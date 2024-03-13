Return-Path: <linux-kernel+bounces-102562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272987B3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC26B222B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9C5F47D;
	Wed, 13 Mar 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqWOTs1c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4454BD3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366462; cv=none; b=J82kkSC2egvIrY7OKO/w+DqDpvnRulqXmqdPgRFS7PjWVtrRjjrfE9ZqbNFgG5zntAI7UYX3umcS4KEnPFFEZgKPUANvngXvqxJkGuINy4HACI++ojaTrvVMgTSzhP2nFxCJuMhokCC23reVnU5NAZt7V7FLrO8V7Xn5exB6ywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366462; c=relaxed/simple;
	bh=RZT7eZ9qXAWIGdyOh/YTc5ekI4YFmly+9JiblJdJ5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4wsxpCunB7yjJ2PXZI1kFoJwNWLmTOJyBLO1Ens4iSsFQszX+NuamiXD/JpipSaf9s6LiQ1vcY5PPBbD+SxzhKRclUW6dtGPAKxulhzl2uxU1TaJ7kLdXUtq0KzfIOOFQV1+rwQ1yydXKp8iFTqyrhEXyfQQR+Z4daD3hktZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqWOTs1c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3/QtZ/X4uy5vGDlYUaKemCeea0qTqCUbzq3qEDmZ7g=;
	b=KqWOTs1cgvMyp8D4WfJo5JT0Rzte5AxEkHwK87aq145U9UDQYdPm52pW0CvKMm41KPmbnd
	yqHuwogNH+KYNVj8bO6MOX7gVfVo++NpPmv4Ha198kfADbp/0h8o/Lgxaj9Eil4e+NtOff
	RW2coLE8V5wf9bV4etx1jxXtYSZ1ZDQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-gvcmqf-qNTuWR3HjugFFcg-1; Wed, 13 Mar 2024 17:47:36 -0400
X-MC-Unique: gvcmqf-qNTuWR3HjugFFcg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6912513fc7bso1699716d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366455; x=1710971255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3/QtZ/X4uy5vGDlYUaKemCeea0qTqCUbzq3qEDmZ7g=;
        b=a+ndR1oFKN246Q+aDX3nn8ovn3Rk+3/0o8PX1Va3Yip3pyOIjgk75FynEMkUw/poMA
         0JT5Z3Qi7YWj9gJxd/+IG5wDMXSrluA9cLNfoofOnII4ttL3CQFg5CKcmAvBNQeu2yjR
         jIEfs7DEbg2URWgn780mOKO36RqjqyHjUrIe7L9FbzRgsw/X5b+z7l4dKuH0ouBElRBX
         vwmGt3sYLz21CJz9rhl+nOwjnD7pEw+o07j8dXgYGfwkKiiL4cEB311s35vxx85Inm+J
         3twprDXbwySJ5oqSif+Grt6A3iFVPcC8FvNpdWAPmxpJpKDMi8fwH+/AZXt4trzoo89u
         qZSA==
X-Gm-Message-State: AOJu0YzlZNQxlfvDPcwImhCVuUTRlWeis4EpjHXteiQ6g2vNLUrRIzdj
	4/J2KwyLrkrLAq/tT0a1bQUNsCCrXGBi59gcaxArs3WGiXcYy/VlPqhUK5+JHLyUkOKig4gpyN7
	k5Z5veBYQhkrSUWD2x7Y0Yd6WonbzFW0au2neTLbJSeWXYD0c0Yy14Ek0ASjY3z7B0yCWyfDoKl
	pjVfO11YYDuxlPgxTLo7VLBygw/iQfX0t9ceazCMYTf0g=
X-Received: by 2002:a05:6214:2c:b0:690:c12f:9750 with SMTP id b12-20020a056214002c00b00690c12f9750mr2845137qvr.4.1710366455172;
        Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/h1WlE9AZBGc/IXZwL3Hjjpc9ZAcuTEVAooWtSlvbi8OV5VzFu9Jid1QvxHh3VTvOYBscJA==
X-Received: by 2002:a05:6214:2c:b0:690:c12f:9750 with SMTP id b12-20020a056214002c00b00690c12f9750mr2845108qvr.4.1710366454748;
        Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Date: Wed, 13 Mar 2024 17:47:15 -0400
Message-ID: <20240313214719.253873-10-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
it will keep returning false.

As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
pgtable walker __find_linux_pte() already used pXd_leaf() to check hugetlb
mappings.

The goal should be that we will have one API pXd_leaf() to detect all kinds
of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.

This helps to simplify a follow up patch to drop pXd_huge() treewide.

NOTE: *_leaf() definition need to be moved before the inclusion of
asm/book3s/64/pgtable-4k.h, which defines pXd_huge() with it.

[1] https://lore.kernel.org/r/87v85zo6w7.fsf@mail.lhotse

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../include/asm/book3s/64/pgtable-4k.h        | 14 ++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 27 +++++++++----------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 48f21820afe2..92545981bb49 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -8,22 +8,12 @@
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pmd_leaf(pmd);
 }
 
 static inline int pud_huge(pud_t pud)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pud_leaf(pud);
 }
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index df66dce8306f..fd7180fded75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;
 
 extern struct page *vmemmap;
 extern unsigned long pci_io_base;
+
+#define pmd_leaf pmd_leaf
+static inline bool pmd_leaf(pmd_t pmd)
+{
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
+}
+
+#define pud_leaf pud_leaf
+static inline bool pud_leaf(pud_t pud)
+{
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
+}
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
@@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 	return false;
 }
 
-/*
- * Like pmd_huge(), but works regardless of config options
- */
-#define pmd_leaf pmd_leaf
-static inline bool pmd_leaf(pmd_t pmd)
-{
-	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
-#define pud_leaf pud_leaf
-static inline bool pud_leaf(pud_t pud)
-{
-	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-}
-
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.44.0


