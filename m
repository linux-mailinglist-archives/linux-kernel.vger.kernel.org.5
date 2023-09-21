Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBD7AA2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjIUV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjIUV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:27:04 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C58DEFB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:01:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1E60F60173;
        Thu, 21 Sep 2023 23:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695330070; bh=dnvxZB6ijmf5qfNfVWCh3Dsa4dri+/XlY2xzIjhOE8I=;
        h=Date:To:Cc:From:Subject:From;
        b=nIG6vGkHrBGc+LKvlYCPFxBIw7wNtO4YAssT+hD5CTfhEfvVBKMc3EBBUXPxZWZJy
         UB4KxiG9QrB6pAwQiEX+RQRGaEPzCj8Q4ynInV2XuBLtJ/aBXT9+GZF8Tnr1w7EyQy
         TBokEBIX+v16rAEsz/7eEi0RsxsnhONa4+6PYROwNHX5UriGa+uoBUKKt9Ippp0mfe
         P3D6PaHY1mUsCBO5PAVFOiS9jFj3o54VsqLd7kTp5PHik/wQaKaD0sPdAe6Vx0hZR6
         uHwg0dJ/oePr3neIpvvOuGHbDQVLzZwW8E4Etugg1ks91BP6lnxh+ASyIOoj7gGA6d
         ACkCmHDAJkAig==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Xj6KVGT8V4p; Thu, 21 Sep 2023 23:01:06 +0200 (CEST)
Received: from [192.168.1.6] (78-3-40-141.adsl.net.t-com.hr [78.3.40.141])
        by domac.alu.hr (Postfix) with ESMTPSA id 77A7560157;
        Thu, 21 Sep 2023 23:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695330066; bh=dnvxZB6ijmf5qfNfVWCh3Dsa4dri+/XlY2xzIjhOE8I=;
        h=Date:To:Cc:From:Subject:From;
        b=OcYTcK5/16WdK6bH1cSsr0evi91bRY+lraLulfSy3wwUt4juZo07XjxiVVnuYNYuH
         Wnc1LaPIjZEd7qFND3FrV9HYGTn367HiJf05pe4O62pBIP4VfocNbkVcilQGhojsfd
         Z5wrFhsGXtP8lAjwrvr7Vrq3qRW3wTq04wOeo/CY35XNfa0Jy7lP/wkTu6Svu0Gbtj
         ZqV1WFB1mG7soQWNTrioZhe+LKj43gAD7RNCyVx0v+wNZB0/+QFG9pjJNlzJc5zwoF
         hzPKSWIcYiLtYfEYdInCNvzGCw6qSMlt3lLQ458yecJSjq0lIxCxaa8wdYJIJXuNJb
         1OPb1e3p7NYIQ==
Message-ID: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
Date:   Thu, 21 Sep 2023 23:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: maple_tree: KCSAN: data-race in mas_topiary_replace /
 mtree_range_walk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On the 6.6-rc2 vanilla torvalds tree kernel, KCSAN had reported a number of data-races:

[ 6413.367326] ==================================================================
[ 6413.367349] BUG: KCSAN: data-race in mas_topiary_replace / mtree_range_walk

[ 6413.367375] write to 0xffff8883a0c5db00 of 8 bytes by task 5475 on cpu 24:
[ 6413.367386] mas_topiary_replace (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:491 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:1701 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2590)
[ 6413.367399] mas_spanning_rebalance.isra.0 (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2664 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2961)
[ 6413.367413] mas_wr_spanning_store.isra.0 (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:3894)
[ 6413.367428] mas_wr_store_entry.isra.0 (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:4242)
[ 6413.367442] mas_store_prealloc (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:256 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:5408)
[ 6413.367455] vma_merge (/home/marvin/linux/kernel/torvalds2/mm/internal.h:1127 /home/marvin/linux/kernel/torvalds2/mm/mmap.c:1005)
[ 6413.367466] mprotect_fixup (/home/marvin/linux/kernel/torvalds2/mm/mprotect.c:632)
[ 6413.367480] do_mprotect_pkey (/home/marvin/linux/kernel/torvalds2/mm/mprotect.c:819)
[ 6413.367494] __x64_sys_mprotect (/home/marvin/linux/kernel/torvalds2/mm/mprotect.c:837)
[ 6413.367503] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
[ 6413.367517] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)

