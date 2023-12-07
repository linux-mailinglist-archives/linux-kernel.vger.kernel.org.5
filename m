Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0C807F24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjLGDWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGDWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:22:12 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236AE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:22:17 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4647ee28abeso89895137.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 19:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701919336; x=1702524136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYxCe4yU0FKmpZYmwJDLKxDE8nu9dh7yAm7+u55ixkw=;
        b=HW5tC5i1peXvtAREc/vQC0ugHP5w6hP0279xTCM8nTlYiPgrQ4JUNjpE1RWCFAtP0e
         iaJP0mliWjw92b81wwTQhzvoWJLSIIsGfrF8yLLTjqnkDLTigAl1ISPDjoPpLVumHGSM
         EIrXmZX9/M7mKvM4dQx6vcWX87X5Ko2aUxiGsDyrvdeDBxZAPTXSTXX5sBC9icLUic5K
         JjrbRnK9u9SWF8CQaosNvO1MHlN6ZH+UNpSDaQllGud651mcRTrNrRPsYKk4tTJNBckE
         O/kh/DaGWAuQ37m6hV4VTaroq3SnZqT+z+7l2h+lH0r+Y9JmGp0q0fTXMaacKVIokyyL
         f/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701919336; x=1702524136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYxCe4yU0FKmpZYmwJDLKxDE8nu9dh7yAm7+u55ixkw=;
        b=WJk2tpFzNxIlBY+zcAVjB2DgrOEKAQgcnTr15MjcrF3z2oXrU6gdLhte67uPk9ybO3
         8TdmebR81lnBGJ2TL5TRIx2f1EsTTkkCDq8w5a5XQbKUI1Xe60YzD3zci55JfQ7Ssa0a
         /UkFycdkKmY1AvrLxugD2HuecH/hpqUUE/LZDn94Ln23qZyiaoSS3Itrrun1QWE2Ia5P
         NbV3gQT/N5fEL96I/B7RYLeF2zGBhtOCF6MByEX7KmTTCX80MPYediCxft3XJvsWIKQr
         AH/xMfunL6lWkzOh2DtNaiZTYK9fezAQHhMuJU7DYm8J/zE+7lYHNXvXrkDAQj+w+qp0
         yHKA==
X-Gm-Message-State: AOJu0YzD1uoItVI8dUHHvZS8KTvRo7e/MaJox92fl2gooxxe1M7CeGBB
        SqKQEDTy43jSLlaZR5hkp7q1ZNUygzoPPp0wDXw=
X-Google-Smtp-Source: AGHT+IFRJ4+Mfjq4M96kB5QGwNTbMw7Nmtqi+RVd5aX9qOpV++hXfFuP/QcnG1XZh8L9oM24jIJy78shxe7bDTPQb2g=
X-Received: by 2002:a67:f250:0:b0:464:421c:a56b with SMTP id
 y16-20020a67f250000000b00464421ca56bmr1801288vsm.0.1701919336447; Wed, 06 Dec
 2023 19:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com> <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
 <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com> <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
 <e1e6dba5-8702-457e-b149-30b2e43156cf@redhat.com> <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
 <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
 <5de66ff5-b6c8-4ffc-acd9-59aec4604ca4@redhat.com> <bab848b8-edd3-4c57-9a96-f17a33e030d0@arm.com>
 <71c4b8b2-512a-4e50-9160-6ee77a5ec0a4@arm.com> <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
 <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com> <c5c82611-3153-4d56-b799-a1df3c953efe@redhat.com>
 <8aa8f095-1840-4a2e-ad06-3f375282ab6a@arm.com> <7065bbd3-64b3-4cd6-a2cd-146c556aac66@redhat.com>
