Return-Path: <linux-kernel+bounces-104210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8E87CABB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561711F236BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DFF17C69;
	Fri, 15 Mar 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgM7KuJS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67713AC5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495040; cv=none; b=hVaThCbqCNnHkvmSKtUHgQYVtUVEU/uxKcmLRIoeEuQ3wFTvvLWOXrXurrfeOSwuOSdm42aguGhK+dCCoYD+mwAaSWStyd8e3vQDE4VYxfJSYjyaY6OgYzmbxe/o68g/b6B7Ce8C71CmZYDHUtXWWz6M+xDpe5C/+vKdrnl9MsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495040; c=relaxed/simple;
	bh=Au2WA24KOGm8FFAVvYolf7bzqfEfbKmRL43HKzXoRJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbE1Isz92mmSYXWn128cNLC89zTtJuxxIOngacAn2udvAHcSR60Wb71FUCWlKNbxd7VVNg8jSsiZi4cSVO+yMUvyPyon0GyFtzHfI+0RUudK+PHtkB3ar1WEKcyncyk8mSHVGLiR2tb4oeepqGZBvFyriiaiqqqqvNNsQ/GPURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgM7KuJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710495037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=40Zr+nDs3kuA0ooVpJfDyIYkyX5ZFovqluzneizYYw8=;
	b=KgM7KuJSe6Pb+OQF8DWvyuvqisCgEj6xCzDqH/uUij6M8QQ8zXQBtTF0V/tdQoVTQTO8H6
	pq9E5H5UKi3HmCtE40J9hBa4YFdZ/ti2n6eu/qPsOgrc3IfGNLIHGS9v0hDaCghdG6P9L+
	2397Ob7XChcMXXBpi3VVOTOQLfDEtYI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-kja3BsOvPcawcnEC_5AMmA-1; Fri, 15 Mar 2024 05:30:34 -0400
X-MC-Unique: kja3BsOvPcawcnEC_5AMmA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-60cd073522cso24790707b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710495034; x=1711099834;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40Zr+nDs3kuA0ooVpJfDyIYkyX5ZFovqluzneizYYw8=;
        b=X1F4roT3S9mihQouV1cr9k9f+t8lRezFHgs1JS6328R0p3zVRqTbMqYRob55+ZMaZX
         u8l5nn6UPW166jFJcUb/V4fp6o83oPUtY4xkeArxz2amxKN3Sme55cCHkz4ZY+6aZZ9q
         7yOzBOCBt2+l6QCjeG/tuS6dmueYuSroothwrnwUp0mqDWhwta/RRTEQA+iCP0o8YPe0
         XdSsi67clxUMcdIqhdhAOuhjepDU8wWie1Q/fCSBr8MVPC5nfduCBln2RsuX1wwt9qOO
         AQ4tf/0D2knu1oKSwVq0bmKKYYTaLSZwWg5QJWgWuPi9BGrL2zgmEigAvrKpST0iexPQ
         TuVg==
X-Forwarded-Encrypted: i=1; AJvYcCVbXNtlyq50jxxpv6Vj4jcrbtg/6Ffey1ic/y1h5CINLSP/vEPCrGXzyN7ZZuIFQUvy5MlotxGvbwxqF/ayFdD49XNxFyMoZ1N8XtgX
X-Gm-Message-State: AOJu0Yy4o7HugObJBVMXbY2dDPMLng6hKVu65MaRF/GszyY4O20B1Xqh
	VfAijFgnP7lKPJVZ46RSrSkbqMmLn4j+tQDVyD3h6UHxeswsa7TYH5TME3Txw+fYFDgOOVty+mf
	1WaOHTVnXZouzif2dEofkPZxXe1iA3e2F/9jJVmF4L2Xe59uN9LVxSv9uEg9nvQ==
X-Received: by 2002:a81:7103:0:b0:60a:470:d1bb with SMTP id m3-20020a817103000000b0060a0470d1bbmr4538617ywc.20.1710495034241;
        Fri, 15 Mar 2024 02:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfAxi6TfePiH+QBqdPhcJ3NO5ERsPPOpbPYxurW5+NOLfeylG5TitX58ATf2XTpFLFt09giw==
