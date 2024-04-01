Return-Path: <linux-kernel+bounces-126988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12324894577
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48219B218D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E62524DF;
	Mon,  1 Apr 2024 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dik6KSIj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+eqgGLxl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4A42056
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999619; cv=none; b=LoDXGkg/oa0BgHSp4pjhzbI8F+VaI11HeW/JJfU0MPzwoZE5yetni/ulhOW0i04SwBYty4C+11IRGxnIPAIPFeg/UgWbVAG7tGvsuH2EEt/iNpsVoqfs9KhF95fXqzjwwZUYvDS+nEKPogm8TtXCQrLPQgAugWu53m/hxoyUFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999619; c=relaxed/simple;
	bh=qc/Zjbm3RMgx8NvZNdskzTcxOocNtFPyzrxC/zDV2ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaShlFrMtqFVB78lGLG3fBr2RDMNpn/GHNQcjJNlYGaYJPyLsIor0L0JsNs1HRIf6exBMJ38cFFyOjDYXZ7pM7R4HMzcJNomZuC4TcSU9ZpDt4nsxoWZCcMMHGgUkMqTwAS6u1aquJrCaiwGsn2LIpoaRxYztDSI1Sd0z3qPSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dik6KSIj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+eqgGLxl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 266C71F394;
	Mon,  1 Apr 2024 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711999615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+NkVK3uxJNsG0RyhZVqp1vQfoJIsEqZ21lQJ8d8QMzU=;
	b=Dik6KSIjy+j/NXUfa8mftP9AMO3eIyswByML7jTqQxro2CDSgLKVgpijrvmrNyJH4xm/uV
	fkJ5uviK9XJeStcQurIlochIUu44v6yXLCRsc81eUU7IDT8DRddC64bRqmlOdWfybx2Cbo
	g7HYS4NyfSCID3yhKVivHMSU1W/PvWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711999615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+NkVK3uxJNsG0RyhZVqp1vQfoJIsEqZ21lQJ8d8QMzU=;
	b=+eqgGLxlQj5Xcv35Tpkfa4YYm2TAwxzNyGX506yHGHcqn+CxGh4vFJlR62mqMPI/Qa5blm
	vOSbNZt1D4hnusAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E8FF1348C;
	Mon,  1 Apr 2024 19:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nnUKA38KC2b4DAAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Mon, 01 Apr 2024 19:26:55 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	stable@vger.kenrel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] mm, mmap: remove vma_merge()
Date: Mon,  1 Apr 2024 21:26:24 +0200
Message-ID: <20240401192623.18575-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.89
X-Spam-Flag: NO
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,suse.cz,vger.kenrel.org,gmail.com,oracle.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 266C71F394

With SLAB gone I was looking for what I could delete next, and then it
dawned on me - it should be vma_merge(). It's simply an unmaintainable
mess.

The code is extremely hard to follow. There has been a number of recent
attempts to made it more readable, by Liam, Lorenzo and myself. Almost
every time this only resulted in subtle embarassing bugs [1] [2] [3] [4]
[5]. For many of the bugs the only reliable testcase we have is the rpm
process running in the Open Build Service. Which is worrying, as that
clearly makes vma_merge() a potential supply chain attack vector for
planting backdoors.

Thus simply remove vma_merge() and all the related code, and adjust all
callers to take the path as if merging was attempted and failed.
The only downside is that there might now be more vmas and maple tree
nodes due to no merging. To extensively validate that, I've booted the
kernel with virtme-ng before and after the change and checked slabinfo
for the number of active objects:

before:
maple_node          1159
vm_area_struct      1538

after:
maple_node          1113
vm_area_struct      1861

Yeah there's more vma's but interestingly, less maple tree nodes. I
believe it's worth it. The larger number of smaller vmas could even help
with better parallelism thanks to per-vma locking. So the conclusion is
obvious - we should have never tried merging vmas in the first place,
hence the tags on this patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d014cd7c1c35
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c6759967826
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e7757876f25
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1419430c8abb
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc0c8f9089c2

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kenrel.org> # CVE mandatory
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Singed-off-by-one: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h |   7 -
 mm/mmap.c     | 368 +++-----------------------------------------------
 mm/mremap.c   |  60 --------
 3 files changed, 17 insertions(+), 418 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..a95bf9f33403 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1107,13 +1107,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
 
