Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED227849C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjHVSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHVSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:54:47 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF425CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:54:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d77b9d574f8so114527276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692730485; x=1693335285;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC4FoWXo6SNQKwsXxt28KsctazZB0KZm2Dgg9LreMAM=;
        b=1YIoFqVN55j3XEBWw5UYnqxvNjoz+koElbxuVIP/CJlJ0hkI9N8eMY39So2s6Zh8e0
         lYOJwoMEQBCBGM9ObvuUJ43RLHkBTQhPIi4D2e21eC0WOzSMo3w6Pej51GXssjJncxsr
         40V/Mu1pMG/D3T0D49sODOZIfKYGqNqFAaOkTMSHTKzO6xb16qy4PWhFgzJJXzDEWNDd
         syAPBovHWWRT8jV5/JwCsG9j6lWmyoq166pYQYj+5LjUZx2PNOAhbu+jAuVXXYMq6btV
         oWcKnK9p1XjuZsNocTtOJIfHWsLUDWxxgnOuAfTnpiEG8/nc/26eHsq/XlCM+fMpNl17
         lGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730485; x=1693335285;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC4FoWXo6SNQKwsXxt28KsctazZB0KZm2Dgg9LreMAM=;
        b=JlHDUEGe/oqZarYgLHVvCvmg+1isqWu2W8n4nHn+Eatsq+TRGe0xyC1zfCT4huNFgZ
         R76zg23QF2CgrBWBQxDPErMeXkEEtKR5309UnslttETSw7Cispoi8tFusUwrXjn+jTK1
         o6U5/hgP83gsBhRXJC6eeKOQlFRDhIrG7+ZTLE1vQJvzkqjMfq8OREpK+q4pkG19dQlE
         Pyi+InpZZl89jLUi3/A8b0PsormasZI592w1m+N6mi3mlC2jipjsYA8QhQ9A6PAZx7/s
         niRDEKjAB2wgxtcPo/XY555t2R51ZICxrBZ6Z/pHA7uS00tiBCtS0dEqy5pHwAJQLCJh
         XoLQ==
X-Gm-Message-State: AOJu0YzMuWtwoooWL2aCTFTrcbaCRk03XYa/zH6fZl0PbN+5nqeqbIzQ
        UTHTOwKp/PyQq7jYBP6w2CIAMg==
X-Google-Smtp-Source: AGHT+IFpHQvIMwN5WYlfI56GAofuwQT9IU67DR/OnesR0CbZe8XpbWpAMdSzZjh6aZoI7atOZrgvQQ==
X-Received: by 2002:a81:4843:0:b0:583:2df2:35f3 with SMTP id v64-20020a814843000000b005832df235f3mr9917420ywa.1.1692730484669;
        Tue, 22 Aug 2023 11:54:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r64-20020a815d43000000b00545a08184cesm2915469ywb.94.2023.08.22.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:54:44 -0700 (PDT)
Date:   Tue, 22 Aug 2023 11:54:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jann Horn <jannh@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
In-Reply-To: <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
Message-ID: <82d294-c9b0-d7b4-71c9-cfed3925c47b@google.com>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com> <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com> <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com> <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-405531799-1692730484=:3162"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-405531799-1692730484=:3162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 Aug 2023, Jann Horn wrote:
> On Tue, Aug 22, 2023 at 4:51=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > On Mon, 21 Aug 2023, Jann Horn wrote:
> > > On Mon, Aug 21, 2023 at 9:51=E2=80=AFPM Hugh Dickins <hughd@google.co=
m> wrote:
> > > > Just for this case, take the pmd_lock() two steps earlier: not beca=
use
> > > > it gives any protection against this case itself, but because ptloc=
k
> > > > nests inside it, and it's the dropping of ptlock which let the bug =
in.
> > > > In other cases, continue to minimize the pmd_lock() hold time.
> > >
> > > Special-casing userfaultfd like this makes me a bit uncomfortable; bu=
t
> > > I also can't find anything other than userfaultfd that would insert
> > > pages into regions that are khugepaged-compatible, so I guess this
> > > works?
> >
> > I'm as sure as I can be that it's solely because userfaultfd breaks
> > the usual rules here (and in fairness, IIRC Andrea did ask my permissio=
n
> > before making it behave that way on shmem, COWing without a source page=
).
> >
> > Perhaps something else will want that same behaviour in future (it's
> > tempting, but difficult to guarantee correctness); for now, it is just
> > userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
> > expecting uffd to add more such exceptional modes in future).
>=20
> Hm, yeah, sounds okay. (I guess we'd also run into this if we ever
> wanted to make it possible to reliably install PTE markers with
> madvise() or something like that, which might be nice for allowing
> userspace to create guard pages without unnecessary extra VMAs...)

I see the mailthread has taken inspiration from your comment there,
and veered off in that direction: but I'll ignore those futures.

>=20
> > > I guess an alternative would be to use a spin_trylock() instead of th=
e
> > > current pmd_lock(), and if that fails, temporarily drop the page tabl=
e
> > > lock and then restart from step 2 with both locks held - and at that
> > > point the page table scan should be fast since we expect it to usuall=
y
> > > be empty.
> >
> > That's certainly a good idea, if collapse on userfaultfd_armed private
> > is anything of a common case (I doubt, but I don't know).  It may be a
> > better idea anyway (saving a drop and retake of ptlock).
>=20
> I was thinking it also has the advantage that it would still perform
> okay if we got rid of the userfaultfd_armed() condition at some point
> - though I realize that designing too much for hypothetical future
> features is an antipattern.
>=20
> > I gave it a try, expecting to end up with something that would lead
> > me to say "I tried it, but it didn't work out well"; but actually it
> > looks okay to me.  I wouldn't say I prefer it, but it seems reasonable,
> > and no more complicated (as Peter rightly observes) than the original.
> >
> > It's up to you and Peter, and whoever has strong feelings about it,
> > to choose between them: I don't mind (but I shall be sad if someone
> > demands that I indent that comment deeper - I'm not a fan of long
> > multi-line comments near column 80).
>=20
> I prefer this version because it would make it easier to remove the
> "userfaultfd_armed()" check in the future if we have to, but I guess
> we could also always change it later if that becomes necessary, so I
> don't really have strong feelings on it at this point.

Thanks for considering them both, Jann.  I do think your trylock way,
as in v2, is in principle superior, and we may well have good reason
to switch over to it in future; but I find it slightly more confusing,
so will follow your and Peter's "no strong feelings" for now, and ask
Andrew please to take the original (implicit v1).

Overriding reason: I realized overnight that v2 is not quite correct:
I was clever enough to realize that nr_ptes needed to be reset to 0
to get the accounting right with a recheck pass, but not clever enough
to realize that resetting it to 0 there would likely skip the abort
path's flush_tlb_mm(mm), when we actually had cleared entries on the
first pass.  It needs a separate bool to decide the flush_tlb_mm(mm),
or it needs that (ridiculously minor!) step 3 to be moved down.

But rather than reworking it, please let's just go with v1 for now.

Thanks,
Hugh
---1463760895-405531799-1692730484=:3162--
