Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCB7EE64E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjKPSAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKPSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:00:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00519B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700157640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8jO9uVCVvhZ4+F5Z/aAV+bkiow5OoBo+Ba5OJ/kTx4=;
        b=Dz61ZuJ7xrhM/C3GNBwyz4fxHpJkmBr8piEr+fH8irhJD8R9qT2xMAIjhsq2AtQ3OPZmbQ
        eeq7rQppyp5kUer0oX2vrUFdM/19skcX5zbpvUb8k/c1Ualvf2/J0Cq7mLI9CaAD1+Wa7V
        tESI3Vvxx/0XgEE93AtX4JVnZkvC81w=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-luK4ypuBPla2ZHok3z7KZg-1; Thu, 16 Nov 2023 13:00:37 -0500
X-MC-Unique: luK4ypuBPla2ZHok3z7KZg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7b9f985f88aso94237241.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157636; x=1700762436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8jO9uVCVvhZ4+F5Z/aAV+bkiow5OoBo+Ba5OJ/kTx4=;
        b=NNNPn5BwAun5MqaVWwFIG2bkTOWmuch+rq2X04d5vhJqSyW7erIsmOjR5R+AJ+Y2ba
         jfx7yvZMMQW7K3n5i722uO1A3uAbNMYU3pu5cleEa+TD19KZZZ8veLmxmhlYmywsvHMz
         go+qtB+g0DT7Du84QJi/cDfSa+5H7drbVdRBJbeXupvcmt62C43rLFodvvWmcVI2XJEC
         /8ef/gWX+22iZmTlXm9241ugvdlnZmW4g2FC4S4i3SnjO6z9jPOSje54mC6+LHo2z/Wq
         Q4xkwa9x5FxbH6dR3ucXM6HwMqp754EVX+/40Ylj5FPye1VG1ypWZ+O3LfwKlmp5i1o7
         jkHg==
X-Gm-Message-State: AOJu0YzMxEcodQsRDi14Gk+uVcP3fswpW7waQvYa9krLMc6uQTpjMPnr
        O8UaT38agdyagpNh96JnG0AZ0BvGkgvFj5uqP8IwwcoP6BV4eDECWlx8YI0LEQsk/t230gGeGYM
        NN0HcrClTVQG57MFNwbwLfuIM
X-Received: by 2002:a05:6102:829:b0:45d:980e:3ed3 with SMTP id k9-20020a056102082900b0045d980e3ed3mr9153563vsb.2.1700157634871;
        Thu, 16 Nov 2023 10:00:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjlx2i9Ecbtzr2CDgQi1gmLu8Y3djYZNYe6HZLBLTwmeOV8N9LjfNDVhKt20y4veYCOA4sOw==
X-Received: by 2002:a05:6102:829:b0:45d:980e:3ed3 with SMTP id k9-20020a056102082900b0045d980e3ed3mr9153205vsb.2.1700157632968;
        Thu, 16 Nov 2023 10:00:32 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id jy8-20020a0562142b4800b0065d0d0c752csm1529026qvb.116.2023.11.16.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:00:32 -0800 (PST)
Date:   Thu, 16 Nov 2023 13:00:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        wangkefeng.wang@huawei.com
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
Message-ID: <ZVZYvleasZddv-TD@x1n>
References: <000000000000b0e576060a30ee3b@google.com>
 <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
 <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8349273-c512-4d23-bf85-5812d2a007d1@redhat.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:19:13AM +0100, David Hildenbrand wrote:
