Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60FE765617
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjG0OkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjG0OkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:40:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3B2D47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:40:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so95355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690468811; x=1691073611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy3ot5QcIIA3cfo4DH/Mcif4JvZoxXny17t2aC1892Y=;
        b=W8gG6bj40pYSiJWmg0l6d6qbgvSnGWdsy5vFfsA4gtUo9YqAVT4cnZwCMH5WxY5JFp
         +fZGxgdjUhm/1U3bA71MnBvXQGrFd3QIrDGBMJoaqL0220+sBaM1SaWhOzIYnGOVkUEN
         pIh3YWjA06CY5cf+dqHXDeRZ5HkTHTR9wPEGkDltvJPzChaj9a1p0evvggs7ZRr3flkP
         K0NLQY5RY+nLw3NPKw5oTAeG1q6DxQJo3D9Zo16Gh6P47smMIFa4vr0y/hin2vvpG9fA
         tbSqMjOvQ5hlN9V1kc0mT6yuLwCxyvW6ZrVWh5BYyt1BiLGRgnKuQIVhatupgjI+JEaP
         3qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468811; x=1691073611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy3ot5QcIIA3cfo4DH/Mcif4JvZoxXny17t2aC1892Y=;
        b=aiBHh73Jq0UtjmqLrfTjzQJ7UNbvhFgOMama33JsGn5dDi4TGNDBT6j1xDnkiJe4lD
         gsgfyg8856lbLulhtHkICK0ouMXaib+zE5ni1qVmu82SvwIhYCpMcZwWD7I+hRSrHFQM
         pc8u40oylkYzd6D0jVLe3NZESe9Se5MCvnvDRt5bhi0OibOA1nuOeuo/6u2h85hQHJpR
         abKwWNoNCJK/k+fNmh+EExmZ6jqC7bAZm2cUe6l44cwl19J+dnOF/SCfd8bQydiIIhd9
         wMPX7UgqcxUrttVNXkY0Un3pJVXeiI7SLcoA4V6mYPKMCBi/3sXyLdO3YaHg0QotWi5A
         rDmg==
X-Gm-Message-State: ABy/qLZ3ScB1nTocLsg3JQa/RrQWcVYwkqoUGKRNddmetjKT2u3We5fq
        mciWU2lHctAxFV/FOXF7Xw9vlXBMuawIdevVnFtEBw==
X-Google-Smtp-Source: APBJJlGoKupT7bYrhLOrGrQZmXu42rkmk1BYWAGKbC0h2ROAaqiUpU+j7JdfoA6S2Xtip8uNKxV9v7h9ABXhiphZ4S4=
X-Received: by 2002:a05:600c:880c:b0:3fc:75d:8f85 with SMTP id
 gy12-20020a05600c880c00b003fc075d8f85mr101578wmb.6.1690468810800; Thu, 27 Jul
 2023 07:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
