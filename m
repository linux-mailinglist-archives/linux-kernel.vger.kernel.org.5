Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816E07FD0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjK2Id3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjK2Id1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:33:27 -0500
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1EC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:33:30 -0800 (PST)
Message-ID: <04355714-3519-48f6-a5c6-15608b131e71@ingalls.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ingalls.rocks;
        s=key1; t=1701246808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cbpFsE7FcsGwKJEpvfC1Wki3/2feMNJnrhcrC6Kcxk=;
        b=IT1ArPecscFvD8wYJohp14tZxU9viiOZ9iH5Dfjc6FdiZ4yNtcF0eNKNDplNyhYuq3ursa
        ZCZ1bNzTGDbYa8bvJa2HqmmC1Yl8QGMnSsD5wgSXZsdv3VQxhR+H4sVE1n0hPuJ955ThTg
        /IfVwYyDNQ0AG0p/VqoJ2GcDhhoFT20=
Date:   Wed, 29 Nov 2023 03:33:22 -0500
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/6] mm/gmem: add arch-independent abstraction to
 track address mapping status
Content-Language: en-US
To:     Weixi Zhu <weixi.zhu@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     leonro@nvidia.com, apopple@nvidia.com,
        amd-gfx@lists.freedesktop.org, mgorman@suse.de, ziy@nvidia.com,
        zhi.a.wang@intel.com, rcampbell@nvidia.com, jgg@nvidia.com,
        weixi.zhu@openeuler.sh, jhubbard@nvidia.com,
        intel-gfx@lists.freedesktop.org, mhairgrove@nvidia.com,
        jglisse@redhat.com, rodrigo.vivi@intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        tvrtko.ursulin@linux.intel.com, Felix.Kuehling@amd.com,
        Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, ogabbay@kernel.org
References: <20231128125025.4449-1-weixi.zhu@huawei.com>
 <20231128125025.4449-3-weixi.zhu@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   emily <emily@ingalls.rocks>