> On 15.11.23 23:00, Andrew Morton wrote:
> > On Wed, 15 Nov 2023 05:32:19 -0800 syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ff3057680000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=7ca4b2719dc742b8d0a4
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162a25ff680000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d62338e80000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/00e30e1a5133/disk-ac347a06.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/07c43bc37935/vmlinux-ac347a06.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/c6690c715398/bzImage-ac347a06.xz
> > > 
> > > The issue was bisected to:
> > > 
> > > commit 12f6b01a0bcbeeab8cc9305673314adb3adf80f7
> > > Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > Date:   Mon Aug 21 14:15:15 2023 +0000
> > > 
> > >      fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag
> > 
> > Thanks.  The bisection is surprising, but the mentioned patch does
> > mess with pagemap.
> > 
> > How about we add this?
> > 
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: mm/memory.c:zap_pte_range() print bad swap entry
> > Date: Wed Nov 15 01:54:18 PM PST 2023
> > 
> > We have a report of this WARN() triggering.  Let's print the offending
> > swp_entry_t to help diagnosis.
> > 
> > Link: https://lkml.kernel.org/r/000000000000b0e576060a30ee3b@google.com
> > Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >   mm/memory.c |    1 +
> >   1 file changed, 1 insertion(+)
> > 
> > --- a/mm/memory.c~a
> > +++ a/mm/memory.c
> > @@ -1521,6 +1521,7 @@ static unsigned long zap_pte_range(struc
> >   				continue;
> >   		} else {
> >   			/* We should have covered all the swap entry types */
> > +			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
> >   			WARN_ON_ONCE(1);
> >   		}
> >   		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > _
> > 
> 
> I'm curious if
> 
> 1) make_uffd_wp_pte() won't end up overwriting existing pte markers, for
>    example, if PTE_MARKER_POISONED is set. [unrelated to this bug]

It should be fine, as:

static void make_uffd_wp_pte(struct vm_area_struct *vma,
			     unsigned long addr, pte_t *pte)
{
	pte_t ptent = ptep_get(pte);

#ifndef CONFIG_USERFAULTFD_

	if (pte_present(ptent)) {
		pte_t old_pte;

		old_pte = ptep_modify_prot_start(vma, addr, pte);
		ptent = pte_mkuffd_wp(ptent);
		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
	} else if (is_swap_pte(ptent)) {
		ptent = pte_swp_mkuffd_wp(ptent);
		set_pte_at(vma->vm_mm, addr, pte, ptent);
	} else {                                      <----------------- this must be pte_none() already
		set_pte_at(vma->vm_mm, addr, pte,
			   make_pte_marker(PTE_MARKER_UFFD_WP));
	}
}

> 
> 2) We get the error on arm64, which does *not* support uffd-wp. Do we
>    maybe end up calling make_uffd_wp_pte() and place a pte marker, even
>    though we don't have CONFIG_PTE_MARKER_UFFD_WP?
> 
> 
> static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
> {
> #ifdef CONFIG_PTE_MARKER_UFFD_WP
> 	return is_pte_marker_entry(entry) &&
> 	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
> #else
> 	return false;
> #endif
> }
> 
> Will always return false without CONFIG_PTE_MARKER_UFFD_WP.
> 
> But make_uffd_wp_pte() might just happily place an entry. Hm.
> 
> 
> The following might fix the problem:
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51e0ec658457..ae1cf19918d3 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1830,8 +1830,10 @@ static void make_uffd_wp_pte(struct vm_area_struct
> *vma,
>                 ptent = pte_swp_mkuffd_wp(ptent);
>                 set_pte_at(vma->vm_mm, addr, pte, ptent);
>         } else {
> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
>                 set_pte_at(vma->vm_mm, addr, pte,
>                            make_pte_marker(PTE_MARKER_UFFD_WP));
> +#endif
>         }
>  }

I'd like to double check with Muhammad (as I didn't actually follow his
work in the latest versions.. quite a lot changed), but I _think_
fundamentally we missed something important in the fast path, and I think
it applies even to archs that support uffd..

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e91085d79926..3b81baabd22a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2171,7 +2171,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
                return 0;
        }

-       if (!p->vec_out) {
+       if (!p->vec_out &&
+           (p->arg.flags & PM_SCAN_WP_MATCHING))
                /* Fast path for performing exclusive WP */
                for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
                        if (pte_uffd_wp(ptep_get(pte)))

There's yet another report in fs list that triggers other issues:

https://lore.kernel.org/all/000000000000773fa7060a31e2cc@google.com/

I'll think over that and I plan to prepare a small patchset to fix all I
saw.

Thanks,

-- 
Peter Xu

