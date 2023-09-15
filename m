Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2C7A1F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjIONEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjIONEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CFE31AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694783017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpfbgJ5FdmMlvqcljfZeMWdf6Pp3ie+fbXvpKVgnxSk=;
        b=Z9WftRfMZ6po/DxkkmdQdcU4nxyQ867pY0M5yfywqDkvEJmtmbbb3UpLt6/bpKdpwWNkoC
        0K9wBlekPBIDcpKZYZTEYaPm5tJvjU/0G4G9b3VUahRd/Hv5LU2rEI7xQeFLmgYMOPlnBQ
        W9WB8XPelFINoQ/nGp3y3RwFw9uVOCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-CFYeF0T8NXStZbVp2ZErcg-1; Fri, 15 Sep 2023 09:03:33 -0400
X-MC-Unique: CFYeF0T8NXStZbVp2ZErcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB87780A154;
        Fri, 15 Sep 2023 13:03:32 +0000 (UTC)
Received: from localhost (unknown [10.72.113.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16DDF1006B70;
        Fri, 15 Sep 2023 13:03:31 +0000 (UTC)
Date:   Fri, 15 Sep 2023 21:03:29 +0800
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
Subject: Re: [PATCH v2 9/9] mm: vmalloc: Set nr_nodes/node_size based on
 CPU-cores
Message-ID: <ZQRWIRzhspyU1xIE@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-10-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-10-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
......
> real    1m28.382s
> user    0m0.014s
> sys     0m0.026s
> urezki@pc638:~$
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9cce012aecdb..08990f630c21 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -796,6 +796,9 @@ struct vmap_node {
>  	atomic_t fill_in_progress;
>  };
>  
> +#define MAX_NODES U8_MAX
> +#define MAX_NODE_SIZE SZ_4M
> +
>  static struct vmap_node *nodes, snode;
>  static __read_mostly unsigned int nr_nodes = 1;
>  static __read_mostly unsigned int node_size = 1;
> @@ -4803,11 +4806,24 @@ static void vmap_init_free_space(void)
>  	}
>  }
>  
> +static unsigned int calculate_nr_nodes(void)
> +{
> +	unsigned int nr_cpus;
> +
> +	nr_cpus = num_present_cpus();
> +	if (nr_cpus <= 1)
> +		nr_cpus = num_possible_cpus();
> +
> +	/* Density factor. Two users per a node. */
> +	return clamp_t(unsigned int, nr_cpus >> 1, 1, MAX_NODES);
> +}
> +
>  static void vmap_init_nodes(void)
>  {
>  	struct vmap_node *vn;
>  	int i;
>  
> +	nr_nodes = calculate_nr_nodes();
>  	nodes = &snode;
>  
>  	if (nr_nodes > 1) {
> @@ -4830,6 +4846,16 @@ static void vmap_init_nodes(void)
>  		INIT_LIST_HEAD(&vn->free.head);
>  		spin_lock_init(&vn->free.lock);
>  	}
> +
> +	/*
> +	 * Scale a node size to number of CPUs. Each power of two
> +	 * value doubles a node size. A high-threshold limit is set
> +	 * to 4M.
> +	 */
> +#if BITS_PER_LONG == 64
> +	if (nr_nodes > 1)
> +		node_size = min(SZ_64K << fls(num_possible_cpus()), SZ_4M);
> +#endif
>  }
>  
>  void __init vmalloc_init(void)
> -- 
> 2.30.2
> 

