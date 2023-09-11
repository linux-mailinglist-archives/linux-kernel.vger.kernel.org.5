Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95C79B65C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbjIKVLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbjIKQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6A7EE7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694450874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlE5hxD39QAwP7iSa7A3UcuUWfmPcVu6XAYVvHUfNKU=;
        b=jQJRFw7dlS6CJbiiyVAu3Hm9bh2nhDHvf/3uLiZMNVb9kQsvd0WjSIbxTkDCfcWzHtocdy
        kVshMD/3Ph/zhmkvwAL9vQbeKwLtc46tO1ibF47lkP4LtTzN8LovcG0hzEqvfZncckWcD0
        N+a8LEMRS/QTfCm7cqihYdd3dfn29PE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-dKd75GJuOlmpkmOBMSDFWw-1; Mon, 11 Sep 2023 12:47:51 -0400
X-MC-Unique: dKd75GJuOlmpkmOBMSDFWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D42D3C19371;
        Mon, 11 Sep 2023 16:47:50 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.22.48.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A13D2156702;
        Mon, 11 Sep 2023 16:47:49 +0000 (UTC)
Date:   Mon, 11 Sep 2023 12:47:47 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Rafael Aquini <raquini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: fix slab_caches list corruption after
 kmem_cache_destroy()
Message-ID: <ZP9Es3zK1XCY7i6-@optiplex-fbsd>
References: <20230908230649.802560-1-aquini@redhat.com>
 <afaa8691-0be9-4574-a87d-aab68c7a49b3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afaa8691-0be9-4574-a87d-aab68c7a49b3@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 05:06:15PM +0200, Vlastimil Babka wrote:
> On 9/9/23 01:06, Rafael Aquini wrote:
> > After the commit in Fixes:, if a module that created a slab cache does not
> > release all of its allocated objects before destroying the cache (at rmmod
> > time), we might end up releasing the kmem_cache object without removing it
> > from the slab_caches list thus corrupting the list as kmem_cache_destroy()
> > ignores the return value from shutdown_cache(), which in turn never removes
> > the kmem_cache object from slabs_list in case __kmem_cache_shutdown() fails
> > to release all of the cache's slabs.
> > 
> > This is easily observable on a kernel built with CONFIG_DEBUG_LIST=y
> > as after that ill release the system will immediately trip on list_add,
> > or list_del, assertions similar to the one shown below as soon as another
> > kmem_cache gets created, or destroyed:
> > 
> >   [ 1041.213632] list_del corruption. next->prev should be ffff89f596fb5768, but was 52f1e5016aeee75d. (next=ffff89f595a1b268)
> >   [ 1041.219165] ------------[ cut here ]------------
> >   [ 1041.221517] kernel BUG at lib/list_debug.c:62!
> >   [ 1041.223452] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >   [ 1041.225408] CPU: 2 PID: 1852 Comm: rmmod Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
> >   [ 1041.228244] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
> >   [ 1041.231212] RIP: 0010:__list_del_entry_valid+0xae/0xb0
> > 
> > Another quick way to trigger this issue, in a kernel with CONFIG_SLUB=y,
> > is to set slub_debug to poison the released objects and then just run
> > cat /proc/slabinfo after removing the module that leaks slab objects,
> > in which case the kernel will panic:
> > 
> >   [   50.954843] general protection fault, probably for non-canonical address 0xa56b6b6b6b6b6b8b: 0000 [#1] PREEMPT SMP PTI
> >   [   50.961545] CPU: 2 PID: 1495 Comm: cat Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
> >   [   50.966808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
> >   [   50.972663] RIP: 0010:get_slabinfo+0x42/0xf0
> > 
> > This patch fixes this issue by properly checking shutdown_cache()'s
> > return value before taking the kmem_cache_release() branch.
> > 
> > Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> Thanks, added to slab.git. Tweaked the code a bit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.6/hotfixes&id=46a9ea6681907a3be6b6b0d43776dccc62cad6cf
>

Thank you, Vlastimil.

 
> > ---
> >  mm/slab_common.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index cd71f9581e67..31e581dc6e85 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -479,7 +479,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
> >  
> >  void kmem_cache_destroy(struct kmem_cache *s)
> >  {
> > -	int refcnt;
> > +	int err;
> >  	bool rcu_set;
> >  
> >  	if (unlikely(!s) || !kasan_check_byte(s))
> > @@ -490,17 +490,20 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >  
> >  	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
> >  
> > -	refcnt = --s->refcount;
> > -	if (refcnt)
> > +	s->refcount--;
> > +	if (s->refcount) {
> > +		err = -EBUSY;
> >  		goto out_unlock;
> > +	}
> >  
> > -	WARN(shutdown_cache(s),
> > +	err = shutdown_cache(s);
> > +	WARN(err,
> >  	     "%s %s: Slab cache still has objects when called from %pS",
> >  	     __func__, s->name, (void *)_RET_IP_);
> >  out_unlock:
> >  	mutex_unlock(&slab_mutex);
> >  	cpus_read_unlock();
> > -	if (!refcnt && !rcu_set)
> > +	if (!err && !rcu_set)
> >  		kmem_cache_release(s);
> >  }
> >  EXPORT_SYMBOL(kmem_cache_destroy);
> 
> 

