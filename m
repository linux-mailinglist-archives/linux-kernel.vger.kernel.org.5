Return-Path: <linux-kernel+bounces-164580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489448B7F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B676F1F249A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983831836C8;
	Tue, 30 Apr 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCQnuqtS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF4180A92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501278; cv=none; b=auCeXteMylLmNfkdFvxMHGQwfzAs065fEY+LQU8C21iOweJjAbuBoO7+lM+Nq04uAXHxzTJySeiDaXDrHLVa/jHkiNHVfjMhpPJtXzZUGICPyc2j4swaQxhY0mVLtLH8s3hnqEv6ET+kasF7Q/ut4JQlgwgFVeU5UzevYJTVWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501278; c=relaxed/simple;
	bh=rND+3fkI7Edc3joMmvRi1z6kvN4kiLzAkbqK27b0PCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H2vUhXnrJTb8pAN/Wsd+HUPbONwJB/a3BryyrZS61u6zidnRUkyMxcTbCy2aR0x8Gx/+tW9243F2n+cKZKvsIMMhyc7X9y/Cl8u+G/hJeZWDo/9FOwffwBXj/Egc7AxIz3Sm/YxefKaLepYtd2d44pNUB1vY/jdFK6KkbmZ8ENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCQnuqtS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714501275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k5qGlhCzuJIQlMvPTrRxrB8N+3ffGAJAVF4sXFgfIpo=;
	b=XCQnuqtSIt7vBaW8vbaq4QL/87q/DEZD2SoZAsIMN5p8h8IRXrNGv0CRv/FIDrvCKHErbV
	ZiiRRg3tFyXPxPqmPLZp3QsNtN00hxyIjtQLP7CUIteYBXeTSm3ImXk9BnU058+PRQ5NPy
	hEkaKaWKnR24iB7+lL3Fp2y5dESSWcY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Lj2B_JH_NdKBWiwTGP4nzA-1; Tue, 30 Apr 2024 14:21:14 -0400
X-MC-Unique: Lj2B_JH_NdKBWiwTGP4nzA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34ccedec528so2003816f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501273; x=1715106073;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5qGlhCzuJIQlMvPTrRxrB8N+3ffGAJAVF4sXFgfIpo=;
        b=IuxBI/8+yWQMWBkYeCXTcVQUokXJ2z/iTr5RNQKwUppAE0ZAKHL+bSd0B0vv4AugGc
         4kdRZkwJcfHEC5BmRAj7SJzN4XEpubgYMLGSOwtTMY8qbKvoMmpWhivcxDhUn/nl01AW
         3CAwHKWyLKTSRzmwX0uXVQQTbz1b8B3vFNV93cieTbLCjc4KGj47pC+mOfOprHNn+Jxg
         QN9RYlbrT3sDeL8lkr8htw9WjyDMb0ScBLM/ZlF7U/HLrqLuB1SWjWhDxOLE/398KfjO
         VWjowK4qT1mCV+wfwaST5AiMqTAYg/5xBCdj6Cx4OgmyzEEpgC0FilhbvHi2ZEguHdNN
         4B4w==
X-Forwarded-Encrypted: i=1; AJvYcCVs0YaNdiXk0RHrcdZG+Yg+VZzw3M54QEaLn5SNlARRre3lT7mFlmsJBCY8vOgRaulGby1pbN30v6RF2/ZRFs13ZjCmR5KLKfetRjdU
X-Gm-Message-State: AOJu0YzW1a1xhQyAwYtym85UeRJj8QqycoHH2yxMV7Q3rrhaWzYKq29f
	TC2mHLJ1XAcSeWI+kaV2T1gFI4YQXm46bThTmBWdcZH0AgmoVeTbCwKfgMnVNiPEPq9K5CNAmUw
	6+c1R6H730J+/Ys8Yu7SpxaqHqY+IvFiDaV6IuXCQxUjcOcBpcaVebGM2ZW1viNwGukYbPA==
X-Received: by 2002:adf:b188:0:b0:34a:2a90:c45 with SMTP id q8-20020adfb188000000b0034a2a900c45mr304584wra.31.1714501273134;
        Tue, 30 Apr 2024 11:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEn35BVok73+HzmQpYAiCsMA5h6J4EOv4FgfRUFQYazT37K8spHrTovKy4v4H67sIY9si5gQ==
X-Received: by 2002:adf:b188:0:b0:34a:2a90:c45 with SMTP id q8-20020adfb188000000b0034a2a900c45mr304567wra.31.1714501272619;
        Tue, 30 Apr 2024 11:21:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3d00:d57f:b4c9:850e:d0b8? (p200300cbc7073d00d57fb4c9850ed0b8.dip0.t-ipconnect.de. [2003:cb:c707:3d00:d57f:b4c9:850e:d0b8])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm32448217wri.95.2024.04.30.11.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 11:21:12 -0700 (PDT)
