Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84238805C05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjLEQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjLEQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F36A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701795483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ELf8MFiiC+U22XjQQS3STGR+Op06anfDzFy1HDxkZQ0=;
        b=IZe1hik5SGB5fP464kIXKKMry4Qf9kyUzSwYdLQdgxwNLMqdAc4X/quzuTQNskc4O4ZXhr
        XiaJSdUN3Z0pZVbPbw4tGDp79tq5P+I+ElTrEFVUEQ1s2P4byJh90AJZJ8FX2Ixq8Pma94
        aXnTqbgWh8nYAdBj8tOGR5/11iShVLQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-tfvjPQH4MXe1QO5RMQgrJQ-1; Tue, 05 Dec 2023 11:58:02 -0500
X-MC-Unique: tfvjPQH4MXe1QO5RMQgrJQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b443d698eso40737625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795481; x=1702400281;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELf8MFiiC+U22XjQQS3STGR+Op06anfDzFy1HDxkZQ0=;
        b=GNYI2GbiYzspLrfPneMtLGMLyH0V5pF5BV2FHm4H5SKyQDZ8GCTmHayrWnohvUeyOU
         p7zZ6cKn0seBHCcQSglDSziU3wngjvAV3Fb+bO/Lbpb1fF+aIwR07l0SnwNeDJ9Jhzwi
         owU1EbkdvQ8kHIUUBlfGMFTJtqylbf7TVOk0IdjMOMhFD5IfEiU9+KnQiKVI1yQrXn6X
         EkuTo62fakzcH9y8aMqJVjWOaSL5uQueJtmFqoTaBmWhysf4nOwkB+fmlasdPpSz/4R/
         pU9fuwegau1gxO3z0nJSiYeJl2E+/kv/e8JtdoOoqg38r2b5I6wAOPCzxeFyqOt3W9vt
         Hdiw==
X-Gm-Message-State: AOJu0YySEODiVXAxchsARBXsN4AbdVobXS0a6KqhTJM/zVf5pEao0m7f
        odqOKabAbgQK3gYl1kjntyBmEXij9M08KZkStshl4yrnnYaZDmT27BZoRvbJOSmb59ay7sbvBGW
        gmuto2KIMHBPHga9nS2cnJ5/Z
X-Received: by 2002:a1c:7214:0:b0:40b:5e21:d346 with SMTP id n20-20020a1c7214000000b0040b5e21d346mr742433wmc.79.1701795480969;
        Tue, 05 Dec 2023 08:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZLZ5WaCMtpImiv8y3olD07A0P1y1RYRKjS3FNUCmZ0vK2nZcqPGFt9+yACNOL+6egHrVA6Q==
X-Received: by 2002:a1c:7214:0:b0:40b:5e21:d346 with SMTP id n20-20020a1c7214000000b0040b5e21d346mr742409wmc.79.1701795480460;
        Tue, 05 Dec 2023 08:58:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b0040839fcb217sm19586724wmp.8.2023.12.05.08.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:58:00 -0800 (PST)
Message-ID: <004ed23d-5571-4474-b7fe-7bc08817c165@redhat.com>
Date:   Tue, 5 Dec 2023 17:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-4-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204102027.57185-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.23 11:20, Ryan Roberts wrote:
> In preparation for adding support for anonymous multi-size THP,
> introduce new sysfs structure that will be used to control the new
> behaviours. A new directory is added under transparent_hugepage for each
> supported THP size, and contains an `enabled` file, which can be set to
> "inherit" (to inherit the global setting), "always", "madvise" or
> "never". For now, the kernel still only supports PMD-sized anonymous
> THP, so only 1 directory is populated.
> 
> The first half of the change converts transhuge_vma_suitable() and
> hugepage_vma_check() so that they take a bitfield of orders for which
> the user wants to determine support, and the functions filter out all
> the orders that can't be supported, given the current sysfs
> configuration and the VMA dimensions. If there is only 1 order set in
> the input then the output can continue to be treated like a boolean;
> this is the case for most call sites. The resulting functions are
> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
> respectively.
> 
> The second half of the change implements the new sysfs interface. It has
> been done so that each supported THP size has a `struct thpsize`, which
> describes the relevant metadata and is itself a kobject. This is pretty
> minimal for now, but should make it easy to add new per-thpsize files to
> the interface if needed in future (e.g. per-size defrag). Rather than
> keep the `enabled` state directly in the struct thpsize, I've elected to
> directly encode it into huge_anon_orders_[always|madvise|inherit]
> bitfields since this reduces the amount of work required in
> thp_vma_allowable_orders() which is called for every page fault.
> 
> See Documentation/admin-guide/mm/transhuge.rst, as modified by this
> commit, for details of how the new sysfs interface works.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Some comments mostly regarding thp_vma_allowable_orders and friends. In 
general, LGTM. I'll have to go over the order logic once again, I got a 
bit lost once we started mixing anon and file orders.

