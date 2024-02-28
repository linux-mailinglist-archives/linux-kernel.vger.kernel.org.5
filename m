Return-Path: <linux-kernel+bounces-84758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D786AB24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0011F2373B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812931A82;
	Wed, 28 Feb 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnj4Pchd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0622065
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112441; cv=none; b=PqnOf2DOMvDDnZX8i+2PwGThASazSB78a6uK0ee1Lavi4Y2lXMFPxRhnrDCdtxwd5jKQlO6YGPgjwrR60idBqKxPPZJab3Vs1a3nP85NjjgXPHZkHvsgKvPsk4gvRZukFVJ26poje9MItAQt8IThh0rJu7cqn+4iWS/6aeO/gME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112441; c=relaxed/simple;
	bh=Wi273g6TtrYvy7qseec9+gcMVzAdkaDhWksxSwYNGLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbDitlPY4gd2Af6cFB4qFkCNu+gsIT9lYq9qZEAhjwu0LylaQNAAppSbi6jUMRA5J4NHSSSlySwNn8zceFcVq/Kfh8J217nAoGJeNeYVfyvvHMNerUPht2fXxJoZPzvUyh9lqCmp05oRkYJ8dzH8pZva3KwZgJjWgU30nTmQ1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hnj4Pchd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709112438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3UkgT4oHLfn/Gn+eWNstUeC+v5h5q3tpSuEQK9eJKI=;
	b=Hnj4PchdcdSYuSxm7poaOp7pQjlroVG566FwvXNsf4iHaqXZgexa3bWyM41vDNZT++frWv
	lS6Td6d6Bd/Frwt7s9c0YfchkPpeMngzY2PqkoVvl5EUv0cMw1kBx09xagzTQhfGtQu8Wh
	t3Z+LjQ2Y3hdYQ/IuaeXUz1N2UMzjio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-2bNyEf_zMXO3EtyQzjOjKA-1; Wed, 28 Feb 2024 04:27:12 -0500
X-MC-Unique: 2bNyEf_zMXO3EtyQzjOjKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC7B311BB5E7;
	Wed, 28 Feb 2024 09:27:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C8E8173;
	Wed, 28 Feb 2024 09:27:09 +0000 (UTC)
Date: Wed, 28 Feb 2024 17:27:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
	kirill.shutemov@linux.intel.com,
	Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Message-ID: <Zd78aiZ8uiM6ZP16@MiWiFi-R3L-srv>
References: <20240102184633.748113-1-urezki@gmail.com>
 <ZdcHXFMq0cwmVKfM@pc636>
 <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
 <ZdhmrEmA8wOuVcQT@pc636>
 <Zdhy3S1PzwfEJuS3@MiWiFi-R3L-srv>
 <Zdh8KmZtoQym7Syz@pc636>
 <ZdjAZQRVmP9gnfsJ@MiWiFi-R3L-srv>
 <ZdjqDRLbpnExRhSZ@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PvGAVpYbqnFPzAAR"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdjqDRLbpnExRhSZ@pc638.lan>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


