Return-Path: <linux-kernel+bounces-118412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9E88BA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E8D29E626
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03B130A6E;
	Tue, 26 Mar 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uys7I63q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o4yifOMq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uys7I63q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o4yifOMq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CF130A58
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434570; cv=none; b=fAOmZxowmuFxug7eSetFtxO5p0pjkDfa6IntDX7pgHEjxEUL2fBgUJhcJGTOSoMOqm1snuQPicATAlOlwrtkWfef55b664SZddKvOynRMZ9qt1rv5QjAKf2xkQgBlRqla6OeaqM+AlJzldTGVIFsVnawC9x0DuG56Xox7H0Ct0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434570; c=relaxed/simple;
	bh=8n3sjFiVCX1R6oI4eVrTQsVqUAorYWqWuKdioQ15Qb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7jFuwjDctuABEkw9zjWrBWrg+PMPNnGeetiMVFSMNzAfOW5an/sOYBp6NxjxuFx5VDKtru4pfwRVq51M8DYy5zLYUydkUG63zbsQ7KHTKvbjKoUImHE1k13+5BNykmE8j2u3ULyI8iOZH+GT4tcRkcBTTchUAag4tSZn1PBUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uys7I63q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o4yifOMq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uys7I63q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o4yifOMq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B964F37809;
	Tue, 26 Mar 2024 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711434558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2s5Z+mBTGRB1b77yA719SIjqvuRSMVvpx566llr28g=;
	b=uys7I63qEzH54ztueaqvOcRv7kEMi7JKK98QUJwjFcOQCbCvkJzWOsZdmawTS01a4bLghx
	HbMaGF0J90jgQy5t8lYEdlgfTxl7RAxhvuS9ZV0sIWyulS3s1DojetzdlH384Ch+i6+aXt
	myvKJra6Z4vadQJopHu1BBeZfZixHdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711434558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2s5Z+mBTGRB1b77yA719SIjqvuRSMVvpx566llr28g=;
	b=o4yifOMqEqPGNbaCq9D0Jv4FpBOK2yvang64LxEzR7ta7Hr7knVIVmCKpEA3kgloOHZYVI
	3jLcWOULZ0oq19CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711434558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2s5Z+mBTGRB1b77yA719SIjqvuRSMVvpx566llr28g=;
	b=uys7I63qEzH54ztueaqvOcRv7kEMi7JKK98QUJwjFcOQCbCvkJzWOsZdmawTS01a4bLghx
	HbMaGF0J90jgQy5t8lYEdlgfTxl7RAxhvuS9ZV0sIWyulS3s1DojetzdlH384Ch+i6+aXt
	myvKJra6Z4vadQJopHu1BBeZfZixHdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711434558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2s5Z+mBTGRB1b77yA719SIjqvuRSMVvpx566llr28g=;
	b=o4yifOMqEqPGNbaCq9D0Jv4FpBOK2yvang64LxEzR7ta7Hr7knVIVmCKpEA3kgloOHZYVI
	3jLcWOULZ0oq19CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 24BB013215;
	Tue, 26 Mar 2024 06:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6NRLBj5rAmY2YQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 26 Mar 2024 06:29:18 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: [PATCH v3 2/3] mm,page_owner: Fix refcount imbalance
Date: Tue, 26 Mar 2024 07:30:35 +0100
Message-ID: <20240326063036.6242-3-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326063036.6242-1-osalvador@suse.de>
References: <20240326063036.6242-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[41bbfdb8d41003d12c0f];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de,syzkaller.appspotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Current code does not contemplate scenarios were an allocation and
free operation on the same pages do not handle it in the same amount
at once.
To give an example, page_alloc_exact(), where we will allocate a page
of enough order to stafisfy the size request, but we will free the
remainings right away.

In the above example, we will increment the stack_record refcount
only once, but we will decrease it the same number of times as number
of unused pages we have to free.
This will lead to a warning because of refcount imbalance.

Fix this by recording the number of base pages in the refcount field.

