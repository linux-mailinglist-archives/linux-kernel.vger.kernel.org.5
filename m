Return-Path: <linux-kernel+bounces-162070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C348B557E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F241B233B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF74B5DA;
	Mon, 29 Apr 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ZfDEYM1g"
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DE35F18;
	Mon, 29 Apr 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386966; cv=none; b=acbc/wo9NHGpUG5bVSXnRvfRt1FNo/WXPgrRp6oQRWe4qt3rbXdP088gvM26Jzzhh59A06sX0r9fha5AVGRqZB5kspnQInPpQZYcdoiCp3Z823i/eoGTw4tQs4/PZNHZsCr8OryqwBh4xgEqEBDLczBxRdB3HsbvCsY0T7594GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386966; c=relaxed/simple;
	bh=jxXWxShuCRotVk/KOZsP3/ma7cHvuzHRC6adnl/VgTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3yqUIZWQCGLYbuuoGscBTrNVYDPFmr8zAQoSWUZTP0kyJZwVGipsrQygYbA9pRnIIa7QLCG6DTga0H2v05IuYIOuiP6NO7ZM7z5X53qq+FqQ3n2ycjLd/ErPL9KAiI74CI90jOP9SvhNKhTF0ySQKlqya7BWGuFxTpzDKrynTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ZfDEYM1g; arc=none smtp.client-ip=140.205.0.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714386956; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Zpq+IlpQptIiF+1qadAYLdyILX4yq5vgiQqk5YenteU=;
	b=ZfDEYM1gq/EfWQ1/jTJn8UIMBGO1bgOCbOhZrBJC0Vjk6W2CVIppNxCigwGNKA6RcuSHnfRYM6xAMQKlQdmtvv0c7/kY5LSBJmtJhPZ62sjJVlcNVNtXz88CvftP/ibZibJcyRarkYqHPHsfuRAMRzPm3AkIQvFqtZhAsuIVADQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.XOFQRPj_1714386953;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XOFQRPj_1714386953)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 18:35:54 +0800
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
Subject: [PATCH v1 2/5] mips: Add update_mmu_tlb_range()
Date: Mon, 29 Apr 2024 18:33:43 +0800
Message-Id: <20240429103346.59115-3-libang.li@antgroup.com>
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
 arch/mips/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index e27a4c83c548..0891ad7d43b6 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -596,6 +596,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #define	__HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
+#define update_mmu_tlb_range(vma, address, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, address, ptep, nr)
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 	unsigned long address, pmd_t *pmdp)
-- 
2.19.1.6.gb485710b


