Return-Path: <linux-kernel+bounces-112558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32456887B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175762828F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70F1870;
	Sun, 24 Mar 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvMUE4Ze"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1919E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711249040; cv=none; b=VuPoq0nlWcf2lkrZ/DMwy3sRJpCsW3D28RvuH4qZ6G5ReCifYQI1x52nfg4Pybcf7Ds8mB2k+WvGZ9yq/o6TI39F8IRMc8q7HsRsLInUKCkO/F6URQGB8sblasBR4QV1wqQ/zmJHmKAsLYnyGgs85OqORRWBUoHST12cVtzAdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711249040; c=relaxed/simple;
	bh=TwIFZFSsRdL3TAoDrRM7KDSioOD7UeXUrtLMNenX+Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKJ1b3KWGYzd3ixYBVjZnIA8AbXSmZQOFo4ozfJ+op3hizH2rWOu7eoC8a/xCmPi/Zrrqb7r9lvQ3vx4JMDl5R/zQ91/6BlqR1C9KO1g8qUF90uCAbJmngQttTJJHhnfub/wpVDiAxYqvhxRKUIE9zKayCaQhnl30W+NP1IxU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvMUE4Ze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711249037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+TBDAPYKAkzCa4g/UJwRwmAT/evwdu5C0HNn4WKYUA=;
	b=QvMUE4ZeGCMP+F1gEpGDXuDJHh3MTVqa3ZRyNYir0cDWl90Cc3T8qBTO7f49ZyOx9k8/YW
	OvhZ0KIS/luSBqNQ25oMlgyUFvBtmkRhqRURgINaYY7VK7jZBHltVmjOttA0IRmy8HSur2
	nuuiYF1nrsaP0xc3yes/vmenkw2TlXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558--yiJeQbhMVyWzc5LN26Xbg-1; Sat,
 23 Mar 2024 22:57:09 -0400
X-MC-Unique: -yiJeQbhMVyWzc5LN26Xbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A10ED29AA384;
	Sun, 24 Mar 2024 02:57:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A68F2166B31;
	Sun, 24 Mar 2024 02:57:06 +0000 (UTC)
Date: Sun, 24 Mar 2024 10:56:56 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <Zf+WeI2URdy23qxy@MiWiFi-R3L-srv>
References: <20240323141544.4150-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323141544.4150-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 03/23/24 at 03:15pm, Uladzislau Rezki (Sony) wrote:
> During the boot the s390 system triggers "spinlock bad magic" messages
> if the spinlock debugging is enabled:
> 
> [    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
> [    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
> [    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
> [    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
> [    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
> [    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
> [    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
> [    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
> [    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
> [    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
> [    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40
> 
> it happens because such system tries to access some vmap areas
> whereas the vmalloc initialization is not even yet done:
> 
> [    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
> [    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
> [    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
> [    0.466572] find_vm_area (mm/vmalloc.c:3150)
> [    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
> [    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
> [    0.466651] paging_init (arch/s390/mm/init.c:97)
> [    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
> [    0.466702] start_kernel (init/main.c:899)
> [    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
> [    0.466811] INFO: lockdep is turned off.
> ...
> [    0.718250] vmalloc init - busy lock init 0000000002871860
> [    0.718328] vmalloc init - busy lock init 00000000028731b8
> 
> Some background. It worked before because the lock that is in question
> was statically defined and initialized. As of now, the locks and data
> structures are initialized in the vmalloc_init() function.
> 
> To address that issue add the check whether the "vmap_initialized"
> variable is set, if not find_vmap_area() bails out on entry returning NULL.
> 
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..0d77d171b5d9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2343,6 +2343,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	struct vmap_area *va;
>  	int i, j;
>  
> +	if (unlikely(!vmap_initialized))
> +		return NULL;
> +
>  	/*
>  	 * An addr_to_node_id(addr) converts an address to a node index
>  	 * where a VA is located. If VA spans several zones and passed

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>