Reported-by: syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/00000000000090e8ff0613eda0e5@google.com
Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/mm/page_owner.rst | 73 +++++++++++++++++----------------
 mm/page_owner.c                 | 34 ++++++++-------
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 0d0334cd5179..3a45a20fc05a 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -24,10 +24,10 @@ fragmentation statistics can be obtained through gfp flag information of
 each page. It is already implemented and activated if page owner is
 enabled. Other usages are more than welcome.
 
-It can also be used to show all the stacks and their outstanding
-allocations, which gives us a quick overview of where the memory is going
-without the need to screen through all the pages and match the allocation
-and free operation.
+It can also be used to show all the stacks and their current number of
+allocated base pages, which gives us a quick overview of where the memory
+is going without the need to screen through all the pages and match the
+allocation and free operation.
 
 page owner is disabled by default. So, if you'd like to use it, you need
 to add "page_owner=on" to your boot cmdline. If the kernel is built
@@ -75,42 +75,45 @@ Usage
 
 	cat /sys/kernel/debug/page_owner_stacks/show_stacks > stacks.txt
 	cat stacks.txt
-	 prep_new_page+0xa9/0x120
-	 get_page_from_freelist+0x7e6/0x2140
-	 __alloc_pages+0x18a/0x370
-	 new_slab+0xc8/0x580
-	 ___slab_alloc+0x1f2/0xaf0
-	 __slab_alloc.isra.86+0x22/0x40
-	 kmem_cache_alloc+0x31b/0x350
-	 __khugepaged_enter+0x39/0x100
-	 dup_mmap+0x1c7/0x5ce
-	 copy_process+0x1afe/0x1c90
-	 kernel_clone+0x9a/0x3c0
-	 __do_sys_clone+0x66/0x90
-	 do_syscall_64+0x7f/0x160
-	 entry_SYSCALL_64_after_hwframe+0x6c/0x74
-	stack_count: 234
+	 post_alloc_hook+0x177/0x1a0
+	 get_page_from_freelist+0xd01/0xd80
+	 __alloc_pages+0x39e/0x7e0
+	 allocate_slab+0xbc/0x3f0
+	 ___slab_alloc+0x528/0x8a0
+	 kmem_cache_alloc+0x224/0x3b0
+	 sk_prot_alloc+0x58/0x1a0
+	 sk_alloc+0x32/0x4f0
+	 inet_create+0x427/0xb50
+	 __sock_create+0x2e4/0x650
+	 inet_ctl_sock_create+0x30/0x180
+	 igmp_net_init+0xc1/0x130
+	 ops_init+0x167/0x410
+	 setup_net+0x304/0xa60
+	 copy_net_ns+0x29b/0x4a0
+	 create_new_namespaces+0x4a1/0x820
+	nr_base_pages: 16
 	...
 	...
 	echo 7000 > /sys/kernel/debug/page_owner_stacks/count_threshold
 	cat /sys/kernel/debug/page_owner_stacks/show_stacks> stacks_7000.txt
 	cat stacks_7000.txt
