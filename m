Return-Path: <linux-kernel+bounces-157660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2F8B1424
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E765C1C20C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B713C9C6;
	Wed, 24 Apr 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC0csR0u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE813C3C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989351; cv=none; b=ivi9YrENkcuB1H2LJK9k+YKfihpG8LnAZt3IQQYImTyLA6kUBsS4c2skFauEsWScTA+wl8R52vUUqjfRuro3H54mGZOQZ0ZAAYVQIBETvzyrF0favebfc6Apbd+XGNvHm7ZjZ+Y7saktqCt2t/2j3iKysZC9Fs4AHZL29druh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989351; c=relaxed/simple;
	bh=Pb+nVlOkqdU7jZrYfZhsszGpThWzNPGxSneB6+5N5Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZrzj/yCHDonrQaNhr+PGbXSN4cO2xEB8lfDYHRxoXZ4I5N9wfzI5qHPcj9hSwWUS+sC/pquE+FcFMQyOZnbozBzjwocwoSgXs3X5R4ahsFNsqy9Z/ZcQ11jAw2J+FERycz03+CmfCiPetQ46MQADc5c8188DwjsNQ1EUXevUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC0csR0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713989348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gpNNAZX9PhyX15KEVWcpyu1NhxfciU5/8nxC2ZtTKK8=;
	b=PC0csR0uCv6pniojUT7XqgeRA+msqPToEIt++oj8q3PjI6XT7/H4ReLknd16hfqNdXBMW9
	CXINw6VahxsQtaokEHswHOfsMssZZwZm/vlUbokhzm5/VkthHqt2H6+lq4QfqU9g/sZBAQ
	yMiQZhxK2CtsKDRpEOIEKRa5NrKuf4Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-BXQelXEcPmGl5tbgDPKYIQ-1; Wed, 24 Apr 2024 16:09:05 -0400
X-MC-Unique: BXQelXEcPmGl5tbgDPKYIQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418f5e7b9b2so985945e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989344; x=1714594144;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpNNAZX9PhyX15KEVWcpyu1NhxfciU5/8nxC2ZtTKK8=;
        b=uTik0IZGomahUxP1ETnrG0UlVGT6k7AKyfNrXO0mIrnO2kqzg60GjgJmWchx1m2wYi
         RswvhNe3xlJTQB2X2nnMihaWYAH6KYa+jb9td6LYVn07kELUnk3d0CzCmfYjK1nxMSQp
         zNEJ86Ztr7lY1Ed9zHJscwnJNXoadrMP4NugoQAyja3XWTEDQob72NgYq3l7SYUBqkH5
         AK/izHXWyjyAugSvjUsuvgq2zRE+r+3LXtFJbmwqaL270x5MUNNf2S8QO8/w3VGDhu/K
         UJY/5p1wmjgkVgxm3oWkRJFAVQvNtIc/dAyX9fF2laQphXT4FwLpNWEtVwzYfED9Ua0B
         Of5w==
X-Forwarded-Encrypted: i=1; AJvYcCXiayqSsu+UZ15Mua9fxlD3Swf5YrbBhUy82gljZ60Xfih1ePbfKsLRpX/OFNRIzrTm7f/J5K/9fUJDnBqvTNKVveP74s+TxD4k9IUV
X-Gm-Message-State: AOJu0Yy7vgXHlFX8wNyyCZiyk6hbRuPWExZEnMle7ebwjVzec90k8ZS2
	03mbP7e4NSsvjp9ROX+3GZc74iBeVuy6zPrxTs8erSUMSLZxb4CEMzxGNirDMAviGNXwmMXAhgu
	n9O/RlVzRRA8UrZIjQWB8UDUanGIPpkolSPMsLvQuZ2rzzAsotHWMS+JcT7xcVA==
X-Received: by 2002:a05:600c:5119:b0:418:c1a3:8521 with SMTP id o25-20020a05600c511900b00418c1a38521mr2739962wms.26.1713989344406;
        Wed, 24 Apr 2024 13:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGub4zq1HTTZlBq/hcwlFktBiQXE9y/Gdmi1r5S9/EVF2fUqCU8CU2xg0nfbU7xzTc/76QcsQ==
X-Received: by 2002:a05:600c:5119:b0:418:c1a3:8521 with SMTP id o25-20020a05600c511900b00418c1a38521mr2739943wms.26.1713989343998;
        Wed, 24 Apr 2024 13:09:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm14297176wmq.17.2024.04.24.13.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:09:03 -0700 (PDT)
Message-ID: <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
Date: Wed, 24 Apr 2024 22:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZibOQI9kwzE98n12@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 22:53, Guillaume Morin wrote:
> On 22 Apr 20:59, David Hildenbrand wrote:
>>> The benefit - to me - is very clear. People do use hugetlb mappings to
>>> run code in production environments. The perf benefits are there for some
>>> workloads. Intel has published a whitepaper about it etc.
>>> Uprobes are a very good tool to do live tracing. If you can restart the
>>> process and reproduce, you should be able to disable hugetlb remapping
>>> but if you need to look at a live process, there are not many options.
>>> Not being able to use uprobes is crippling.
>>
>> Please add all that as motivation to the patch description or cover letter.
>>
>>>> Yes, libhugetlbfs exists. But why do we have to support uprobes with it?
>>>> Nobody cared until now, why care now?
>>>
>>> I think you could ask the same question for every new feature patch :)
>>
>> I have to, because it usually indicates a lack of motivation in the
>> cover-letter/patch description :P
> 
> My cover letter was indeed lacking. I will make sure to add this kind of
> details next time.
>   
>>> Since the removal a few releases ago of the __morecore() hook in glibc,
>>> the main feature of libhugetlbfs is ELF segments remapping. I think
>>> there are definitely a lot of users that simply deal with this
>>> unnecessary limitation.
>>>
>>> I am certainly not shoving this patch through anyone's throat if there
>>> is no interest. But we definitely find it a very useful feature ...
>>
>> Let me try to see if we can get this done cleaner.
>>
>> One ugly part (in general here) is the custom page replacement in the
>> registration part.
>>
>> We are guaranteed to have a MAP_PRIVATE mapping. Instead of replacing pages
>> ourselves (which we likely shouldn't do ...) ... maybe we could use
>> FAULT_FLAG_UNSHARE faults such that we will get an anonymous folio
>> populated. (like KSM does nowadays)
>>
>> Punching FOLL_PIN|FOLL_LONGTERM into GUP would achieve the same thing, but
>> using FOLL_WRITE would not work on many file systems. So maybe we have to
>> trigger an unsharing fault ourselves.

^ realizing that we already use FOLL_FORCE, so we can just use 
FOLL_WRITE to break COW.

>>
>> That would do the page replacement for us and we "should" be able to lookup
>> an anonymous folio that we can then just modify, like ptrace would.
>>
>> But then, there is also unregistration part, with weird conditional page
>> replacement. Zapping the anon page if the content matches the content of the
>> original page is one thing. But why are we placing an existing anonymous
>> page by a new anonymous page when the content from the original page differs
>> (but matches the one from the just copied page?)?
>>
>> I'll have to further think about that one. It's all a bit nasty.
>
> Sounds good to me. I am willing to help with the code when you have a
> plan or testing as you see fit. Let me know.

I'm hacking on a redesign that removes the manual COW breaking logic and 
*might* make it easier to integrate hugetlb. (very likely, but until I 
have the redesign running I cannot promise anything :) )

I'll let you know once I have something ready so you could integrate the 
hugetlb portion.

-- 
Cheers,

David / dhildenb


