Return-Path: <linux-kernel+bounces-162069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8AB8B557B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8108E1F21BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F147F41;
	Mon, 29 Apr 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="WiL+qiQq"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B14778E;
	Mon, 29 Apr 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386964; cv=none; b=pOnzPUDZbJ0x2XHkTljB8MwlGBNO505JEHlD2s6XPhUnVrz7FJZYHnUJOXhwzr+1lQOujHrBQDsVlfYIOU72uA7lnoyM3bsbhGaMcTNH8VmET/CfRBwkJfwqiwvgJiCAVIQYsLF/An+v7A2uaK1juXwQBdKeum2HUPbeCOnyJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386964; c=relaxed/simple;
	bh=kik5XO6svGpEoUGKapTye8QDGY88f/SLWUpm40ED15Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmstYwuazKCo1KpWRlRrk5X8ctjXBREH5pfr/myHHpR92YAVyEN830t0aBB16LvvKoZRZ0r6j7D5rjqo+PU5mRAKWrcuhhe3L0aTXjxp8bMVBZFiHj9sso0YJOK87zZS9u5gZmFlCIwTowx6sIt1zUvqqOZF0NY+CI2YK2OiOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=WiL+qiQq; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714386954; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6Lf/KTNGeV9HQ9Bw8oLzpkcGoRQJ7Qoem8o9ZsWDa00=;
	b=WiL+qiQq5ggcx6KKouoOmmZdbRu4tyn6tVR+PSDU5+g4LD/aG7bh/F+kWEy0F1E9p8rWRXZiHBUAWW7PX579FC6dQiUgUk9xNK2yMzX3LUka9AgQPSqlKtbMXXHD0AU+0AS1Mpo/4+vlWn3JfM9lNMp2eHNxyknvhk/ymbLEbnc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.XOEanKl_1714386951;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XOEanKl_1714386951)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 18:35:52 +0800
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
Subject: [PATCH v1 1/5] LoongArch: Add update_mmu_tlb_range()
Date: Mon, 29 Apr 2024 18:33:42 +0800
Message-Id: <20240429103346.59115-2-libang.li@antgroup.com>
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
 arch/loongarch/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index af3acdf3481a..5ccc2a3a6f7a 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -469,6 +469,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
+#define update_mmu_tlb_range(vma, addr, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 			unsigned long address, pmd_t *pmdp)
-- 
2.19.1.6.gb485710b