-	 prep_new_page+0xa9/0x120
-	 get_page_from_freelist+0x7e6/0x2140
-	 __alloc_pages+0x18a/0x370
-	 alloc_pages_mpol+0xdf/0x1e0
-	 folio_alloc+0x14/0x50
-	 filemap_alloc_folio+0xb0/0x100
-	 page_cache_ra_unbounded+0x97/0x180
-	 filemap_fault+0x4b4/0x1200
-	 __do_fault+0x2d/0x110
-	 do_pte_missing+0x4b0/0xa30
-	 __handle_mm_fault+0x7fa/0xb70
-	 handle_mm_fault+0x125/0x300
-	 do_user_addr_fault+0x3c9/0x840
-	 exc_page_fault+0x68/0x150
-	 asm_exc_page_fault+0x22/0x30
-	stack_count: 8248
+	 post_alloc_hook+0x177/0x1a0
+	 get_page_from_freelist+0xd01/0xd80
+	 __alloc_pages+0x39e/0x7e0
+	 alloc_pages_mpol+0x22e/0x490
+	 folio_alloc+0xd5/0x110
+	 filemap_alloc_folio+0x78/0x230
+	 page_cache_ra_order+0x287/0x6f0
+	 filemap_get_pages+0x517/0x1160
+	 filemap_read+0x304/0x9f0
+	 xfs_file_buffered_read+0xe6/0x1d0 [xfs]
+	 xfs_file_read_iter+0x1f0/0x380 [xfs]
+	 __kernel_read+0x3b9/0x730
+	 kernel_read_file+0x309/0x4d0
+	 __do_sys_finit_module+0x381/0x730
+	 do_syscall_64+0x8d/0x150
+	 entry_SYSCALL_64_after_hwframe+0x62/0x6a
+	nr_base_pages: 20824
 	...
 
 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 52d1ced0b57f..5df0d6892bdc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -196,7 +196,8 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	spin_unlock_irqrestore(&stack_list_lock, flags);
 }
 
-static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
+static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask,
+				   int nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
 
@@ -217,15 +218,20 @@ static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
 			/* Add the new stack_record to our list */
 			add_stack_record_to_list(stack_record, gfp_mask);
 	}
-	refcount_inc(&stack_record->count);
+	refcount_add(nr_base_pages, &stack_record->count);
 }
 
-static void dec_stack_record_count(depot_stack_handle_t handle)
+static void dec_stack_record_count(depot_stack_handle_t handle,
+				   int nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
 
-	if (stack_record)
-		refcount_dec(&stack_record->count);
+	if (!stack_record)
+		return;
+
+	if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
+		pr_warn("%s: refcount went to 0 for %u handle\n", __func__,
+			handle);
 }
 
 static inline void __update_page_owner_handle(struct page_ext *page_ext,
@@ -306,7 +312,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		 * the machinery is not ready yet, we cannot decrement
 		 * their refcount either.
 		 */
-		dec_stack_record_count(alloc_handle);
+		dec_stack_record_count(alloc_handle, 1 << order);
 }
 
 noinline void __set_page_owner(struct page *page, unsigned short order,
@@ -325,7 +331,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 				   current->pid, current->tgid, ts_nsec,
 				   current->comm);
 	page_ext_put(page_ext);
-	inc_stack_record_count(handle, gfp_mask);
+	inc_stack_record_count(handle, gfp_mask, 1 << order);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
@@ -872,11 +878,11 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 	return stack;
 }
 
-static unsigned long page_owner_stack_threshold;
+static unsigned long page_owner_pages_threshold;
 
 static int stack_print(struct seq_file *m, void *v)
 {
-	int i, stack_count;
+	int i, nr_base_pages;
 	struct stack *stack = v;
 	unsigned long *entries;
 	unsigned long nr_entries;
@@ -887,14 +893,14 @@ static int stack_print(struct seq_file *m, void *v)
 
 	nr_entries = stack_record->size;
 	entries = stack_record->entries;
-	stack_count = refcount_read(&stack_record->count) - 1;
+	nr_base_pages = refcount_read(&stack_record->count) - 1;
 
-	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
+	if (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold)
 		return 0;
 
 	for (i = 0; i < nr_entries; i++)
 		seq_printf(m, " %pS\n", (void *)entries[i]);
-	seq_printf(m, "stack_count: %d\n\n", stack_count);
+	seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
 
 	return 0;
 }
@@ -924,13 +930,13 @@ static const struct file_operations page_owner_stack_operations = {
 
 static int page_owner_threshold_get(void *data, u64 *val)
 {
-	*val = READ_ONCE(page_owner_stack_threshold);
+	*val = READ_ONCE(page_owner_pages_threshold);
 	return 0;
 }
 
 static int page_owner_threshold_set(void *data, u64 val)
 {
-	WRITE_ONCE(page_owner_stack_threshold, val);
+	WRITE_ONCE(page_owner_pages_threshold, val);
 	return 0;
 }
 
-- 
2.44.0


