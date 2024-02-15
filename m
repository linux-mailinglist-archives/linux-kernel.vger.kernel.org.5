Return-Path: <linux-kernel+bounces-66642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8CA855F65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBA01C2309A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D762812CDBC;
	Thu, 15 Feb 2024 10:32:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE912CDA3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993162; cv=none; b=LfiGzzo91RQE1toUsCYuKuqKSXSTLrjBE/zuq9/85RK1wQCE4nzkCjXUb13HFT9Js7hNDiuxdvF2ywnKmXJlKUFYuYaJGlzme8eJtbXWHO8sEL6QC22+v01KKLPsbmNWyi0zmYewawb0OxZkSrTPko4SVSAPylKcEgvmr245B+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993162; c=relaxed/simple;
	bh=2pMOLH70RyGBPdRH3ynfTXiJWugM9Ml+vZUSCzri78g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1mkN/fmVArKwmDAmR3uK5rBZy2N3hR3Mm2ddLD5yZgIAMyCjDeZq0uF0+UHQ/rGI32hI03dObzYZG59iIWJc81UtGhA7X5eZU/BMh37bo4K7es5QsS9Xh1gDC0clu730PPbRG3HGPXjXWd3397Tj9H3rHURgnH4IxvWS4EA7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA741516;
	Thu, 15 Feb 2024 02:33:21 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442213F7B4;
	Thu, 15 Feb 2024 02:32:37 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/18] mm: Tidy up pte_next_pfn() definition
Date: Thu, 15 Feb 2024 10:31:53 +0000
Message-Id: <20240215103205.2607016-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215103205.2607016-1-ryan.roberts@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the all architecture overrides of pte_next_pfn() have been
replaced with pte_advance_pfn(), we can simplify the definition of the
generic pte_next_pfn() macro so that it is unconditionally defined.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b7ac8358f2aa..bc005d84f764 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,7 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
-#ifndef pte_next_pfn
 #ifndef pte_advance_pfn
 static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 {
@@ -221,7 +220,6 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 #endif
 
 #define pte_next_pfn(pte) pte_advance_pfn(pte, 1)
-#endif
 
 #ifndef set_ptes
 /**
-- 
2.25.1


