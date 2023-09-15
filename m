Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290897A1F79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjIONDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjIONDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EEB519AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694782968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8bHS8Nm1L36VGlRSDu87qJxdfk+i3aQtvW/QfYsZ1nE=;
        b=Xv1qvVupkHwGrzxTdrIaD1yBWhWLEAPZ92nenmNZ8wKxDm57wRybe0BWVsA0GdNQrB/MsB
        1los9FxSR7o3GGWOe3t+7KDoz51tI4nSc7hu74JqeU4sQ0OBhmeI1TIrcdXzYsQI/GGhFY
        wtbOGRaKzOFhvrLB8SuNCh+71AAwv6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-D5haY_jWNNmo41bUVAnvJw-1; Fri, 15 Sep 2023 09:02:43 -0400
X-MC-Unique: D5haY_jWNNmo41bUVAnvJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74C58858F1D;
        Fri, 15 Sep 2023 13:02:42 +0000 (UTC)
Received: from localhost (unknown [10.72.113.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88AD8170EC;
        Fri, 15 Sep 2023 13:02:41 +0000 (UTC)
Date:   Fri, 15 Sep 2023 21:02:37 +0800
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
Subject: Re: [PATCH v2 8/9] mm: vmalloc: Support multiple nodes in vmallocinfo
Message-ID: <ZQRV7fAXEZNFWAx4@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-9-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-9-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> Allocated areas are spread among nodes, it implies that
> the scanning has to be performed individually of each node
> in order to dump all existing VAs.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 120 ++++++++++++++++++++-------------------------------
>  1 file changed, 47 insertions(+), 73 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 968144c16237..9cce012aecdb 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4636,30 +4636,6 @@ bool vmalloc_dump_obj(void *object)
>  #endif
>  
>  #ifdef CONFIG_PROC_FS
> -static void *s_start(struct seq_file *m, loff_t *pos)
> -{
> -	struct vmap_node *vn = addr_to_node(0);
> -
> -	mutex_lock(&vmap_purge_lock);
> -	spin_lock(&vn->busy.lock);
> -
> -	return seq_list_start(&vn->busy.head, *pos);
> -}
> -
> -static void *s_next(struct seq_file *m, void *p, loff_t *pos)
> -{
> -	struct vmap_node *vn = addr_to_node(0);
> -	return seq_list_next(p, &vn->busy.head, pos);
> -}
> -
> -static void s_stop(struct seq_file *m, void *p)
> -{
> -	struct vmap_node *vn = addr_to_node(0);
> -
> -	spin_unlock(&vn->busy.lock);
> -	mutex_unlock(&vmap_purge_lock);
> -}
> -
>  static void show_numa_info(struct seq_file *m, struct vm_struct *v)
>  {
>  	if (IS_ENABLED(CONFIG_NUMA)) {
> @@ -4703,84 +4679,82 @@ static void show_purge_info(struct seq_file *m)
>  	}
>  }
>  
> -static int s_show(struct seq_file *m, void *p)
> +static int vmalloc_info_show(struct seq_file *m, void *p)
>  {
>  	struct vmap_node *vn;
>  	struct vmap_area *va;
>  	struct vm_struct *v;
> +	int i;
>  
> -	vn = addr_to_node(0);
> -	va = list_entry(p, struct vmap_area, list);
> +	for (i = 0; i < nr_nodes; i++) {
> +		vn = &nodes[i];
>  
> -	if (!va->vm) {
> -		if (va->flags & VMAP_RAM)
> -			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> -				(void *)va->va_start, (void *)va->va_end,
> -				va->va_end - va->va_start);
> +		spin_lock(&vn->busy.lock);
> +		list_for_each_entry(va, &vn->busy.head, list) {
> +			if (!va->vm) {
> +				if (va->flags & VMAP_RAM)
> +					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
> +						(void *)va->va_start, (void *)va->va_end,
> +						va->va_end - va->va_start);
>  
> -		goto final;
> -	}
> +				continue;
> +			}
>  
> -	v = va->vm;
> +			v = va->vm;
>  
> -	seq_printf(m, "0x%pK-0x%pK %7ld",
> -		v->addr, v->addr + v->size, v->size);
> +			seq_printf(m, "0x%pK-0x%pK %7ld",
> +				v->addr, v->addr + v->size, v->size);
>  
> -	if (v->caller)
> -		seq_printf(m, " %pS", v->caller);
> +			if (v->caller)
> +				seq_printf(m, " %pS", v->caller);
>  
> -	if (v->nr_pages)
> -		seq_printf(m, " pages=%d", v->nr_pages);
> +			if (v->nr_pages)
> +				seq_printf(m, " pages=%d", v->nr_pages);
>  
> -	if (v->phys_addr)
> -		seq_printf(m, " phys=%pa", &v->phys_addr);
> +			if (v->phys_addr)
> +				seq_printf(m, " phys=%pa", &v->phys_addr);
>  
> -	if (v->flags & VM_IOREMAP)
> -		seq_puts(m, " ioremap");
> +			if (v->flags & VM_IOREMAP)
> +				seq_puts(m, " ioremap");
>  
> -	if (v->flags & VM_ALLOC)
> -		seq_puts(m, " vmalloc");
> +			if (v->flags & VM_ALLOC)
> +				seq_puts(m, " vmalloc");
>  
> -	if (v->flags & VM_MAP)
> -		seq_puts(m, " vmap");
> +			if (v->flags & VM_MAP)
> +				seq_puts(m, " vmap");
>  
> -	if (v->flags & VM_USERMAP)
> -		seq_puts(m, " user");
> +			if (v->flags & VM_USERMAP)
> +				seq_puts(m, " user");
>  
> -	if (v->flags & VM_DMA_COHERENT)
> -		seq_puts(m, " dma-coherent");
> +			if (v->flags & VM_DMA_COHERENT)
> +				seq_puts(m, " dma-coherent");
>  
> -	if (is_vmalloc_addr(v->pages))
> -		seq_puts(m, " vpages");
> +			if (is_vmalloc_addr(v->pages))
> +				seq_puts(m, " vpages");
>  
> -	show_numa_info(m, v);
> -	seq_putc(m, '\n');
> +			show_numa_info(m, v);
> +			seq_putc(m, '\n');
> +		}
> +		spin_unlock(&vn->busy.lock);
> +	}
>  
>  	/*
>  	 * As a final step, dump "unpurged" areas.
>  	 */
> -final:
> -	if (list_is_last(&va->list, &vn->busy.head))
> -		show_purge_info(m);
> -
> +	show_purge_info(m);
>  	return 0;
>  }
>  
> -static const struct seq_operations vmalloc_op = {
> -	.start = s_start,
> -	.next = s_next,
> -	.stop = s_stop,
> -	.show = s_show,
> -};
> -
>  static int __init proc_vmalloc_init(void)
>  {
> +	void *priv_data = NULL;
> +
>  	if (IS_ENABLED(CONFIG_NUMA))
> -		proc_create_seq_private("vmallocinfo", 0400, NULL,
> -				&vmalloc_op,
> -				nr_node_ids * sizeof(unsigned int), NULL);
> -	else
> -		proc_create_seq("vmallocinfo", 0400, NULL, &vmalloc_op);
> +		priv_data = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
> +
> +	proc_create_single_data("vmallocinfo",
> +		0400, NULL, vmalloc_info_show, priv_data);
> +
>  	return 0;
>  }
>  module_init(proc_vmalloc_init);
> -- 
> 2.30.2
> 