In-Reply-To: <20231128125025.4449-3-weixi.zhu@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/23 07:50, Weixi Zhu wrote:
> This patch adds an abstraction layer, struct vm_object, that maintains
> per-process virtual-to-physical mapping status stored in struct gm_mapping.
> For example, a virtual page may be mapped to a CPU physical page or to a
> device physical page. Struct vm_object effectively maintains an
> arch-independent page table, which is defined as a "logical page table".
> While arch-dependent page table used by a real MMU is named a "physical
> page table". The logical page table is useful if Linux core MM is extended
> to handle a unified virtual address space with external accelerators using
> customized MMUs.
>
> In this patch, struct vm_object utilizes a radix
> tree (xarray) to track where a virtual page is mapped to. This adds extra
> memory consumption from xarray, but provides a nice abstraction to isolate
> mapping status from the machine-dependent layer (PTEs). Besides supporting
> accelerators with external MMUs, struct vm_object is planned to further
> union with i_pages in struct address_mapping for file-backed memory.
>
> The idea of struct vm_object is originated from FreeBSD VM design, which
> provides a unified abstraction for anonymous memory, file-backed memory,
> page cache and etc[1].
>
> Currently, Linux utilizes a set of hierarchical page walk functions to
> abstract page table manipulations of different CPU architecture. The
> problem happens when a device wants to reuse Linux MM code to manage its
> page table -- the device page table may not be accessible to the CPU.
> Existing solution like Linux HMM utilizes the MMU notifier mechanisms to
> invoke device-specific MMU functions, but relies on encoding the mapping
> status on the CPU page table entries. This entangles machine-independent
> code with machine-dependent code, and also brings unnecessary restrictions.
> The PTE size and format vary arch by arch, which harms the extensibility.
>
> [1] https://docs.freebsd.org/en/articles/vm-design/
>
> Signed-off-by: Weixi Zhu <weixi.zhu@huawei.com>
> ---
>   include/linux/gmem.h     | 120 +++++++++++++++++++++++++
>   include/linux/mm_types.h |   4 +
>   mm/Makefile              |   2 +-
>   mm/vm_object.c           | 184 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 309 insertions(+), 1 deletion(-)
>   create mode 100644 mm/vm_object.c
>
> diff --git a/include/linux/gmem.h b/include/linux/gmem.h
> index fff877873557..529ff6755a99 100644
> --- a/include/linux/gmem.h
> +++ b/include/linux/gmem.h
> @@ -9,11 +9,131 @@
>   #ifndef _GMEM_H
>   #define _GMEM_H
>   
> +#include <linux/mm_types.h>
> +
>   #ifdef CONFIG_GMEM
> +
> +#define GM_PAGE_CPU	0x10 /* Determines whether page is a pointer or a pfn number. */
> +#define GM_PAGE_DEVICE	0x20
> +#define GM_PAGE_NOMAP	0x40
> +#define GM_PAGE_WILLNEED	0x80
> +
> +#define GM_PAGE_TYPE_MASK	(GM_PAGE_CPU | GM_PAGE_DEVICE | GM_PAGE_NOMAP)
> +
> +struct gm_mapping {
> +	unsigned int flag;
> +
> +	union {
> +		struct page *page;	/* CPU node */
> +		struct gm_dev *dev;	/* hetero-node. TODO: support multiple devices */
> +		unsigned long pfn;
> +	};
> +
> +	struct mutex lock;
> +};
> +
> +static inline void gm_mapping_flags_set(struct gm_mapping *gm_mapping, int flags)
> +{
> +	if (flags & GM_PAGE_TYPE_MASK)
> +		gm_mapping->flag &= ~GM_PAGE_TYPE_MASK;
> +
> +	gm_mapping->flag |= flags;
> +}
> +
> +static inline void gm_mapping_flags_clear(struct gm_mapping *gm_mapping, int flags)
> +{
> +	gm_mapping->flag &= ~flags;
> +}
> +
> +static inline bool gm_mapping_cpu(struct gm_mapping *gm_mapping)
> +{
> +	return !!(gm_mapping->flag & GM_PAGE_CPU);
> +}
> +
> +static inline bool gm_mapping_device(struct gm_mapping *gm_mapping)
> +{
> +	return !!(gm_mapping->flag & GM_PAGE_DEVICE);
> +}
> +
> +static inline bool gm_mapping_nomap(struct gm_mapping *gm_mapping)
> +{
> +	return !!(gm_mapping->flag & GM_PAGE_NOMAP);
> +}
> +
> +static inline bool gm_mapping_willneed(struct gm_mapping *gm_mapping)
> +{
> +	return !!(gm_mapping->flag & GM_PAGE_WILLNEED);
> +}
> +
>   /* h-NUMA topology */
>   void __init hnuma_init(void);
> +
> +/* vm object */
> +/*
> + * Each per-process vm_object tracks the mapping status of virtual pages from
> + * all VMAs mmap()-ed with MAP_PRIVATE | MAP_PEER_SHARED.
> + */
> +struct vm_object {
> +	spinlock_t lock;
> +
> +	/*
> +	 * The logical_page_table is a container that holds the mapping
> +	 * information between a VA and a struct page.
> +	 */
> +	struct xarray *logical_page_table;
> +	atomic_t nr_pages;
> +};
> +
> +int __init vm_object_init(void);
> +struct vm_object *vm_object_create(struct mm_struct *mm);
> +void vm_object_drop_locked(struct mm_struct *mm);
> +
> +struct gm_mapping *alloc_gm_mapping(void);
> +void free_gm_mappings(struct vm_area_struct *vma);
> +struct gm_mapping *vm_object_lookup(struct vm_object *obj, unsigned long va);
> +void vm_object_mapping_create(struct vm_object *obj, unsigned long start);
> +void unmap_gm_mappings_range(struct vm_area_struct *vma, unsigned long start,
> +			     unsigned long end);
> +void munmap_in_peer_devices(struct mm_struct *mm, unsigned long start,
> +			    unsigned long end);
>   #else
>   static inline void hnuma_init(void) {}
> +static inline void __init vm_object_init(void)
> +{
> +}
> +static inline struct vm_object *vm_object_create(struct vm_area_struct *vma)
> +{
> +	return NULL;
> +}
> +static inline void vm_object_drop_locked(struct vm_area_struct *vma)
> +{
> +}
> +static inline struct gm_mapping *alloc_gm_mapping(void)
> +{
> +	return NULL;
> +}
> +static inline void free_gm_mappings(struct vm_area_struct *vma)
> +{
> +}
> +static inline struct gm_mapping *vm_object_lookup(struct vm_object *obj,
> +						  unsigned long va)
> +{
> +	return NULL;
> +}
> +static inline void vm_object_mapping_create(struct vm_object *obj,
> +					    unsigned long start)
> +{
> +}
> +static inline void unmap_gm_mappings_range(struct vm_area_struct *vma,
> +					   unsigned long start,
> +					   unsigned long end)
> +{
> +}
> +static inline void munmap_in_peer_devices(struct mm_struct *mm,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +}
>   #endif
>   
>   #endif /* _GMEM_H */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 957ce38768b2..4e50dc019d75 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -31,6 +31,7 @@
>   
>   struct address_space;
>   struct mem_cgroup;
> +struct vm_object;
>   
>   /*
>    * Each physical page in the system has a struct page associated with
> @@ -974,6 +975,9 @@ struct mm_struct {
>   #endif
>   		} lru_gen;
>   #endif /* CONFIG_LRU_GEN */
> +#ifdef CONFIG_GMEM
> +		struct vm_object *vm_obj;
> +#endif
>   	} __randomize_layout;
>   
>   	/*
> diff --git a/mm/Makefile b/mm/Makefile
> index f48ea2eb4a44..d2dfab012c96 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -138,4 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
>   obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>   obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>   obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> -obj-$(CONFIG_GMEM) += gmem.o
> +obj-$(CONFIG_GMEM) += gmem.o vm_object.o
> diff --git a/mm/vm_object.c b/mm/vm_object.c
> new file mode 100644
> index 000000000000..4e76737e0ca1
> --- /dev/null
> +++ b/mm/vm_object.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * arch/alpha/boot/bootp.c
> + *
> + * Copyright (C) 1997 Jay Estabrook
> + *
> + * This file is used for creating a bootp file for the Linux/AXP kernel
> + *
> + * based significantly on the arch/alpha/boot/main.c of Linus Torvalds
> + */


