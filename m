Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB6D78F658
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347937AbjIAATY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjIAATW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:19:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5878E67
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:19:19 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79536bc6697so51664939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693527559; x=1694132359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJr2TRCzYoBSC8ybEg+IVfuBxW+TOUi/yIcqDzlQM1o=;
        b=CRNpncGApA1KlrzfT+7MIJWF35cCyVfxel5Dx2y4JmNqRBd/8KQK8jrqV7s8XweJfv
         yltKe92ohxwFCzXpMlNyqrES1KIUaWm10qvYh5KFU6Jzua2lk0KAszNET6AtjpQD5T0O
         0gGkPthMp7Xl+JVzkFJVXKierP9I1wFkHcX6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693527559; x=1694132359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJr2TRCzYoBSC8ybEg+IVfuBxW+TOUi/yIcqDzlQM1o=;
        b=gXoCtgzh0ueoqDICdJGlSYLzP2uo0QhxOr6sCHevSvtT2xIngK3K9KmrmmjBxHPhPa
         N/k45xZkbMcaSQFXNl3Z6kMVFBR+g1bjCCpN656YDuTQLpeZOWxqDen7XF1HwaFGVZre
         wslY83GHXAKvfFbTZBzVvOIgmbE/RxwK+4L6WHzXxfrnq9C6QUe1wITOEiGYiDXRU69A
         f0uZB5up49ncjIMnEV/rX1TVhTdM1BqgUJKBAve2Qr83BrWduK7JjO1gyzRplR/54ydP
         fOdQIWVRmmVnIkYkgvRtt3TJoAfaTdUBjufUKqfiXeN2mD5gTScmyIqp8STf23Ij1bVM
         8pig==
X-Gm-Message-State: AOJu0YytELP1JvkSNdMpGxqCnx/CloiOvTlinwrm85Qdt83PKDx/TzJl
        FzpE31UpbhkcafRSZn5RYwLArg==
X-Google-Smtp-Source: AGHT+IGb7sZBvvl51e4dQtJiZ/vDJ4zUjhxqO4U4boVBY5g2/wBMTeU1aw98BQ1Q8rg0Sy8onkXDRg==
X-Received: by 2002:a6b:6a19:0:b0:790:a211:b95a with SMTP id x25-20020a6b6a19000000b00790a211b95amr923908iog.4.1693527559073;
        Thu, 31 Aug 2023 17:19:19 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id t15-20020a05663801ef00b0041cd626ea0csm713150jaq.147.2023.08.31.17.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 17:19:18 -0700 (PDT)
Date:   Fri, 1 Sep 2023 00:19:17 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <20230901001917.GA2723108@google.com>
References: <20230831171827.2625016-1-joel@joelfernandes.org>
 <ZPDuaI2kTTKCivXa@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPDuaI2kTTKCivXa@pc636>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:47:52PM +0200, Uladzislau Rezki wrote:
> On Thu, Aug 31, 2023 at 05:18:25PM +0000, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
> > 
> > [apply test robot feedback on unused function fix.]
> > 
> > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: rcu@vger.kernel.org
> > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > v1->v2: Apply review tags and test robot feedback.
> > 
> >  mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 93cf99aba335..f09e882ae3b8 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> >  	return va;
> >  }
> >  
> > +#ifdef CONFIG_PRINTK
> > +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> > +{
> > +	struct vmap_area *va;
> > +
> > +	if (!spin_trylock(&vmap_area_lock))
> > +		return NULL;
> > +	va = __find_vmap_area(addr, &vmap_area_root);
> > +	spin_unlock(&vmap_area_lock);
> > +
> > +	return va;
> > +}
> > +#endif
> > +
> >  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> >  {
> >  	struct vmap_area *va;
> > @@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
> >  	return va->vm;
> >  }
> >  
> > +/**
> > + * try_to_find_vm_area - find a continuous kernel virtual area
> > + * @addr:	  base address
> > + *
> > + * This function is the same as find_vm_area() except that it is
> > + * safe to call if vmap_area_lock is already held and returns NULL
> > + * if it is. See comments in find_vmap_area() for other details.
> > + *
> > + * Return: the area descriptor on success or %NULL on failure.
> > + */
> > +#ifdef CONFIG_PRINTK
> > +static struct vm_struct *try_to_find_vm_area(const void *addr)
> > +{
> > +	struct vmap_area *va;
> > +
> > +	va = find_vmap_area_trylock((unsigned long)addr);
> > +	if (!va)
> > +		return NULL;
> > +
> > +	return va->vm;
> > +}
> > +#endif
> > +
> >  /**
> >   * remove_vm_area - find and remove a continuous kernel virtual area
> >   * @addr:	    base address
> > @@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
> >  	struct vm_struct *vm;
> >  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> >  
> > -	vm = find_vm_area(objp);
> > +	vm = try_to_find_vm_area(objp);
> >  	if (!vm)
> >  		return false;
> >  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",

Hi Vlad,
Thanks for taking a look.

> I am not sure if this patch makes a lot of sense. I agree, this is a
> problem and it mitigates it. But it is broken in terms of once you drop
> the lock, the VA should not be accessed.

Just to note the lockless-access issue you are referring to is not introduced
by this patch but is rather in the existing code. Also just to note this is
debug code.

> Is that a real issue or it gets triggered due to some syntetic test case?

It is a real issue. See 2/2.

> If i were you, i would go with open-coded version of trylock. Because
> there is only one user so far.

Taking your open coding and locking suggestions, I came up with the below
which actually results in a smaller patch. Does it look good to you?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..aaf6bad997a7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4274,14 +4274,31 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
+	void *caller, *objp = (void *)PAGE_ALIGN((unsigned long)object);
 	struct vm_struct *vm;
-	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+	struct vmap_area *va;
+	unsigned long addr;
+	unsigned int nr_pages;
 
-	vm = find_vm_area(objp);
-	if (!vm)
+	if (!spin_trylock(&vmap_area_lock))
+		return false;
+	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
+	if (!va) {
+		spin_unlock(&vmap_area_lock);
 		return false;
+	}
+
+	vm = va->vm;
+	if (!vm) {
+		spin_unlock(&vmap_area_lock);
+		return false;
+	}
+	addr = vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vmap_area_lock);
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
+		nr_pages, addr, caller);
 	return true;
 }
 #endif

