Return-Path: <linux-kernel+bounces-86357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DB86C458
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E651F26FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3255E58;
	Thu, 29 Feb 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9vhfca3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465155C05
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197020; cv=none; b=uK9nF+MoaMZD6QRJ+pxdWicGZA0KS/kWwfVTkTnkxjmTPOx1Pf6O4Xn3UJ9w7P2o0Utb+zJcOD76OGyx8CsqDjwRZ4fvaCNVNpmDq0Et7gct+8q9HhlD/BOjZHh9aMvYRCBdJIYQvkZNnDRLorviy3dw7UH1z1xrNnfwooUQJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197020; c=relaxed/simple;
	bh=ROLEyceRn5qg+tZtq6hYREybjuoWzJ2JgNjEeL+453g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXpgD/R+lfL4tx46sA5Ow6OTD6/gEAkZg1xR3BOUOqkJR7IcJd8ItgtTe1yFwkGaSbQtVqWbfp15JFSDRPLusIuOuMHCmHtn+Ccx7K5smWDvgXz+4+Rylfe34Aadm1QhlvaKzW0KBIS5dpllolEwRpu1aXtCygujwWkPekNRTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9vhfca3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709197017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6gLQmjTkjHEN/mIY25iopWXLJEjouW98+K4zMvqpxEE=;
	b=F9vhfca3XlFIEy6/f8OOEjDZccZ02qUkFFX/gKL/MY7lxRDIlqj99ElgO0fRJr8fBmq2d8
	GmUsu74ISr5Ld/8UkfQEaRFuOuWNVdxa3/QoWyR0diG9kdDoD9Wi1SQLp1IBktxveNP+kt
	G9AlBlk2OlfQ72jW2cuUEhlfe9Qde/U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-MgQ_WLOQOUGZO-A2lQ7fOA-1; Thu, 29 Feb 2024 03:56:56 -0500
X-MC-Unique: MgQ_WLOQOUGZO-A2lQ7fOA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412b7dafaa7so2831475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197015; x=1709801815;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gLQmjTkjHEN/mIY25iopWXLJEjouW98+K4zMvqpxEE=;
        b=smG7i8oglilHFM4PwPgoZpbukHqONUiJvF8x6RA9BikmX6On4/GcbjBx6lL4htInsQ
         1RyUetuxBqBk0yqlg7FFpgmF9AKHhjDthHBR/W/vLwHv8rRLvJqMXbRuBbst1vIDKbAG
         rF71Fd+JDU738++HleO0MRFowFzwzjG0G90Do+kAOebL8iwW+jKb8LauwKRjHpsimxjl
         XCR0toLyH1QzcNvB3j9g4M38JDl1X1B8WVxWfY4bImK6UlZYGTyJVEaF4VgiyyuLGSN1
         2C+lUDplzbWWYIZi2SHZuKwNznzLp6Y9KC7Zpdxi/5I/pUquu5z6q5zxoYxkN3MS/Bf3
         gjkw==
X-Forwarded-Encrypted: i=1; AJvYcCXZcV8FTMJg616E0DRhLmDxS+i7yhUGcqxCpKWi6EO0NOW8IfSnVwa/5LiNyXUjz1MaUgtci9bgC4Hw8cede9GI+DPPKp5XcvEv9UDH
X-Gm-Message-State: AOJu0YwJvzkkz/M0Ky/rXpOTaNYUA+c1pYJr3tSqgOTyyfpcTqpinAzd
	c9pyNRK+YEP0Cq0VKtIHi+Z6F2C49JD9UovTGOJUJRF0FDHqH76QGlit7+fpYcGW4S/H4noT6Ej
	0dQmJjLy1WAEF0AhMnbEF36i0hZT/xr04CDum+bwGOS0emOgBlGHn6jc76N5//Q==
X-Received: by 2002:a05:600c:3106:b0:412:bfa1:fc0 with SMTP id g6-20020a05600c310600b00412bfa10fc0mr404187wmo.8.1709197014954;
        Thu, 29 Feb 2024 00:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1fFJLqhS3XqtxOabveMf38PuN1qmZhQ+iEocQtv4HziMm92RX3oPwOKCkDfVPQVJZcfEMpQ==