[ 6413.367534] read to 0xffff8883a0c5db00 of 8 bytes by task 5558 on cpu 11:
[ 6413.367545] mtree_range_walk (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:539 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2789)
[ 6413.367556] mas_walk (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:251 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:4844)
[ 6413.367567] lock_vma_under_rcu (/home/marvin/linux/kernel/torvalds2/mm/memory.c:5436)
[ 6413.367579] do_user_addr_fault (/home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1357)
[ 6413.367593] exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/paravirt.h:695 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1513 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1561)
[ 6413.367602] asm_exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:570)

[ 6413.367617] value changed: 0xffff888341d43116 -> 0xffff888340f92116

[ 6413.367632] Reported by Kernel Concurrency Sanitizer on:
[ 6413.367640] CPU: 11 PID: 5558 Comm: ThreadPoolForeg Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
[ 6413.367653] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 6413.367660] ==================================================================

For your convenience, took the trouble of finding those suspicious lines of code:

The write side:

lib/maple_tree.c:491
--------------------
   456 /*
   457  * mas_set_parent() - Set the parent node and encode the slot
   458  * @enode: The encoded maple node.
   459  * @parent: The encoded maple node that is the parent of @enode.
   460  * @slot: The slot that @enode resides in @parent.
   461  *
   462  * Slot number is encoded in the enode->parent bit 3-6 or 2-6, depending on the
   463  * parent type.
   464  */
   465 static inline
   466 void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
   467                     const struct maple_enode *parent, unsigned char slot)
   468 {
   469         unsigned long val = (unsigned long)parent;
   470         unsigned long shift;
   471         unsigned long type;
   472         enum maple_type p_type = mte_node_type(parent);
   473
   474         MAS_BUG_ON(mas, p_type == maple_dense);
   475         MAS_BUG_ON(mas, p_type == maple_leaf_64);
   476
   477         switch (p_type) {
   478         case maple_range_64:
   479         case maple_arange_64:
   480                 shift = MAPLE_PARENT_SLOT_SHIFT;
   481                 type = MAPLE_PARENT_RANGE64;
   482                 break;
   483         default:
   484         case maple_dense:
   485         case maple_leaf_64:
   486                 shift = type = 0;
   487                 break;
   488         }
   489
   490         val &= ~MAPLE_NODE_MASK; /* Clear all node metadata in parent */
→ 491         val |= (slot << shift) | type;
   492         mte_to_node(enode)->parent = ma_parent_ptr(val);
   493 }