In-Reply-To: <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Jul 2023 16:39:34 +0200
Message-ID: <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     paulmck@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 1:19=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Jul 26, 2023 at 11:41:01PM +0200, Jann Horn wrote:
> > Hi!
> >
> > Patch 1 here is a straightforward fix for a race in per-VMA locking cod=
e
> > that can lead to use-after-free; I hope we can get this one into
> > mainline and stable quickly.
> >
> > Patch 2 is a fix for what I believe is a longstanding memory ordering
> > issue in how vma->anon_vma is used across the MM subsystem; I expect
> > that this one will have to go through a few iterations of review and
> > potentially rewrites, because memory ordering is tricky.
> > (If someone else wants to take over patch 2, I would be very happy.)
> >
> > These patches don't really belong together all that much, I'm just
> > sending them as a series because they'd otherwise conflict.
> >
> > I am CCing:
> >
> >  - Suren because patch 1 touches his code
> >  - Matthew Wilcox because he is also currently working on per-VMA
> >    locking stuff
> >  - all the maintainers/reviewers for the Kernel Memory Consistency Mode=
l
> >    so they can help figure out the READ_ONCE() vs smp_load_acquire()
> >    thing
>
> READ_ONCE() has weaker ordering properties than smp_load_acquire().
>
> For example, given a pointer gp:
>
>         p =3D whichever(gp);
>         a =3D 1;
>         r1 =3D p->b;
>         if ((uintptr_t)p & 0x1)
>                 WRITE_ONCE(b, 1);
>         WRITE_ONCE(c, 1);
>
> Leaving aside the "&" needed by smp_load_acquire(), if "whichever" is
> "READ_ONCE", then the load from p->b and the WRITE_ONCE() to "b" are
> ordered after the load from gp (the former due to an address dependency
> and the latter due to a (fragile) control dependency).  The compiler
> is within its rights to reorder the store to "a" to precede the load
> from gp.  The compiler is forbidden from reordering the store to "c"
> wtih the load from gp (because both are volatile accesses), but the CPU
> is completely within its rights to do this reordering.
>
> But if "whichever" is "smp_load_acquire()", all four of the subsequent
> memory accesses are ordered after the load from gp.
>
> Similarly, for WRITE_ONCE() and smp_store_release():
>
>         p =3D READ_ONCE(gp);
>         r1 =3D READ_ONCE(gi);
>         r2 =3D READ_ONCE(gj);
>         a =3D 1;
>         WRITE_ONCE(b, 1);
>         if (r1 & 0x1)
>                 whichever(p->q, r2);
>
> Again leaving aside the "&" needed by smp_store_release(), if "whichever"
> is WRITE_ONCE(), then the load from gp, the load from gi, and the load
> from gj are all ordered before the store to p->q (by address dependency,
> control dependency, and data dependency, respectively).  The store to "a"
> can be reordered with the store to p->q by the compiler.  The store to
> "b" cannot be reordered with the store to p->q by the compiler (again,
> both are volatile), but the CPU is free to reorder them, especially when
> whichever() is implemented as a conditional store.
>
> But if "whichever" is "smp_store_release()", all five of the earlier
> memory accesses are ordered before the store to p->q.
>
> Does that help, or am I missing the point of your question?

My main question is how permissible/ugly you think the following use
of READ_ONCE() would be, and whether you think it ought to be an
smp_load_acquire() instead.

Assume that we are holding some kind of lock that ensures that the
only possible concurrent update to "vma->anon_vma" is that it changes
from a NULL pointer to a non-NULL pointer (using smp_store_release()).


if (READ_ONCE(vma->anon_vma) !=3D NULL) {
  // we now know that vma->anon_vma cannot change anymore

  // access the same memory location again with a plain load
  struct anon_vma *a =3D vma->anon_vma;

  // this needs to be address-dependency-ordered against one of
  // the loads from vma->anon_vma
  struct anon_vma *root =3D a->root;
}


Is this fine? If it is not fine just because the compiler might
reorder the plain load of vma->anon_vma before the READ_ONCE() load,
would it be fine after adding a barrier() directly after the
READ_ONCE()?

I initially suggested using READ_ONCE() for this, and then Linus and
me tried to reason it out and Linus suggested (if I understood him
correctly) that you could make the ugly argument that this works
because loads from the same location will not be reordered by the
hardware. So on anything other than alpha, we'd still have the
required address-dependency ordering because that happens for all
loads, even plain loads, while on alpha, the READ_ONCE() includes a
memory barrier. But that argument is weirdly reliant on
architecture-specific implementation details.

The other option is to replace the READ_ONCE() with a
smp_load_acquire(), at which point it becomes a lot simpler to show
that the code is correct.


>                                                         Thanx, Paul
>
> >  - people involved in the previous discussion on the security list
> >
> >
> > Jann Horn (2):
> >   mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock
> >   mm: Fix anon_vma memory ordering
> >
> >  include/linux/rmap.h | 15 ++++++++++++++-
> >  mm/huge_memory.c     |  4 +++-
> >  mm/khugepaged.c      |  2 +-
> >  mm/ksm.c             | 16 +++++++++++-----
> >  mm/memory.c          | 32 ++++++++++++++++++++------------
> >  mm/mmap.c            | 13 ++++++++++---
> >  mm/rmap.c            |  6 ++++--
> >  mm/swapfile.c        |  3 ++-
> >  8 files changed, 65 insertions(+), 26 deletions(-)
> >
> >
> > base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
> > --
> > 2.41.0.487.g6d72f3e995-goog
> >
