Return-Path: <linux-kernel+bounces-61228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F930850F42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997401F226A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39610A23;
	Mon, 12 Feb 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvR8xfjd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82210A05
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728708; cv=none; b=PMoov8mRKRR5EO5DMuHMfD+aQjygnZRpzUhp34aWw/Zi4lF5sfSHzXPDeKsmxuIsfzuCy+PNqH5qVSCB6XnKKr8PyOy6PIB3QOZdH83xRVUWFWJw/v+borS7L8d5Y/Gh8YVraJKnwTvXZQ7HluP4hSB3P/+ZYGmjcB2zDKrmBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728708; c=relaxed/simple;
	bh=epX4ni0miOmgul2S4eAmsEkQenZYLwkDcqhBiwG1vRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZItSRwBGZUky1+JAS0+7AaGJMfvkPc8L6s4NlXR0dWSSMTYR5XmxYNl6G1mVTqw30yQ9M0AOssJhL9zPmeFPtAd1P/zuapCY7DAC59uFkxvlni3H4xGO8V5TWN/YMNldDb+l9CwYpjm/4NqR4Y5aAXl+JgukQhdeJlX3exhdE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvR8xfjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707728706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vVWqrcbvT6Jgui2UzjnuWOOc25jjYiOFrNNZqedfwL8=;
	b=cvR8xfjdX3Plurxs95HCnMnscjDr5OXV+mTL//te49z7gAUYaArvQUYczhnd0PJTgeVDXP
	vqAlVX0C7RnE4wxwVedmxpjZg/fY4YOfxqD5YVVNhekWbxMEPnX5Fwo5rhP3L8DfWqWgr+
	35/LRREoJQs+zgICfAAj1hYRLvjjusw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Ph9bMKagO0uRxktCEyI11w-1; Mon, 12 Feb 2024 04:05:04 -0500
X-MC-Unique: Ph9bMKagO0uRxktCEyI11w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51144722c56so2984227e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707728703; x=1708333503;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVWqrcbvT6Jgui2UzjnuWOOc25jjYiOFrNNZqedfwL8=;
        b=Ki29AoLP28Q/rFsuymvKKE81oA6qOLpmH4Ja4zkQPV1/klRTSsaU6rZYnfen7Oezf0
         uN1g1U7VqlkXrrSKqel0KmkrbdCCF3qUgrTOgybanc1U6bmH6ucGK+2WKXLkDoi5g7F0
         gJdrPXB9A+3NmTUBSfvIc9Tq8XwZdYCqR1wnYnrOS1SzYJhekto4AqemI+Ga4NyQxsLf
         bcZ/amw+jjjwWLhgCumuzjhVKjwSma7ATPI/pWE6z5O/dgJVj6UNT+DBNANGTqa9DQaD
         7bzOrCSuVVhmFfHCNMnWkTRntwqGMSVIuP7jHzJbShlY8rFRjjQ/tIWWSmifNJLvJ1qj
         5XMw==
X-Gm-Message-State: AOJu0YzGx7xBJ92E+8IgRhkn59AfB0bw2imX8WSulc1IXInhN+Ny2VFD
	/Wz10vUlLqtBAJVi9FFnwPYMock1WX6NH2uo7AkDMN3Jvja1wtV17a6lI289Oql6OizdVE1Dejf
	Qb+Lf4/R443rM9rJGaSkw9DKxw4IOP4GtGKUhUuS7o1LP9CvtnLTxoIoRBIRAbQ==
X-Received: by 2002:a05:6512:3244:b0:511:737d:6619 with SMTP id c4-20020a056512324400b00511737d6619mr3394154lfr.0.1707728703083;
        Mon, 12 Feb 2024 01:05:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfFLQYPUUppRMxcfUxxOUmGhf/M5SoV+8fc9TSIRJaSdT1xW8fFFDrfDFym51J8jpGjzoT0g==
