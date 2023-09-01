Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1D78F666
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347941AbjIAAd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjIAAd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:33:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D2E55
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:33:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79275d86bc3so52504839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693528402; x=1694133202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4U1NQrViH36a7MoLhWpGu66hQAydP4LWUk0MHgtZl0=;
        b=adyuGFKmau7iEph8wCG79jgZyDIIs9WBUWFDxoAMLp83lIEO+hWyHeP07pGT5Q7L6h
         icfVPtPVV8viRFNkyVVu0fB91UDrrHVIoZxxlGBsuFsJE1YHGXRF6XLj6AhmShRig6tU
         hkiDnMnh0NlZWMmGYtFvYRf2RM2vG5qD61tPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693528402; x=1694133202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4U1NQrViH36a7MoLhWpGu66hQAydP4LWUk0MHgtZl0=;
        b=f85KM3jKjE3kZakuGDPk7fWdekUjPbgzusXBxEqb26nCenSdfci2RIb1cP7dfVWUIw
         BnvSTi4/w0K8xrjneCwk908H7oUXwjagKZYZs6h7QcNrj+U34ZKpHs5gMiabJrhXsFSS
         OHmO/iW7PrPTh8tzcrfRaCU0H7l0o1ZFsB22HyhoI9BmLSdwWPgFFb4qlwd/InqSAh2x
         X1f+2kaXTJK2daLFJEihfFFOwrDPh3iM8fKfNpKosIVFLeSQHsYRAf6XZDBlR+WVLBAr
         18A38t/kPrZr8rjKGs9XzIV06zAlu+jObRUpTHpVH7L5VPIILB0ThHs/jI8vpPPY5kI8
         Blog==
X-Gm-Message-State: AOJu0YwMX+JgYJ1G/PcuBuCzxWBpDXekEkYtgIz8Ujzx8HJxgVhbVylK
        kwlOUbKTkZo20GHtsLL9p0BAFg==
X-Google-Smtp-Source: AGHT+IGSdOwhf7l6iGXUIYKsmYGXTh2irESvlLBAwRhppj4dAcA0ffHphEJYVWn96GbC8f1pqZBjIw==
X-Received: by 2002:a5e:dc49:0:b0:785:5917:a35f with SMTP id s9-20020a5edc49000000b007855917a35fmr809235iop.8.1693528402440;
        Thu, 31 Aug 2023 17:33:22 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id c25-20020a02a419000000b0042b2e90ed06sm723052jal.23.2023.08.31.17.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 17:33:21 -0700 (PDT)
Date:   Fri, 1 Sep 2023 00:33:21 +0000
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
Message-ID: <20230901003321.GA3389909@google.com>
References: <20230831171827.2625016-1-joel@joelfernandes.org>
 <ZPDuaI2kTTKCivXa@pc636>
 <20230901001917.GA2723108@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901001917.GA2723108@google.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 12:19:17AM +0000, Joel Fernandes wrote:
> On Thu, Aug 31, 2023 at 09:47:52PM +0200, Uladzislau Rezki wrote:
> > On Thu, Aug 31, 2023 at 05:18:25PM +0000, Joel Fernandes (Google) wrote:
> > > It is unsafe to dump vmalloc area information when trying to do so from
> > > some contexts. Add a safer trylock version of the same function to do a
> > > best-effort VMA finding and use it from vmalloc_dump_obj().
> > > 
> > > [apply test robot feedback on unused function fix.]
> > > 
> > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: rcu@vger.kernel.org
> > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > > v1->v2: Apply review tags and test robot feedback.
> > > 
> > >  mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 93cf99aba335..f09e882ae3b8 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> > >  	return va;
> > >  }
> > >  
> > > +#ifdef CONFIG_PRINTK
> > > +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> > > +{
> > > +	struct vmap_area *va;
> > > +
> > > +	if (!spin_trylock(&vmap_area_lock))
> > > +		return NULL;
> > > +	va = __find_vmap_area(addr, &vmap_area_root);
> > > +	spin_unlock(&vmap_area_lock);
> > > +
> > > +	return va;
> > > +}
> > > +#endif
> > > +
> > >  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> > >  {
> > >  	struct vmap_area *va;
> > > @@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
> > >  	return va->vm;
> > >  }
> > >  
> > > +/**
> > > + * try_to_find_vm_area - find a continuous kernel virtual area
> > > + * @addr:	  base address
> > > + *
> > > + * This function is the same as find_vm_area() except that it is
> > > + * safe to call if vmap_area_lock is already held and returns NULL
> > > + * if it is. See comments in find_vmap_area() for other details.
> > > + *
> > > + * Return: the area descriptor on success or %NULL on failure.
> > > + */
> > > +#ifdef CONFIG_PRINTK
> > > +static struct vm_struct *try_to_find_vm_area(const void *addr)
> > > +{
> > > +	struct vmap_area *va;
> > > +
> > > +	va = find_vmap_area_trylock((unsigned long)addr);
> > > +	if (!va)
> > > +		return NULL;
> > > +
> > > +	return va->vm;
> > > +}
> > > +#endif
> > > +
> > >  /**
> > >   * remove_vm_area - find and remove a continuous kernel virtual area
> > >   * @addr:	    base address
> > > @@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
> > >  	struct vm_struct *vm;
> > >  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > >  
> > > -	vm = find_vm_area(objp);
> > > +	vm = try_to_find_vm_area(objp);
> > >  	if (!vm)
> > >  		return false;
> > >  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> 
> Hi Vlad,
> Thanks for taking a look.
> 
> > I am not sure if this patch makes a lot of sense. I agree, this is a
> > problem and it mitigates it. But it is broken in terms of once you drop
> > the lock, the VA should not be accessed.
> 
> Just to note the lockless-access issue you are referring to is not introduced
> by this patch but is rather in the existing code. Also just to note this is
> debug code.
> 
> > Is that a real issue or it gets triggered due to some syntetic test case?
> 
> It is a real issue. See 2/2.
> 
> > If i were you, i would go with open-coded version of trylock. Because
> > there is only one user so far.
> 
> Taking your open coding and locking suggestions, I came up with the below
> which actually results in a smaller patch. Does it look good to you?
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..aaf6bad997a7 100644

And with some trivial compiler errors fixed (sorry should have build tested
but wanted to just share the idea earlier):

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..2c6a0e2ff404 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
-	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+	const void *caller;
+	struct vm_struct *vm;
+	struct vmap_area *va;
+	unsigned long addr;
+	unsigned int nr_pages;
 
-	vm = find_vm_area(objp);
-	if (!vm)
+	if (!spin_trylock(&vmap_area_lock))
+		return false;
+	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
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
+	addr = (unsigned long)vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vmap_area_lock);
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
+		nr_pages, addr, caller);
 	return true;
 }
 #endif
