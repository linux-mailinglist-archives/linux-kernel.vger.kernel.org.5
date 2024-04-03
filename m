Return-Path: <linux-kernel+bounces-130617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB6D897A95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F6AB250C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9F415689F;
	Wed,  3 Apr 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpS2200/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4A156877
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179315; cv=none; b=fqS1alHAb5YxsVLwB13nE3ajh4kX066d2PJM39eYbkF/b7zxdfHv25y9ZtFoCJKg/xG4ukQqgPdDSk8ttL/chW+QlWqeMcf1kz566GfaZPbcNv7F29md8dVsxtVtt1sZjB4gZwAc23ABbfyIbcJ+2s98TIUd/nt+wqwnVWqDk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179315; c=relaxed/simple;
	bh=7JYeGfRmI+qnn/Wb/X6hMdLG5Gk0ibkOlIFcA9pOcvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiR6SAgep/UIaV3VsX4QISGz3u/uQnOwUtYrCge1rNSSSqjMdXJP+qpM3MZk+ZnUvKDyjCa8BEuuS7VWs68DKOYUZo20DPgi1RHTQaRfgdCeXxtc25y/mvQwniEF0yTTG+599kbzeW+/FqT42Ex4ykwZU5ALdzgB+XCGMf6v+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpS2200/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712179312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+Rp6ySTBNIv56mdti9ntn+kpoYCySu8a7gHTxAHTW8=;
	b=fpS2200/WKyvdtMi7FlrG47COcl/mN4OLH0qxqQP5mhDy6hTjH2de32mnUA8sTqJaah/Jr
	xJ6b1Ugdg8XOkV3e3tf5R6ScXIrobhF34hX1VerReHAeRbiUOTRE1ILjhzHDK0fuKwVnKF
	aOzv2Nc6hD2JmG0hiFW7qRAF6F3hC10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-VPtS9D_fO9-dBs4V1J1QMw-1; Wed, 03 Apr 2024 17:21:49 -0400
X-MC-Unique: VPtS9D_fO9-dBs4V1J1QMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B346580A153;
	Wed,  3 Apr 2024 21:21:48 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF5E91121313;
	Wed,  3 Apr 2024 21:21:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Fei Li <fei1.li@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 2/3] x86/mm/pat: fix VM_PAT handling in COW mappings
Date: Wed,  3 Apr 2024 23:21:30 +0200
Message-ID: <20240403212131.929421-3-david@redhat.com>
In-Reply-To: <20240403212131.929421-1-david@redhat.com>
References: <20240403212131.929421-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

PAT handling won't do the right thing in COW mappings: the first PTE
(or, in fact, all PTEs) can be replaced during write faults to point at
anon folios. Reliably recovering the correct PFN and cachemode using
follow_phys() from PTEs will not work in COW mappings.

Using follow_phys(), we might just get the address+protection of the
anon folio (which is very wrong), or fail on swap/nonswap entries,
failing follow_phys() and triggering a WARN_ON_ONCE() in untrack_pfn()
and track_pfn_copy(), not properly calling free_pfn_range().

In free_pfn_range(), we either wouldn't call memtype_free() or would
call it with the wrong range, possibly leaking memory.

To fix that, let's update follow_phys() to refuse returning anon folios,
and fallback to using the stored PFN inside vma->vm_pgoff for COW
mappings if we run into that.

We will now properly handle untrack_pfn() with COW mappings, where we
don't need the cachemode. We'll have to fail fork()->track_pfn_copy() if
the first page was replaced by an anon folio, though: we'd have to store
the cachemode in the VMA to make this work, likely growing the VMA size.

For now, lets keep it simple and let track_pfn_copy() just fail in that
case: it would have failed in the past with swap/nonswap entries already,
and it would have done the wrong thing with anon folios.

Simple reproducer to trigger the WARN_ON_ONCE() in untrack_pfn():

<--- C reproducer --->
 #include <stdio.h>
 #include <sys/mman.h>
 #include <unistd.h>
 #include <liburing.h>

 int main(void)
 {
         struct io_uring_params p = {};
         int ring_fd;
         size_t size;
         char *map;

         ring_fd = io_uring_setup(1, &p);
         if (ring_fd < 0) {
                 perror("io_uring_setup");
                 return 1;
         }
         size = p.sq_off.array + p.sq_entries * sizeof(unsigned);

         /* Map the submission queue ring MAP_PRIVATE */
         map = mmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
                    ring_fd, IORING_OFF_SQ_RING);
         if (map == MAP_FAILED) {
                 perror("mmap");
                 return 1;
         }

         /* We have at least one page. Let's COW it. */
         *map = 0;
         pause();
         return 0;
 }
<--- C reproducer --->

On a system with 16 GiB RAM and swap configured:
 # ./iouring &
 # memhog 16G
 # killall iouring