X-Received: by 2002:a05:6512:3244:b0:511:737d:6619 with SMTP id c4-20020a056512324400b00511737d6619mr3394139lfr.0.1707728702691;
        Mon, 12 Feb 2024 01:05:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJyAt/qEcy62QbqvMJ5ibo9vbgg01k8AjEqOoYQacEQ6CotrHtRCBlNLIsi2PAYWJ9Uh8KjelI8qXm6IMriqOf/eOcZyNzLnAqctf4nciCHVpKYtxEDQ/l6Jxo490uj+ivb3X+awk2yGIrXFS5x1LB9RmUfCWz5LTOhgjwZWz58mPwj/qBxQ==
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b005115ea2c301sm799410lfo.49.2024.02.12.01.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 01:05:02 -0800 (PST)
Message-ID: <d5954401-5716-4054-b2c4-ac64899d6c98@redhat.com>
Date: Mon, 12 Feb 2024 10:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: Add display flag for VM_MAYOVERLAY
Content-Language: en-US
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240208084805.1252337-1-anshuman.khandual@arm.com>
 <fb157154-5661-4925-b2c5-7952188b28f5@redhat.com>
 <20240208124035.1c96c256d6e8c65f70b18675@linux-foundation.org>
 <2e7496af-0988-49fb-9582-bf6a94f08198@redhat.com>
 <e0521fe5-f7d5-404a-b646-6630ddd8a244@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e0521fe5-f7d5-404a-b646-6630ddd8a244@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.24 03:00, Anshuman Khandual wrote:
> 
> On 2/10/24 04:01, David Hildenbrand wrote:
>> On 08.02.24 21:40, Andrew Morton wrote:
>>> On Thu, 8 Feb 2024 17:48:26 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 08.02.24 09:48, Anshuman Khandual wrote:
>>>>> VM_UFFD_MISSING flag is mutually exclussive with VM_MAYOVERLAY flag as they
>>>>> both use the same bit position i.e 0x00000200 in the vm_flags. Let's update
>>>>> show_smap_vma_flags() to display the correct flags depending on CONFIG_MMU.
>>>>>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Cc: linux-fsdevel@vger.kernel.org
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>>> This applies on v6.8-rc3
>>>>>
>>>>>     fs/proc/task_mmu.c | 4 ++++
>>>>>     1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>> index 3f78ebbb795f..1c4eb25cfc17 100644
>>>>> --- a/fs/proc/task_mmu.c
>>>>> +++ b/fs/proc/task_mmu.c
>>>>> @@ -681,7 +681,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>>>>>             [ilog2(VM_HUGEPAGE)]    = "hg",
>>>>>             [ilog2(VM_NOHUGEPAGE)]    = "nh",
>>>>>             [ilog2(VM_MERGEABLE)]    = "mg",
>>>>> +#ifdef CONFIG_MMU
>>>>>             [ilog2(VM_UFFD_MISSING)]= "um",
>>>>> +#else
>>>>> +        [ilog2(VM_MAYOVERLAY)]    = "ov",
>>>>> +#endif /* CONFIG_MMU */
>>>>>             [ilog2(VM_UFFD_WP)]    = "uw",
>>>>>     #ifdef CONFIG_ARM64_MTE
>>>>>             [ilog2(VM_MTE)]        = "mt",
>>>>
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>
>>> I'm thinking
>>>
>>> Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
>>> Cc: <stable@vger.kernel.org>
>>
>> I'm having a hard time believing that anybody that runs a !MMU kernel would actually care about this bit being exposed as "ov" instead of "uw".
>>
>> So in my thinking, one could even update Documentation/filesystems/proc.rst to just mention that "uw" on !MMU is only used for internal purposes.
>>
>> But now, I actually read what that structure says:
>>
>> "Don't forget to update Documentation/ on changes."
>>
>> So, let's look there: Documentation/filesystems/proc.rst
>>
>> "Note that there is no guarantee that every flag and associated mnemonic will be present in all further kernel releases. Things get changed, the flags may be vanished or the reverse -- new added. Interpretation of their meaning might change in future as well. So each consumer of these flags has to follow each specific kernel version for the exact semantic.
>>
>> This file is only present if the CONFIG_MMU kernel configuration option is enabled."
>>
>> And in fact
>>
>> $ git grep MMU fs/proc/Makefile
>> fs/proc/Makefile:proc-$(CONFIG_MMU)     := task_mmu.o
> 
> Ahh! you are right, completely missed that.
> 
>>
>>
>> So I rewoke my RB, this patch should be dropped and was never even tested unless I am missing something important.
> 
> Fair enough, let's drop this patch. I found this via code inspection while
> looking into VM_UFFD_MISSING definition, booted with default configs which
> has CONFIG_MMU enabled. But this was an oversight, my bad.
> 

No worries, NUMMU is just absolutely weird :)

-- 
Cheers,

David / dhildenb


