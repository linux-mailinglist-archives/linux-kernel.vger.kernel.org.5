Return-Path: <linux-kernel+bounces-162074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E118B5588
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E3428381B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA41A52F9A;
	Mon, 29 Apr 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="rLohAmKf"
Received: from out187-3.us.a.mail.aliyun.com (out187-3.us.a.mail.aliyun.com [47.90.187.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D24F891;
	Mon, 29 Apr 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386973; cv=none; b=iscVzIfGEPWfGiyukyvddWXThPUSAqKWDVQt+3PlYCH7mCnYf5bpyJT6is5xbxFf3Pj4OpLNUEqv1JLekEwuzMqb8YSXBE4Tc7qaP42KfxD0KlO6mjFXp6oMJqs/Jm/UmIfCTER1YX2GlDPWgu4L3HI41c24O/baGSSUp5M7P9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386973; c=relaxed/simple;
	bh=PPzTdu8GHUSCZuJDiTQr/ewx5LKlmshWf3qQHg5D1RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XASQPAqLFZvFwW7ExWpA2UyqoZ++x4JBEITjxjqwrqzGvtLrOx8fRfICEftDaG+QrpaeG5MsqmmaaPbscU1Vjf0nOzQzE4SyUNfQjDA8kDnrW0EnZnuNh9r1fE56E518Vj0yNna/c56NTgQLITudg5FcBOA3BBCF7zsyqAeLnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=rLohAmKf; arc=none smtp.client-ip=47.90.187.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714386959; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=L9Nnq3jHrztC2V1l+aPsgS97TA5W6U5sPTcwdSCKib4=;
	b=rLohAmKf4SrixuQnHlrxT++B6o0m4L2zDIthfDKSFqfKyzTipMDIIOixCW9vJBJ4L2/Y/QHPBgjl2mdPKNGZIcgwZ1bJBeSy3P6Pk38aZPA3ZFObZxMExxIx3bwaR7sX/aZi7y4QRpNEthyaXmLYoUwKnlf9phi0ZR40Wgcs+AQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.XOEanMa_1714386956;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XOEanMa_1714386956)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 18:35:57 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc:  <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <libang.linux@gmail.com>,
   <ioworker0@gmail.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <loongarch@lists.linux.dev>,
   <linux-mips@vger.kernel.org>,
   <linux-riscv@lists.infradead.org>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v1 4/5] xtensa: Add update_mmu_tlb_range()
Date: Mon, 29 Apr 2024 18:33:45 +0800
Message-Id: <20240429103346.59115-5-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240429103346.59115-1-libang.li@antgroup.com>
References: <20240429103346.59115-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added update_mmu_tlb_range function, we can batch update tlb of an
address range.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 arch/xtensa/include/asm/pgtable.h | 2 ++
 arch/xtensa/mm/tlb.c              | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 9a7e5e57ee9a..50ccfc988256 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -412,6 +412,8 @@ typedef pte_t *pte_addr_t;
 
 void update_mmu_tlb(struct vm_area_struct *vma,
 		    unsigned long address, pte_t *ptep);
+void update_mmu_tlb_range(struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, unsigned int nr);
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 
 #endif /* !defined (__ASSEMBLY__) */
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index d8b60d6e50a8..05efba86b870 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -169,6 +169,12 @@ void update_mmu_tlb(struct vm_area_struct *vma,
 	local_flush_tlb_page(vma, address);
 }
 
+void update_mmu_tlb_range(struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, unsigned int nr)
+{
+	local_flush_tlb_range(vma, address, address + PAGE_SIZE * nr);
+}
+
 #ifdef CONFIG_DEBUG_TLB_SANITY
 
 static unsigned get_pte_for_vaddr(unsigned vaddr)
-- 
2.19.1.6.gb485710b