In-Reply-To: <7065bbd3-64b3-4cd6-a2cd-146c556aac66@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 7 Dec 2023 16:22:05 +1300
Message-ID: <CAGsJ_4xR9HsXU-Sib6LF_KRJHpU38g8Xu33HGgogPAVbb=BKbg@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 3:16=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.11.23 13:14, Ryan Roberts wrote:
> > On 27/11/2023 12:01, David Hildenbrand wrote:
> >> On 27.11.23 12:56, Ryan Roberts wrote:
> >>> On 24/11/2023 18:14, Barry Song wrote:
> >>>> On Fri, Nov 24, 2023 at 10:55=E2=80=AFPM Steven Price <steven.price@=
arm.com> wrote:
> >>>>>
> >>>>> On 24/11/2023 09:01, Ryan Roberts wrote:
> >>>>>> On 24/11/2023 08:55, David Hildenbrand wrote:
> >>>>>>> On 24.11.23 02:35, Barry Song wrote:
> >>>>>>>> On Mon, Nov 20, 2023 at 11:57=E2=80=AFPM Ryan Roberts <ryan.robe=
rts@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 20/11/2023 09:11, David Hildenbrand wrote:
> >>>>>>>>>> On 17.11.23 19:41, Barry Song wrote:
> >>>>>>>>>>> On Fri, Nov 17, 2023 at 7:28=E2=80=AFPM David Hildenbrand <da=
vid@redhat.com>
> >>>>>>>>>>> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 17.11.23 01:15, Barry Song wrote:
> >>>>>>>>>>>>> On Fri, Nov 17, 2023 at 7:47=E2=80=AFAM Barry Song <21cnbao=
@gmail.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On Thu, Nov 16, 2023 at 5:36=E2=80=AFPM David Hildenbrand
> >>>>>>>>>>>>>> <david@redhat.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On 15.11.23 21:49, Barry Song wrote:
> >>>>>>>>>>>>>>>> On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbra=
nd
> >>>>>>>>>>>>>>>> <david@redhat.com>
> >>>>>>>>>>>>>>>> wrote:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> On 14.11.23 02:43, Barry Song wrote:
> >>>>>>>>>>>>>>>>>> This patch makes MTE tags saving and restoring support=
 large
> >>>>>>>>>>>>>>>>>> folios,
> >>>>>>>>>>>>>>>>>> then we don't need to split them into base pages for s=
wapping out
> >>>>>>>>>>>>>>>>>> on ARM64 SoCs with MTE.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> arch_prepare_to_swap() should take folio rather than p=
age as
> >>>>>>>>>>>>>>>>>> parameter
> >>>>>>>>>>>>>>>>>> because we support THP swap-out as a whole.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Meanwhile, arch_swap_restore() should use page paramet=
er rather
> >>>>>>>>>>>>>>>>>> than
> >>>>>>>>>>>>>>>>>> folio as swap-in always works at the granularity of ba=
se pages
> >>>>>>>>>>>>>>>>>> right
> >>>>>>>>>>>>>>>>>> now.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> ... but then we always have order-0 folios and can pass=
 a folio,
> >>>>>>>>>>>>>>>>> or what
> >>>>>>>>>>>>>>>>> am I missing?
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Hi David,
> >>>>>>>>>>>>>>>> you missed the discussion here:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4u=
DQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com/
> >>>>>>>>>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp=
5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com/
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Okay, so you want to handle the refault-from-swapcache ca=
se where you
> >>>>>>>>>>>>>>> get a
> >>>>>>>>>>>>>>> large folio.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I was mislead by your "folio as swap-in always works at t=
he
> >>>>>>>>>>>>>>> granularity of
> >>>>>>>>>>>>>>> base pages right now" comment.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> What you actually wanted to say is "While we always swap =
in small
> >>>>>>>>>>>>>>> folios, we
> >>>>>>>>>>>>>>> might refault large folios from the swapcache, and we onl=
y want to
> >>>>>>>>>>>>>>> restore
> >>>>>>>>>>>>>>> the tags for the page of the large folio we are faulting =
on."
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> But, I do if we can't simply restore the tags for the who=
le thing
> >>>>>>>>>>>>>>> at once
> >>>>>>>>>>>>>>> at make the interface page-free?
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Let me elaborate:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> IIRC, if we have a large folio in the swapcache, the swap
> >>>>>>>>>>>>>>> entries/offset are
> >>>>>>>>>>>>>>> contiguous. If you know you are faulting on page[1] of th=
e folio
> >>>>>>>>>>>>>>> with a
> >>>>>>>>>>>>>>> given swap offset, you can calculate the swap offset for =
page[0]
> >>>>>>>>>>>>>>> simply by
> >>>>>>>>>>>>>>> subtracting from the offset.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> See page_swap_entry() on how we perform this calculation.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> So you can simply pass the large folio and the swap entry
> >>>>>>>>>>>>>>> corresponding
> >>>>>>>>>>>>>>> to the first page of the large folio, and restore all tag=
s at once.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> So the interface would be
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> arch_prepare_to_swap(struct folio *folio);
> >>>>>>>>>>>>>>> void arch_swap_restore(struct page *folio, swp_entry_t st=
art_entry);
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I'm sorry if that was also already discussed.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This has been discussed. Steven, Ryan and I all don't thin=
k this is
> >>>>>>>>>>>>>> a good
> >>>>>>>>>>>>>> option. in case we have a large folio with 16 basepages, a=
s
> >>>>>>>>>>>>>> do_swap_page
> >>>>>>>>>>>>>> can only map one base page for each page fault, that means=
 we have