[...]

Doc updates all looked good to me, skimming over them.

> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fa0350b0812a..bd0eadd3befb 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h

[...]

> +static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long orders)
> +{
> +	int order;
> +
> +	/*
> +	 * Iterate over orders, highest to lowest, removing orders that don't
> +	 * meet alignment requirements from the set. Exit loop at first order
> +	 * that meets requirements, since all lower orders must also meet
> +	 * requirements.
> +	 */
> +
> +	order = first_order(orders);

nit: "highest_order" or "largest_order" would be more expressive 
regarding the actual semantics.

> +
> +	while (orders) {
> +		unsigned long hpage_size = PAGE_SIZE << order;
> +		unsigned long haddr = ALIGN_DOWN(addr, hpage_size);
> +
> +		if (haddr >= vma->vm_start &&
> +		    haddr + hpage_size <= vma->vm_end) {
> +			if (!vma_is_anonymous(vma)) {
> +				if (IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> +						vma->vm_pgoff,
> +						hpage_size >> PAGE_SHIFT))
> +					break;
> +			} else
> +				break;

Comment: Codying style wants you to use if () {} else {}

But I'd recommend for the conditions:

if (haddr < vma->vm_start ||
     haddr + hpage_size > vma->vm_end)
	continue;
/* Don't have to check pgoff for anonymous vma */
if (!vma_is_anonymous(vma))
	break;
if (IS_ALIGNED((...
	break;

[...]


> +/**
> + * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
> + * @vma:  the vm area to check
> + * @vm_flags: use these vm_flags instead of vma->vm_flags
> + * @smaps: whether answer will be used for smaps file
> + * @in_pf: whether answer will be used by page fault handler
> + * @enforce_sysfs: whether sysfs config should be taken into account
> + * @orders: bitfield of all orders to consider
> + *
> + * Calculates the intersection of the requested hugepage orders and the allowed
> + * hugepage orders for the provided vma. Permitted orders are encoded as a set
> + * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
> + * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
> + *
> + * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
> + * orders are allowed.
> + */
> +unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> +				       unsigned long vm_flags, bool smaps,
> +				       bool in_pf, bool enforce_sysfs,
> +				       unsigned long orders)
> +{
> +	/* Check the intersection of requested and supported orders. */
> +	orders &= vma_is_anonymous(vma) ?
> +			THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
> +	if (!orders)
> +		return 0;

Comment: if this is called from some hot path, we might want to move as 
much as possible into a header, so we can avoid this function call here 
when e.g., THP are completely disabled etc.

> +
>   	if (!vma->vm_mm)		/* vdso */
> -		return false;
> +		return 0;
>   
>   	/*
>   	 * Explicitly disabled through madvise or prctl, or some
> @@ -88,16 +141,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>   	 * */
>   	if ((vm_flags & VM_NOHUGEPAGE) ||
>   	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -		return false;
> +		return 0;
>   	/*
>   	 * If the hardware/firmware marked hugepage support disabled.
>   	 */
>   	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
> -		return false;
> +		return 0;
>   
>   	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>   	if (vma_is_dax(vma))
> -		return in_pf;
> +		return in_pf ? orders : 0;
>   
>   	/*
>   	 * khugepaged special VMA and hugetlb VMA.
> @@ -105,17 +158,29 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>   	 * VM_MIXEDMAP set.
>   	 */
>   	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
> -		return false;
> +		return 0;
>   
>   	/*
> -	 * Check alignment for file vma and size for both file and anon vma.
> +	 * Check alignment for file vma and size for both file and anon vma by
> +	 * filtering out the unsuitable orders.
>   	 *
>   	 * Skip the check for page fault. Huge fault does the check in fault
> -	 * handlers. And this check is not suitable for huge PUD fault.
> +	 * handlers.
>   	 */
> -	if (!in_pf &&
> -	    !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> -		return false;
> +	if (!in_pf) {
> +		int order = first_order(orders);
> +		unsigned long addr;
> +
> +		while (orders) {
> +			addr = vma->vm_end - (PAGE_SIZE << order);
> +			if (thp_vma_suitable_orders(vma, addr, BIT(order)))
> +				break;

Comment: you'd want a "thp_vma_suitable_order" helper here. But maybe 
the compiler is smart enough to optimize the loop and everyything else out.

[...]

> +
> +static ssize_t thpsize_enabled_store(struct kobject *kobj,
> +				     struct kobj_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	int order = to_thpsize(kobj)->order;
> +	ssize_t ret = count;
> +
> +	if (sysfs_streq(buf, "always")) {
> +		set_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_inherit);
> +		clear_bit(order, &huge_anon_orders_madvise);
> +	} else if (sysfs_streq(buf, "inherit")) {
> +		set_bit(order, &huge_anon_orders_inherit);
> +		clear_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_madvise);
> +	} else if (sysfs_streq(buf, "madvise")) {
> +		set_bit(order, &huge_anon_orders_madvise);
> +		clear_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_inherit);
> +	} else if (sysfs_streq(buf, "never")) {
> +		clear_bit(order, &huge_anon_orders_always);
> +		clear_bit(order, &huge_anon_orders_inherit);
> +		clear_bit(order, &huge_anon_orders_madvise);

Note: I was wondering for a second if some concurrent cames could lead 
to an inconsistent state. I think in the worst case we'll simply end up 
with "never" on races.

[...]

>   static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>   {
>   	int err;
> +	struct thpsize *thpsize;
> +	unsigned long orders;
> +	int order;
> +
> +	/*
> +	 * Default to setting PMD-sized THP to inherit the global setting and
> +	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
> +	 * constant so we have to do this here.
> +	 */
> +	huge_anon_orders_inherit = BIT(PMD_ORDER);
>   
>   	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>   	if (unlikely(!*hugepage_kobj)) {
> @@ -434,8 +631,24 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>   		goto remove_hp_group;
>   	}
>   
> +	orders = THP_ORDERS_ALL_ANON;
> +	order = first_order(orders);
> +	while (orders) {
> +		thpsize = thpsize_create(order, *hugepage_kobj);
> +		if (IS_ERR(thpsize)) {
> +			pr_err("failed to create thpsize for order %d\n", order);
> +			err = PTR_ERR(thpsize);
> +			goto remove_all;
> +		}
> +		list_add(&thpsize->node, &thpsize_list);
> +		order = next_order(&orders, order);
> +	}
> +
>   	return 0;
>   

[...]

>   	page = compound_head(page);
> @@ -5116,7 +5116,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>   		return VM_FAULT_OOM;
>   retry_pud:
>   	if (pud_none(*vmf.pud) &&
> -	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
> +	    thp_vma_allowable_orders(vma, vm_flags, false, true, true,
> +				     BIT(PUD_ORDER))) {
>   		ret = create_huge_pud(&vmf);
>   		if (!(ret & VM_FAULT_FALLBACK))
>   			return ret;
> @@ -5150,7 +5151,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>   		goto retry_pud;
>   
>   	if (pmd_none(*vmf.pmd) &&
> -	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
> +	    thp_vma_allowable_orders(vma, vm_flags, false, true, true,
> +				     BIT(PMD_ORDER))) {

Comment: A helper like "thp_vma_allowable_order(vma, PMD_ORDER)" might 
make this easier to read -- and the implemenmtation will be faster.

>   		ret = create_huge_pmd(&vmf);
>   		if (!(ret & VM_FAULT_FALLBACK))
>   			return ret;
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e0b368e545ed..64da127cc267 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -268,7 +268,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			 * cleared *pmd but not decremented compound_mapcount().
>   			 */
>   			if ((pvmw->flags & PVMW_SYNC) &&
> -			    transhuge_vma_suitable(vma, pvmw->address) &&
> +			    thp_vma_suitable_orders(vma, pvmw->address,
> +						    BIT(PMD_ORDER)) &&

Comment: Similarly, a helper like "thp_vma_suitable_order(vma, 
PMD_ORDER)" might make this easier to read.

>   			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
>   				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
>   

-- 
Cheers,

David / dhildenb

