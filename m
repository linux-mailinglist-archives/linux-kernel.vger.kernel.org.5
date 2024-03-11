Return-Path: <linux-kernel+bounces-99266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5502B8785B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0939B20DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908156B64;
	Mon, 11 Mar 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="SUzPNr44"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0654FA2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175615; cv=none; b=bxoA8lqi8AU4NaMffJL237HyFuaKpEajNVQ5pq4wmLbMfk+Cnf9KjUWxYvwX14Wt9BblSECMGooWXybPtsEuFOw3reuyNpDn/LDNZUdKKaHvXLvChjHB45Maz8VaXcsxTHCWU73JJaSV45mhswUzi/OvpE8Y8UDWN84UEMamqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175615; c=relaxed/simple;
	bh=J5REF2bzCzAX7O0LOHW14nTnyl8YGMv3zounUf7qQr4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rrr3D6t5kuX9VikkA7oYAw55Mk0Z/VFpJ+EJfKBvzyOABDyINM/cl8n9oO7LAWDWCxBZ8maxfMh6FsNj6lNNYBQo+6qRHP1vEukDn3A+zmN9U9lJW5jyD8KFbtPAiAk10R3j/szE1oScfyC04C/gjsL1HYOvx3oaG2grMKSSnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=SUzPNr44; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78850ab4075so120664885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175612; x=1710780412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUTioQgK+VFwu4bHGNUstSWJvzqUc2xbAOy5DzulCE4=;
        b=SUzPNr44BG72fCi5CjWAI1V5z26hOG3O70z6dpgZmoI0Hie9Bb5RZ/y/i+WpfZcpDc
         zqn15CuFqqma3nQj2QF2/9bV/iowcKNpwOgPKZ9n4u/UP6q2Yk9n/akcXS4zbhIT9uGe
         nFAgmY57GPDejAT3ytqEbDRKNcfbZ3ii+D9kTwSrZlva/a02KZRvG1F9yQCU3ywJv20s
         j7IRWwDmDep/P6Gw7ikDRoVbq/KuauaZw+MvlY3WQS4w+RMM2omI38z2Jnsj2SKOiqL8
         pVEggM2qsy1yrmgr/yOanBVLaasw0ZT6gjEEqvkK1GVbRO88DxHb1XQknFcU9g3YawRG
         Gq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175612; x=1710780412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUTioQgK+VFwu4bHGNUstSWJvzqUc2xbAOy5DzulCE4=;
        b=UVdzOxkA9jPXIgkTAZ571SIhTm+4JpBEu+GnB2mzCNerWr5oxy1/QHIh/ekg6/Wo4u
         lakMk0sMIY06T7ldzMkj5iF42yKH9DPBxkp/dZoaxD/ra+EByw52tnld/K5ZmUlY3S4c
         sHzWyn3BsxxcPIGuqEujQcwsm0NDH79Wmj5SvEfyCCSRn0cIbWQ+n3MDILZCqcLH7Hkc
         pmjvId48GuCGTGo3J4JF7pLtnFOb5QmAjExSvwFIpgBULCOonKZ9kPseO5WTupTrfIph
         gMoAaWXXIm558ktBYyhpbJzz84oTGRtE1iEpZ8mtZKwZ0d/WsVQuLcgu55+Fz1DFuI3n
         MZqg==
X-Gm-Message-State: AOJu0YxFB249T7CnbwaD3MXFWWTn2wzvYaqIU4itBsMkDFCAfrx2q11S
	D7oAqsltxi7kD/L2AHC3JxaC6/XHdLrsrnR8N7eDZvoen0Hbqhr8L9grIDb1QbepwBPcoA+FHjY
	irJE=
X-Google-Smtp-Source: AGHT+IF4clsrNYnhAmKVCQ5b1CkyUTVuvR4XaNSojXhA81ENz+LMIfO1rJKaTKEeTeVkpkuetWxx/w==
X-Received: by 2002:a05:620a:5d9a:b0:788:5909:8ce5 with SMTP id xx26-20020a05620a5d9a00b0078859098ce5mr1085134qkn.34.1710175612342;
        Mon, 11 Mar 2024 09:46:52 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:51 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 09/14] mm/vmalloc: Add a get_vm_area_node() and vmap_pages_range_noflush() public functions
Date: Mon, 11 Mar 2024 16:46:33 +0000
Message-ID: <20240311164638.2015063-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_vm_area_node()
Unlike the other public get_vm_area_* variants, this one accepts node
from which to allocate data structure, and also the align, which allows
to create vm area with a specific alignment.

This call is going to be used by dynamic stacks in order to ensure that
the stack VM area of a specific alignment, and that even if there is
only one page mapped, no page table allocations are going to be needed
to map the other stack pages.

vmap_pages_range_noflush()
Is already a global function, but was exported through mm/internal.h,
since we will need it from kernel/fork.c in order to map the initial
stack pages, move the forward declaration of this function to the
linux/vmalloc.h header.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/vmalloc.h | 15 +++++++++++++++
 mm/internal.h           |  9 ---------
 mm/vmalloc.c            | 24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..e18b6ab1584b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -210,6 +210,9 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
 					const void *caller);
+struct vm_struct *get_vm_area_node(unsigned long size, unsigned long align,
+				   unsigned long flags, int node, gfp_t gfp,
+				   const void *caller);
 void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
@@ -241,10 +244,22 @@ static inline void set_vm_flush_reset_perms(void *addr)
 		vm->flags |= VM_FLUSH_RESET_PERMS;
 }
 
+int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+					  pgprot_t prot, struct page **pages,
+					  unsigned int page_shift);
+
 #else
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
+
+static inline
+int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+					  pgprot_t prot, struct page **pages,
+					  unsigned int page_shift)
+{
+	return -EINVAL;
+}
 #endif
 
 /* for /proc/kcore */
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..ba1e2ce68157 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -969,19 +969,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  */
 #ifdef CONFIG_MMU
 void __init vmalloc_init(void);
-int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift);
 #else
 static inline void vmalloc_init(void)
 {
 }
-
-static inline
-int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift)
-{
-	return -EINVAL;
-}
 #endif
 
 int __must_check __vmap_pages_range_noflush(unsigned long addr,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..7dcba463ff99 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2650,6 +2650,30 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				  NUMA_NO_NODE, GFP_KERNEL, caller);
 }
 
+/**
+ * get_vm_area_node - reserve a contiguous and aligned kernel virtual area
+ * @size:	 size of the area
+ * @align:	 alignment of the start address of the area
+ * @flags:	 %VM_IOREMAP for I/O mappings
+ * @node:	 NUMA node from which to allocate the area data structure
+ * @gfp:	 Flags to pass to the allocator
+ * @caller:	 Caller to be stored in the vm area data structure
+ *
+ * Search an area of @size/align in the kernel virtual mapping area,
+ * and reserved it for out purposes.  Returns the area descriptor
+ * on success or %NULL on failure.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+struct vm_struct *get_vm_area_node(unsigned long size, unsigned long align,
+				   unsigned long flags, int node, gfp_t gfp,
+				   const void *caller)
+{
+	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
+				  VMALLOC_START, VMALLOC_END,
+				  node, gfp, caller);
+}
+
 /**
  * find_vm_area - find a continuous kernel virtual area
  * @addr:	  base address
-- 
2.44.0.278.ge034bb2e1d-goog


