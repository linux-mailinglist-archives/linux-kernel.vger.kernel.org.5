Return-Path: <linux-kernel+bounces-112387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28D887930
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8603A1F21A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19F405FB;
	Sat, 23 Mar 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gR+wZuEP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E729CE7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711207012; cv=none; b=kiNBCVDgTCAlk+CS0c8uCiaB8UM5gAridRAoqFlR9+9GD7TCdiqTYHTqbVkN81KpVT47pp2nmAP6d7palP/8h4na7HlBEM/7GLSXQoL8s+2Jd/DOMjWxB3dhkqFsrqEpDtKhVINuIlymU71guaQIqkoGsWDZfaYi1k9IDPGuTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711207012; c=relaxed/simple;
	bh=8/IejPvpjwyrmtQylLt92kAA0GQm47DMu4dF7mC0HCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjAJ/r690ERVdlDsqm2thbv7OtSt60wG+b4OqbmhwouUPWeJxIaH/uIUKofq2tmz4frGdN1LtZiUkJZT7h88nP37WwmyHMrZQ1Yy/S356/98F1GxONAaZP/qM7BUFPm7GUm+22e65/1BDN2NvmgtJ3qeaUf6PZ0zifLRaliWoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gR+wZuEP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711207009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVVxUd0Zld9xbU0wa229w8cCSBmfZ2i7ESIOSMDwyXg=;
	b=gR+wZuEP64Ivi26BjOscGph4NssvQ3MI9zG+HX1tFOb9cUUDielmdP9zJtEI70zQqRfJ92
	F0gU/LhxDTnNjIKkAci5jeHuuRwuy1FPRmXZBapMM8OwCjkWdwZVac1Qr0eSvGEOMsMC5u
	/24k0igggW4Y8deKEsqVVvNTNyjHLNc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-lKTZifP0NJKrehMyAerRWA-1; Sat, 23 Mar 2024 11:16:47 -0400
X-MC-Unique: lKTZifP0NJKrehMyAerRWA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69120b349c9so6925296d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 08:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711207006; x=1711811806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVVxUd0Zld9xbU0wa229w8cCSBmfZ2i7ESIOSMDwyXg=;
        b=LcRO9dFyL/bI5qs4GgKCvnJum6NV8r3MC/JpjKD8f6T8EqtWvbKsxU+rMnVD9mjomQ
         VapWhZxeZc9KUCFf2M3pUrRbAHHeNOJDjf4BwudF0QISO+ecS306cwFLXtJItvL3OGq1
         a+9xaBpjOPbzZWizfCAscYppQu4ayhR9t4LIhKjZNWcYNL9F12zGoZzbRQZef3qU9FOZ
         bfmYqI2jQ/p1hOsw5B/RJE3jk84mj3ENdhAYImCSe506CvNdzxGCT6VXYXry2tLDSMeh
         mlGs3IVP19nmTUrme6m2OQpNXrOfOSd3RYzgJWd6+XUGmf+U0l4QUOqPkf1deoPyVA9H
         MBzg==
X-Gm-Message-State: AOJu0YyXOGAA0b0Q0Za2NbfiIoEgFPBF0AV57Dg1T5Kv+mU0AYwY/jnS
	f50SH1vAa2zPZhZfcPyeAOIZyQGgZb4MCg2Zj6cCGpLN4+AoykaMeAM6yYuHyoOJUWWUCFMEgqo
	1xp1CeMWXu7ZWZc1tuZf9yJUR0U0g1EvbJUnNUhtdIDz8sYyMX4eQ9jMqaKldSAFdHzYyxjwKA9
	ozHcfeIi9Mm4CV/7U8hnEJv0OvRmhi+6DzN9qR6imcee0=
X-Received: by 2002:a05:6214:5d81:b0:690:c64d:c2 with SMTP id mf1-20020a0562145d8100b00690c64d00c2mr2601820qvb.2.1711207006272;
        Sat, 23 Mar 2024 08:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt47SYAwH97tZePGJd4B1bbJ1slye2vSOQirjRSTPcAdv3shZNMWsbvi27EJpRwkH6JEhrfQ==
X-Received: by 2002:a05:6214:5d81:b0:690:c64d:c2 with SMTP id mf1-20020a0562145d8100b00690c64d00c2mr2601777qvb.2.1711207005505;
        Sat, 23 Mar 2024 08:16:45 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dm2-20020ad44e22000000b0069675bc7182sm1064916qvb.36.2024.03.23.08.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 08:16:45 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/arch: Provide pud_pfn() fallback
Date: Sat, 23 Mar 2024 11:16:43 -0400
Message-ID: <20240323151643.1047281-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

The comment in the code explains the reasons.  We took a different approach
comparing to pmd_pfn() by providing a fallback function.

Another option is to provide some lower level config options (compare to
HUGETLB_PAGE or THP) to identify which layer an arch can support for such
huge mappings.  However that can be an overkill.

Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403231529.HRev1zcD-lkp@intel.com/
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Andrew,

If we care about per-commit build errors (and if it is ever feasible to
reorder), we can move this patch to be before the patch "mm/gup: handle
huge pud for follow_pud_mask()" in mm-unstable to unbreak build on that
commit.

Thanks,
---
 arch/riscv/include/asm/pgtable.h    |  1 +
 arch/s390/include/asm/pgtable.h     |  1 +
 arch/sparc/include/asm/pgtable_64.h |  1 +
 arch/x86/include/asm/pgtable.h      |  1 +
 include/linux/pgtable.h             | 10 ++++++++++
 5 files changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 20242402fc11..0ca28cc8e3fa 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -646,6 +646,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 
 #define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1a71cb19c089..6cbbe473f680 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1414,6 +1414,7 @@ static inline unsigned long pud_deref(pud_t pud)
 	return (unsigned long)__va(pud_val(pud) & origin_mask);
 }
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	return __pa(pud_deref(pud)) >> PAGE_SHIFT;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4d1bafaba942..26efc9bb644a 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -875,6 +875,7 @@ static inline bool pud_leaf(pud_t pud)
 	return pte_val(pte) & _PAGE_PMD_HUGE;
 }
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index cefc7a84f7a4..273f7557218c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -234,6 +234,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
 }
 
+#define pud_pfn pud_pfn
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	phys_addr_t pfn = pud_val(pud);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a1c044ae467..deae9e50f1a8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1817,6 +1817,16 @@ typedef unsigned int pgtbl_mod_mask;
 #define pte_leaf_size(x) PAGE_SIZE
 #endif
 
+/*
+ * We always define pmd_pfn for all archs as it's used in lots of generic
+ * code.  Now it happens too for pud_pfn (and can happen for larger
+ * mappings too in the future; we're not there yet).  Instead of defining
+ * it for all archs (like pmd_pfn), provide a fallback.
+ */
+#ifndef pud_pfn
+#define pud_pfn(x) ({ BUILD_BUG(); 0; })
+#endif
+
 /*
  * Some architectures have MMUs that are configurable or selectable at boot
  * time. These lead to variable PTRS_PER_x. For statically allocated arrays it
-- 
2.44.0


