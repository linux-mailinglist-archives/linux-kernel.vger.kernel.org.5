Return-Path: <linux-kernel+bounces-102555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FFA87B3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F49B224B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46855B68F;
	Wed, 13 Mar 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeQc9kMI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047D5A0F2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366452; cv=none; b=JFCI+1Kcp7p0Xv9EO7qRDsWz29x5hRbT1qcWmqOvRL6kbNshYEdxUxLI8y7cRE8ClYq1Sf1wyhfWNfo7azCLdEYh/bj1lSXT1g2Dt3GF5PsT8Rw/AlBBGvkl7skl2pCyqHkdAR6Adl5sVsgvvJWNib8FmnjxB0em8lJSWmrOAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366452; c=relaxed/simple;
	bh=xsXv+igcIa2LD7vY6Lm1s+FcdmOPBabwjo2Ma8p3Wuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNEe+DbreOOOMSjr2eezui2VmQcp9v0g1eceWeNC6YYLorr/5NZbDGBA79d1V2TYbP5+si9uOvjA+fyIqnFX7zeR9wa+dVPbuqHs74bYkUZb/6ud3GdtS5/1R5UtxRNlJ5EUtqrSRhqc20oVoSuDMxBfPgxPXIT+q20Ozz7PuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeQc9kMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtZJyICZEGrBJHpYWSu5beimQ7UmPGzVa4S5UCB/Dcs=;
	b=YeQc9kMIJnzFU21uNz/0XHapVQ9Ht6kAArhV6nFscCO+u4Lyrd/27NENelJ4Y9/ALASmOm
	mUtqIW2Q16T8MFmN3O4retQ4Kj3oRXPdyJxA3kgi+kOWh5ncoPkYkqdeNzVy7JWXF9ZpZN
	7YdzHxsHD1HBpRIkZGAXFhBMPufFmPs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-5Z8XkCT3NHu1_BatdcGThw-1; Wed, 13 Mar 2024 17:47:28 -0400
X-MC-Unique: 5Z8XkCT3NHu1_BatdcGThw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-690b5ad0e61so1037556d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366448; x=1710971248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtZJyICZEGrBJHpYWSu5beimQ7UmPGzVa4S5UCB/Dcs=;
        b=g9tG0Ytc4kHegJjOIb38lxxDQE05TmKBpAc7QM+8HNkB2n97A7G+glg2ZyTObWDIZU
         7NOcRtw4t2HKcr49+tzuYVOpsveuiAhgjWVl2N2A3BlS5WdeZSjx059/EYnRGDgDbyjX
         tpfWsj0NpADCKHWXbj0N/XbyutJd1KozV5Wn1UcKpzRyldkG2ju9zKFKMQ3Ei+Jz8bLV
         BpLnZB45IB18IAwBYv6JYRA6oQTSgcnR83g2FH3KFpmw5UTW6i3YL7DuMRhAD/WaSCnH
         dXSLZKBZutCLK6auBo6iG8oeMJ0G8s2lJHyobOxoOKpYbJ5bn1vOeS1Xgwd8fuKsGlga
         05/A==
X-Gm-Message-State: AOJu0YzFkXOHjf2FsTc2KwbL05kHMhkyoN8CEQi6AksCsni8u6cGtKDl
	mNBowQa2cVcv+NnJ3l+kUJidl65412eHMyCV7ieKQ/SAtjwZrjJkUcx4GOnFxoq/BBu5o9Ul6n4
	5GndDwndgtUI6HmClI5WvZnFpzd+Bz6auEF++/qIq2Zplq1F1vjl0GTSCtQAWTtR3c8AJRYkqbM
	x0HujvSEOgTRx6aoVTnsE8At1K7EBxohEg2HXHr4PK3dE=
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id j8-20020a0cf508000000b00690b02c2a5fmr13464444qvm.4.1710366447662;
        Wed, 13 Mar 2024 14:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIi4iLkgKJ4BRvvEEi/kkT0r+z7XC1hachuRmolyjwCQk4v8XzYiXmWJ7FNVheaziOarzFKQ==
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id j8-20020a0cf508000000b00690b02c2a5fmr13464414qvm.4.1710366447219;
        Wed, 13 Mar 2024 14:47:27 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:26 -0700 (PDT)
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
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 04/13] mm/x86: Change pXd_huge() behavior to exclude swap entries
Date: Wed, 13 Mar 2024 17:47:10 -0400
Message-ID: <20240313214719.253873-5-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

This patch partly reverts below commits:

3a194f3f8ad0 ("mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry")
cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage")

Right now, pXd_huge() definition across kernel is unclear. We have two
groups that think differently on swap entries:

  - x86/sparc:     Allow pXd_huge() to accept swap entries
  - all the rest:  Doesn't allow pXd_huge() to accept swap entries

This is so confusing.  Since the sparc helpers seem to be added in 2016,
which is after x86's (2015), so sparc could have followed a trend.  x86
proposed such swap handling in 2015 to resolve hugetlb swap entries hit in
GUP, but now GUP guards swap entries with !pXd_present() in all layers so
we should be safe.

We should define this API properly, one way or another, rather than keep
them defined differently across archs.

Gut feeling tells me that pXd_huge() shouldn't include swap entries, and it
turns out that I am not the only one thinking so, the question was raised
when the current pmd_huge() for x86 was proposed by Ville Syrjälä:

https://lore.kernel.org/all/Y2WQ7I4LXh8iUIRd@intel.com/

  I might also be missing something obvious, but why is it even necessary
  to treat PRESENT==0+PSE==0 as a huge entry?

It is also questioned when Jason Gunthorpe reviewed the other patchset on
swap entry handlings:

https://lore.kernel.org/all/20240221125753.GQ13330@nvidia.com/

Revert its meaning back to original.  It shouldn't have any functional
change as we should be ready with guards on !pXd_present() explicitly
everywhere.

Note that I also dropped the "#if CONFIG_PGTABLE_LEVELS > 2", it was there
probably because it was breaking things when 3a194f3f8ad0 was proposed,
according to the report here:

https://lore.kernel.org/all/Y2LYXItKQyaJTv8j@intel.com/

Now we shouldn't need that.

Instead of reverting to _PAGE_PSE raw check, leverage pXd_leaf().

Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/hugetlbpage.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 5804bbae4f01..8362953a24ce 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -20,29 +20,19 @@
 #include <asm/elf.h>
 
 /*
- * pmd_huge() returns 1 if @pmd is hugetlb related entry, that is normal
- * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
- * Otherwise, returns 0.
+ * pmd_huge() returns 1 if @pmd is hugetlb related entry.
  */
 int pmd_huge(pmd_t pmd)
 {
-	return !pmd_none(pmd) &&
-		(pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
+	return pmd_leaf(pmd);
 }
 
 /*
- * pud_huge() returns 1 if @pud is hugetlb related entry, that is normal
- * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
- * Otherwise, returns 0.
+ * pud_huge() returns 1 if @pud is hugetlb related entry.
  */
 int pud_huge(pud_t pud)
 {
-#if CONFIG_PGTABLE_LEVELS > 2
-	return !pud_none(pud) &&
-		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
-#else
-	return 0;
-#endif
+	return pud_leaf(pud);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.44.0