i believe you have made a mistake here. you will likely want to correct 
the information in this comment.

> +#include <linux/mm.h>
> +#include <linux/gmem.h>
> +
> +/*
> + * Sine VM_OBJECT maintains the logical page table under each VMA, and each VMA
> + * points to a VM_OBJECT. Ultimately VM_OBJECTs must be maintained as long as VMA
> + * gets changed: merge, split, adjust
> + */
> +static struct kmem_cache *vm_object_cachep;
> +static struct kmem_cache *gm_mapping_cachep;
> +
> +static inline void release_gm_mapping(struct gm_mapping *mapping)
> +{
> +	kmem_cache_free(gm_mapping_cachep, mapping);
> +}
> +
> +static inline struct gm_mapping *lookup_gm_mapping(struct vm_object *obj,
> +						   unsigned long pindex)
> +{
> +	return xa_load(obj->logical_page_table, pindex);
> +}
> +
> +int __init vm_object_init(void)
> +{
> +	vm_object_cachep = KMEM_CACHE(vm_object, 0);
> +	if (!vm_object_cachep)
> +		goto out;
> +
> +	gm_mapping_cachep = KMEM_CACHE(gm_mapping, 0);
> +	if (!gm_mapping_cachep)
> +		goto free_vm_object;
> +
> +	return 0;
> +free_vm_object:
> +	kmem_cache_destroy(vm_object_cachep);
> +out:
> +	return -ENOMEM;
> +}
> +
> +/*
> + * Create a VM_OBJECT and attach it to a mm_struct
> + * This should be called when a task_struct is created.
> + */
> +struct vm_object *vm_object_create(struct mm_struct *mm)
> +{
> +	struct vm_object *obj = kmem_cache_alloc(vm_object_cachep, GFP_KERNEL);
> +
> +	if (!obj)
> +		return NULL;
> +
> +	spin_lock_init(&obj->lock);
> +
> +	/*
> +	 * The logical page table maps va >> PAGE_SHIFT
> +	 * to pointers of struct gm_mapping.
> +	 */
> +	obj->logical_page_table = kmalloc(sizeof(struct xarray), GFP_KERNEL);
> +	if (!obj->logical_page_table) {
> +		kmem_cache_free(vm_object_cachep, obj);
> +		return NULL;
> +	}
> +
> +	xa_init(obj->logical_page_table);
> +	atomic_set(&obj->nr_pages, 0);
> +
> +	return obj;
> +}
> +
> +/* This should be called when a mm no longer refers to a VM_OBJECT */
> +void vm_object_drop_locked(struct mm_struct *mm)
> +{
> +	struct vm_object *obj = mm->vm_obj;
> +
> +	if (!obj)
> +		return;
> +
> +	/*
> +	 * We must enter this with VMA write-locked, which is unfortunately a
> +	 * giant lock.
> +	 */
> +	mmap_assert_write_locked(mm);
> +	mm->vm_obj = NULL;
> +
> +	xa_destroy(obj->logical_page_table);
> +	kfree(obj->logical_page_table);
> +	kmem_cache_free(vm_object_cachep, obj);
> +}
> +
> +/*
> + * Given a VA, the page_index is computed by
> + * page_index = address >> PAGE_SHIFT
> + */
> +struct gm_mapping *vm_object_lookup(struct vm_object *obj, unsigned long va)
> +{
> +	return lookup_gm_mapping(obj, va >> PAGE_SHIFT);
> +}
> +EXPORT_SYMBOL_GPL(vm_object_lookup);
> +
> +void vm_object_mapping_create(struct vm_object *obj, unsigned long start)
> +{
> +
> +	unsigned long index = start >> PAGE_SHIFT;
> +	struct gm_mapping *gm_mapping;
> +
> +	if (!obj)
> +		return;
> +
> +	gm_mapping = alloc_gm_mapping();
> +	if (!gm_mapping)
> +		return;
> +
> +	__xa_store(obj->logical_page_table, index, gm_mapping, GFP_KERNEL);
> +}
> +
> +/* gm_mapping will not be release dynamically */
> +struct gm_mapping *alloc_gm_mapping(void)
> +{
> +	struct gm_mapping *gm_mapping = kmem_cache_zalloc(gm_mapping_cachep, GFP_KERNEL);
> +
> +	if (!gm_mapping)
> +		return NULL;
> +
> +	gm_mapping_flags_set(gm_mapping, GM_PAGE_NOMAP);
> +	mutex_init(&gm_mapping->lock);
> +
> +	return gm_mapping;
> +}
> +
> +/* This should be called when a PEER_SHAERD vma is freed */
> +void free_gm_mappings(struct vm_area_struct *vma)
> +{
> +	struct gm_mapping *gm_mapping;
> +	struct vm_object *obj;
> +
> +	obj = vma->vm_mm->vm_obj;
> +	if (!obj)
> +		return;
> +
> +	XA_STATE(xas, obj->logical_page_table, vma->vm_start >> PAGE_SHIFT);
> +
> +	xa_lock(obj->logical_page_table);
> +		xas_for_each(&xas, gm_mapping, vma->vm_end >> PAGE_SHIFT) {
> +		release_gm_mapping(gm_mapping);
> +		xas_store(&xas, NULL);
> +	}
> +	xa_unlock(obj->logical_page_table);
> +}
> +
> +void unmap_gm_mappings_range(struct vm_area_struct *vma, unsigned long start,
> +			    unsigned long end)
> +{
> +	struct xarray *logical_page_table;
> +	struct gm_mapping *gm_mapping;
> +	struct page *page = NULL;
> +
> +	if (!vma->vm_mm->vm_obj)
> +		return;
> +
> +	logical_page_table = vma->vm_mm->vm_obj->logical_page_table;
> +	if (!logical_page_table)
> +		return;
> +
> +	XA_STATE(xas, logical_page_table, start >> PAGE_SHIFT);
> +
> +	xa_lock(logical_page_table);
> +	xas_for_each(&xas, gm_mapping, end >> PAGE_SHIFT) {
> +		page = gm_mapping->page;
> +		if (page && (page_ref_count(page) != 0)) {
> +			put_page(page);
> +			gm_mapping->page = NULL;
> +		}
> +	}
> +	xa_unlock(logical_page_table);
> +}
