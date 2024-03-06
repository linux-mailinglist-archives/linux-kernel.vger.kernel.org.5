Return-Path: <linux-kernel+bounces-93745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1021A873444
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6F4B301FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2945FBB9;
	Wed,  6 Mar 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HU43I3Jn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835575DF2A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720677; cv=none; b=r6/tEKX3rq5gJZ2wxoWZtBSa+d7oNSos7VWJJAYYu9hLeohQtxsIAoK2FFr2b9Np8hI55Kdjn/NU3TzGeBj7oY7qpcTqVIkY9DPTefPkpjIw/dcxYcsFRadcIUMEBROCFmC/JVo8nj1paglXqAo4UfKud38xXJWiXvwnSPyGlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720677; c=relaxed/simple;
	bh=AUalg+eBvcXmMbNLv/deLntpdQGFLoKQEBA048I3XZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JftoNSLaxH43lQDbd+1wa1bK6vGda115z7wiTZ7MklqeUZ3uoZDMhfmk9wVRdqV1rMME9ej/fP2l//uIrfzgkX8hsInyOXJ6EnHhRuoLb0plDKmR1fLLZ+PYTx1kyjhxy6dA6enNPCLYnsBBJgZv805M+sXdxZsrdjWMIMI8J+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HU43I3Jn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709720674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nj78kHoRXsejOD7DS45NjAtcYVpsOI+dek7h1+BXJUY=;
	b=HU43I3JnLbsmFY4+7PQ0/H6zRp7U/qCXWO2FfYBMOh5O7jpiCPHxb4wb55XHu8BEbLTsDH
	NIE32TPnuh+bxsPmzgxRH8akcrYCFATSxFtCtOEq0/DfbWC5paj1bHJPaacFlp3v0+s9Ip
	L4lp169dsTQRmaZbX+vpoSR9uJTPK7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-YSquNslnO9C62_qC0HrQ4A-1; Wed, 06 Mar 2024 05:24:32 -0500
X-MC-Unique: YSquNslnO9C62_qC0HrQ4A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412edc9d70aso9893555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720671; x=1710325471;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj78kHoRXsejOD7DS45NjAtcYVpsOI+dek7h1+BXJUY=;
        b=uhUMCuUhRCiRDtbQUnOzlLv9/ixJfFIMkPEnj77FchPx/SS80qjSzRrDy61JzkRdJY
         dcLzDuaieldccmmbY+Ubk9Q0HmFRpqT8gi6Yqm7igALS4c8/Z5vfSC1RfhKyNMr4QQny
         1GFVygjuPlHXVZ2VxFUqXgBfgEg+gp9IsoLp+p9LuP4z0Eo/KL848n3sNnDBVJfpSjcV
         hGxBtXRqCkyIlNcKMsfDmYCwLOFNNwMqe+DvT1Z6CkhLsLZOoy1WOF4bvy/7Sr2G3yHv
         Fpj7vnxIs0nFDGmCQtsd6cNO/zrvLCR0l10WHL7flEJg3RAHCd9NQFfLch7e4FtViorm
         11Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWpfgT6qDu4NxjAzuUe65oUQOj/LdaSK4XnsNhvcnI4d7dhILYtwhN4og1Aohy6dXlzLDDWJzmN68JAx/3rrBD3hPTCX0MGDMFVxpkh
X-Gm-Message-State: AOJu0YwkrizK9My9UYLuJxDon7hieNKsQQGRhqkLGV+yaeR92+XQ6JgU
	YfiHOH+/btJJZbVW1YoicC4fgvcj67OwfNdq7ih7eA/9gUIsqkOG/Cn7YkpgiJ/Dsp2dUIBUgyy
	EllvwjSiEZwCbyEPwEhUFAvuEkxqJSQ+S/8yeT98v3PT/dlQs88cylNtQvDFq9Q==
X-Received: by 2002:a05:600c:34d0:b0:412:ef4b:cd5a with SMTP id d16-20020a05600c34d000b00412ef4bcd5amr2679339wmq.9.1709720671331;
        Wed, 06 Mar 2024 02:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfYJFmow2ckJ5oDsIowQOQ/+lgQNGBRCHoHUoIIhWnvWtmIYYFzz7JaA1dOB/jlx4Ai3qkaQ==
X-Received: by 2002:a05:600c:34d0:b0:412:ef4b:cd5a with SMTP id d16-20020a05600c34d000b00412ef4bcd5amr2679319wmq.9.1709720670866;
        Wed, 06 Mar 2024 02:24:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c744:e000:ec38:8ec6:b1c4:c844? (p200300cbc744e000ec388ec6b1c4c844.dip0.t-ipconnect.de. [2003:cb:c744:e000:ec38:8ec6:b1c4:c844])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b004101543e843sm23622234wmq.10.2024.03.06.02.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 02:24:30 -0800 (PST)
Message-ID: <5691dff3-a944-42f2-9848-ea7287a89192@redhat.com>
Date: Wed, 6 Mar 2024 11:24:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] filemap: avoid unnecessary major faults in
 filemap_fault()