> >>>>>>>>>>>>>> to restore 16(tags we restore in each page fault) * 16(the=
 times of
> >>>>>>>>>>>>>> page
> >>>>>>>>>>>>>> faults)
> >>>>>>>>>>>>>> for this large folio.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> and still the worst thing is the page fault in the Nth PTE=
 of large
> >>>>>>>>>>>>>> folio
> >>>>>>>>>>>>>> might free swap entry as that swap has been in.
> >>>>>>>>>>>>>> do_swap_page()
> >>>>>>>>>>>>>> {
> >>>>>>>>>>>>>>         /*
> >>>>>>>>>>>>>>          * Remove the swap entry and conditionally try to =
free up the
> >>>>>>>>>>>>>> swapcache.
> >>>>>>>>>>>>>>          * We're already holding a reference on the page b=
ut haven't
> >>>>>>>>>>>>>> mapped it
> >>>>>>>>>>>>>>          * yet.
> >>>>>>>>>>>>>>          */
> >>>>>>>>>>>>>>          swap_free(entry);
> >>>>>>>>>>>>>> }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> So in the page faults other than N, I mean 0~N-1 and N+1 t=
o 15, you
> >>>>>>>>>>>>>> might
> >>>>>>>>>>>>>> access
> >>>>>>>>>>>>>> a freed tag.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> And David, one more information is that to keep the paramet=
er of
> >>>>>>>>>>>>> arch_swap_restore() unchanged as folio,
> >>>>>>>>>>>>> i actually tried an ugly approach in rfc v2:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +void arch_swap_restore(swp_entry_t entry, struct folio *fo=
lio)
> >>>>>>>>>>>>> +{
> >>>>>>>>>>>>> + if (system_supports_mte()) {
> >>>>>>>>>>>>> +      /*
> >>>>>>>>>>>>> +       * We don't support large folios swap in as whole ye=
t, but
> >>>>>>>>>>>>> +       * we can hit a large folio which is still in swapca=
che
> >>>>>>>>>>>>> +       * after those related processes' PTEs have been unm=
apped
> >>>>>>>>>>>>> +       * but before the swapcache folio  is dropped, in th=
is case,
> >>>>>>>>>>>>> +       * we need to find the exact page which "entry" is m=
apping
> >>>>>>>>>>>>> +       * to. If we are not hitting swapcache, this folio w=
on't be
> >>>>>>>>>>>>> +       * large
> >>>>>>>>>>>>> +     */
> >>>>>>>>>>>>> + struct page *page =3D folio_file_page(folio, swp_offset(e=
ntry));
> >>>>>>>>>>>>> + mte_restore_tags(entry, page);
> >>>>>>>>>>>>> + }
> >>>>>>>>>>>>> +}
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> And obviously everybody in the discussion hated it :-)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> I can relate :D
> >>>>>>>>>>>>
> >>>>>>>>>>>>> i feel the only way to keep API unchanged using folio is th=
at we
> >>>>>>>>>>>>> support restoring PTEs
> >>>>>>>>>>>>> all together for the whole large folio and we support the s=
wap-in of
> >>>>>>>>>>>>> large folios. This is
> >>>>>>>>>>>>> in my list to do, I will send a patchset based on Ryan's la=
rge anon
> >>>>>>>>>>>>> folios series after a
> >>>>>>>>>>>>> while. till that is really done, it seems using page rather=
 than folio
> >>>>>>>>>>>>> is a better choice.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I think just restoring all tags and remembering for a large =
folio that
> >>>>>>>>>>>> they have been restored might be the low hanging fruit. But =
as always,
> >>>>>>>>>>>> devil is in the detail :)
> >>>>>>>>>>>
> >>>>>>>>>>> Hi David,
> >>>>>>>>>>> thanks for all your suggestions though my feeling is this is =
too
> >>>>>>>>>>> complex and
> >>>>>>>>>>> is not worth it for at least  three reasons.
> >>>>>>>>>>
> >>>>>>>>>> Fair enough.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> 1. In multi-thread and particularly multi-processes, we need =
some
> >>>>>>>>>>> locks to
> >>>>>>>>>>> protect and help know if one process is the first one to rest=
ore tags
> >>>>>>>>>>> and if
> >>>>>>>>>>> someone else is restoring tags when one process wants to rest=
ore. there
> >>>>>>>>>>> is not this kind of fine-grained lock at all.
> >>>>>>>>>>
> >>>>>>>>>> We surely always hold the folio lock on swapin/swapout, no? So=
 when these
