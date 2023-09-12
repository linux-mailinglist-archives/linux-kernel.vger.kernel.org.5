Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7279D1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjILNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjILNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C842C10CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694524918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZD6YWQJqPrWvbOfZQJq7iTJokWiyIC+lAqfbjqQ8NIw=;
        b=A4OdRG2aikPsQPW9BCwlRJ8SYPXSaFokPTKeFlZQCTVgtk90fAQxjPXJ6PdNaikSCauyQ8
        Ho6FFmuTX06j/U/fYbVfosGpfqViTZcgjeIq2AX8wzLMuExZK0PpLruYA1gp3agVwLlDtd
        GTLiyGvdWBZoBuhLjRdI7AiFgL2csG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-wNPhRgZgPde1KIJoDFaalw-1; Tue, 12 Sep 2023 09:21:52 -0400
X-MC-Unique: wNPhRgZgPde1KIJoDFaalw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 253638FBCE3;
        Tue, 12 Sep 2023 13:21:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7150D40C6EBF;
        Tue, 12 Sep 2023 13:21:51 +0000 (UTC)
Date:   Tue, 12 Sep 2023 21:21:47 +0800
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
Subject: Re: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZQBl66DDGL2FspV8@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-7-urezki@gmail.com>
 <ZP6IjeCpDIqHgV0y@MiWiFi-R3L-srv>
 <ZP9KE8bU+c1Tp2Rg@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP9KE8bU+c1Tp2Rg@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/23 at 07:10pm, Uladzislau Rezki wrote:
> On Mon, Sep 11, 2023 at 11:25:01AM +0800, Baoquan He wrote:
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Concurrent access to a global vmap space is a bottle-neck.
> > > We can simulate a high contention by running a vmalloc test
> > > suite.
> > > 
> > > To address it, introduce an effective vmap node logic. Each
> > > node behaves as independent entity. When a node is accessed
> > > it serves a request directly(if possible) also it can fetch
> > > a new block from a global heap to its internals if no space
> > > or low capacity is left.
> > > 
> > > This technique reduces a pressure on the global vmap lock.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 316 +++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 279 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 5a8a9c1370b6..4fd4915c532d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -779,6 +779,7 @@ struct rb_list {
> > >  
> > >  struct vmap_node {
> > >  	/* Bookkeeping data of this node. */
> > > +	struct rb_list free;
> > >  	struct rb_list busy;
> > >  	struct rb_list lazy;
> > >  
> > > @@ -786,6 +787,13 @@ struct vmap_node {
> > >  	 * Ready-to-free areas.
> > >  	 */
> > >  	struct list_head purge_list;
> > > +	struct work_struct purge_work;
> > > +	unsigned long nr_purged;
> > > +
> > > +	/*
> > > +	 * Control that only one user can pre-fetch this node.
> > > +	 */
> > > +	atomic_t fill_in_progress;
> > >  };
> > >  
> > >  static struct vmap_node *nodes, snode;
> > > @@ -804,6 +812,32 @@ addr_to_node(unsigned long addr)
> > >  	return &nodes[addr_to_node_id(addr)];
> > >  }
> > >  
> > > +static inline struct vmap_node *
> > > +id_to_node(int id)
> > > +{
> > > +	return &nodes[id % nr_nodes];
> > > +}
> > > +
> > > +static inline int
> > > +this_node_id(void)
> > > +{
> > > +	return raw_smp_processor_id() % nr_nodes;
> > > +}
> > > +
> > > +static inline unsigned long
> > > +encode_vn_id(int node_id)
> > > +{
> > > +	/* Can store U8_MAX [0:254] nodes. */
> > > +	return (node_id + 1) << BITS_PER_BYTE;
> > > +}
> > > +
> > > +static inline int
> > > +decode_vn_id(unsigned long val)
> > > +{
> > > +	/* Can store U8_MAX [0:254] nodes. */
> > > +	return (val >> BITS_PER_BYTE) - 1;
> > > +}
> > 
> > This patch looks good to me. However, should we split out the encoding
> > vn_id into va->flags optimization into another patch? It looks like an
> > independent optimization which can be described better with specific
> > log. At least, in the pdf file pasted or patch log, it's not obvious
> > that:
> > 1) node's free tree could contains any address range;
> > 2) nodes' busy tree only contains address range belonging to this node;
> >    - could contain crossing node range, corner case.
> > 3) nodes' purge tree could contain any address range;
> >    - decided by encoded vn_id in va->flags.
> >    - decided by address via addr_to_node(va->va_start).
> > 
> > Personal opinion, feel it will make reviewing easier.
> > 
> Sure, if it is easier to review, then i will split these two parts.
> All three statements are correct and valid. The pdf file only covers
> v1, so it is not up to date.
> 
> Anyway i will update a cover letter in v3 with more details.

Maybe providing these details in patch log or cover letter is enough.
Leave it to you to decide if splitting patch is still needed. Thanks.