To: Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, willy@infradead.org, ying.huang@intel.com,
 fengwei.yin@intel.com, aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
 hughd@google.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20240306083809.1236634-1-zhangpeng362@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240306083809.1236634-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.24 09:38, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
> in application, which leading to an unexpected issue[1].
> 
> This caused by temporarily cleared PTE during a read+clear/modify/write
> update of the PTE, eg, do_numa_page()/change_pte_range().
> 
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private anonymous
> page is generated after the COW is triggered. Mlockall can lock COW pages
> (anonymous pages), but the original file pages cannot be locked and may
> be reclaimed. If the global variable (private anon page) is accessed when
> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
> 
> This issue affects our traffic analysis service. The inbound traffic is
> heavy. If a major fault occurs, the I/O schedule is triggered and the
> original I/O is suspended. Generally, the I/O schedule is 0.7 ms. If
> other applications are operating disks, the system needs to wait for
> more than 10 ms. However, the inbound traffic is heavy and the NIC buffer
> is small. As a result, packet loss occurs. But the traffic analysis service
> can't tolerate packet loss.
> 
> Fix this by holding PTL and rechecking the PTE in filemap_fault() before
> triggering a major fault. We do this check only if vma is VM_LOCKED to
> reduce the performance impact in common scenarios.
> 
> In our product environment, there were 7 major faults every 12 hours.
> After the patch is applied, no major fault have been triggered.
> 
> Testing file page read and write page fault performance in ext4 and
> ramdisk using will-it-scale[2] on a x86 physical machine. The data is
> the average change compared with the mainline after the patch is applied.
> The test results are within the range of fluctuation. We do this check
> only if vma is VM_LOCKED, therefore, no performance regressions is caused
> for most common cases.
> 
> The test results are as follows:
>                            processes processes_idle  threads threads_idle
> ext4    private file write:  0.22%    0.26%           1.21%  -0.15%
> ext4    private file  read:  0.03%    1.00%           1.39%   0.34%
> ext4    shared  file write: -0.50%   -0.02%          -0.14%  -0.02%
> ramdisk private file write:  0.07%    0.02%           0.53%   0.04%
> ramdisk private file  read:  0.01%    1.60%          -0.32%  -0.02%
> 
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/
> 
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v3->v4:
> - Update the performance data and commit message
> - Check PTE without lock firstly per Huang, Ying
> - Update comments for recheck function per David Hildenbrand
> - Simply return 0 to make it easier to read per David Hildenbrand
> - Check !FAULT_FLAG_ORIG_PTE_VALID instead of pmd_none()
> 
> v2->v3:
> - Do this check only if vma is VM_LOCKED per David Hildenbrand
> - Hold PTL and recheck the PTE
> - Place the recheck code in a new function filemap_fault_recheck_pte()
> 
> v1->v2:
> - Add more test results per Huang, Ying
> - Add more comments before check PTE per Huang, Ying, David Hildenbrand
>    and Yin Fengwei
> - Change pte_offset_map_nolock to pte_offset_map as the PTL won't
>    be used
> 
> RFC->v1:
> - Add error handling when ptep == NULL per Huang, Ying and Matthew
>    Wilcox
> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>    Huang, Ying and Yin Fengwei
> - Add pmd_none() check before PTE map
> - Update commit message and add performance test information
> 
>   mm/filemap.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4858d89f1b1..31ab455c4537 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3181,6 +3181,48 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>   	return fpin;
>   }
>   
> +static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	pte_t *ptep;
> +
> +	/*
> +	 * We might have COW'ed a pagecache folio and might now have an mlocked
> +	 * anon folio mapped. The original pagecache folio is not mlocked and
> +	 * might have been evicted. During a read+clear/modify/write update of
> +	 * the PTE, such as done in do_numa_page()/change_pte_range(), we
> +	 * temporarily clear the PTE under PT lock and might detect it here as
> +	 * "none" when not holding the PT lock.
> +	 *
> +	 * Not rechecking the PTE under PT lock could result in an unexpected
> +	 * major fault in an mlock'ed region. Recheck only for this special
> +	 * scenario while holding the PT lock, to not degrade non-mlocked
> +	 * scenarios. Recheck the PTE without PT lock firstly, thereby reducing
> +	 * the number of times we hold PT lock.
> +	 */
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return 0;
> +
> +	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
> +		return 0;
> +
> +	ptep = pte_offset_map(vmf->pmd, vmf->address);
> +	if (unlikely(!ptep))
> +		return VM_FAULT_NOPAGE;
> +
> +	if (unlikely(!pte_none(ptep_get_lockless(ptep)))) {
> +		ret = VM_FAULT_NOPAGE;
> +	} else {
> +		spin_lock(vmf->ptl);

I assume the assumption is that vmf->ptl is still set from 
handle_pte_fault(). But in the meantime, we did a pte_unmap(vmf->pte).

Looking at other users of vmf->ptl, this here sticks out.

I would suggest replacing the pte_offset_map() above by a 
pte_offset_map_nolock() that gives us the ptl.


With that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