> >>>>>>>>>> functions are called.
> >>>>>>>>>>
> >>>>>>>>>> So that might just work already -- unless I am missing somethi=
ng
> >>>>>>>>>> important.
> >>>>>>>>>
> >>>>>>>>> We already have a page flag that we use to mark the page as hav=
ing had
> >>>>>>>>> its mte
> >>>>>>>>> state associated; PG_mte_tagged. This is currently per-page (an=
d IIUC,
> >>>>>>>>> Matthew
> >>>>>>>>> has been working to remove as many per-page flags as possible).=
 Couldn't
> >>>>>>>>> we just
> >>>>>>>>> make arch_swap_restore() take a folio, restore the tags for *al=
l* the
> >>>>>>>>> pages and
> >>>>>>>>> repurpose that flag to be per-folio (so head page only)? It loo=
ks like
> >>>>>>>>> the the
> >>>>>>>>> mte code already manages all the serialization requirements too=
. Then
> >>>>>>>>> arch_swap_restore() can just exit early if it sees the flag is =
already
> >>>>>>>>> set on
> >>>>>>>>> the folio.
> >>>>>>>>>
> >>>>>>>>> One (probably nonsense) concern that just sprung to mind about =
having
> >>>>>>>>> MTE work
> >>>>>>>>> with large folios in general; is it possible that user space co=
uld cause
> >>>>>>>>> a large
> >>>>>>>>> anon folio to be allocated (THP), then later mark *part* of it =
to be
> >>>>>>>>> tagged with
> >>>>>>>>> MTE? In this case you would need to apply tags to part of the f=
olio only.
> >>>>>>>>> Although I have a vague recollection that any MTE areas have to=
 be
> >>>>>>>>> marked at
> >>>>>>>>> mmap time and therefore this type of thing is impossible?
> >>>>>>>>
> >>>>>>>> right, we might need to consider only a part of folio needs to b=
e
> >>>>>>>> mapped and restored MTE tags.
> >>>>>>>> do_swap_page() can have a chance to hit a large folio but it onl=
y
> >>>>>>>> needs to fault-in a page.
> >>>>>>>>
> >>>>>>>> A case can be quite simple as below,
> >>>>>>>>
> >>>>>>>> 1. anon folio shared by process A and B
> >>>>>>>> 2. add_to_swap() as a large folio;
> >>>>>>>> 3. try to unmap A and B;
> >>>>>>>> 4. after A is unmapped(ptes become swap entries), we do a
> >>>>>>>> MADV_DONTNEED on a part of the folio. this can
> >>>>>>>> happen very easily as userspace is still working in 4KB level;
> >>>>>>>> userspace heap management can free an
> >>>>>>>> basepage area by MADV_DONTNEED;
> >>>>>>>> madvise(address, MADV_DONTNEED, 4KB);
> >>>>>>>> 5. A refault on address + 8KB, we will hit large folio in
> >>>>>>>> do_swap_page() but we will only need to map
> >>>>>>>> one basepage, we will never need this DONTNEEDed in process A.
> >>>>>>>>
> >>>>>>>> another more complicated case can be mprotect and munmap a part =
of
> >>>>>>>> large folios. since userspace
> >>>>>>>> has no idea of large folios in their mind, they can do all stran=
ge
> >>>>>>>> things. are we sure in all cases,
> >>>>>>>> large folios have been splitted into small folios?
> >>>>>>
> >>>>>> I don;'t think these examples you cite are problematic. Although u=
ser space
> >>>>>> thinks about things in 4K pages, the kernel does things in units o=
f folios.
> >>>>>> So a
> >>>>>> folio is either fully swapped out or not swapped out at all. MTE t=
ags can be
> >>>>>> saved/restored per folio, even if only part of that folio ends up =
being mapped
> >>>>>> back into user space.
> >>>>
> >>>> I am not so optimistic :-)
> >>>>
> >>>> but zap_pte_range() due to DONTNEED on a part of swapped-out folio c=
an
> >>>> free a part of swap
> >>>> entries? thus, free a part of MTE tags in a folio?
> >>>> after process's large folios are swapped out, all PTEs in a large
> >>>> folio become swap
> >>>> entries, but DONTNEED on a part of this area will only set a part of
> >>>> swap entries to
> >>>> PTE_NONE, thus decrease the swapcount of this part?
> >>>>
> >>>> zap_pte_range
> >>>>       ->
> >>>>             entry =3D pte_to_swp_entry
> >>>>                     -> free_swap_and_cache(entry)
> >>>>                         -> mte tags invalidate
> >>>
> >>> OK I see what you mean.
> >>>
> >>> Just trying to summarize this, I think there are 2 questions behind a=
ll this:
> >>>
> >>> 1) Can we save/restore MTE tags on at the granularity of a folio?
> >>>
> >>> I think the answer is no; we can enable MTE on a individual pages wit=
hin a folio
> >>> with mprotect, and we can throw away tags on individual pages as you =
describe
> >>> above. So we have to continue to handle tags per-page.
> >>
> >> Can you enlighten me why the scheme proposed by Steven doesn't work?
> >
> > Are you referring to Steven's suggestion of reading the tag to see if i=
t's
> > zeros? I think that demonstrates my point that this has to be done per-=
page and
>
> Yes.
>
> > not per-folio? I'm also not sure what it buys us - instead of reading a=
 per-page