Message-ID: <35c88b38-96e6-4092-a7e0-fd22f6d784cc@redhat.com>
Date: Tue, 30 Apr 2024 20:21:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 muchun.song@linux.dev
References: <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org> <ZjEMoHkbloHVeJ0h@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZjEMoHkbloHVeJ0h@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 17:22, Guillaume Morin wrote:
> On 26 Apr 21:55, Guillaume Morin wrote:
>>
>> On 26 Apr  9:19, David Hildenbrand wrote:
>>> A couple of points:
>>>
>>> a) Don't use page_mapcount(). Either folio_mapcount(), but likely you want
>>> to check PageAnonExclusive.
>>>
>>> b) If you're not following the can_follow_write_pte/_pmd model, you are
>>> doing something wrong :)
>>>
>>> c) The code was heavily changed in mm/mm-unstable. It was merged with t
>>> the common code.
>>>
>>> Likely, in mm/mm-unstable, the existing can_follow_write_pte and
>>> can_follow_write_pmd checks will already cover what you want in most cases.
>>>
>>> We'd need a can_follow_write_pud() to cover follow_huge_pud() and
>>> (unfortunately) something to handle follow_hugepd() as well similarly.
>>>
>>> Copy-pasting what we do in can_follow_write_pte() and adjusting for
>>> different PTE types is the right thing to do. Maybe now it's time to factor
>>> out the common checks into a separate helper.
>>
>> I tried to get the hugepd stuff right but this was the first I heard
>> about it :-) Afaict follow_huge_pmd and friends were already DTRT
> 
> I got it working on top of your uprobes-cow branch with the foll force
> patch sent friday. Still pretty lightly tested

Sorry for not replying earlier, was busy with other stuff. I'll try 
getiing that stuff into shape and send it out soonish.

> 
> I went with using one write uprobe function with some additional
> branches. I went back and forth between that and making them 2 different
> functions.

All the folio_test_hugetlb() special casing is a bit suboptimal. Likely 
we want a separate variant, because we should be sing hugetlb PTE 
functions consistently (e.g., huge_pte_uffd_wp() vs pte_uffd_wp(), 
softdirty does not exist etc.)

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 2f4e88552d3f..8a33e380f7ea 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -83,6 +83,10 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
>   	{}
>   };
>   
> +bool hugetlbfs_mapping(struct address_space *mapping) {
> +	return mapping->a_ops == &hugetlbfs_aops;

is_vm_hugetlb_page() might be what you are looking for.

[...]

>   }
>   
> -static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
> +static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len, unsigned long page_mask)
>   {
>   	void *kaddr = kmap_atomic(page);
> -	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> +	memcpy(dst, kaddr + (vaddr & ~page_mask), len);
>   	kunmap_atomic(kaddr);
>   }

>   
> -static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
> +static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len, unsigned long page_mask)
>   {
>   	void *kaddr = kmap_atomic(page);
> -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> +	memcpy(kaddr + (vaddr & ~page_mask), src, len);
>   	kunmap_atomic(kaddr);
>   }

These two changes really are rather ugly ...

An why are they even required? We get a PAGE_SIZED-based subpage of a 
hugetlb page. We only kmap that one and copy within that one.

In other words, I don't think the copy_from_page() and copy_to_page() 
changes are even required when we consistently work on subpages and not 
suddenly on head pages.

>   
> -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
> +static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode, unsigned long page_mask)
>   {
>   	uprobe_opcode_t old_opcode;
>   	bool is_swbp;
> @@ -191,7 +192,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>   	 * is a trap variant; uprobes always wins over any other (gdb)
>   	 * breakpoint.
>   	 */
> -	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
> +	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE,
> +		       page_mask);
>   	is_swbp = is_swbp_insn(&old_opcode);
>   
>   	if (is_swbp_insn(new_opcode)) {
> @@ -376,8 +378,8 @@ struct uwo_data {
>   	uprobe_opcode_t opcode;
>   };
>   
> -static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
> -		unsigned long next, struct mm_walk *walk)
> +static int __write_opcode(pte_t *ptep, unsigned long vaddr,
> +			  unsigned long page_mask, struct mm_walk *walk)


Unrelated alignment change.