X-Received: by 2002:a81:7103:0:b0:60a:470:d1bb with SMTP id m3-20020a817103000000b0060a0470d1bbmr4538596ywc.20.1710495033828;
        Fri, 15 Mar 2024 02:30:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:7700:ef08:112b:278d:7d90? (p200300cbc7197700ef08112b278d7d90.dip0.t-ipconnect.de. [2003:cb:c719:7700:ef08:112b:278d:7d90])
        by smtp.gmail.com with ESMTPSA id x193-20020a81a0ca000000b00609eb9472a7sm649924ywg.41.2024.03.15.02.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 02:30:33 -0700 (PDT)
Message-ID: <8bba487c-83ac-4c34-ba29-4ab0408bdfa6@redhat.com>
Date: Fri, 15 Mar 2024 10:30:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: adds soft dirty page tracking
To: Shivansh Vij <shivanshvij@outlook.com>
Cc: shivanshvij@loopholelabs.io, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Houghton <jthoughton@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <ff65f353-6aa6-46a0-94fe-892e7b950d35@redhat.com>
 <MW4PR12MB68753331C2CC131C9D99564DB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <MW4PR12MB68753331C2CC131C9D99564DB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.24 23:32, Shivansh Vij wrote:
> Hi David,
> 
> On Tue, Mar 12, 2024 at 09:22:25AM +0100, David Hildenbrand wrote:
>> On 12.03.24 02:16, Shivansh Vij wrote:
>>
>> Hi,
>>
>>> Checkpoint-Restore in Userspace (CRIU) needs to be able
>>> to track a memory page's changes if we want to enable
>>> pre-dumping, which is important for live migrations.
>>>
>>> The PTE_DIRTY bit (defined in pgtable-prot.h) is already
>>> used to track software dirty pages, and the PTE_WRITE and
>>> PTE_READ bits are used to track hardware dirty pages.
>>>
>>> This patch enables full soft dirty page tracking
>>> (including swap PTE support) for arm64 systems, and is
>>> based very closely on the x86 implementation.
>>>
>>> It is based on an unfinished patch by
>>> Bin Lu (bin.lu@arm.com) from 2017
>>> (https://patchwork.kernel.org/project/linux-arm-kernel/patch/1512029649-61312-1-git-send-email-bin.lu@arm.com/),
>>> but has been updated for newer 6.x kernels as well as
>>> tested on various 5.x kernels.
>>
>> There has also been more recently:
>>
>> https://lore.kernel.org/lkml/20230703135526.930004-1-npache@redhat.com/#r
>>
>> I recall that we are short on SW PTE bits:
>>
>> "
>> So if you need software dirty, it can only be done with another software
>> PTE bit. The problem is that we are short of such bits (only one left if
>> we move PTE_PROT_NONE to a different location). The userfaultfd people
>> also want such bit.
>>
>> Personally I'd reuse the four PBHA bits but I keep hearing that they may
>> be used with some out of tree patches.
>> "
>>
>> https://lore.kernel.org/lkml/ZLQIaSMI74KpqsQQ@arm.com/
> 
> If I'm understanding the previous discussion (https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230703135526.930004-1-npache@redhat.com/) correctly, the core issue is that we actually do need to use a special SW PTE bit (like the PTE_SOFT_DIRTY that's in this patch) - but at the same time, the PTE bits are highly contentious so it would be ideal if we could reuse an existing bit (maybe one of the PBHA bits like you suggested) instead of creating a new one.
>   
> Is my understanding correct?

Yes, that matches my understanding. As Joey noted, the bit you chose is 
defined by HW and might soon get used.

As Catalin wrote, some OOT patches might use the PBHA bits; although I 
am not sure what the latest state on that is and if we really should 
care about OOT patches. Maybe it would be good enough to allow driver 
use only in PFNMAP mappings, and simply not use the bit for 
softdirty/uffd-wp in there.

I don't know much about PBHA, this [1] never got merged but is an 
interesting read. We are certainly short on sw bits in any case.

There was recently some discussions around why soft-dirty tracking is 
not suitable (unfixable) for some cases, buried in previous iterations 
of [2]. The outcome of that was a new UFFD_FEATURE_WP_ASYNC mode as a 
replacement for soft-dirty tracking.

So long-term, avoiding introducing soft-dirty tracking and instead 
supporting uffd-wp might be the better choice on arm64.

[1] https://lkml.kernel.org/r/20211015161416.2196-8-james.morse@arm.com
[2] 
https://lore.kernel.org/all/20230821141518.870589-1-usama.anjum@collabora.com/

-- 
Cheers,

David / dhildenb


