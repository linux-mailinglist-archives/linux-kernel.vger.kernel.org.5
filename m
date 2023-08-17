Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570DC77FBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353672AbjHQQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353660AbjHQQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:22:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8135A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:22:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15048a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692289326; x=1692894126;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ena0p3NSggEqk+vk2x8D1QzEktiYk6xgHB3uHWeBhi8=;
        b=SbZ/dxJ8cwYpJxoocaE7f2Go7xFhUfdGxmUCICEpIF+LUY1Sw5dmsA3cla8FSDaDBs
         cHd0/Qe8qHP/TJ4P+LHVcofX7+U+Sj4HVIuTCGPRP5E52jXO5CJerPNNX5TB7MwrOS14
         KPyFphqn/szOAEgUDOagIUHLHyUw0jvdSrvxGV8Wcgr+LrVc5ZGY1EQbgUKVnYG49z1n
         +HgjyvrSDyk6xjycgAUIzOm2CN918EO2580QD4lC72pvbDawOoovKWaeRwzu/tXuLAWz
         O9OstIcjqa3MmzRrAshYvrGaK8Gb2y6or/yOmmcSprjj+PgZKyXApx0ri+GMdPG7o4GO
         Fb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289326; x=1692894126;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ena0p3NSggEqk+vk2x8D1QzEktiYk6xgHB3uHWeBhi8=;
        b=g/EzEOjIDI++AiWUtcVGU50GNUrdlDsFzooG6VTfH/9GAVNCgcbWIjce0IbH813F2r
         WYSR6s9xqf/QwMU1ypLiddWjxy6HHX/fcTkNA57X8W4h0lPtSRFVPJPhJm1b96GWcpTg
         MNSsIzzB4MsGNq+2aXN536+xZBBxMNO7iFMv1LCPGdN0aMMqv9ABDQJu1IbRK2g1IGly
         Sf8ZsyGL9Ya0qvYPjvWBnPXh8m/UJ9p23SICc5gpDK8067p8ff2yUxRgH7DIBNghosG0
         2Z0JsZeh+1s6yYXLPuqHn8N64umsp2DI3G+ntHgs9LjH5wEZUj2n74+ZHPEYNUIy/r6s
         8OIg==
X-Gm-Message-State: AOJu0YzpKbhB8VpzwWolWeHjpB4pVB1LDjk/Yg5zzl6f+n5o1e8KLYb8
        wMJWnxed2CgXPtTrYMWOvOtPgDJ/bV9CPk96O3zBYA==
X-Google-Smtp-Source: AGHT+IEvc1Iar/eaWxd/s2yjVp8hczH15UMlGe3dZN9WEzzOh/gJ+w0h2ykqzhK03+HThMRgHhE58Px4a4PA5KN1KM0=
X-Received: by 2002:a50:9ee2:0:b0:51a:1ffd:10e with SMTP id
 a89-20020a509ee2000000b0051a1ffd010emr87129edf.3.1692289326180; Thu, 17 Aug
 2023 09:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1KYR9pY1s0=9QH_n5cY-_Zejajj2JEa-se=UZQbeN4hw@mail.gmail.com>
 <20230817134231.xji3i6w7ev3rbs52@revolver>
In-Reply-To: <20230817134231.xji3i6w7ev3rbs52@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 17 Aug 2023 18:21:29 +0200
Message-ID: <CAG48ez1oL+a1pnXUL_3oPWSFa9QLB2-kcUh1jObGM4bZTqgv7g@mail.gmail.com>
Subject: Re: [mm] VMA merging behavior wrt anon_vma has been slightly broken
 since Linux 3.0 (in a non-dangerous way)
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shaohua Li <shaohua.li@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 3:42=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * Jann Horn <jannh@google.com> [230815 15:44]:
> > Hi!
> >
> > I think VMA merging was accidentally nerfed a bit by commit
> > 965f55dea0e3 ("mmap: avoid merging cloned VMAs"), which landed in
> > Linux 3.0 - essentially, that commit makes it impossible to merge a
> > VMA with an anon_vma into an adjacent VMA that does not have an
> > anon_vma. (But the other direction works.)
> >
> >
> > is_mergeable_anon_vma() is defined as:
> >
> > ```
> > static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
> >                  struct anon_vma *anon_vma2, struct vm_area_struct *vma=
)
> > {
> >         /*
> >          * The list_is_singular() test is to avoid merging VMA cloned f=
rom
> >          * parents. This can improve scalability caused by anon_vma loc=
k.
> >          */
> >         if ((!anon_vma1 || !anon_vma2) && (!vma ||
> >                 list_is_singular(&vma->anon_vma_chain)))
> >                 return true;
> >         return anon_vma1 =3D=3D anon_vma2;
> > }
> > ```
> >
> > If this function is called with a non-NULL vma pointer (which is
> > almost always the case, except when checking for whether it's possible
> > to merge in both directions at the same time),
>
> You are talking about case 1 & 6 here?