--PvGAVpYbqnFPzAAR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 02/23/24 at 07:55pm, Uladzislau Rezki wrote:
> On Fri, Feb 23, 2024 at 11:57:25PM +0800, Baoquan He wrote:
> > On 02/23/24 at 12:06pm, Uladzislau Rezki wrote:
> > > > On 02/23/24 at 10:34am, Uladzislau Rezki wrote:
> > > > > On Thu, Feb 22, 2024 at 11:15:59PM +0000, Pedro Falcato wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Thu, Feb 22, 2024 at 8:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello, Folk!
> > > > > > >
> > > > > > >[...]
> > > > > > > pagetable_alloc - gets increased as soon as a higher pressure is applied by
> > > > > > > increasing number of workers. Running same number of jobs on a next run
> > > > > > > does not increase it and stays on same level as on previous.
> > > > > > >
> > > > > > > /**
> > > > > > >  * pagetable_alloc - Allocate pagetables
> > > > > > >  * @gfp:    GFP flags
> > > > > > >  * @order:  desired pagetable order
> > > > > > >  *
> > > > > > >  * pagetable_alloc allocates memory for page tables as well as a page table
> > > > > > >  * descriptor to describe that memory.
> > > > > > >  *
> > > > > > >  * Return: The ptdesc describing the allocated page tables.
> > > > > > >  */
> > > > > > > static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
> > > > > > > {
> > > > > > >         struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> > > > > > >
> > > > > > >         return page_ptdesc(page);
> > > > > > > }
> > > > > > >
> > > > > > > Could you please comment on it? Or do you have any thought? Is it expected?
> > > > > > > Is a page-table ever shrink?
> > > > > > 
> > > > > > It's my understanding that the vunmap_range helpers don't actively
> > > > > > free page tables, they just clear PTEs. munmap does free them in
> > > > > > mmap.c:free_pgtables, maybe something could be worked up for vmalloc
> > > > > > too.
> > > > > >
> > > > > Right. I see that for a user space, pgtables are removed. There was a
> > > > > work on it.
> > > > > 
> > > > > >
> > > > > > I would not be surprised if the memory increase you're seeing is more
> > > > > > or less correlated to the maximum vmalloc footprint throughout the
> > > > > > whole test.
> > > > > > 
> > > > > Yes, the vmalloc footprint follows the memory usage. Some uses cases
> > > > > map lot of memory.
> > > > 
> > > > The 'nr_threads=256' testing may be too radical. I took the test on
> > > > a bare metal machine as below, it's still running and hang there after
> > > > 30 minutes. I did this after system boot. I am looking for other
> > > > machines with more processors.
> > > > 
> > > > [root@dell-r640-068 ~]# nproc 
> > > > 64
> > > > [root@dell-r640-068 ~]# free -h
> > > >                total        used        free      shared  buff/cache   available
> > > > Mem:           187Gi        18Gi       169Gi        12Mi       262Mi       168Gi
> > > > Swap:          4.0Gi          0B       4.0Gi
> > > > [root@dell-r640-068 ~]# 
> > > > 
> > > > [root@dell-r640-068 linux]# tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> > > > Run the test with following parameters: run_test_mask=127 nr_threads=256
> > > > 
> > > Agree, nr_threads=256 is a way radical :) Mine took 50 minutes to
> > > complete. So wait more :)
> > 
> > Right, mine could take the similar time to finish that. I got a machine
> > with 288 cpus, see if I can get some clues. When I go through the code
> > flow, suddenly realized it could be drain_vmap_area_work which is the 
> > bottle neck and cause the tremendous page table pages costing.
> > 
> > On your system, there's 64 cpus. then 
> > 
> > nr_lazy_max = lazy_max_pages() = 7*32M = 224M;
> > 
> > So with nr_threads=128 or 256, it's so easily getting to the nr_lazy_max
> > and triggering drain_vmap_work(). When cpu resouce is very limited, the
> > lazy vmap purging will be very slow. While the alloc/free in lib/tet_vmalloc.c 
> > are going far faster and more easily then vmap reclaiming. If old va is not
> > reused, new va is allocated and keep extending, the new page table surely
> > need be created to cover them.
> > 
> > I will take testing on the system with 288 cpus, will update if testing
> > is done.
> > 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 12caa794abd4..a90c5393d85f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1754,6 +1754,8 @@ size_to_va_pool(struct vmap_node *vn, unsigned long size)
>  	return NULL;
>  }
>  
> +static unsigned long lazy_max_pages(void);
> +
>  static bool
>  node_pool_add_va(struct vmap_node *n, struct vmap_area *va)
>  {
> @@ -1763,6 +1765,9 @@ node_pool_add_va(struct vmap_node *n, struct vmap_area *va)
>  	if (!vp)
>  		return false;
>  
> +	if (READ_ONCE(vp->len) > lazy_max_pages())
> +		return false;
> +
>  	spin_lock(&n->pool_lock);
>  	list_add(&va->list, &vp->head);
>  	WRITE_ONCE(vp->len, vp->len + 1);
> @@ -2170,9 +2175,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>  				INIT_WORK(&vn->purge_work, purge_vmap_node);
>  
>  				if (cpumask_test_cpu(i, cpu_online_mask))
> -					schedule_work_on(i, &vn->purge_work);
> +					queue_work_on(i, system_highpri_wq, &vn->purge_work);
>  				else
> -					schedule_work(&vn->purge_work);
> +					queue_work(system_highpri_wq, &vn->purge_work);
>  
>  				nr_purge_helpers--;
>  			} else {
> <snip>
> 
> We need this. This settles it back to a normal PTE-usage. Tomorrow i
> will check if cache-len should be limited. I tested on my 64 CPUs
> system with radical 256 kworkers. It looks good.

I finally finished the testing w/o and with your above improvement
patch. Testing is done on a system with 128 cpus. The system with 288
cpus is not available because of some console connection. Attach the log
here. In some testing after rebooting, I found it could take more than 30
minutes, I am not sure if it's caused by my messy code change. I finally
cleaned up all of them and take a clean linux-next to test, then apply
your above draft code.

--PvGAVpYbqnFPzAAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmalloc_node.log"

[root@dell-per6515-03 linux]# nproc 
128
[root@dell-per6515-03 linux]# free -h
               total        used        free      shared  buff/cache   available
Mem:           124Gi       2.6Gi       122Gi        21Mi       402Mi       122Gi
Swap:          4.0Gi          0B       4.0Gi

1)linux-next kernel w/o improving code from Uladzislau
-------------------------------------------------------
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=64
Run the test with following parameters: run_test_mask=127 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real	4m28.018s
user	0m0.015s
sys	0m4.712s
[root@dell-per6515-03 ~]# sort -h /proc/allocinfo | tail -10
    21405696     5226 mm/memory.c:1122 func:folio_prealloc 
    26199936     7980 kernel/fork.c:309 func:alloc_thread_stack_node 
    29822976     7281 mm/readahead.c:247 func:page_cache_ra_unbounded 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
   107638784     6320 mm/readahead.c:468 func:ra_alloc_folio 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   134742016    32896 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   266797056    65136 include/linux/mm.h:2848 func:pagetable_alloc 
   507617280    32796 mm/slub.c:2305 func:alloc_slab_page 
