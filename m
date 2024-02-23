Return-Path: <linux-kernel+bounces-78651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91FB86168C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529BD1F21D37
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76C82D66;
	Fri, 23 Feb 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5hIBsHk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D182C60
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703860; cv=none; b=nCacgRmXS8EOd3TKR/cP8Npae+jn/AV6kgx2b74MiVLMq54eEcSXuLXLfs9Tj/VOw6tfVdEIwE7nor7yZwNBdNAiIK0zzuKbxjJPKYPuoRyDC6VTdbufu1tKjLFy+J5HbgQujwP0osm04ASMuNy6gqhx9paP+/FHOMQjTniVXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703860; c=relaxed/simple;
	bh=zi7xhCN9r1n3iv+sh5wHZdIfmjyejjuSjiISgXho2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doDmcgTnPd+96Yp20keBjASBCU/wEDCe8HSReYrETP8GDJPlBUjnnj2Q8CKfcWdkmlieV9135s8rCkusXsmQ3OxKYcNZUJY2mq3YADIegskaBXO+ZJ8BkgbpLAewsqC2It2VknNwKWS9cHlGCERZAOg7oXLCnxHagx/3XFQCDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5hIBsHk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708703856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+cR72EL54R2xpPEHe1/1VXURnv19BSEwvnemyDV8zU=;
	b=g5hIBsHkEL823PoYoE96NvQRIbPuglpuH9XAXJOFJGcqFSq6HTQcHRDtu3wH7SFRJbhBy8
	jGCh2eYn9tz9CGi8TMfevWsLFjcRhZog5BcAbjjRIq29ebIDjfGby4WUAvOc431+giRKZ6
	gQCIXNkB3ocYtYdkYQgZZZEdf0AP5hQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ahSBYWehOVOzYxLguwbzWw-1; Fri, 23 Feb 2024 10:57:31 -0500
X-MC-Unique: ahSBYWehOVOzYxLguwbzWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AABB185A780;
	Fri, 23 Feb 2024 15:57:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 43026112132A;
	Fri, 23 Feb 2024 15:57:28 +0000 (UTC)
Date: Fri, 23 Feb 2024 23:57:25 +0800
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
Message-ID: <ZdjAZQRVmP9gnfsJ@MiWiFi-R3L-srv>
References: <20240102184633.748113-1-urezki@gmail.com>
 <ZdcHXFMq0cwmVKfM@pc636>
 <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
 <ZdhmrEmA8wOuVcQT@pc636>
 <Zdhy3S1PzwfEJuS3@MiWiFi-R3L-srv>
 <Zdh8KmZtoQym7Syz@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdh8KmZtoQym7Syz@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/23/24 at 12:06pm, Uladzislau Rezki wrote:
> > On 02/23/24 at 10:34am, Uladzislau Rezki wrote:
> > > On Thu, Feb 22, 2024 at 11:15:59PM +0000, Pedro Falcato wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Feb 22, 2024 at 8:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > Hello, Folk!
> > > > >
> > > > >[...]
> > > > > pagetable_alloc - gets increased as soon as a higher pressure is applied by
> > > > > increasing number of workers. Running same number of jobs on a next run
> > > > > does not increase it and stays on same level as on previous.
> > > > >
> > > > > /**
> > > > >  * pagetable_alloc - Allocate pagetables
> > > > >  * @gfp:    GFP flags
> > > > >  * @order:  desired pagetable order
> > > > >  *
> > > > >  * pagetable_alloc allocates memory for page tables as well as a page table
> > > > >  * descriptor to describe that memory.
> > > > >  *
> > > > >  * Return: The ptdesc describing the allocated page tables.
> > > > >  */
> > > > > static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
> > > > > {
> > > > >         struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> > > > >
> > > > >         return page_ptdesc(page);
> > > > > }
> > > > >
> > > > > Could you please comment on it? Or do you have any thought? Is it expected?
> > > > > Is a page-table ever shrink?
> > > > 
> > > > It's my understanding that the vunmap_range helpers don't actively
> > > > free page tables, they just clear PTEs. munmap does free them in
> > > > mmap.c:free_pgtables, maybe something could be worked up for vmalloc
> > > > too.
> > > >
> > > Right. I see that for a user space, pgtables are removed. There was a
> > > work on it.
> > > 
> > > >
> > > > I would not be surprised if the memory increase you're seeing is more
> > > > or less correlated to the maximum vmalloc footprint throughout the
> > > > whole test.
> > > > 
> > > Yes, the vmalloc footprint follows the memory usage. Some uses cases
> > > map lot of memory.
> > 
> > The 'nr_threads=256' testing may be too radical. I took the test on
> > a bare metal machine as below, it's still running and hang there after
> > 30 minutes. I did this after system boot. I am looking for other
> > machines with more processors.
> > 
> > [root@dell-r640-068 ~]# nproc 
> > 64
> > [root@dell-r640-068 ~]# free -h
> >                total        used        free      shared  buff/cache   available
> > Mem:           187Gi        18Gi       169Gi        12Mi       262Mi       168Gi
> > Swap:          4.0Gi          0B       4.0Gi
> > [root@dell-r640-068 ~]# 
> > 
> > [root@dell-r640-068 linux]# tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> > Run the test with following parameters: run_test_mask=127 nr_threads=256
> > 
> Agree, nr_threads=256 is a way radical :) Mine took 50 minutes to
> complete. So wait more :)

Right, mine could take the similar time to finish that. I got a machine
with 288 cpus, see if I can get some clues. When I go through the code
flow, suddenly realized it could be drain_vmap_area_work which is the 
bottle neck and cause the tremendous page table pages costing.

On your system, there's 64 cpus. then 

nr_lazy_max = lazy_max_pages() = 7*32M = 224M;

So with nr_threads=128 or 256, it's so easily getting to the nr_lazy_max
and triggering drain_vmap_work(). When cpu resouce is very limited, the
lazy vmap purging will be very slow. While the alloc/free in lib/tet_vmalloc.c 
are going far faster and more easily then vmap reclaiming. If old va is not
reused, new va is allocated and keep extending, the new page table surely
need be created to cover them.

I will take testing on the system with 288 cpus, will update if testing
is done.


