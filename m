Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204307E7645
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbjKJBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbjKJBCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:02:12 -0500
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E072244B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:02:09 -0800 (PST)
X-AuditID: a67dfc5b-d85ff70000001748-cc-654d810e1540
Date:   Fri, 10 Nov 2023 10:02:01 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231110010201.GA72073@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <20231108041208.GA40954@system.software.com>
 <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsXC9ZZnkS5/o2+qQccaNos564HE5w3/2Cxe
        bGhntPi6/hezxdNPfSwWl3fNYbO4t+Y/q8X5XWtZLXYs3cdkcenAAiaL67seMloc7z3AZLF5
        01Rmi98/gOrmTLGyODlrMouDgMf31j4WjwWbSj02r9DyWLznJZPHplWdbB6bPk1i93h37hy7
        x4kZv1k8dj609Jh3MtDj/b6rbB5bf9l5fN4k5/Fu/lu2AL4oLpuU1JzMstQifbsEroz7x9qZ
        Ch6IV8yZeYupgXGBYBcjJ4eEgInElZUr2GDsvW3P2EFsFgFViSe9OxhBbDYBdYkbN34yg9gi
        AooSh/bfA4szC7xjlfj+SRPEFhaIlvi09xVYL6+AhUTXkkbWLkYuDiGB5UwS69pnskAkBCVO
        znzCAtGsLvFn3iWgoRxAtrTE8n8cEGF5ieats8F2cQrYSdyb0wlWLiqgLHFg23EmiDu3sUt0
        bk6CsCUlDq64wTKBUXAWkg2zkGyYhbBhFpINCxhZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIE
        xuyy2j/ROxg/XQg+xCjAwajEw3vhuk+qEGtiWXFl7iFGCQ5mJRHeCyZAId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYwa+w6t1JCeeI/DotLR916Qemap
        nd2ia40HH27yv960wqFiakqj7aVftm4zc39/sXyUL1m6s/ZGjdelG4x8f6sltm2L+Xjd8OZq
        /t+M89iXnvt78lnW26Xarhk1UXOfmn/QdSvXmcOYd9akbX0Wk+yL71c/24b4rviq/nKVDe9i
        KWaG4jMfIzOVWIozEg21mIuKEwFQEDrb1QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC5WfdrMvX6JtqsOekjsWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBn3j7UzFTwQr5gz8xZTA+MCwS5GTg4JAROJvW3P2EFsFgFViSe9OxhBbDYBdYkb
        N34yg9giAooSh/bfA4szC7xjlfj+SRPEFhaIlvi09xVYL6+AhUTXkkbWLkYuDiGB5UwS69pn
        skAkBCVOznzCAtGsLvFn3iWgoRxAtrTE8n8cEGF5ieats8F2cQrYSdyb0wlWLiqgLHFg23Gm
        CYx8s5BMmoVk0iyESbOQTFrAyLKKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMAaX1f6ZuIPx
        y2X3Q4wCHIxKPLwXrvukCrEmlhVX5h5ilOBgVhLhvWACFOJNSaysSi3Kjy8qzUktPsQozcGi
        JM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamA8F5Kf3SdX3HPMtXuRd5NwzyuuTdkH4qIvr+Rb
        emjvwyP7nz1Ov+uqGsZ9oFH6ieWnlRpVb44u/7by1oRe3ZrdLyJN1PVtvOPvKEYoOzpqTfn5
        JndqMvtbMT8B+bcNVQd4XOamTerasbPHPsrjBN8sLZ9PDbMYGTl/WdtPFw6IK1+w55r74UVK
        LMUZiYZazEXFiQClF+oAvQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:16:57AM +0000, Nadav Amit wrote:
> 
> 
> > On Nov 8, 2023, at 6:12 AM, Byungchul Park <byungchul@sk.com> wrote:
> > 
> > !! External Email
> > 
> > On Mon, Oct 30, 2023 at 09:51:30PM +0900, Byungchul Park wrote:
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 6c264d2f969c..75dc48b6e15f 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -3359,6 +3359,19 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >>>>  if (vmf->page)
> >>>>          folio = page_folio(vmf->page);
> >>>> 
> >>>> + /*
> >>>> +  * This folio has its read copy to prevent inconsistency while
> >>>> +  * deferring TLB flushes. However, the problem might arise if
> >>>> +  * it's going to become writable.
> >>>> +  *
> >>>> +  * To prevent it, give up the deferring TLB flushes and perform
> >>>> +  * TLB flush right away.
> >>>> +  */
> >>>> + if (folio && migrc_pending_folio(folio)) {
> >>>> +         migrc_unpend_folio(folio);
> >>>> +         migrc_try_flush_free_folios(NULL);
> >>> 
> >>> So many potential function calls… Probably they should have been combined
> >>> into one and at least migrc_pending_folio() should have been an inline
> >>> function in the header.
> >> 
> >> I will try to change it as you mention.
> >> 
> >>>> + }
> >>>> +
> >>> 
> >>> What about mprotect? I thought David has changed it so it can set writable
> >>> PTEs.
> >> 
> >> I will check it out.
> > 
> > I found mprotect stuff is already performing TLB flushes needed for it.
> > So some redundant TLB flushes might happen by migrc but it's not that
> > harmful I think. Thanks.
> 
> Let me explain the scenario I am concerned with. Assume page P is RO, and
> moves from Psrc to Pdst. Pointer “p” points to P. Initially (*p == 0).
> 
> Let’s also assume we also have an atomic variable “a”. Initially (a == 0).
> 
> I hope I got the migration function names right, but I hope the problem
> itself can be clear regardless. 
> 
> CPU0			CPU1			CPU2		CPU3
> ----			----			----		----
> 			(user-mode)		(user-mode)		
> 
> 			Access *p
> 			[Psrc cached in TLB]
>  
> migrate_pages_batch()
> -> migrate_folio_unmap()
> 
> [ PTE updated, 
>   still no flush ]
> 
> 								mprotect(p,
> 									RW)

Here,

mprotect()
   do_mprotect_pkey()
      tlb_finish_mmu()
         tlb_flush_mmu()

I thought TLB flush for mprotect() is performed by tlb_flush_mmu() so
any cached TLB entries on other CPUs can have chance to update. Could
you correct me if I get it wrong? Thanks.

	Byungchul

> 
> 								[ Psrc is
> 								  RW ]
> 
> 								[ flush
> 								  deferred]
> 
> 
> 						*p = 1  # Pdst
> 						
> 						xchg(&a, 1)
> 			mfence
> 			if (a == 1)
> 			  assert(*p == 1);
> 
> 
> 				
> Now at this point the assertion might fail. CPU2 wrote into Pdst, whereas
> CPU1 reads from Psrc. But based on x86 memory model, userspace might not
> expect this scenario to be possible, hence leading to bugs.
