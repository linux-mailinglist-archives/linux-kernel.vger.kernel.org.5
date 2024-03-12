Return-Path: <linux-kernel+bounces-100634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166C879B04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6C5B22D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A22139569;
	Tue, 12 Mar 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUnBElGu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3A1386D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267091; cv=none; b=uFrq7lFJLORhNW8Q6V2ERux84XlnyJipsHbO3JtZMoR+4mv2SOs+yjFb0uLfubAQw3SCgRlClDxk2IPMVZOs7iP4jyXi3cPzh4wjDyPLgMFo8hR7xUSMc3H2LV85I3HAQI8cKbWZApNx3oM3SDxnNgC8C2d+yLs49dnjXwKzSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267091; c=relaxed/simple;
	bh=X6q67ae8BBmaF+lgmtGUJ+5fXnmJWE3ftqJYyTI6St8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHn5UwexS9i9DkXoMWi6yoApkRHowFFmG9+2m+0cgxvo9iRWAwObXg5HcADOXRoOIKVUlGGtCibUovVKa1E7e/rz6K3vvZ+4AqJjBzvtjAj7UWSkVMdk3zGKAQIwEDLelLkv80yMuATu5gsRe9ixX7zC3uPqvkPROKXxoYKWobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUnBElGu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710267088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QDV9x+7F96bUT8ZplUut026NxQLyg/9WyFP+QKSKcOg=;
	b=UUnBElGuvHIFdqHp0MHxJQChbfg1BP1Xjb+2x5oteQlNwXmiZ7Jx/THV8pP0+HS9YvqL4F
	SVsjsVYWG0ZlUnCg2wzVFDEaqBgGEWyFnSFrDt8L3fl8G3tRYK2/Id+FWaTUoQjWBQLuzh
	jcwhLQ6qPouCvB4vRMoy5caT4FzzfYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-CSwAWI_fNK6YyzOGkSGKaA-1; Tue, 12 Mar 2024 14:11:22 -0400
X-MC-Unique: CSwAWI_fNK6YyzOGkSGKaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3F53185A789;
	Tue, 12 Mar 2024 18:11:21 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CFE831121337;
	Tue, 12 Mar 2024 18:11:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	David Hildenbrand <david@redhat.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Date: Tue, 12 Mar 2024 19:11:18 +0100
Message-ID: <20240312181118.318701-1-david@redhat.com>
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

On top of mm/mm-unstable.

I spent way too much time trying to squeeze the cachemode into the VMA in
a clean way. I even went the extra mile and tried to get rid of
follow_phys() completely, storing the cachemode and the PFN in the VMA.

But I didn't quite like the end result and decided to just keep it
simple and not care about improving the already-broken fork() corner case.

follow_phys() is rather ugly, and I have some patches to improve the
situation. But let's get this fix here out first and discuss if there is
an alternative.

---
 arch/x86/mm/pat/memtype.c | 49 ++++++++++++++++++++++++++++-----------
 mm/memory.c               |  4 ++++
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e8e1260..82857148dbec5 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -950,6 +950,38 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
+static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
+			pgprot_t *pgprot)
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
@@ -960,20 +992,13 @@ static void free_pfn_range(u64 paddr, unsigned long size)
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
 
@@ -1048,7 +1073,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		 unsigned long size, bool mm_wr_locked)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 
 	if (vma && !(vma->vm_flags & VM_PAT))
 		return;
@@ -1056,11 +1080,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
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
index f2bc6dd15eb83..bd3336fa5b66a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5971,6 +5971,10 @@ int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = ptep_get(ptep);
 
+	/* Never return PFNs of anon folios in COW mappings. */
+	if (vm_normal_folio(vma, address, pte))
+		goto unlock;
+
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
 
-- 
2.43.2