-/*
- * mm/mmap.c
- */
-struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
-					struct vm_area_struct *vma,
-					unsigned long delta);
-
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
diff --git a/mm/mmap.c b/mm/mmap.c
index 6dbda99a47da..4a95bf905c61 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -807,248 +807,6 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 	return false;
 }
 
-/*
- * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
- * figure out whether that can be merged with its predecessor or its
- * successor.  Or both (it neatly fills a hole).
- *
- * In most cases - when called for mmap, brk or mremap - [addr,end) is
- * certain not to be mapped by the time vma_merge is called; but when
- * called for mprotect, it is certain to be already mapped (either at
- * an offset within prev, or at the start of next), and the flags of
- * this area are about to be changed to vm_flags - and the no-change
- * case has already been eliminated.
- *
- * The following mprotect cases have to be considered, where **** is
- * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
- * at the same address as **** and is of the same or larger span, and
- * NNNN the next vma after ****:
- *
- *     ****             ****                   ****
- *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
- *    cannot merge    might become       might become
- *                    PPNNNNNNNNNN       PPPPPPPPPPCC
- *    mmap, brk or    case 4 below       case 5 below
- *    mremap move:
- *                        ****               ****
- *                    PPPP    NNNN       PPPPCCCCNNNN
- *                    might become       might become
- *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
- *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
- *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
- *
- * It is important for case 8 that the vma CCCC overlapping the
- * region **** is never going to extended over NNNN. Instead NNNN must
- * be extended in region **** and CCCC must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_merge drops the
- * rmap_locks, the properties of the merged vma will be already
- * correct for the whole merged range. Some of those properties like
- * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
- * be correct for the whole merged range immediately after the
- * rmap_locks are released. Otherwise if NNNN would be removed and
- * CCCC would be extended over the NNNN range, remove_migration_ptes
- * or other rmap walkers (if working on addresses beyond the "end"
- * parameter) may establish ptes with the wrong permissions of CCCC
- * instead of the right permissions of NNNN.
- *
- * In the code below:
- * PPPP is represented by *prev
- * CCCC is represented by *curr or not represented at all (NULL)
- * NNNN is represented by *next or not represented at all (NULL)
- * **** is not represented - it will be merged and the vma containing the
- *      area is returned, or the function will return NULL
- */
-static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
-	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
-	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-	   struct anon_vma_name *anon_name)
-{
-	struct mm_struct *mm = src->vm_mm;
-	struct anon_vma *anon_vma = src->anon_vma;
-	struct file *file = src->vm_file;
-	struct vm_area_struct *curr, *next, *res;
-	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	struct vm_area_struct *anon_dup = NULL;
-	struct vma_prepare vp;
-	pgoff_t vma_pgoff;
-	int err = 0;
-	bool merge_prev = false;
-	bool merge_next = false;
-	bool vma_expanded = false;
-	unsigned long vma_start = addr;
-	unsigned long vma_end = end;
-	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
-	long adj_start = 0;
-
-	/*
-	 * We later require that vma->vm_flags == vm_flags,
-	 * so this tests vma->vm_flags & VM_SPECIAL, too.
-	 */
-	if (vm_flags & VM_SPECIAL)
-		return NULL;
-
-	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
-
-	if (!curr ||			/* cases 1 - 4 */
-	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vma_lookup(mm, end);
-	else
-		next = NULL;		/* case 5 */
-
-	if (prev) {
-		vma_start = prev->vm_start;
-		vma_pgoff = prev->vm_pgoff;
-
-		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
-		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-					   pgoff, vm_userfaultfd_ctx, anon_name)) {
-			merge_prev = true;
-			vma_prev(vmi);
-		}
-	}
-
-	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
-		merge_next = true;
-	}
-
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
-	if (!merge_prev && !merge_next)
-		return NULL; /* Not mergeable. */
-
-	if (merge_prev)
-		vma_start_write(prev);
-
-	res = vma = prev;
-	remove = remove2 = adjust = NULL;
-
-	/* Can we merge both the predecessor and the successor? */
-	if (merge_prev && merge_next &&
-	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-		vma_start_write(next);
-		remove = next;				/* case 1 */
-		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next, &anon_dup);
-		if (curr) {				/* case 6 */
-			vma_start_write(curr);
-			remove = curr;
-			remove2 = next;
-			/*
-			 * Note that the dup_anon_vma below cannot overwrite err
-			 * since the first caller would do nothing unless next
-			 * has an anon_vma.
-			 */
-			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else if (merge_prev) {			/* case 2 */
-		if (curr) {
-			vma_start_write(curr);
-			if (end == curr->vm_end) {	/* case 7 */
-				/*
-				 * can_vma_merge_after() assumed we would not be
-				 * removing prev vma, so it skipped the check
-				 * for vm_ops->close, but we are removing curr
-				 */
-				if (curr->vm_ops && curr->vm_ops->close)
-					err = -EINVAL;
-				remove = curr;
-			} else {			/* case 5 */
-				adjust = curr;
-				adj_start = (end - curr->vm_start);
-			}
-			if (!err)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else { /* merge_next */
-		vma_start_write(next);
-		res = next;
-		if (prev && addr < prev->vm_end) {	/* case 4 */
-			vma_start_write(prev);
-			vma_end = addr;
-			adjust = next;
-			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev, &anon_dup);
-		} else {
-			/*
-			 * Note that cases 3 and 8 are the ONLY ones where prev
-			 * is permitted to be (but is not necessarily) NULL.
-			 */
-			vma = next;			/* case 3 */
-			vma_start = addr;
-			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff - pglen;
-			if (curr) {			/* case 8 */
-				vma_pgoff = curr->vm_pgoff;
-				vma_start_write(curr);
-				remove = curr;
-				err = dup_anon_vma(next, curr, &anon_dup);
-			}
-		}
-	}
-
-	/* Error in anon_vma clone. */
-	if (err)
-		goto anon_vma_fail;
-
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
-
-	if (vma_expanded) {
-		vma_iter_config(vmi, vma_start, vma_end);
-	} else {
-		vma_iter_config(vmi, adjust->vm_start + adj_start,
-				adjust->vm_end);
-	}
-
-	if (vma_iter_prealloc(vmi, vma))
-		goto prealloc_fail;
-
-	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
-	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
-		   vp.anon_vma != adjust->anon_vma);
-
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
-
-	if (vma_expanded)
-		vma_iter_store(vmi, vma);
-
-	if (adj_start) {
-		adjust->vm_start += adj_start;
-		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
-		if (adj_start < 0) {
-			WARN_ON(vma_expanded);
-			vma_iter_store(vmi, next);
-		}
-	}
-
-	vma_complete(&vp, vmi, mm);
-	khugepaged_enter_vma(res, vm_flags);
-	return res;
-
-prealloc_fail:
-	if (anon_dup)
-		unlink_anon_vmas(anon_dup);
-
-anon_vma_fail:
-	vma_iter_set(vmi, addr);
-	vma_iter_load(vmi);
-	return NULL;
-}
-
 /*
  * Rough compatibility check to quickly see if it's even worth looking
  * at sharing an anon_vma.
@@ -2433,14 +2191,6 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 				  struct vm_userfaultfd_ctx uffd_ctx,
 				  struct anon_vma_name *anon_name)
 {
-	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	struct vm_area_struct *merged;
-
-	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
-			   pgoff, policy, uffd_ctx, anon_name);
-	if (merged)
-		return merged;
-
 	if (vma->vm_start < start) {
 		int err = split_vma(vmi, vma, start, 1);
 
@@ -2458,35 +2208,6 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	return vma;
 }
 
-/*
- * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
- * must ensure that [start, end) does not overlap any existing VMA.
- */
-static struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff)
-{
-	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
-			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/*
- * Expand vma by delta bytes, potentially merging with an immediately adjacent
- * VMA with identical properties.
- */
-struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
-					struct vm_area_struct *vma,
-					unsigned long delta)
-{
-	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
-
-	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
-			 vma->vm_flags, pgoff, vma_policy(vma),
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2718,7 +2439,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct vm_area_struct *next, *prev, *merge;
+	struct vm_area_struct *next, *prev;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
@@ -2838,30 +2559,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto close_and_free_vma;
 
 		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge_new_vma(&vmi, prev, vma,
-						  vma->vm_start, vma->vm_end,
-						  vma->vm_pgoff);
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
 
 		vm_flags = vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
@@ -2899,7 +2596,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
 	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
@@ -3354,65 +3050,35 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool *need_rmap_locks)
 {
 	struct vm_area_struct *vma = *vmap;
-	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
-	bool faulted_in_anon_vma = true;
-	VMA_ITERATOR(vmi, mm, addr);
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
+	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
 		pgoff = addr >> PAGE_SHIFT;
-		faulted_in_anon_vma = false;
-	}
 
 	new_vma = find_vma_prev(mm, addr, &prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
-	if (new_vma) {
-		/*
-		 * Source vma may have been merged into new_vma
-		 */
-		if (unlikely(vma_start >= new_vma->vm_start &&
-			     vma_start < new_vma->vm_end)) {
-			/*
-			 * The only way we can get a vma_merge with
-			 * self during an mremap is if the vma hasn't
-			 * been faulted in yet and we were allowed to
-			 * reset the dst vma->vm_pgoff to the
-			 * destination address of the mremap to allow
-			 * the merge to happen. mremap must change the
-			 * vm_pgoff linearity between src and dst vmas
-			 * (in turn preventing a vma_merge) to be
-			 * safe. It is only safe to keep the vm_pgoff
-			 * linear if there are no pages mapped yet.
-			 */
-			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
-			*vmap = vma = new_vma;
-		}
-		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
-	} else {
-		new_vma = vm_area_dup(vma);
-		if (!new_vma)
-			goto out;
-		vma_set_range(new_vma, addr, addr + len, pgoff);
-		if (vma_dup_policy(vma, new_vma))
-			goto out_free_vma;
-		if (anon_vma_clone(new_vma, vma))
-			goto out_free_mempol;
-		if (new_vma->vm_file)
-			get_file(new_vma->vm_file);
-		if (new_vma->vm_ops && new_vma->vm_ops->open)
-			new_vma->vm_ops->open(new_vma);
-		if (vma_link(mm, new_vma))
-			goto out_vma_link;
-		*need_rmap_locks = false;
-	}
+	new_vma = vm_area_dup(vma);
+	if (!new_vma)
+		goto out;
+	vma_set_range(new_vma, addr, addr + len, pgoff);
+	if (vma_dup_policy(vma, new_vma))
+		goto out_free_vma;
+	if (anon_vma_clone(new_vma, vma))
+		goto out_free_mempol;
+	if (new_vma->vm_file)
+		get_file(new_vma->vm_file);
+	if (new_vma->vm_ops && new_vma->vm_ops->open)
+		new_vma->vm_ops->open(new_vma);
+	if (vma_link(mm, new_vma))
+		goto out_vma_link;
+
 	return new_vma;
 
 out_vma_link:
diff --git a/mm/mremap.c b/mm/mremap.c
index 38d98465f3d8..617d65a8ce5a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -951,20 +951,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	return ret;
 }
 