[  301.552930] ------------[ cut here ]------------
[  301.553285] WARNING: CPU: 7 PID: 1402 at arch/x86/mm/pat/memtype.c:1060 untrack_pfn+0xf4/0x100
[  301.553989] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_g
[  301.558232] CPU: 7 PID: 1402 Comm: iouring Not tainted 6.7.5-100.fc38.x86_64 #1
[  301.558772] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebu4
[  301.559569] RIP: 0010:untrack_pfn+0xf4/0x100
[  301.559893] Code: 75 c4 eb cf 48 8b 43 10 8b a8 e8 00 00 00 3b 6b 28 74 b8 48 8b 7b 30 e8 ea 1a f7 000
[  301.561189] RSP: 0018:ffffba2c0377fab8 EFLAGS: 00010282
[  301.561590] RAX: 00000000ffffffea RBX: ffff9208c8ce9cc0 RCX: 000000010455e047
[  301.562105] RDX: 07fffffff0eb1e0a RSI: 0000000000000000 RDI: ffff9208c391d200
[  301.562628] RBP: 0000000000000000 R08: ffffba2c0377fab8 R09: 0000000000000000
[  301.563145] R10: ffff9208d2292d50 R11: 0000000000000002 R12: 00007fea890e0000
[  301.563669] R13: 0000000000000000 R14: ffffba2c0377fc08 R15: 0000000000000000
[  301.564186] FS:  0000000000000000(0000) GS:ffff920c2fbc0000(0000) knlGS:0000000000000000
[  301.564773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  301.565197] CR2: 00007fea88ee8a20 CR3: 00000001033a8000 CR4: 0000000000750ef0
[  301.565725] PKRU: 55555554
[  301.565944] Call Trace:
[  301.566148]  <TASK>
[  301.566325]  ? untrack_pfn+0xf4/0x100
[  301.566618]  ? __warn+0x81/0x130
[  301.566876]  ? untrack_pfn+0xf4/0x100
[  301.567163]  ? report_bug+0x171/0x1a0
[  301.567466]  ? handle_bug+0x3c/0x80
[  301.567743]  ? exc_invalid_op+0x17/0x70
[  301.568038]  ? asm_exc_invalid_op+0x1a/0x20
[  301.568363]  ? untrack_pfn+0xf4/0x100
[  301.568660]  ? untrack_pfn+0x65/0x100
[  301.568947]  unmap_single_vma+0xa6/0xe0
[  301.569247]  unmap_vmas+0xb5/0x190
[  301.569532]  exit_mmap+0xec/0x340
[  301.569801]  __mmput+0x3e/0x130
[  301.570051]  do_exit+0x305/0xaf0
..

Reported-by: Wupeng Ma <mawupeng1@huawei.com>
Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 49 ++++++++++++++++++++++++++++-----------
 mm/memory.c               |  4 ++++
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0d72183b5dd0..36b603d0cdde 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -947,6 +947,38 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
+static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
+		pgprot_t *pgprot)
+{
+	unsigned long prot;
+
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_PAT));
+
+	/*
+	 * We need the starting PFN and cachemode used for track_pfn_remap()
+	 * that covered the whole VMA. For most mappings, we can obtain that
+	 * information from the page tables. For COW mappings, we might now
+	 * suddenly have anon folios mapped and follow_phys() will fail.
+	 *
+	 * Fallback to using vma->vm_pgoff, see remap_pfn_range_notrack(), to
+	 * detect the PFN. If we need the cachemode as well, we're out of luck
+	 * for now and have to fail fork().
+	 */
+	if (!follow_phys(vma, vma->vm_start, 0, &prot, paddr)) {
+		if (pgprot)
+			*pgprot = __pgprot(prot);
+		return 0;
+	}
+	if (is_cow_mapping(vma->vm_flags)) {
+		if (pgprot)
+			return -EINVAL;
+		*paddr = (resource_size_t)vma->vm_pgoff << PAGE_SHIFT;
+		return 0;
+	}
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
@@ -957,20 +989,13 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 int track_pfn_copy(struct vm_area_struct *vma)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
 
 	if (vma->vm_flags & VM_PAT) {
-		/*
-		 * reserve the whole chunk covered by vma. We need the
-		 * starting address and protection from pte.
-		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, &pgprot))
 			return -EINVAL;
-		}
-		pgprot = __pgprot(prot);
+		/* reserve the whole chunk covered by vma. */
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
 
@@ -1045,7 +1070,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		 unsigned long size, bool mm_wr_locked)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 
 	if (vma && !(vma->vm_flags & VM_PAT))
 		return;
@@ -1053,11 +1077,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, NULL))
 			return;
-		}
-
 		size = vma->vm_end - vma->vm_start;
 	}
 	free_pfn_range(paddr, size);
diff --git a/mm/memory.c b/mm/memory.c
index 1211e2090c1a..1e9a0288fdaf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6002,6 +6002,10 @@ int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = ptep_get(ptep);
 
+	/* Never return PFNs of anon folios in COW mappings. */
+	if (vm_normal_folio(vma, address, pte))
+		goto unlock;
+
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
 
-- 
2.44.0


