Return-Path: <linux-kernel+bounces-52143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331684948F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D671C23E8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314D10A11;
	Mon,  5 Feb 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjmnvuqE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCB10A09
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118284; cv=none; b=ltFdBGRTnf5cNLSblQKKa3fV2GXHBhChIqQ8JIcoEvTs1D4XbvpEANb6y2OxnZLvlh3/KT6v5Qj8FT9l9eRvDdUXPRUsJF5EqQeGlDiVw1iFlBO8iJzPOfQWp8lGc4BugMCEkn9k4KXADYZ5JMFeAFjzI11sMi/2GMk/Af54IrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118284; c=relaxed/simple;
	bh=sX5ZjFLHVO5wziKXM5xgSkQfQucm2FfknhOaxBTL8Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEs1oZe5maYgXuAJLimA6RwK/+sO6JvkyCfj6KAaX92LaRj283/fnOwWfKkj2oZizCJBlCabZ1qWdaAS+huVyuinj+VXfHIHPOD1Nwy0QI7NSE4f6/Qrb+ut4aMjfdJA1HzzGk5KpPlFGunelBGsngp6dfsujqUe62TJOaq+PJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjmnvuqE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707118281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wMJ30afySF8exXiwPIpv+F4qOMEGushGjR0KqMJAnuc=;
	b=PjmnvuqET56wyNj6df6gWoZVZFyGa5NKjFgpxj/o9PX97tNfge1gYAewrVjZQm1280Nx0Q
	VOZOccM+EUuY5cuzDCl+haSgw29/DcygQm+2yKZZjb6+8iF3AB/t0ZKug4nNpr+Gezcpz/
	8pF/iTz5zmYKALsqaEG0D1GUlBRxPCc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Oo0Akg_SPpSuP_SGmKmRkg-1; Mon, 05 Feb 2024 02:31:19 -0500
X-MC-Unique: Oo0Akg_SPpSuP_SGmKmRkg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b1799e433so1748878f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 23:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118278; x=1707723078;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMJ30afySF8exXiwPIpv+F4qOMEGushGjR0KqMJAnuc=;
        b=QmtAss/RSAcP8wujwZrG/jRYSPGV3liSbQ3kGAXjl9pidpAP4ohkUuiZoJSILHcKhA
         ++RWV4phPiRry9ZNYAkUoSVE6+C5j7aV4LnDcGTbrhOo76OdE/KLnoacoOCBYW4PF8uB
         /Vhm8y28jephpu2QqqV+tB/dw0JVaWPtaSFUE/Fj0qOHepGRNAHFLT7UXbX+LDm39Ws5
         /vKnzejp2pYW4LHmisSL22vzOIBWq2OOIqtsHybmHS6MXE6ha14/v5CDs8hVx5AmYnG2
         n4tkDOdsu0KX1TAC05GPOuvDcFQyqGuWd9OKBlNoY41X+PuI73RKCuJ7Bln2ksddZDTH
         wGKQ==
X-Gm-Message-State: AOJu0Yyg6y4k0R0n6At3OpubOc/9Jzv5EouFWN2N7JSwXenc2EDlDAwv
	8GH6yJaB8s2nfrp68mZlKzhV3rQGWPa5LG/XbVTUVf+kiKgf4WjkZM4ONrfEFY/D+BrN2y6BXkd
	cjCjVMAca2WujBJzG7/EjICM9neM5pGH/XRzPCJbHO+OyoL6TepDgjEZNpzQDNQ==
X-Received: by 2002:a5d:43d1:0:b0:33b:2a02:619f with SMTP id v17-20020a5d43d1000000b0033b2a02619fmr3418289wrr.51.1707118278092;
        Sun, 04 Feb 2024 23:31:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEznEffocQHwwY3hdIlN8/u8O5bMoIM4mtVw/B+QzTO/xVVAjSiuZwTWjKhVbus3TECQSRJyQ==
X-Received: by 2002:a5d:43d1:0:b0:33b:2a02:619f with SMTP id v17-20020a5d43d1000000b0033b2a02619fmr3418272wrr.51.1707118277694;
        Sun, 04 Feb 2024 23:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfp5mYUlKOQqSAn3fh0csthWYdL6fvKXsyR+0bgbAqNQg8+dEkCd7FAnnjGTVZ0wyLDMvSI5BK2ZkkwYWKgdHgYeA3VLlptPXI4yjXbcEuiNe4MjV81u6ZPKnqLyB+p08kplFdcTcbm4pl60iCMsTyF4HRhboDYGwb1NXCK4zvnZdC68eiMAzIqrj3/SYAnMsVk7Xb+oPYw/VXW2gTZTbdnQc0UR5Z32F2/tdC5zuIANe/z1L/XOdlesGnJvEUjB0hwnr8yJTG2nN5LUXgyqMXCwygSoG3olKW9fRfudnRHgA7fIxY4leb4vR/kfGTECeffWQFTNwPgkEX6S043Bc94aRk5e/hqL4=
