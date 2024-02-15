Return-Path: <linux-kernel+bounces-66645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44889855F69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F314D289D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815D12E1CA;
	Thu, 15 Feb 2024 10:32:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE612DD8B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993172; cv=none; b=UVytpcxV/zGAWnWqKakhUUTr1eieJEBpS/jQThIYb63ib8cyf5zBYASWCDnt4MrjbWGzDdtVWXFUmPMT7NMZdm2B1Yb7gkOIv5hjMTZlQQzCeJzQu1sNWMlWSVgc6tApaTAkkl+vmLurkUMEj41oqUlZ/y1M2hgNMVuX9hJ8gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993172; c=relaxed/simple;
	bh=7L0V2A6x2ZTDwqOnJsQvbevz7Qvgf2Zqp4ANa3PXVOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzBp/uaKWx7M+2u/EJiJYLaN8Bmh5VGQp45aJrgxaYMkpnzRpgwSD9DMdddRWXnsIn5Wtyda+3zxSGYSJ2uJdyHxfuwMu2c6W4AqVucdvonL4YfWZA0dcUvNidSDOTBp3+NYAjfjNphfC6u2WIYOZNdXEhzYLvCORtMkES3o7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86F1E1570;
	Thu, 15 Feb 2024 02:33:31 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D7603F7B4;
	Thu, 15 Feb 2024 02:32:47 -0800 (PST)
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
Subject: [PATCH v6 09/18] arm64/mm: Convert ptep_clear() to ptep_get_and_clear()
Date: Thu, 15 Feb 2024 10:31:56 +0000
Message-Id: <20240215103205.2607016-10-ryan.roberts@arm.com>
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

ptep_clear() is a generic wrapper around the arch-implemented
ptep_get_and_clear(). We are about to convert ptep_get_and_clear() into
a public version and private version (__ptep_get_and_clear()) to support
the transparent contpte work. We won't have a private version of
ptep_clear() so let's convert it to directly call ptep_get_and_clear().

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 27f6160890d1..48e8b429879d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -229,7 +229,7 @@ static void clear_flush(struct mm_struct *mm,
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		ptep_clear(mm, addr, ptep);
+		ptep_get_and_clear(mm, addr, ptep);
 
 	flush_tlb_range(&vma, saddr, addr);
 }
-- 
2.25.1