X-Received: by 2002:a05:600c:3106:b0:412:bfa1:fc0 with SMTP id g6-20020a05600c310600b00412bfa10fc0mr404162wmo.8.1709197014420;
        Thu, 29 Feb 2024 00:56:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:fa00:74f2:89da:ed65:8b50? (p200300cbc707fa0074f289daed658b50.dip0.t-ipconnect.de. [2003:cb:c707:fa00:74f2:89da:ed65:8b50])
        by smtp.gmail.com with ESMTPSA id dn6-20020a05600c654600b004126ca2a1cbsm4473493wmb.48.2024.02.29.00.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:56:53 -0800 (PST)
Message-ID: <038e55eb-70a9-445d-89ef-4b989eaa9c66@redhat.com>
Date: Thu, 29 Feb 2024 09:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] filemap: avoid unnecessary major faults in
 filemap_fault()
To: Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, willy@infradead.org, ying.huang@intel.com,
 fengwei.yin@intel.com, aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
 hughd@google.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20240229060907.836589-1-zhangpeng362@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240229060907.836589-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.02.24 07:09, Peng Zhang wrote:
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
> triggering a major fault. We do this check only if vma is VM_LOCKED. In
> our service test environment, the baseline is 7 major faults / 12 hours.
> After the patch is applied, no major fault will be triggered.
> 
> Testing file anonymous page read and write page fault performance in
> ext4, tmpfs and ramdisk using will-it-scale[2] on a x86 physical machine.
> The data is the average change compared with the mainline after the patch
> is applied. The test results are indicates some performance regressions.
> We do this check only if vma is VM_LOCKED, therefore, no performance
> regressions is caused for most common cases.
> 
> The test results are as follows:
>                            processes processes_idle threads threads_idle
> ext4    private file write: -0.51%    0.08%          -0.03%  -0.04%
> ext4    shared  file write:  0.135%  -0.531%          2.883% -0.772%
> ramdisk private file write: -0.48%    0.23%          -1.08%   0.27%
> ramdisk private file  read:  0.07%   -6.90%          -5.85%  -0.70%
> tmpfs   private file write: -0.344%  -0.110%          0.200%  0.145%
> tmpfs   shared  file write:  0.958%   0.101%          2.781% -0.337%
> tmpfs   private file  read: -0.16%    0.00%          -0.12%   0.41%
> 
> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
> [2] https://github.com/antonblanchard/will-it-scale/
> 
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
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
>   mm/filemap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4858d89f1b1..2668bac68df7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3181,6 +3181,42 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>   	return fpin;
>   }
>   
> +/*
> + * filemap_fault_recheck_pte - hold PTL and recheck whether pte is none.
> + * @vmf - the vm_fault for this fault.
> + *
> + * Recheck PTE as the PTE can be cleared temporarily during a read+clear/modify
> + * /write update of the PTE, eg, do_numa_page()/change_pte_range(). This will
> + * trigger an unexpected major fault, even if we use mlockall(), which may
> + * increase IO and thus cause other unexpected behavior.
> + *
> + * Return VM_FAULT_NOPAGE if the PTE is not none or pte_offset_map_lock()
> + * fails. In other cases, 0 is returned.
> + */

That documentation is imprecise, as you are not explaining the mlock 
limitation.

It's an internal helper, I'd drop all that and rather add a comment 
below right next to the conditions that are performing the check ...

> +static vm_fault_t filemap_fault_recheck_pte(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	pte_t *ptep;
> +
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return ret;

I was wondering if we also want to do:

if (!is_cow_mappinng(vma->vm_flags))
	return 0;

But likely it's not helpful.


Then add something like:

/*
  * We might have COW'ed a pageache folio and might now have an mlocked
  * anon folio mapped. The original pagecache folio is not mlocked and
  * might have been evicted. During a read+clear/modify/write update of
  * the PTE, such as done in do_numa_page()/change_pte_range(), we
  * temporarily clear the PTE under PT lock and might detect it here as
  * "none" when not holding the PT lock.
  *
  * Not rechecking the PTE under PT lock could result in an
  * unexpected major fault in an mlock'ed region. Recheck only for
  * this special scenario while holding the PT lock, to not degrade
  * non-mlocked scenarios.
  */

> +
> +	if (pmd_none(*vmf->pmd))
> +		return ret;

I'd  simply return 0 in both cases, easier to read.

> +
> +	ptep = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> +				   &vmf->ptl);
> +	if (unlikely(!ptep))
> +		return VM_FAULT_NOPAGE;
> +
> +	if (unlikely(!pte_none(ptep_get(ptep))))
> +		ret = VM_FAULT_NOPAGE;
> +
> +	pte_unmap_unlock(ptep, vmf->ptl);
> +	return ret;
> +}

-- 
Cheers,

David / dhildenb


