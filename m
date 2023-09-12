Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3D79D1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjILNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjILNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 668D710CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694524757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45vYBZ3G2jZIqFieNjtpHSeDEfoCcr3MhetjZ/eAgmE=;
        b=GScva/nz7RwAAy/ILU2qlFwZ4nSQvzpTyfrBz46aKPXXNwbIYc3SIvd3/3hFn4Y1SY4jUh
        RXu+0mIWNe5fwYb1Smai2bYBzIDFzLL2Zdi92CgnVIR/8alwfdWH37QyFQKYOwpcVytibZ
        F+BsPmMecdtvbY9pPw3+6mbCUffjOtk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-VwJ5igqmMbWEkGlt2SHWzA-1; Tue, 12 Sep 2023 09:19:16 -0400
X-MC-Unique: VwJ5igqmMbWEkGlt2SHWzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 879533C18DD1;
        Tue, 12 Sep 2023 13:19:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A94172904;
        Tue, 12 Sep 2023 13:19:14 +0000 (UTC)
Date:   Tue, 12 Sep 2023 21:19:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZQBlT9l5bo2F2uCY@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZP59pbh9SKROtjlr@MiWiFi-R3L-srv>
 <ZP9GGW/q0nCFelLf@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP9GGW/q0nCFelLf@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/23 at 06:53pm, Uladzislau Rezki wrote:
> On Mon, Sep 11, 2023 at 10:38:29AM +0800, Baoquan He wrote:
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Store allocated objects in a separate nodes. A va->va_start
> > > address is converted into a correct node where it should
> > > be placed and resided. An addr_to_node() function is used
> > > to do a proper address conversion to determine a node that
> > > contains a VA.
> > > 
> > > Such approach balances VAs across nodes as a result an access
> > > becomes scalable. Number of nodes in a system depends on number
> > > of CPUs divided by two. The density factor in this case is 1/2.
> > > 
> > > Please note:
> > > 
> > > 1. As of now allocated VAs are bound to a node-0. It means the
> > >    patch does not give any difference comparing with a current
> > >    behavior;
> > > 
> > > 2. The global vmap_area_lock, vmap_area_root are removed as there
> > >    is no need in it anymore. The vmap_area_list is still kept and
> > >    is _empty_. It is exported for a kexec only;
> > > 
> > > 3. The vmallocinfo and vread() have to be reworked to be able to
> > >    handle multiple nodes.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 209 +++++++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 161 insertions(+), 48 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index b7deacca1483..ae0368c314ff 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
> > >  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
> > >  
> > >  
> > > -static DEFINE_SPINLOCK(vmap_area_lock);
> > >  static DEFINE_SPINLOCK(free_vmap_area_lock);
> > >  /* Export for kexec only */
> > >  LIST_HEAD(vmap_area_list);
> > > -static struct rb_root vmap_area_root = RB_ROOT;
> > >  static bool vmap_initialized __read_mostly;
> > >  
> > >  static struct rb_root purge_vmap_area_root = RB_ROOT;
> > > @@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
> > >   */
> > >  static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
> > >  
> > > +/*
> > > + * An effective vmap-node logic. Users make use of nodes instead
> > > + * of a global heap. It allows to balance an access and mitigate
> > > + * contention.
> > > + */
> > > +struct rb_list {
> > > +	struct rb_root root;
> > > +	struct list_head head;
> > > +	spinlock_t lock;
> > > +};
> > > +
> > > +struct vmap_node {
> > > +	/* Bookkeeping data of this node. */
> > > +	struct rb_list busy;
> > > +};
> > > +
> > > +static struct vmap_node *nodes, snode;
> > > +static __read_mostly unsigned int nr_nodes = 1;
> > > +static __read_mostly unsigned int node_size = 1;
> > 
> > It could be better if calling these global variables a meaningful name,
> > e.g vmap_nodes, static_vmap_nodes, nr_vmap_nodes. When I use vim+cscope
> > to reference them, it gives me a super long list. Aside from that, a
> > simple name often makes me mistake it as a local virable. A weak
> > opinion.
> > 
> I am OK to add "vmap_" prefix:
> 
> vmap_nodes;
> vmap_nr_nodes;
           ~ nr_vmap_nodes?
> vmap_node_size;
> ..
> 
> If you are not OK with that, feel free to propose other variants.

Other than the nr_nodes one, others look good to me, thanks a lot.

