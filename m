Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E579E7EBD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjKOHBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:01:45 -0500
Received: from 2.mo576.mail-out.ovh.net (2.mo576.mail-out.ovh.net [178.33.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1CEB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:01:40 -0800 (PST)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.138.183])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id B3B9B2B899
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:55:17 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kk79p (unknown [10.110.103.209])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CCDBC1FE63;
        Wed, 15 Nov 2023 06:55:14 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.109])
        by ghost-submission-6684bf9d7b-kk79p with ESMTPSA
        id dYJtK1JrVGU8rBAAqzq3ag
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 15 Nov 2023 06:55:14 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-109S0036636ec59-b412-492a-b5ae-5815ec344a16,
                    1B5EDD6806DE6C3B4F01E8E4F83C0687A6DCEFC3) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.111.222
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev,
        syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
Subject: [PATCH] mm/pgtable: return null if no ptl in __pte_offset_map_lock
Date:   Wed, 15 Nov 2023 08:55:05 +0200
Message-Id: <20231115065506.19780-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7734087937806738971
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefhedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeevveeileeukeefjeevkeffudehhedtvdeuhffgteelvdejieefheffveelhfekheenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucfkphepuddvjedrtddrtddruddpkeejrdelgedrudduuddrvddvvddpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation of __pte_offset_map_lock suggest there is situations where
a pmd may not have a corresponding page table, in which case it should
return NULL without changing ptlp. Syzbot found its ways to produce a
NULL dereference in the function showing this case. This patch will
provide the exit path suggested if this unlikely situation turns up. The
output of the kasan null-ptr-report follows:

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 7952 Comm: syz-executor682 Not tainted 6.6.0-rc6-syzkaller-g78124b0c1d10 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
lr : lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
sp : ffff800098f26d40
x29: ffff800098f27000 x28: ffff8000808df4bc x27: ffff7000131e4e18
x26: 1ffff00011c340b9 x25: 0000000000000000 x24: 0000000000000000
x23: ffff7000131e4dd0 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000022 x18: ffff800098f27750
x17: 0000ffff833dafff x16: ffff80008a632120 x15: 0000000000000001
x14: ffff80008e1a05d0 x13: ffff800098f26e80 x12: dfff800000000000
x11: ffff800080319468 x10: ffff80008e1a05cc x9 : 00000000000000f3
x8 : 0000000000000004 x7 : ffff8000808df4bc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
Call trace:
 __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0x154/0x360 mm/pgtable-generic.c:373
 pte_offset_map_lock include/linux/mm.h:2939 [inline]
 filemap_map_pages+0x698/0x11f0 mm/filemap.c:3582
 do_fault_around mm/memory.c:4525 [inline]
 do_read_fault mm/memory.c:4558 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x326c/0x49fc mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x3e0/0xa24 mm/gup.c:1239
 populate_vma_page_range+0x254/0x328 mm/gup.c:1666
 __mm_populate+0x240/0x3d8 mm/gup.c:1775
 mm_populate include/linux/mm.h:3305 [inline]
 vm_mmap_pgoff+0x2bc/0x3d4 mm/util.c:551
 ksys_mmap_pgoff+0xd0/0x5b0 mm/mmap.c:1400
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: b006f948 b943a108 34000208 d343fe68 (386c6908)
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:   b006f948        adrp    x8, 0xdf29000
   4:   b943a108        ldr     w8, [x8, #928]
   8:   34000208        cbz     w8, 0x48
   c:   d343fe68        lsr     x8, x19, #3
* 10:   386c6908        ldrb    w8, [x8, x12] <-- trapping instruction

Reported-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
Fixes: 0d940a9b270b9 ("mm/pgtable: allow pte_offset_map[_lock]() to fail")
Closes: https://syzkaller.appspot.com/bug?id=7494636a5865150aecc6e480e0e7e17f2980ad8d
Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 include/linux/mm.h   | 4 ++--
 mm/pgtable-generic.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..38d876529e1f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2854,7 +2854,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return ptdesc->ptl;
+	return (likely(ptdesc)) ? ptdesc->ptl : NULL;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
@@ -2872,7 +2872,7 @@ static inline void ptlock_free(struct ptdesc *ptdesc)
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &ptdesc->ptl;
+	return (likely(ptdesc)) ? &ptdesc->ptl : NULL;
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4fcd959dcc4d..7796339d7ef2 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -370,6 +370,8 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	if (unlikely(!pte))
 		return pte;
 	ptl = pte_lockptr(mm, &pmdval);
+	if (unlikely(!ptl))
+		return NULL;
 	spin_lock(ptl);
 	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
 		*ptlp = ptl;
-- 
2.39.2