[root@dell-per6515-03 ~]# 
[root@dell-per6515-03 ~]# 
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=128
Run the test with following parameters: run_test_mask=127 nr_threads=128
Done.
Check the kernel ring buffer to see the summary.

real	6m19.328s
user	0m0.005s
sys	0m9.476s
[root@dell-per6515-03 ~]# sort -h /proc/allocinfo | tail -10
    21405696     5226 mm/memory.c:1122 func:folio_prealloc 
    26889408     8190 kernel/fork.c:309 func:alloc_thread_stack_node 
    29822976     7281 mm/readahead.c:247 func:page_cache_ra_unbounded 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
   107638784     6320 mm/readahead.c:468 func:ra_alloc_folio 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   134742016    32896 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   550068224    34086 mm/slub.c:2305 func:alloc_slab_page 
   664535040   162240 include/linux/mm.h:2848 func:pagetable_alloc 
[root@dell-per6515-03 ~]# 
[root@dell-per6515-03 ~]# 
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
Run the test with following parameters: run_test_mask=127 nr_threads=256
Done.
Check the kernel ring buffer to see the summary.

real	19m10.657s
user	0m0.015s
sys	0m20.959s
[root@dell-per6515-03 ~]# sort -h /proc/allocinfo | tail -10
    22441984     5479 mm/shmem.c:1634 func:shmem_alloc_folio 
    26758080     8150 kernel/fork.c:309 func:alloc_thread_stack_node 
    35880960     8760 mm/readahead.c:247 func:page_cache_ra_unbounded 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   122355712     7852 mm/readahead.c:468 func:ra_alloc_folio 
   134742016    32896 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   708231168    50309 mm/slub.c:2305 func:alloc_slab_page 
  1107296256   270336 include/linux/mm.h:2848 func:pagetable_alloc 
[root@dell-per6515-03 ~]# 

2)linux-next kernel with improving code from Uladzislau
-----------------------------------------------------
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=64
Run the test with following parameters: run_test_mask=127 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real	4m27.226s
user	0m0.006s
sys	0m4.709s
[root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
    38023168     9283 mm/readahead.c:247 func:page_cache_ra_unbounded 
    72228864    17634 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
    99863552    97523 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   136314880    33280 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   184176640    10684 mm/readahead.c:468 func:ra_alloc_folio 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   284700672    69507 include/linux/mm.h:2848 func:pagetable_alloc 
   601427968    36377 mm/slub.c:2305 func:alloc_slab_page 
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=128
Run the test with following parameters: run_test_mask=127 nr_threads=128
Done.
Check the kernel ring buffer to see the summary.

real	6m16.960s
user	0m0.007s
sys	0m9.465s
[root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
    38158336     9316 mm/readahead.c:247 func:page_cache_ra_unbounded 
    72220672    17632 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
    99863552    97523 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   136314880    33280 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   184504320    10710 mm/readahead.c:468 func:ra_alloc_folio 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   427884544   104464 include/linux/mm.h:2848 func:pagetable_alloc 
   697311232    45159 mm/slub.c:2305 func:alloc_slab_page
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
Run the test with following parameters: run_test_mask=127 nr_threads=256
Done.
Check the kernel ring buffer to see the summary.

real	21m15.673s
user	0m0.008s
sys	0m20.259s
[root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
    38158336     9316 mm/readahead.c:247 func:page_cache_ra_unbounded 
    72224768    17633 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
    99863552    97523 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   136314880    33280 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   184504320    10710 mm/readahead.c:468 func:ra_alloc_folio 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   506974208   123773 include/linux/mm.h:2848 func:pagetable_alloc 
   809504768    53621 mm/slub.c:2305 func:alloc_slab_page
[root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
Run the test with following parameters: run_test_mask=127 nr_threads=256
Done.
Check the kernel ring buffer to see the summary.

real	21m36.580s
user	0m0.012s
sys	0m19.912s
[root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
    38977536     9516 mm/readahead.c:247 func:page_cache_ra_unbounded 
    72273920    17645 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
    99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
    99895296    97554 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
   120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
   141033472    34432 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
   186064896    10841 mm/readahead.c:468 func:ra_alloc_folio 
   263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
   541237248   132138 include/linux/mm.h:2848 func:pagetable_alloc 
   694718464    41216 mm/slub.c:2305 func:alloc_slab_page




--PvGAVpYbqnFPzAAR--