-static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
-{
-	unsigned long end = vma->vm_end + delta;
-
-	if (end < vma->vm_end) /* overflow */
-		return 0;
-	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
-		return 0;
-	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
-			      0, MAP_FIXED) & ~PAGE_MASK)
-		return 0;
-	return 1;
-}
-
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -1093,52 +1079,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
-	/* old_len exactly to the end of the area..
-	 */
-	if (old_len == vma->vm_end - addr) {
-		unsigned long delta = new_len - old_len;
-
-		/* can we just expand the current mapping? */
-		if (vma_expandable(vma, delta)) {
-			long pages = delta >> PAGE_SHIFT;
-			VMA_ITERATOR(vmi, mm, vma->vm_end);
-			long charged = 0;
-
-			if (vma->vm_flags & VM_ACCOUNT) {
-				if (security_vm_enough_memory_mm(mm, pages)) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				charged = pages;
-			}
-
-			/*
-			 * Function vma_merge_extend() is called on the
-			 * extension we are adding to the already existing vma,
-			 * vma_merge_extend() will merge this extension with the
-			 * already existing vma (expand operation itself) and
-			 * possibly also with the next vma if it becomes
-			 * adjacent to the expanded vma and otherwise
-			 * compatible.
-			 */
-			vma = vma_merge_extend(&vmi, vma, delta);
-			if (!vma) {
-				vm_unacct_memory(charged);
-				ret = -ENOMEM;
-				goto out;
-			}
-
-			vm_stat_account(mm, vma->vm_flags, pages);
-			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
-				locked = true;
-				new_addr = addr;
-			}
-			ret = addr;
-			goto out;
-		}
-	}
-
 	/*
 	 * We weren't able to just expand or shrink the area,
 	 * we need to create a new one and move it..
-- 
2.44.0


