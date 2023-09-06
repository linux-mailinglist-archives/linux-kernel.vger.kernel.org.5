Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AC7943E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbjIFTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjIFTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:47:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C110F1;
        Wed,  6 Sep 2023 12:46:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4018af1038cso2642325e9.0;
        Wed, 06 Sep 2023 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694029615; x=1694634415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIUc2xK683d3Q/ZcNSmkTYY4rSdKAhFf7bFcO8REd1s=;
        b=qOJCGrUkxHEFk5TCzH8OpNhXp/JYlB66ZnHOjqJk7utunOfv7F+/kQw1ALkWDOMGIA
         EoYiWmKTVDa4lytdwZk4zVkionxjh1Xa+YZ69HojZzMZgU/uum7upARulrMqSkBoJS9J
         2zalMSSQJGru3ZSq+2J4N07FDSK2NS2zvmOrBnvil5JoJChTv2kOvWk9R4/c6INrK7s6
         TyklL9fB5ChmO93dY06o1h/BjxUcSwWddaP8ZmtwmDcu4KQqdMwZC5mUzDhU/Mx3NvF+
         u/jDUkZExkIvAGMOF1RR5NfX8GkL9yxkABJS+NOVbnYo3kiAYyIHc9k3QEvk0s/LVRXB
         juwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694029615; x=1694634415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIUc2xK683d3Q/ZcNSmkTYY4rSdKAhFf7bFcO8REd1s=;
        b=Fyxtyk3Vr+XRPPRp/Ax5f7P8QFMBblBQ7uCB6jaiQ5EX2suxnag9rU6Nw6pWkIbw4y
         EY8ztejNNt9axn5aXyEfh4tJhTkA3lcDgh+V8ptftz4ClZN39feVlHPJAmRBb0//Hxdw
         4OiowHA/q972l4YGUUyLaQcdZLnZ9jchyNlC2Gvb5xwVLf499QI1iem/YAswWG2ntjZO
         qI4YfYxoyOEWRnE+GpBZjdBnhA4rXEDLfcVsPFsJN3BLjplCNmqcPvTossfJc2Dz9bVV
         oCUFKNJM9bBDfTpHooyxJDB/vlO4KeAaYQ/ROCBWTC2sptaSSwsf5H9em2CDzo4L5YPn
         gEBw==
X-Gm-Message-State: AOJu0YzctFhaE3OrqULJm0oISrNrLtezdOQ3PknwgLjMmpdeDCnsW8d+
        /PSpJkmQ12KTGZARLoX5xdCkG54glno=
X-Google-Smtp-Source: AGHT+IHX/HTYarWHVUGZ8Kl0yIwsTgpFcNTDpxunqaE4hq8YLu00AaGgz+HCZH9+NHFr6Q/ekHWjZQ==
X-Received: by 2002:a1c:770e:0:b0:401:cdc1:ac82 with SMTP id t14-20020a1c770e000000b00401cdc1ac82mr3387067wmi.9.1694029614483;
        Wed, 06 Sep 2023 12:46:54 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0031435731dfasm21167212wrp.35.2023.09.06.12.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:46:53 -0700 (PDT)
Date:   Wed, 6 Sep 2023 20:46:52 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
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
Subject: Re: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <4f19f95a-e93c-4a30-8565-88e044960be0@lucifer.local>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
 <20230905114709.GA3881391@google.com>
 <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:23:18PM +0100, Lorenzo Stoakes wrote:
