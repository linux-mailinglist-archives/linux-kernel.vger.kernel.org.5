Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB86765B48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjG0SRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjG0SRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:17:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C442D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Fi3QSFBo0i0/xtPE6s5L0fNHLLy9eZMDhKUHdEl8qzk=; b=JVbI90yGsrseV1uSb8iSHT5aaM
        a0duvEPMgF6vIDJ/N+QoAsOwhxq/ObRT0lq52bbyI/4ULZ7ZXTpmdLB+7Lr5dIOS8V6pymSZSqNRY
        Xv8ca92Ur3sfqyJTw/KKGbikxTwA/9HuOnfpz7Hrj4OH6Iww6My2uKEcI+ITrN/fACLWlbKQCb5Rc
        Jp+SDx+8dWcomnoQ3X9hwyA28khtlwMD7sBiQifvAuDczKbylnLB5/aGoFCaQRxutnPGDDeIZKhBL
        jcpWWsLZtBRsMOUPL4Kmwn7PvNo/yOMXOYCsCZRtOTol7nTqnX8tpMglgFusHgYbclF46xiGlAZGf
        L7URkahg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP5Xu-007kTL-FL; Thu, 27 Jul 2023 18:17:06 +0000
Date:   Thu, 27 Jul 2023 19:17:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <ZMK0ony0LG2SL2Ha@casper.infradead.org>
References: <000000000000607ff905ffc8e477@google.com>
 <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver>
 <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
 <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:59:33PM +0200, Jann Horn wrote:
> On Thu, Jul 27, 2023 at 7:22 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > Hmm. lock_vma_under_rcu() specifically checks for vma->anon_vma==NULL
> > condition (see [1]) to avoid going into find_mergeable_anon_vma() (a
> > check inside anon_vma_prepare() should prevent that). So, it should
> > fall back to mmap_lock'ing.
> 
> This syzkaller report applies to a tree with Willy's in-progress patch
> series, where lock_vma_under_rcu() only checks for vma->anon_vma if
> vma_is_anonymous() is true - it permits private non-anonymous VMAs
> (which require an anon_vma for handling write faults)  even if they
> don't have an anon_vma.
> 
> The commit bisected by syzkaller
> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a52f58b34afe095ebc5823684eb264404dad6f7b)
> removes the vma_is_anonymous() check in handle_pte_fault(), so it lets
> us reach do_wp_page() with a non-anonymous private VMA without
> anon_vma, even though that requires allocation of an anon_vma.
> 
> So I think this is pretty clearly an issue with Willy's in-progress
> patch series that syzkaller blamed correctly.

Agreed.  What do we think the right solution is?

Option 1:

+++ b/mm/memory.c
@@ -3197,6 +3197,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
        struct mmu_notifier_range range;
        int ret;

+       if (!vma->anon_vma) {
+               // check if there are other things to undo here
+               vma_end_read(vmf->vma);
+               return VM_FAULT_RETRY;
+       }
+
        delayacct_wpcopy_start();

Option 2:

@@ -5581,7 +5587,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
                goto inval;

        /* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-       if (vma_is_anonymous(vma) && !vma->anon_vma)
+       if ((vma_is_anonymous(vma) ||
+            vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) && !vma->anon_vma)
                goto inval;

The problem with option 2 is that we don't know whether this is a write
fault or not, so we'll handle read faults on private file
mappings under the mmap_lock UNTIL somebody writes to the mapping, which
might be never.  That seems like a bad idea.

We could pass FAULT_FLAG_WRITE into lock_vma_under_rcu(), but that also
seems like a bad idea.  I dunno.  Three bad ideas.  Anyone think of a
good one?
