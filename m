Return-Path: <linux-kernel+bounces-76784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8C85FC86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A420D1C22B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9B14D43C;
	Thu, 22 Feb 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipEFQ0uu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCC14E2FD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616210; cv=none; b=d5iiGO3BVULJxxtW7u7aKRi3PHBgVUfnjF8rryp5FIMmEPEvN72omdKeFN4Kwk4jm89kaJP2Jd69E+PcCd7V/p75ttrIQgJ8QCbEDs0CTDELE38wbHe4q94TVKCIfA43dkDkWATnhBgRGL2DAzybqQ2tWuL3gfa9DOrfrBtm5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616210; c=relaxed/simple;
	bh=Svt5HVUwPGoCLtUVipjQD+MDNXUSQX/py4X/oqDqfJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3+PjgdeMg8iXoi4+eCRf1uuvFhcK6KNe6vCvEuO7hVLn9n4uQpCJB2+fc8AhqHkHCyBlf9pETDzQjqoBEo+xLFnwK+VCE+3xxGsFPRVP2qgJrWW6l229wuF9DV4S5Y+gEozRHabeK2IsElFYsrBs0XDwOiYnQHZI63WefOq/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipEFQ0uu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708616207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXua+EAh0lT5XSJySU0YpNyEIgAtAAD3qEPJl+EZM5M=;
	b=ipEFQ0uuJyj5kQo8J9x9/4bUEaU6J8Ci+aqLir0HCHIDbyMHVdNX1q0Us0N14mi1LAhnvd
	IxvWWpsZnA9BMjqE/OdzbP0YMrSYzTKpJ2VbWrybeRig4MhDgw4Z0HLuZl2Xy6HxVtWlse
	d7FCTCzqiN5XYsNkzXy+/b1v55IcVVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-6YO-UfnjPhOpXdad-zyTdQ-1; Thu, 22 Feb 2024 10:36:42 -0500
X-MC-Unique: 6YO-UfnjPhOpXdad-zyTdQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8286D83BA87;
	Thu, 22 Feb 2024 15:36:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4552492BC6;
	Thu, 22 Feb 2024 15:36:40 +0000 (UTC)
Date: Thu, 22 Feb 2024 23:36:37 +0800
From: Baoquan He <bhe@redhat.com>
To: rulinhuang <rulin.huang@intel.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v3] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZddqBZ7dYrcFycjM@MiWiFi-R3L-srv>
References: <ZdW2HB-XdAJKph5s@pc636>
 <20240222121045.216556-1-rulin.huang@intel.com>
 <ZddDdxcdD5hNpyUX@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddDdxcdD5hNpyUX@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/22/24 at 01:52pm, Uladzislau Rezki wrote:
> Hello, Rulinhuang!
> 
> > Hi Uladzislau and Andrew, we have rebased it(Patch v4) on branch 
> > mm-unstable and remeasured it. Could you kindly help confirm if 
> > this is the right base to work on?
> > Compared to the previous result at kernel v6.7 with a 5% performance 
> > gain on intel icelake(160 vcpu), we only had a 0.6% with this commit 
> > base. But we think our modification still has some significance. On 
> > the one hand, this does reduce a critical section. On the other hand, 
> > we have a 4% performance gain on intel sapphire rapids(224 vcpu), 
> > which suggests more performance improvement would likely be achieved 
> > when the core count of processors increases to hundreds or 
> > even thousands.
> > Thank you again for your comments.
> >
> According to the patch that was a correct rebase. Right a small delta
> on your 160 CPUs is because of removing a contention. As for bigger
> systems it is bigger impact, like you point here on your 224 vcpu
> results where you see %4 perf improvement.
> 
> So we should fix it. But the way how it is fixed is not optimal from
> my point of view, because the patch that is in question spreads the
> internals from alloc_vmap_area(), like inserting busy area, across
> many parts now.

I happened to walk into this thread and come up with one draft patch.
Please help check if it's ok.

From 0112e39b3a8454a288e1bcece220c4599bac5326 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Thu, 22 Feb 2024 23:26:59 +0800
Subject: [PATCH] mm/vmalloc.c: avoid repeatedly requiring lock unnecessarily
Content-type: text/plain

By moving setup_vmalloc_vm() into alloc_vmap_area(), we can reduce
requiring lock one time in short time.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aeee71349157..6bda3c06b484 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1848,7 +1848,10 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask,
-				unsigned long va_flags)
+				unsigned long va_flags,
+				struct vm_struct *vm,
+				unsigned long vm_flags,
+				const void *caller)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
@@ -1915,6 +1918,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	spin_lock(&vn->busy.lock);
 	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
+	if (!(va_flags & VMAP_RAM) && vm)
+		setup_vmalloc_vm(vm, va, vm_flags, caller);
 	spin_unlock(&vn->busy.lock);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
@@ -2947,7 +2952,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
+static inline void setup_vmalloc_vm(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
 	vm->flags = flags;
@@ -2957,16 +2962,6 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	va->vm = vm;
 }
 
-static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, const void *caller)
-{
-	struct vmap_node *vn = addr_to_node(va->va_start);
-
-	spin_lock(&vn->busy.lock);
-	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vn->busy.lock);
-}
-
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 {
 	/*
@@ -3009,8 +3004,6 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 		return NULL;
 	}
 
-	setup_vmalloc_vm(area, va, flags, caller);
-
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.
@@ -4586,7 +4579,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}
-- 
2.41.0


