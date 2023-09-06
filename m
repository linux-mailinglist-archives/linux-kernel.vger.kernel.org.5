Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFBD7943C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbjIFTXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbjIFTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:23:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF51990;
        Wed,  6 Sep 2023 12:23:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-573ccec985dso171073a12.2;
        Wed, 06 Sep 2023 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694028210; x=1694633010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZikwxwV5OUPtPOXuowNsFclCwHU3dah79qe2K+yR5dQ=;
        b=siy/7ni49PoKCppR47a/dCxOhi6B4u7VFfChFvUeH+3BLcaKbEn4U04pZs+BZe6tFG
         ZxddLXKR4tdJFGQ7ikPgOOw8dorvz5spsnVL9yu7zLSsWQ7pLv6nDpxVFKVx3LGd5Xrk
         VifJhyqre9lGk22iPJ2QEVcSJPY7hSOLxHeXkUSgU5JoIqVM31rgfzaiJKYLLxR3BTm/
         ry11lzmZNOjeo1YAEzaw+VatxCgpRy+lLwsghy5v9rax2K+zDXTSa4HkGl7WxEAKtRA9
         zzj5T02af03mNjnyiqc3unFgfVckZinynZm6IvUNqrUvqdDlCZtCdNG9hB31ep1vlvMk
         R9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694028210; x=1694633010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZikwxwV5OUPtPOXuowNsFclCwHU3dah79qe2K+yR5dQ=;
        b=NrPhgzfGUtNAfCWHeUd35Wm7EHXmzL5O45feuflNSalzyEnPDnX5d8T4DsuN9GzjkO
         1uPiHqhk8sNaUTr/WCESj7EE9RFHwLTqBfq8RJqJlajAO3Qh44xwOGhFyPxWobkeel00
         DyUp8kJL02gIB+9srSn/70Gct28/PJ8q3k6Hpr31Y1CaPxHKp+Mpi4yI2yVNV/Y9TJlj
         0yUpoDOrpbPuXmeZ7lJTzVAEFpk21mEcPj+i0NiRr1qTIGFhhbzXxrch538hXAaHH460
         HHMrzx7bs8Zm15AThWF842QwR901Ie1h7cbEXFbfYH2yi8ObQvAECdSO/VdEo9N1S9mX
         0CSw==
X-Gm-Message-State: AOJu0Yyhe7gaW2OHSX7m13LYWoP524p92YymkUiGg+dDy/wH3Rj6MzUD
        DWC0qBWfQLUEfxbDQXq4AhQZiVQeHdOY6d4kj/A=
X-Google-Smtp-Source: AGHT+IGnviK2d0b1xWwIrS7FexAWR6yZvrg5Gplwuz5Tq21PdCFksCodt7+vh6io+9iy1mO1TT9B7BRlZKXqfR5VFok=
X-Received: by 2002:a17:90a:d58d:b0:268:b7a2:62e8 with SMTP id
 v13-20020a17090ad58d00b00268b7a262e8mr16476118pju.7.1694028209835; Wed, 06
 Sep 2023 12:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local> <20230905114709.GA3881391@google.com>
In-Reply-To: <20230905114709.GA3881391@google.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Wed, 6 Sep 2023 20:23:18 +0100
Message-ID: <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        stable@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 12:47, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Sep 05, 2023 at 08:09:16AM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 04, 2023 at 06:08:04PM +0000, Joel Fernandes (Google) wrote:
> > > It is unsafe to dump vmalloc area information when trying to do so from
> > > some contexts. Add a safer trylock version of the same function to do a
> > > best-effort VMA finding and use it from vmalloc_dump_obj().
> >
> > It'd be nice to have more details as to precisely which contexts and what this
> > resolves.
>
> True. I was hoping the 'trylock' mention would be sufficient (example hardirq
> context interrupting a lock-held region) but you're right.
>
> > > [applied test robot feedback on unused function fix.]
> > > [applied Uladzislau feedback on locking.]
> > >
> > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: rcu@vger.kernel.org
> > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  mm/vmalloc.c | 26 ++++++++++++++++++++++----
> > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 93cf99aba335..2c6a0e2ff404 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > >  #ifdef CONFIG_PRINTK
> > >  bool vmalloc_dump_obj(void *object)
> > >  {
> > > -   struct vm_struct *vm;
> > >     void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > > +   const void *caller;
> > > +   struct vm_struct *vm;
> > > +   struct vmap_area *va;
> > > +   unsigned long addr;
> > > +   unsigned int nr_pages;
> > >
> > > -   vm = find_vm_area(objp);
> > > -   if (!vm)
> > > +   if (!spin_trylock(&vmap_area_lock))
> > > +           return false;
> >
> > It'd be good to have a comment here explaining why we must trylock here. I am
> > also concerned that in the past this function would return false only if the
> > address was not a vmalloc one, but now it might just return false due to lock
> > contention and the user has no idea which it is?
> >
> > I'd want to at least output "vmalloc region cannot lookup lock contention"
> > vs. the below cannot find case.
>
> In the patch 2/2 we do print if the address looks like a vmalloc address even
> if the vmalloc look up fails.

No, you output exactly what was output before, only changing what it
means and in no way differentiating between couldn't find vmalloc
area/couldn't get lock.

>
> Also the reporter's usecase is not a common one. We only attempt to dump
> information if there was a debug objects failure (example if somebody did a
> double call_rcu). In such a situation, the patch will prevent a deadlock and
> still print something about the address.

Right, but the function still purports to do X but does Y.

>
> > Under heavy lock contention aren't you potentially breaking the ability to
> > introspect vmalloc addresses? Wouldn't it be better to explicitly detect the
> > contexts under which acquiring this spinlock is not appropriate?
>
> Yes this is a good point, but there's another case as well: PREEMPT_RT can
> sleep on lock contention (as spinlocks are sleeping) and we can't sleep from
> call_rcu() as it may be called in contexts that cannot sleep. So we handle
> that also using trylock.

Right so somebody now has to find this email to realise that. I hate
implicit knowledge like this, it needs a comment. It also furthers the
point that it'd be useful to differentiate between the two.

>
> Thanks for the review!

This got merged despite my outstanding comments so I guess I'll have
to follow up with a patch.

>
>  - Joel
>
>
> >
> > > +   va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> > > +   if (!va) {
> > > +           spin_unlock(&vmap_area_lock);
> > >             return false;
> > > +   }
> > > +
> > > +   vm = va->vm;
> > > +   if (!vm) {
> > > +           spin_unlock(&vmap_area_lock);
> > > +           return false;
> > > +   }
> > > +   addr = (unsigned long)vm->addr;
> > > +   caller = vm->caller;
> > > +   nr_pages = vm->nr_pages;
> > > +   spin_unlock(&vmap_area_lock);
> > >     pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > > -           vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> > > +           nr_pages, addr, caller);
> > >     return true;
> > >  }
> > >  #endif
> > > --
> > > 2.42.0.283.g2d96d420d3-goog
> > >

This reads like another 'nice review and I agree but I won't change
anything!'...


-- 
Lorenzo Stoakes
https://ljs.io