Received: from [10.218.83.77] ([88.128.88.102])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b0040fb0c90da6sm7641977wmq.14.2024.02.04.23.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 23:31:17 -0800 (PST)
Message-ID: <1a967b8d-7218-4d3f-9dd2-ae1c66f626c7@redhat.com>
Date: Mon, 5 Feb 2024 08:31:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>,
 "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, willy@infradead.org, fengwei.yin@intel.com,
 aneesh.kumar@linux.ibm.com, shy828301@gmail.com, hughd@google.com,
 wangkefeng.wang@huawei.com
References: <20240204093526.212636-1-zhangpeng362@huawei.com>
 <87zfwf39ha.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <85e03dd9-8bd7-d516-ebe4-84dd449a9fb2@huawei.com>
 <87mssf2yiv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <25de8872-ad79-e5e6-054c-9ac5e7191416@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <25de8872-ad79-e5e6-054c-9ac5e7191416@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.02.24 08:24, zhangpeng (AS) wrote:
> On 2024/2/5 14:52, Huang, Ying wrote:
> 
>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>> On 2024/2/5 10:56, Huang, Ying wrote:
>>>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>
>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>
>>>>> This caused by temporarily cleared PTE during a read/modify/write update
>>>>> of the PTE, eg, do_numa_page()/change_pte_range().
>>>>>
>>>>> For the data segment of the user-mode program, the global variable area
>>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>
>>>>> At this time, the original private file page may have been reclaimed.
>>>>> If the page cache is not available at this time, a major fault will be
>>>>> triggered and the file will be read, causing additional overhead.
>>>>>
>>>>> Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
>>>>> before triggering a major fault.
>>>>>
>>>>> Testing file anonymous page read and write page fault performance in ext4
>>>>> and ramdisk using will-it-scale[2] on a x86 physical machine. The data
>>>>> is the average change compared with the mainline after the patch is
>>>>> applied. The test results are within the range of fluctuation, and there
>>>>> is no obvious difference. The test results are as follows:
>>>>> 			processes processes_idle threads threads_idle
>>>>> ext4 file write:	-1.14%    -0.08%         -1.87%  0.13%
>>>>> ext4 file read:		 0.03%	  -0.65%         -0.51%	-0.08%
>>>>> ramdisk file write:	-1.21%    -0.21%         -1.12%  0.11%
>>>>> ramdisk file read:	 0.00%    -0.68%         -0.33% -0.02%
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>>> [2] https://github.com/antonblanchard/will-it-scale/
>>>>>
>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>> RFC->v1:
>>>>> - Add error handling when ptep == NULL per Huang, Ying and Matthew Wilcox
>>>>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>>>>      Huang, Ying and Yin Fengwei
>>>>> - Add pmd_none() check before PTE map
>>>>> - Update commit message and add performance test information
>>>>>
>>>>>     mm/filemap.c | 18 ++++++++++++++++++
>>>>>     1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>> index 142864338ca4..b29cdeb6a03b 100644
>>>>> --- a/mm/filemap.c
>>>>> +++ b/mm/filemap.c
>>>>> @@ -3238,6 +3238,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>>     			mapping_locked = true;
>>>>>     		}
>>>>>     	} else {
>>>>> +		if (!pmd_none(*vmf->pmd)) {
>>>>> +			pte_t *ptep;
>>>>> +
>>>>> +			ptep = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>>>> +						     vmf->address, &vmf->ptl);
>>>>> +			if (unlikely(!ptep))
>>>>> +				return VM_FAULT_NOPAGE;
>>>>> +			/*
>>>>> +			 * Recheck pte as the pte can be cleared temporarily
>>>>> +			 * during a read/modify/write update.
>>>>> +			 */
>>>> I think that we should add some comments here about the racy checking.
>>> I'll add comments in a v2 as follows:
>>> /*
>>>    * Recheck PTE as the PTE can be cleared temporarily
>>>    * during a read/modify/write update of the PTE, eg,
>>>    * do_numa_page()/change_pte_range(). This will trigger
>>>    * a major fault, even if we use mlockall, which may
>>>    * affect performance.
>>>    */
>> Sorry, my previous words aren't clear enough.  I mean some comments as
>> follows,
>>
>> We don't hold PTL here, so the check is still racy.  But acquiring PTL
>> hurts performance and the race window seems small enough.
> 
> Got it. I'll add comments in a v2 as follows:
> /*
>    * Recheck PTE as the PTE can be cleared temporarily
>    * during a read/modify/write update of the PTE.
>    * We don't hold PTL here as acquiring PTL hurts
>    * performance. So the check is still racy, but
>    * the race window seems small enough.
>    */

It'd be worth spelling out what happens when we lose the race.

-- 
Cheers,

David / dhildenb