lib/maple_tree.c:1701
---------------------
   1682 /*
   1683  * mas_adopt_children() - Set the parent pointer of all nodes in @parent to
   1684  * @parent with the slot encoded.
   1685  * @mas - the maple state (for the tree)
   1686  * @parent - the maple encoded node containing the children.
   1687  */
   1688 static inline void mas_adopt_children(struct ma_state *mas,
   1689                 struct maple_enode *parent)
   1690 {
   1691         enum maple_type type = mte_node_type(parent);
   1692         struct maple_node *node = mte_to_node(parent);
   1693         void __rcu **slots = ma_slots(node, type);
   1694         unsigned long *pivots = ma_pivots(node, type);
   1695         struct maple_enode *child;
   1696         unsigned char offset;
   1697
   1698         offset = ma_data_end(node, type, pivots, mas->max);
   1699         do {
   1700                 child = mas_slot_locked(mas, slots, offset);
→ 1701                 mas_set_parent(mas, child, parent, offset);
   1702         } while (offset--);
   1703 }

   2562 static inline void mas_topiary_replace(struct ma_state *mas,
   2563                 struct maple_enode *old_enode)
   2564 {
   2565         struct ma_state tmp[3], tmp_next[3];
   2566         MA_TOPIARY(subtrees, mas->tree);
   2567         bool in_rcu;
   2568         int i, n;
   2569
   2570         /* Place data in tree & then mark node as old */
   2571         mas_put_in_tree(mas, old_enode);
   2572
   2573         /* Update the parent pointers in the tree */
   2574         tmp[0] = *mas;
   2575         tmp[0].offset = 0;
   2576         tmp[1].node = MAS_NONE;
   2577         tmp[2].node = MAS_NONE;
   2578         while (!mte_is_leaf(tmp[0].node)) {
   2579                 n = 0;
   2580                 for (i = 0; i < 3; i++) {
   2581                         if (mas_is_none(&tmp[i]))
   2582                                 continue;
   2583
   2584                         while (n < 3) {
   2585                                 if (!mas_find_child(&tmp[i], &tmp_next[n]))
   2586                                         break;
   2587                                 n++;
   2588                         }
   2589
→ 2590                        mas_adopt_children(&tmp[i], tmp[i].node);
   2591                 }
   2592
   2593                 if (MAS_WARN_ON(mas, n == 0))
   2594                         break;
   2595
   2596                 while (n < 3)
   2597                         tmp_next[n++].node = MAS_NONE;
   2598
   2599                 for (i = 0; i < 3; i++)
   2600                         tmp[i] = tmp_next[i];
   2601         }
   2602
   2603         /* Collect the old nodes that need to be discarded */
   2604         if (mte_is_leaf(old_enode))
   2605                 return mas_free(mas, old_enode);
   2606
   2607         tmp[0] = *mas;
   2608         tmp[0].offset = 0;
   2609         tmp[0].node = old_enode;
   2610         tmp[1].node = MAS_NONE;
   2611         tmp[2].node = MAS_NONE;
   2612         in_rcu = mt_in_rcu(mas->tree);
   2613         do {
   2614                 n = 0;
   2615                 for (i = 0; i < 3; i++) {
   2616                         if (mas_is_none(&tmp[i]))
   2617                                 continue;

The read side:

    527 /*
    528  * ma_dead_node() - check if the @enode is dead.
    529  * @enode: The encoded maple node
    530  *
    531  * Return: true if dead, false otherwise.
    532  */
    533 static inline bool ma_dead_node(const struct maple_node *node)
    534 {
    535         struct maple_node *parent;
    536
    537         /* Do not reorder reads from the node prior to the parent check */
    538         smp_rmb();
→  539         parent = (void *)((unsigned long) node->parent & ~MAPLE_NODE_MASK);
    540         return (parent == node);
    541 }

   2767 static inline void *mtree_range_walk(struct ma_state *mas)
   2768 {
   2769         unsigned long *pivots;
   2770         unsigned char offset;
   2771         struct maple_node *node;
   2772         struct maple_enode *next, *last;
   2773         enum maple_type type;
   2774         void __rcu **slots;
   2775         unsigned char end;
   2776         unsigned long max, min;
   2777         unsigned long prev_max, prev_min;
   2778
   2779         next = mas->node;
   2780         min = mas->min;
   2781         max = mas->max;
   2782         do {
   2783                 offset = 0;
   2784                 last = next;
   2785                 node = mte_to_node(next);
   2786                 type = mte_node_type(next);
   2787                 pivots = ma_pivots(node, type);
   2788                 end = ma_data_end(node, type, pivots, max);
→ 2789                 if (unlikely(ma_dead_node(node)))
   2790                         goto dead_node;
   2791
   2792                 if (pivots[offset] >= mas->index) {
   2793                         prev_max = max;
   2794                         prev_min = min;
   2795                         max = pivots[offset];
   2796                         goto next;
   2797                 }
   2798
   2799                 do {
   2800                         offset++;
   2801                 } while ((offset < end) && (pivots[offset] < mas->index));

As it is evident, ma_dead_node() expands to:

    527 /*
    528  * ma_dead_node() - check if the @enode is dead.
    529  * @enode: The encoded maple node
    530  *
    531  * Return: true if dead, false otherwise.
    532  */
    533 static inline bool ma_dead_node(const struct maple_node *node)
    534 {
    535         struct maple_node *parent;
    536
    537         /* Do not reorder reads from the node prior to the parent check */
    538         smp_rmb();
→  539         parent = (void *)((unsigned long) node->parent & ~MAPLE_NODE_MASK);
    540         return (parent == node);
    541 }

as above, but the smb_rmb() protection is here, so the KCSAN warning should be double-checked for
validity.

But I do not really understand maple trees to their depth, I am only reporting the symptomatic
outlook of the reported data-race.

This is all-in-all a very interested subject, and I wish there was a way to just slurp all those
interesting kernel intrinsics into the brain, but it just ain't that easy. Forgive me for being
open ...

Best regards,
Mirsad Todorovac