Yeah, about the third call to is_mergeable_anon_vma() in those cases.

> To get here merge_prev and
> merge_next must be set.. which means can_vma_merge_after() and
> can_vma_merge_before() must succeed.. which means
> is_mergeable_anon_vma() returned true with both prev and next being
> passed through as "vma".  So, I think, even that case suffers the same
> issue?

Right, my intent was to talk about individual callers of vma_merge().

> That is, we won't have merge_prev =3D=3D true if prev has an empty
> anon_vma_chain.  The same is true for merge_next.
>
> >and one of the two
> > anon_vmas is non-NULL, this returns
> > list_is_singular(&vma->anon_vma_chain). I believe that
> > list_is_singular() call is supposed to check whether the
> > anon_vma_chain contains *more than one* element, but it actually also
> > fails if the anon_vma_chain contains zero elements.
> >
> > This means that the dup_anon_vma() calls in vma_merge() are
> > effectively all no-ops because they are never called with a target
> > that does not have an anon_vma and a source that has an anon_vma.
> >
> > I think this is unintentional - though I guess this unintentional
> > refusal to merge VMAs this way also lowers the complexity of what can
> > happen in the VMA merging logic. So I think the right fix here is to
> > make this kind of merging possible again by changing
> > "list_is_singular(&vma->anon_vma_chain)" to
> > "list_empty(&vma->anon_vma_chain) ||
> > list_is_singular(&vma->anon_vma_chain)", but my security hat makes me
> > say that I'd also be happy if the unintentional breakage stayed this
> > way it is now.
>
> The commit message for the offending change says
> find_mergeable_anon_vma() already considers merging these, so it may not
> be as nerfed as it looks?

Ah, right, that should reduce the impact a lot.

> From what I understand the merging is an optimisation and, from the
> commit message,  the change was to increase scalability

Yes, my understanding is that it was to increase scalability by
avoiding merging VMAs when that would cause more use of an anon_vma
that is shared with other processes.

 - An empty anon_vma_chain means we have no anon_vma.
 - An anon_vma_chain with a single element means we have an anon_vma
that is private to our process.
 - An anon_vma_chain with more than one element is likely shared with
other processes.

My understanding is that the scalability issue probably comes mainly
from having multiple processes hitting the same anon_vma lock during
operations under the mmap lock in write mode; that wouldn't be a
problem for same-process sharing. There might also be some scalability
impact from this kind of situation, although probably less because
AFAIU rmap walks aren't needed for much hotpath stuff:

 - Process P1 creates a VMA V1, covering range A1-A2, with a new anon_vma A=
V1
 - Process P1 forks a child process P2
   - P2 inherits a copy of V1 called V1', with two anon_vmas:
     - AV1 (inherited)
     - AV2 (used for new pages)
 - P1 extends VMA V1, now it covers range A1-A3
 - let's hypothetically assume that P2 extends VMA V1', now also
covering range A1-A3
 - P1 inserts a page somewhere in the range A2-A3, it gets attached to AV1
 - now if we have to do an rmap walk on the page, this unnecessarily
requires walking the page tables of both P1 and P2

Basically merging VMAs with anon_vma_chains of length >1 could easily
lead to some kind of false sharing for rmap walks of pages mapped in
the parent, which is probably undesirable especially in cases where a
process forks off a lot of children. This sort of situation is
probably harder to trigger in a single-process scenario with a
length-1 AVC, since you'd have to be splitting VMAs and moving them
around with mremap() and extending them with mremap() to have
overlapping ranges in the interval tree.

My understanding is that essentially, in a process that is not going
to fork (or constantly move VMAs around), it would be fine to have
more or less a single anon_vma for all anonymous VMAs; that just means
rmap walks will have to do O(log(number_of_vmas)) steps through the
anon_vma interval tree. In a process that forks, doing so would mean
that operations like VMA expansion and unmapping on inherited VMAs in
all the children would involve taking a shared lock - that'd probably
still be mostly fine, I guess? But if children kept merging new VMAs
into the parent's anon_vma, all their VMA modification operations
would all hit the same lock, which would be bad.

(By the way, we also depend on not merging VMAs with more than one
anon_vma_chain entry for correctness/security, see commit 2555283eb40d
"mm/rmap: Fix anon_vma->degree ambiguity leading to double-reuse".)

> so this shifts
> to using more memory to gain scalability on the anon_vma lock.  Making
> this change will shift back to (maybe?) less memory for more pressure on
> that lock then?  I am hesitant to suggest un-nerfing it, but it
> shouldn't be left as it is since the code is unclear on what is
> happening.
