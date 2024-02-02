Return-Path: <linux-kernel+bounces-49412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80A846A24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD5F1F2AA6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30018037;
	Fri,  2 Feb 2024 08:08:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D613E17C6E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861302; cv=none; b=eQBX1I+lOmIxRH6jHp8O4/ewl7uHM2v/HkFO9j9JCyn3pz1snHcdWFPZ6J4joLU77TA9lyAYcxTTN+36HdBJIOBTw+3dC7TkYVUHaQ87hQ3m2X2oyniP4e8ZSFHmtqnv/Z9fhlIm1koYIJ0qrD2qXAZ0SqtKMpejXK1NKdwybls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861302; c=relaxed/simple;
	bh=crs7YcgUTYuqfO1G2FpVn6hqQ5vqbIBn8D+pZnE5y4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXmWba+vhhMii0ZcRBxasEalutri35btSnONuW2iJCOymFQDcmeBA3yWxhMH1u9Gkkm9dK3slQwOwrGbkUVIZzpQLo6udQ8PMTsVEJxxFyv1u49CwEIk1H8XCQ3frExLPY4sx9tpJd6tZzy+Stq1C+uzto/KTzbpvdrdNdzcvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85221FEC;
	Fri,  2 Feb 2024 00:09:02 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99B143F5A1;
	Fri,  2 Feb 2024 00:08:16 -0800 (PST)
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
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
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
Subject: [PATCH v5 01/25] mm: Clarify the spec for set_ptes()
Date: Fri,  2 Feb 2024 08:07:32 +0000
Message-Id: <20240202080756.1453939-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_ptes() spec implies that it can only be used to set a present pte
because it interprets the PFN field to increment it. However,
set_pte_at() has been implemented on top of set_ptes() since set_ptes()
was introduced, and set_pte_at() allows setting a pte to a not-present
state. So clarify the spec to state that when nr==1, new state of pte
may be present or not present. When nr>1, new state of all ptes must be
present.

While we are at it, tighten the spec to set requirements around the
initial state of ptes; when nr==1 it may be either present or
not-present. But when nr>1 all ptes must initially be not-present. All
set_ptes() callsites already conform to this requirement. Stating it
explicitly is useful because it allows for a simplification to the
upcoming arm64 contpte implementation.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f0feae7f89fb..5e7eaf8f2b97 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -229,6 +229,10 @@ static inline pte_t pte_next_pfn(pte_t pte)
  * @pte: Page table entry for the first page.
  * @nr: Number of pages to map.
  *
+ * When nr==1, initial state of pte may be present or not present, and new state
+ * may be present or not present. When nr>1, initial state of all ptes must be
+ * not present, and new state must be present.
+ *
  * May be overridden by the architecture, or the architecture can define
  * set_pte() and PFN_PTE_SHIFT.
  *
-- 
2.25.1