> > flag we now have to read 128 bytes of tag for each page and check its z=
ero.
>
> My point is, if that is the corner case, we might not care about that.

Hi David,
my understanding is that this is NOT a corner. Alternatively, it is
really a common case.

1. a large folio can be partially unmapped when it is in swapche and
after it is swapped out
in all cases, its tags can be partially invalidated. I don't think
this is a corner case, as long
as userspaces are still working at the granularity of basepages, this
is always going to
happen. For example, userspace libc such as jemalloc can identify
PAGESIZE, and use
madvise(DONTNEED) to return memory to the kernel. Heap management is
still working
at the granularity of the basepage.

2. mprotect on a part of a large folio as Steven pointed out.

3.long term, we are working to swap-in large folios as a whole[1] just
like swapping out large
folios as a whole. for those ptes which are still contiguous swap
entries, i mean, which
are not unmapped by userspace after the large folios are swapped out
to swap devices,
we have a chance to swap in a whole large folio, we do have a chance
to restore tags
for the large folio without early-exit. but we still have a good
chance to fall back to base
page if we fail to allocate large folio, in this case, do_swap_page()
still works at the
granularity of basepage. and do_swap_page() will call swap_free(entry),  ta=
gs of

this particular page can be invalidated as a result.

4. too many early-exit might be negative to performance.


So I am thinking that in the future, we need two helpers,
1. void __arch_swap_restore(swp_entry_t entry, struct page *page);
this is always needed to support page-level tag restore.

2.  void arch_swap_restore(swp_entry_t entry, struct folio *folio);
this can be a helper when we are able to swap in a whole folio. two
conditions must be met
(a). PTEs entries are still contiguous swap entries just as when large
folios were swapped
out.
(b). we succeed in the allocation of a large folio in do_swap_page.

For this moment, we only need 1; we will add 2 in swap-in large folio serie=
s.

What do you think?

[1] https://lore.kernel.org/linux-mm/CAGsJ_4zyhqwUS26bbx0a95rSO0jVANfC_RWdy=
TFbJQQG5KJ_cg@mail.gmail.com/

>
> >
> >>
> >> I mean, having a mixture of tagged vs. untagged is assumed to be the c=
orner
> >> case, right?
> >
> > Yes. But I'm not sure how we exploit that; I guess we could have a per-=
folio
> > flag; when set it means the whole folio is tagged and when clear it mea=
ns fall
> > back to checking the per-page flag?
>
> Let me think this through. We have the following states:
>
> 1) Any subpage is possibly logically tagged and all relevant tags are
>     applied/restored.
> 2) Any subpage is possibly logically tagged, and all relevant tags are
>     not applied but stored in the datastructure.
> 3) No subpage is logically tagged.
>
> We can identify in 1) the subpages by reading the tag from HW, and on 2)
> by checking the datastructure. For 3), there is nothing to check.
>
> On swapout of a large folio:
>
> * For 3) we don't do anything
> * For 2) we don't do anything
> * For 1) we store all tags that are non-zero (reading all tags) and
>    transition to 2).
>
> On swapin of a large folio
>
> A) Old folio (swapcache)
>
> If in 1) or 3) already, nothing to do.
>
> If in 2), restore all tags that are in the datastructure and move to 1).
> Nothing to do for 1
>
> b) Fresh folio (we lost any MTE marker)
>
> Currently always order-0, so nothing to do. We'd have to check the
> datastructure for any tag part of the folio and set the state accordingly=
.
>
>
> Of course, that means that on swapout, you read all tags. But if the
> common case is that all subpages have tags, we don't really care.
>
> I'm sure I made a mistake somewhere, but where? :)
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry
