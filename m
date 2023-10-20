Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714087D0FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377330AbjJTMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377079AbjJTMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:34:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A2D41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zAECRQ9+SRjJ+dlKOHLm6VlSLcd9Pu86x8oU/hzjugw=; b=g4crD1oOaS3pPdfG0Aauo6TbmE
        p9ZPe+xmnv2OHC2uzMafVkwwuCaDi4cJltemBtp+e4tkasgB1ZprQTXVkmvB94jLhJU9ioGYINFVi
        xdi4yMZ8YRAp/SnH1w63INlRE1ugSngXAQAl3OQsrk+Br9v/0nn40C6LMlZgFRhaUcEHD7L8BMqZm
        K3tdvUatVbWLjRJk54jc6pSr/rJT5AW6v9lFKxqfbICDkrAbNMZaAlL2P4zoYkIbzuxe2Hm7u1cuN
        X+9lUUaB6ISgf+L3oR9ijWMx1XMQOvwKxZAtBQJCIvcPvRIJL1rECQsk5OfxONWq+sKobQDOYMHl2
        fISPeG8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtoiB-00D7p8-MF; Fri, 20 Oct 2023 12:34:43 +0000
Date:   Fri, 20 Oct 2023 13:34:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Zhang Zhiyu <zhiyuzhang999@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: KASAN: slab-use-after-free Read in radix_tree_lookup in&after
 Linux Kernel 6.4-rc6
Message-ID: <ZTJz4/hddcv1J6pJ@casper.infradead.org>
References: <CALf2hKtDJGqmsiSykbX8EEfbthwt6a4Bs98m60dUkS7URW-C8g@mail.gmail.com>
 <CALf2hKucyJjmgE8Ry50RvytMtWz8gVXGXwoECvoVYph7xkEDEQ@mail.gmail.com>
 <ZTI5tzh_tgCBnr35@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTI5tzh_tgCBnr35@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:26:31AM +0200, Petr Mladek wrote:
> Adding Matthew into Cc in the hope that he is still familiar with the
> code. Also adding Andrew who accepts patches.

oh joy.  i love dealing with cves.

> > > I agree, this issue looks to be in kernel-core radix tree code in ./lib/radix-tree.c in two of any places.

the radix tree code is the victim here.  maybe also the perpetrator, but
it's rather hard to say.

shrink_slab_memcg()
	down_read_trylock(&shrinker_rwsem)
	shrinker = idr_find(&shrinker_idr, i);

i assume is the path to this bug.  the reporter didn't run the
stacktrace through scripts/decode_stacktrace.sh so it's less useful than
we might want.

prealloc_memcg_shrinker() calls idr_alloc and idr_remove under
shrinker_rwsem in write mode, so that should be fine.

unregister_memcg_shrinker() calls idr_remove after asserting &shrinker_rwsem
is held (although not asserting that it's held for write ... hmm ... but
both callers appear to hold it for write anyway)

so i don't see why we'd get a UAF here.

anyway, adding Qi Zheng to the cc since they're responsible for the
shrinker code.

> > > 817 void *radix_tree_lookup(const struct radix_tree_root *root, unsigned long index)
> > > 818 {
> > > 819 return __radix_tree_lookup(root, index, NULL, NULL);==>
> > > 820 }
> > >
> > >
> > > ==> 747 void *__radix_tree_lookup(const struct radix_tree_root *root,
> > > 748 unsigned long index, struct radix_tree_node **nodep,
> > > 749 void __rcu ***slotp)
> > > 750 {
> > > 751 struct radix_tree_node *node, *parent;
> > > 752 unsigned long maxindex;
> > > 753 void __rcu **slot;
> > > 754
> > > 755 restart:
> > > 756 parent = NULL;
> > > 757 slot = (void __rcu **)&root->xa_head;
> > > 758 radix_tree_load_root(root, &node, &maxindex);
> > > 759 if (index > maxindex)
> > > 760 return NULL;
> > > 761
> > > 762 while (radix_tree_is_internal_node(node)) {
> > > ^..may be (1)
> > > 763 unsigned offset;
> > > 764
> > > 765 parent = entry_to_node(node);
> > > 766 offset = radix_tree_descend(parent, &node, index);
> > > 767 slot = parent->slots + offset;
> > > 768 if (node == RADIX_TREE_RETRY)
> > > 769 goto restart;
> > > 770 if (parent->shift == 0)
> > > 771 break;
> > > 772 }
> > > 773
> > > 774 if (nodep)
> > > 775 *nodep = parent;
> > > 776 if (slotp)
> > > 777 *slotp = slot;
> > > 778 return node;
> > > 779 }
> > >
> > > looking at the backtrack:
> > >
> > > 1)
> > >
> > > [ 2351.169619][ T88] ==================================================================
> > > [ 2351.170501][ T88] BUG: KASAN: slab-use-after-free in radix_tree_lookup+0x12d/0x290
> > > [ 2351.171365][ T88] Read of size 8 at addr ffff8880675ab1a8 by task kswapd0/88
> > > [ 2351.172129][ T88]
> > > [ 2351.172393][ T88] CPU: 0 PID: 88 Comm: kswapd0 Not tainted 6.4.0-rc6 #1
> > > [ 2351.173124][ T88] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> > > [ 2351.174222][ T88] Call Trace:
> > > [ 2351.174593][ T88]
> > > [ 2351.174930][ T88] dump_stack_lvl+0x1ae/0x2a0
> > > [ 2351.175483][ T88] ? show_regs_print_info+0x20/0x20
> > > [ 2351.176077][ T88] ? _printk+0xc0/0x100
> > > [ 2351.176571][ T88] ? vprintk_emit+0x109/0x1e0
> > > [ 2351.177112][ T88] ? __wake_up_klogd+0xcc/0x100
> > > [ 2351.177697][ T88] ? log_buf_vmcoreinfo_setup+0x4a0/0x4a0
> > > [ 2351.178358][ T88] ? _printk+0xc0/0x100
> > > [ 2351.178830][ T88] print_address_description+0x78/0x390
> > > [ 2351.179465][ T88] print_report+0x107/0x1e0
> > > [ 2351.179982][ T88] ? __virt_addr_valid+0x21b/0x2d0
> > > [ 2351.180581][ T88] ? __phys_addr+0xb5/0x160
> > > [ 2351.181107][ T88] ? radix_tree_lookup+0x12d/0x290
> > > [ 2351.181682][ T88] kasan_report+0xcd/0x100
> > > [ 2351.182171][ T88] ? radix_tree_lookup+0x12d/0x290
> > > [ 2351.182721][ T88] radix_tree_lookup+0x12d/0x290
> > > [ 2351.183256][ T88] shrink_slab_memcg+0x369/0x7c0
> > > [ 2351.183791][ T88] ? shrink_slab+0x3c0/0x3c0
> > > [ 2351.184657][ T88] ? lockdep_hardirqs_on_prepare+0x3e2/0x750
> > > [ 2351.186670][ T88] shrink_slab+0xbd/0x3c0
> > > [ 2351.188672][ T88] ? _raw_spin_unlock_irqrestore+0x8b/0x120
> > > [ 2351.190625][ T88] ? lockdep_hardirqs_on+0x8d/0x130
> > > [ 2351.191796][ T88] ? free_shrinker_info_rcu+0x20/0x20
> > > [ 2351.192381][ T88] shrink_one+0x30e/0x750
> > > [ 2351.192853][ T88] shrink_many+0x3ce/0x6d0
> > > [ 2351.193354][ T88] lru_gen_shrink_node+0x3c1/0x5c0
> > > [ 2351.193907][ T88] ? shrink_node+0xb6/0x1040
> > > [ 2351.194406][ T88] ? shrink_node+0x1040/0x1040
> > > [ 2351.194926][ T88] ? pgdat_balanced+0x1e8/0x210
> > > [ 2351.195465][ T88] balance_pgdat+0xca7/0x1ac0
> > >
> > > 2)
> > > Or could be in
> > >
> > > 747 void *__radix_tree_lookup(const struct radix_tree_root *root,
> > > 748 unsigned long index, struct radix_tree_node **nodep,
> > > 749 void __rcu ***slotp)
> > > 750 {
> > > ..
> > > 762 while (radix_tree_is_internal_node(node)) {
> > > 763 unsigned offset;
> > > 764
> > > 765 parent = entry_to_node(node);
> > > 766 offset = radix_tree_descend(parent, &node, index);------- (2)
> > > ^....//Here
> > >
> > >
> > > CPU: 0 PID: 88 Comm: kswapd0 Not tainted 6.4.0-rc6 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> > > Call Trace:
> > > __dump_stack lib/dump_stack.c:88 [inline]
> > > dump_stack_lvl+0x1ae/0x2a0 lib/dump_stack.c:106
> > > print_address_description+0x78/0x390 mm/kasan/report.c:351
> > > print_report+0x107/0x1e0 mm/kasan/report.c:462
> > > kasan_report+0xcd/0x100 mm/kasan/report.c:572
> > > radix_tree_descend lib/radix-tree.c:87 [inline]
> > > ^....................................................//here (2)
> > > __radix_tree_lookup lib/radix-tree.c:764 [inline]
> > > radix_tree_lookup+0x12d/0x290 lib/radix-tree.c:817
> > > shrink_slab_memcg+0x369/0x7c0 mm/vmscan.c:970
> > > shrink_slab+0xbd/0x3c0 mm/vmscan.c:1062
> > > shrink_one+0x30e/0x750 mm/vmscan.c:5380
> > > shrink_many+0x3ce/0x6d0 mm/vmscan.c:5430
> > > lru_gen_shrink_node+0x3c1/0x5c0 mm/vmscan.c:5547
> > > kswapd_shrink_node mm/vmscan.c:7288 [inline]
> > > balance_pgdat+0xca7/0x1ac0 mm/vmscan.c:7478
> > > kswapd+0x2a5/0x540 mm/vmscan.c:7738
> > > kthread+0x2eb/0x310 kernel/kthread.c:379
> > > ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> > >
> > > So, I have assigned CVE-2023-4610 to this defect.
> > >
> > > We will appreciate if this is notified to the upstream and if there are any patch suggestions identified.
> > >
> > > Regards,
> > > Rohit
> > 
> > Message-ID: <CALf2hKs61RkLpoMNb9b2Zcq-wHYnQceb6+s6sdG6E+a2Egx1CA@mail.gmail.com>
> > > Hi Rohit,
> > >
> > > Thanks for you attention to this issue. May I ask that is
> > > CVE-2023-4610 an internal cve of RedHat or a cve recognized by Mitre?
> > >
> > > Also, I would like to know if the latest status of this issue has been
> > > reported to Upstream? If not, do I need to forward all the previous
> > > messages to Upstream such as linux-kernel@vger.kernel.org?
> > >
> > > Best Regards,
> > > Zhiyu
> > 
> > Message-ID: <29561486.28558.1693805923362@app130155.ycg3.service-now.com>
> > > Hi Zhiyu,
> > >
> > > > May I ask that is CVE-2023-4610 an internal cve of RedHat or a cve recognized by Mitre?
> > >
> > > It is recognized by Mitre, so it is regular CVE for everyone. When you will discuss it with Upstream, please refer to this existing CVE num.
> > >
> > > > Also, I would like to know if the latest status of this issue has been reported to Upstream?
> > > > If not, do I need to forward all the previous messages to Upstream such as linux-kernel@vger.kernel.org?
> > >
> > > No, from Red Hat we didn't inform Upstream instead of you.
> > > We keep this one as embargoed currently (not visible outside of Red Hat).
> > > Please forward all the details to the Upstream ( I think linux-kernel@vger.kernel.org good to start with).
> > >
> > > Thank you,
> > > - Alexander Larkin
> > > Senior Product Security Engineer
> > 
> > Hope these would help you check and fix the problem.
> > 
> > Best regards,
> > Zhiyu Zhang
> > 
> > 
> > Zhang Zhiyu <zhiyuzhang999@gmail.com> 于2023年8月7日周一 23:54写道：
> > >
> > > Hi,
> > >
> > > I found a KASAN: slab-use-after-free Read in radix_tree_lookup while
> > > fuzzing Linux kernel 6.4-rc6 with my modified syzkaller in 24 July.
> > >
> > > The report, log, and config can be downloaded from:
> > > https://drive.google.com/file/d/1KiZCUHEyp-_Mbq8wdXvjPLs6KU-12JwM/view?usp=sharing
> > >
> > > Here is the bug-related key info:
> > >
> > > BUG: KASAN: slab-use-after-free in radix_tree_descend
> > > lib/radix-tree.c:87 [inline]
> > > BUG: KASAN: slab-use-after-free in __radix_tree_lookup
> > > lib/radix-tree.c:764 [inline]
> > > BUG: KASAN: slab-use-after-free in radix_tree_lookup+0x12d/0x290
> > > lib/radix-tree.c:817
> > > Read of size 8 at addr ffff8880675ab1a8 by task kswapd0/88
> > >
> > > I have preliminarily anlyzed the root cause. The suspected UAF Read is
> > > located in the __radix_tree_lookup function, which is part of the
> > > Radix Tree implementation in the Linux kernel. The condition check
> > > radix_tree_is_internal_node(node) in the while loop is used to verify
> > > if the node is an internal node. However, this check does not fully
> > > guarantee that the passed pointer node is always valid. If an invalid
> > > node pointer is passed to this function, it could lead to undefined
> > > behavior, potentially including a Use-After-Free Read.
> > >
> > > As this is a data race uaf, the syzkaller* cannot easily generate POC.
> > > I am still trying to construct a POC. By comparing the code of
> > > radix-tree.c, the vulnerability affects versions ranging from 6.4-rc6
> > > to the latest mainline.
> > >
> > > I recommend to patch it by adding invalid check of node in
> > > __radix_tree_lookup, if it is validated as a bug.
> > >
> > > Best. Have a good day!
> > > Zhiyu Zhang
> > 
