Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0068879A175
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjIKCjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjIKCjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBFFD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694399917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OA5FPhJGtcfrrgJQr2PSRC3PhbMxdwfUXAA3Q6/Xk48=;
        b=I+/6r19NCtj0NfxtxdciIAdhSRimE09KaZFRIx0O1sYJ4mkeFhle8R405VbHVx/J+0rT6j
        HqxbwP9m5468G9a0cKgbcWrWA5WgEjqNvwAZ0d54gjuD/KSgglBDUA7emrpTMJM92nqFyp
        siGwC6mkqrUuoBR/z9xdAuATdwxSWWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-dKsYZfzTM7mxtbvPQVYjCw-1; Sun, 10 Sep 2023 22:38:33 -0400
X-MC-Unique: dKsYZfzTM7mxtbvPQVYjCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26C801C0514C;
        Mon, 11 Sep 2023 02:38:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EC35200B401;
        Mon, 11 Sep 2023 02:38:32 +0000 (UTC)
Date:   Mon, 11 Sep 2023 10:38:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
Message-ID: <ZP59pbh9SKROtjlr@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-5-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> Store allocated objects in a separate nodes. A va->va_start
> address is converted into a correct node where it should
> be placed and resided. An addr_to_node() function is used
> to do a proper address conversion to determine a node that
> contains a VA.
> 
> Such approach balances VAs across nodes as a result an access
> becomes scalable. Number of nodes in a system depends on number
> of CPUs divided by two. The density factor in this case is 1/2.
> 
> Please note:
> 
> 1. As of now allocated VAs are bound to a node-0. It means the
>    patch does not give any difference comparing with a current
>    behavior;
> 
> 2. The global vmap_area_lock, vmap_area_root are removed as there
>    is no need in it anymore. The vmap_area_list is still kept and
>    is _empty_. It is exported for a kexec only;
> 
> 3. The vmallocinfo and vread() have to be reworked to be able to
>    handle multiple nodes.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 209 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 161 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b7deacca1483..ae0368c314ff 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
>  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
>  
>  
> -static DEFINE_SPINLOCK(vmap_area_lock);
>  static DEFINE_SPINLOCK(free_vmap_area_lock);
>  /* Export for kexec only */
>  LIST_HEAD(vmap_area_list);
> -static struct rb_root vmap_area_root = RB_ROOT;
>  static bool vmap_initialized __read_mostly;
>  
>  static struct rb_root purge_vmap_area_root = RB_ROOT;
> @@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
>   */
>  static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
>  
> +/*
> + * An effective vmap-node logic. Users make use of nodes instead
> + * of a global heap. It allows to balance an access and mitigate
> + * contention.
> + */
> +struct rb_list {
> +	struct rb_root root;
> +	struct list_head head;
> +	spinlock_t lock;
> +};
> +
> +struct vmap_node {
> +	/* Bookkeeping data of this node. */
> +	struct rb_list busy;
> +};
> +
> +static struct vmap_node *nodes, snode;
> +static __read_mostly unsigned int nr_nodes = 1;
> +static __read_mostly unsigned int node_size = 1;

It could be better if calling these global variables a meaningful name,
e.g vmap_nodes, static_vmap_nodes, nr_vmap_nodes. When I use vim+cscope
to reference them, it gives me a super long list. Aside from that, a
simple name often makes me mistake it as a local virable. A weak
opinion.


> +
> +static inline unsigned int
> +addr_to_node_id(unsigned long addr)
> +{
> +	return (addr / node_size) % nr_nodes;
> +}
> +
> +static inline struct vmap_node *
> +addr_to_node(unsigned long addr)
> +{
> +	return &nodes[addr_to_node_id(addr)];
> +}
> +
>  static __always_inline unsigned long
>  va_size(struct vmap_area *va)
>  {