> On Tue, 5 Sept 2023 at 12:47, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Sep 05, 2023 at 08:09:16AM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Sep 04, 2023 at 06:08:04PM +0000, Joel Fernandes (Google) wrote:
> > > > It is unsafe to dump vmalloc area information when trying to do so from
> > > > some contexts. Add a safer trylock version of the same function to do a
> > > > best-effort VMA finding and use it from vmalloc_dump_obj().
> > >
> > > It'd be nice to have more details as to precisely which contexts and what this
> > > resolves.
> >
> > True. I was hoping the 'trylock' mention would be sufficient (example hardirq
> > context interrupting a lock-held region) but you're right.
> >
> > > > [applied test robot feedback on unused function fix.]
> > > > [applied Uladzislau feedback on locking.]
> > > >
> > > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: rcu@vger.kernel.org
> > > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  mm/vmalloc.c | 26 ++++++++++++++++++++++----
> > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 93cf99aba335..2c6a0e2ff404 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > > >  #ifdef CONFIG_PRINTK
> > > >  bool vmalloc_dump_obj(void *object)
> > > >  {
> > > > -   struct vm_struct *vm;
> > > >     void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > > > +   const void *caller;
> > > > +   struct vm_struct *vm;
> > > > +   struct vmap_area *va;
> > > > +   unsigned long addr;
> > > > +   unsigned int nr_pages;
> > > >
> > > > -   vm = find_vm_area(objp);
> > > > -   if (!vm)
> > > > +   if (!spin_trylock(&vmap_area_lock))
> > > > +           return false;
> > >
> > > It'd be good to have a comment here explaining why we must trylock here. I am
> > > also concerned that in the past this function would return false only if the
> > > address was not a vmalloc one, but now it might just return false due to lock
> > > contention and the user has no idea which it is?
> > >
> > > I'd want to at least output "vmalloc region cannot lookup lock contention"
> > > vs. the below cannot find case.
> >
> > In the patch 2/2 we do print if the address looks like a vmalloc address even
> > if the vmalloc look up fails.
>
> No, you output exactly what was output before, only changing what it
> means and in no way differentiating between couldn't find vmalloc
> area/couldn't get lock.
>
> >
> > Also the reporter's usecase is not a common one. We only attempt to dump
> > information if there was a debug objects failure (example if somebody did a
> > double call_rcu). In such a situation, the patch will prevent a deadlock and
> > still print something about the address.
>
> Right, but the function still purports to do X but does Y.
>
> >
> > > Under heavy lock contention aren't you potentially breaking the ability to
> > > introspect vmalloc addresses? Wouldn't it be better to explicitly detect the
> > > contexts under which acquiring this spinlock is not appropriate?
> >
> > Yes this is a good point, but there's another case as well: PREEMPT_RT can
> > sleep on lock contention (as spinlocks are sleeping) and we can't sleep from
> > call_rcu() as it may be called in contexts that cannot sleep. So we handle
> > that also using trylock.
>
> Right so somebody now has to find this email to realise that. I hate
> implicit knowledge like this, it needs a comment. It also furthers the
> point that it'd be useful to differentiate between the two.
>
> >
> > Thanks for the review!
>
> This got merged despite my outstanding comments so I guess I'll have
> to follow up with a patch.
>
> >
> >  - Joel
> >
> >
> > >
> > > > +   va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> > > > +   if (!va) {
> > > > +           spin_unlock(&vmap_area_lock);
> > > >             return false;
> > > > +   }
> > > > +
> > > > +   vm = va->vm;
> > > > +   if (!vm) {
> > > > +           spin_unlock(&vmap_area_lock);
> > > > +           return false;
> > > > +   }
> > > > +   addr = (unsigned long)vm->addr;
> > > > +   caller = vm->caller;
> > > > +   nr_pages = vm->nr_pages;
> > > > +   spin_unlock(&vmap_area_lock);
> > > >     pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > > > -           vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> > > > +           nr_pages, addr, caller);
> > > >     return true;
> > > >  }
> > > >  #endif
> > > > --
> > > > 2.42.0.283.g2d96d420d3-goog
> > > >
>
> This reads like another 'nice review and I agree but I won't change
> anything!'...
>

Sorry I actually wrote this unkind comment in a moment of annoyance then
meant to delete it but of course forgot to :>) Disregard this bit.

Happy for pushback/disagreement, just feel like a few little touchups would
have helped improve documentation/clarity of what this series does.

Obviously stability matters more so perhaps touch-ups best as a follow up
series... though would be nice to have a comment to that effect.

Thanks!
