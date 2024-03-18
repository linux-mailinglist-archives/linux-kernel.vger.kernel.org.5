Return-Path: <linux-kernel+bounces-106602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F177D87F0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F671F240AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31ED5A784;
	Mon, 18 Mar 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mw6XQS2y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546359B74
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792260; cv=none; b=nO7eAyR71xVFExyrh6CD/Vqmv7f3Idd7oIwbnT3o97d15Iebs+A2UJEnTnlQzVehGoWS7127Hil9K+/RGdatqzC+Z4w38QDGOG/zOsDCDZ10m8zebFU5BRAQQNIMeQNBDenMuTmpaX1Cf+zO03sZmKHbwMmgfg/hCh9M4H+Co+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792260; c=relaxed/simple;
	bh=xsXv+igcIa2LD7vY6Lm1s+FcdmOPBabwjo2Ma8p3Wuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXDv8UHyeI2MAG+fgd2rhAsGrfe2zXQHaOlaEQJXaKGnUE1cNSPirXEELoQfRcN1ZCxUaIIYymigL0RBRzMl3qQ/+26cQ0ldK52Qeje+GLSRNfc0nEtsKLTR32uscU6p778ha4Xuher1fC4duyAXOp/cIFZAnimtvCKcHecQmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mw6XQS2y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtZJyICZEGrBJHpYWSu5beimQ7UmPGzVa4S5UCB/Dcs=;
	b=Mw6XQS2ydeiJ2OY+FGnKceeK1XbSz8gMZGBxBJYvcvYXKiqhxNSwhaANiZ2umRgLcM4fz4
	fn8X2vq7+b8jA14Wz77o2VYrunOQjzYN14RXy7gd1aj1Bsh2PGPmIir9IiIOdZfuFV/Q7L
	bVrzDVv6FJTogPtYTJ6TTm+nhmHdwIU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-F3n1eiPyMYaevvpyH3Kktw-1; Mon, 18 Mar 2024 16:04:13 -0400
X-MC-Unique: F3n1eiPyMYaevvpyH3Kktw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430b4572a97so17523051cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792253; x=1711397053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtZJyICZEGrBJHpYWSu5beimQ7UmPGzVa4S5UCB/Dcs=;
        b=ECNyTdekzZlsDQsdGQgINCY5gpih+OjpmCt7/YuCw/N8sMTUsAW0Y9eL4IGaq0GCJa
         IYyowzCpdOeFybMD8PAxlpxF7kGHktV8iMKg5cn7qTeX/o7Rf/KSypvhV9oztyHtdm1p
         QsR73jKJxaAZaV1sFpmBfykFlg/lciU+8+LcG6f1INBJHTca9RDW/umTac5/RuieCyZO
         Kw8zAxMTgV0ihk4mx8ATZahFcfORRb7JHlVJ7XsN3c1WXPHTZGMgckv1NnxAL65LaDFK
         r+0Z7mBkfr6//F9EkGsKCFZ2Qffvtapk/ChoX07Gg1vUcN7m62j5rQk2HMY32yjX++97
         I+PQ==
X-Gm-Message-State: AOJu0Yy3wAd1lh+CtK/aGruwQuC+vI5bQZdjLsPGtezlmZR8Zpr4pPht
	NDr+h8b9MRsuFAlIAzrCgf1D+dkuIcskhakT1QepvE80eecvOzGRCzoMGuRRarujBNxcj9eDcOt
	hopNXzGqyBLqVOT3O6ttdYCw3ZEdXJbJ/oxRHxWKv6JpE7V0JAP/gAVtzUYF1gbJoVuhnCY2O5j
	8VcnGfsv7/+Pg18tOomquZ3dogPZ/waCqcEaX6+ByFCiM=
X-Received: by 2002:a05:622a:134e:b0:430:c82f:b9ab with SMTP id w14-20020a05622a134e00b00430c82fb9abmr6625425qtk.0.1710792252475;
        Mon, 18 Mar 2024 13:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFopBSFWwBK3v15ombZ7ZQDo2UFCgzW4nradhEvm8gSdWhrm9dq3oWG6x2VBEnxvd6M1ShIXA==
X-Received: by 2002:a05:622a:134e:b0:430:c82f:b9ab with SMTP id w14-20020a05622a134e00b00430c82fb9abmr6625362qtk.0.1710792251793;
        Mon, 18 Mar 2024 13:04:11 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:11 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	peterx@redhat.com,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 04/14] mm/x86: Change pXd_huge() behavior to exclude swap entries
Date: Mon, 18 Mar 2024 16:03:54 -0400
Message-ID: <20240318200404.448346-5-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318200404.448346-1-peterx@redhat.com>
References: <20240318200404.448346-1-peterx@redhat.com>
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


