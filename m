Return-Path: <linux-kernel+bounces-102561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B027187B3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1D1C2343C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE55EE86;
	Wed, 13 Mar 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBeQCrtn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310C5E068
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366459; cv=none; b=Q2FhnJdBCi2y6LL4O2NIvkbW+72sDRD1zJk5z9Cxbf4Hj5kXBhW8QIoeMPIR4yd//TeyCEYiwAWopuX/SndOKHIYMe0MrATMZ+kA9XSDda3tBjdiKYqbtCkdQj/irGo1kIa/R13iHqzuD11MylhK2JklIFcn3LG0N6KR9cXDvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366459; c=relaxed/simple;
	bh=t18R28ny76a7TFkmozYcxNFR6pN9FqPc0sZ3mbG+iGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKwH/wMohEczlrYwCuYHQObpr5kA18j6/FlwYyaDgKf8mstXf9QXGXsIEpDcJ6D3TiAS/AV8nT9jycR1tGN88/SlR5GZW8Jmz5Zqsm4/mQGlpZGShdlX0PgurMEF9/NHWbsTHo8+sAQCxDoZEX8//2etXSL1HHrQDOXgLvCB3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBeQCrtn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZurg04juSYF/uW9HtnhgkfMM1C/gArxmrpoVNEgvCQ=;
	b=SBeQCrtnqHalaF4ij/nFhZNiI+eARsbmV8yx4QsCtNna3JCa4lJ+8rGd3lRzXcXeM8wohm
	qJN9LS5pXgMNewiDDcDNW9aMhXgU8/VQEAs6HswGtID701FRuXbzkf5+PDDA/Ofw0x5+Qs
	AduHSVOOgpAUgK3iubymWDp1e+/DXG4=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-mkmmq4biNHyuLKqLTTzsZg-1; Wed, 13 Mar 2024 17:47:34 -0400
X-MC-Unique: mkmmq4biNHyuLKqLTTzsZg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-474c751e9baso10175137.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366454; x=1710971254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZurg04juSYF/uW9HtnhgkfMM1C/gArxmrpoVNEgvCQ=;
        b=jfXkqebEYSfhzwf59BYGzxdqFFU97K04XD0WogGGBLT9yTDbxQrCA1sT1CLZRBuvMt
         Wr1ucm435Rr8duNbDBbOsJ4vhN4WFsp69UiDYYGXnrEH8Cv5dTqPCmVgdS2e3pl6bc3V
         7yl5XgI5W8ncHPRxx0gHtxEj4cNiYzP+Cl177S+nzrqJcbwv0lpCeNHvtwso0Y8IXmZT
         NDBW/yY/IGoJYNcCgZWja8OPJCRSi5I48HF7XK4tLB2nBx3HhHu+Tk/z5x5tdo5LVlyu
         /LOblzmuMYV0IU2OdJ/m4nt8oq+1oZaevmZ5vw3/4ZvWK2RaBj5KZcucf5/MUlImcR2n
         Ei7Q==
X-Gm-Message-State: AOJu0YwgGgFYYqYZJa7xPcU0eN16sW6ePMpH0C433ZcOmozIROf89yjt
	cCrSYo0H8olesYHgmLpdswnMuBEfwzC369gasn8okT8rU0bjvUYGm1Oyu7AOAl9QF3QPBGoSD1K
	KE+YEhXhgyd7vMIBF9L204vLvyFYthm5DZV/1pgafPv48B/X9DJToQhGD+9IaWdbVsremFPCswr
	jfPiFn4/lnpU5joWfaCwS6NzPk+LWZExWdSKCd1P8nFbQ=
X-Received: by 2002:a05:6102:5492:b0:474:d28c:2ac5 with SMTP id bk18-20020a056102549200b00474d28c2ac5mr243720vsb.0.1710366453744;
        Wed, 13 Mar 2024 14:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkTENrzWBEROMNgSFXQjsM78hPZrMM1UORfrrvjF9qoLUGsHb0Hjw+2mHy3NCjFs/y6Z4aCg==
X-Received: by 2002:a05:6102:5492:b0:474:d28c:2ac5 with SMTP id bk18-20020a056102549200b00474d28c2ac5mr243694vsb.0.1710366453272;
        Wed, 13 Mar 2024 14:47:33 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:32 -0700 (PDT)
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
	Mark Salter <msalter@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 08/13] mm/arm64: Merge pXd_huge() and pXd_leaf() definitions
Date: Wed, 13 Mar 2024 17:47:14 -0400
Message-ID: <20240313214719.253873-9-peterx@redhat.com>
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

Unlike most archs, aarch64 defines pXd_huge() and pXd_leaf() slightly
differently.  Redefine the pXd_huge() with pXd_leaf().

There used to be two traps for old aarch64 definitions over these APIs that
I found when reading the code around, they're:

 (1) 4797ec2dc83a ("arm64: fix pud_huge() for 2-level pagetables")
 (2) 23bc8f69f0ec ("arm64: mm: fix p?d_leaf()")

Define pXd_huge() with the current pXd_leaf() will make sure (2) isn't a
problem (on PROT_NONE checks). To make sure it also works for (1), we move
over the __PAGETABLE_PMD_FOLDED check to pud_leaf(), allowing it to
constantly returning "false" for 2-level pgtables, which looks even safer
to cover both now.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++++
 arch/arm64/mm/hugetlbpage.c      | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 401087e8a43d..14d24c357c7a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -704,7 +704,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!pud_table(pud))
 #define pud_present(pud)	pte_present(pud_pte(pud))
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
+#else
+#define pud_leaf(pud)		false
+#endif
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 #define pud_user(pud)		pte_user(pud_pte(pud))
 #define pud_user_exec(pud)	pte_user_exec(pud_pte(pud))
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0f0e10bb0a95..1234bbaef5bf 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -81,16 +81,12 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_leaf(pmd);
 }
 
 int pud_huge(pud_t pud)
 {
-#ifndef __PAGETABLE_PMD_FOLDED
-	return pud_val(pud) && !(pud_val(pud) & PUD_TABLE_BIT);
-#else
-	return 0;
-#endif
+	return pud_leaf(pud);
 }
 
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-- 
2.44.0