>   {
>   	struct uwo_data *data = walk->private;;
>   	const bool is_register = !!is_swbp_insn(&data->opcode);
> @@ -415,9 +417,12 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
>   
>   	/* Unmap + flush the TLB, such that we can write atomically .*/
>   	flush_cache_page(vma, vaddr, pte_pfn(pte));
> -	pte = ptep_clear_flush(vma, vaddr, ptep);
> +	if (folio_test_hugetlb(folio))
> +		pte = huge_ptep_clear_flush(vma, vaddr, ptep);
> +	else
> +		pte = ptep_clear_flush(vma, vaddr, ptep);
>   	copy_to_page(page, data->opcode_vaddr, &data->opcode,
> -		     UPROBE_SWBP_INSN_SIZE);
> +		     UPROBE_SWBP_INSN_SIZE, page_mask);
>   
>   	/* When unregistering, we may only zap a PTE if uffd is disabled ... */
>   	if (is_register || userfaultfd_missing(vma))
> @@ -443,13 +448,18 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
>   	if (!identical || folio_maybe_dma_pinned(folio))
>   		goto remap;
>   
> -	/* Zap it and try to reclaim swap space. */
> -	dec_mm_counter(mm, MM_ANONPAGES);
> -	folio_remove_rmap_pte(folio, page, vma);
> -	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
> -	     folio_trylock(folio)) {
> -		folio_free_swap(folio);
> -		folio_unlock(folio);
> +	if (folio_test_hugetlb(folio)) {
> +		hugetlb_remove_rmap(folio);
> +		large = false;
> +	} else {
> +		/* Zap it and try to reclaim swap space. */
> +		dec_mm_counter(mm, MM_ANONPAGES);
> +		folio_remove_rmap_pte(folio, page, vma);
> +		if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
> +		folio_trylock(folio)) {
> +			folio_free_swap(folio);
> +			folio_unlock(folio);
> +		}
>   	}
>   	folio_put(folio);
>   
> @@ -461,11 +471,29 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
>   	 */
>   	smp_wmb();
>   	/* We modified the page. Make sure to mark the PTE dirty. */
> -	set_pte_at(mm, vaddr, ptep, pte_mkdirty(pte));
> +	if (folio_test_hugetlb(folio))
> +		set_huge_pte_at(mm , vaddr, ptep, huge_pte_mkdirty(pte),
> +				(~page_mask) + 1);
> +	else
> +		set_pte_at(mm, vaddr, ptep, pte_mkdirty(pte));
>   	return UWO_DONE;
>   }
>   
> +static int __write_opcode_hugetlb(pte_t *ptep, unsigned long hmask,
> +		unsigned long vaddr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	return __write_opcode(ptep, vaddr, hmask, walk);
> +}
> +
> +static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	return __write_opcode(ptep, vaddr, PAGE_MASK, walk);
> +}
> +
>   static const struct mm_walk_ops write_opcode_ops = {
> +	.hugetlb_entry		= __write_opcode_hugetlb,
>   	.pte_entry		= __write_opcode_pte,
>   	.walk_lock		= PGWALK_WRLOCK,
>   };
> @@ -492,7 +520,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>   		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
>   {
>   	struct uprobe *uprobe = container_of(auprobe, struct uprobe, arch);
> -	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
> +	unsigned long vaddr = opcode_vaddr & PAGE_MASK;
>   	const bool is_register = !!is_swbp_insn(&opcode);
>   	struct uwo_data data = {
>   		.opcode = opcode,
> @@ -503,6 +531,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>   	struct mmu_notifier_range range;
>   	int ret, ref_ctr_updated = 0;
>   	struct page *page;
> +	unsigned long page_size = PAGE_SIZE;
>   
>   	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
>   		return -EINVAL;
> @@ -521,7 +550,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>   	if (ret != 1)
>   		goto out;
>   
> -	ret = verify_opcode(page, opcode_vaddr, &opcode);
> +
> +	if (is_vm_hugetlb_page(vma)) {
> +		struct hstate *h = hstate_vma(vma);
> +		page_size = huge_page_size(h);
> +		vaddr &= huge_page_mask(h);
> +		page = compound_head(page);

I think we should only adjust the range we pass to the mmu notifier and 
for walking the VMA range. But we should not adjust vaddr.

Further, we should not adjust the page if possible ... ideally, we'll 
treat hugetlb folios just like large folios here and operate on subpages.

Inside __write_opcode(), we can derive the the page of interest from 
data->opcode_vaddr.

find_get_page() might need some though, if it won't return a subpage of 
a hugetlb folio. Should be solvable by a wrapper, though.

> +	}
> +	ret = verify_opcode(page, opcode_vaddr, &opcode, ~(page_size - 1));
>   	put_page(page);
>   	if (ret <= 0)
>   		goto out;


-- 
Cheers,

David / dhildenb


