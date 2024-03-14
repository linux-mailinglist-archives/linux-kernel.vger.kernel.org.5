Return-Path: <linux-kernel+bounces-103610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803187C1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721D11F222FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8337443A;
	Thu, 14 Mar 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk+vpfua"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A874432
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436367; cv=none; b=JZFm/xsC/M0Ph4Oa1x85VbVi/8Dh3HkQ+uydl889McnqJO1GXQrN23ImoALrw6TMMJtoOTao/f5nObiwJLrQk2vHnvixvKW02wFF8Xl6esHtAXHjndxgq8CrGeky4jIFQXg2k8aIQ9Evwtu1vtcnA+R+oklctlqtvgWlI91srpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436367; c=relaxed/simple;
	bh=8SH89r9VgLZVbC2YH04rFwz1FSuKeGQmHv+aE7iHqGs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/qaZyIX1/TWmuB+TgKH6NiGfyXczE/a2epq0Y4bPu/WfbI9NmHRXCrlRNFtxnZ4p+l4rGD0vN+nDpVW33Jpd+5HSBNQ3xz1wCvxN0NwbcuQovHro7Rns7faNUoy+gsqN4qy/8EnfZ0r6Hjp1po7jKL92zzdaIIyCFeV3u1s0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk+vpfua; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710436364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jU88mEoWN+vKuUhUsac7rcWQgkf0tdyCzzrujyIsjic=;
	b=Lk+vpfuaj38kl7Q4DZo3x/5RItdXtf/93zKRoSuMJ5LJZ7flEkJZlUe7LeYf5w56NmQfzs
	YnA1ucJMVq7GyDEx8pDKZ3iFSFG7z/xN7htQHwVFm0eM/wl4zxMISl33UC0cTeYCxk7tTe
	kjHejJC1AUerP1NMD4M7DWNeUR6tG7o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-h-BFtA9yO9a7SUMeQ-tnhQ-1; Thu, 14 Mar 2024 13:12:42 -0400
X-MC-Unique: h-BFtA9yO9a7SUMeQ-tnhQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513b3ca9650so1028807e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436360; x=1711041160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jU88mEoWN+vKuUhUsac7rcWQgkf0tdyCzzrujyIsjic=;
        b=i1PS3NlmejhtTFyLbLurXQWIIYBI6JHfwmFNmlALal3pBDuOFAmexO9aHuVmkQgwQC
         T/p2koUQmyxEeslq+hiHgckac3K9qJ72Ma5dRus2Hb3ZwfWYQoGItETlNUixI6oLqJBc
         5Z9zBFYtZfBBSsP+jrF98Hzj8Rm2HVd86Db4i2mb7JSwCUoIH9N69dgPXqC1uzJ18bCQ
         i8RafjB0P+tR3kCd5PKE0r1FREKWv9KqbJL7KhmZEMpqAL778t8AvClSQ2q4OvnG1fnQ
         M7sekZ5SbMkT4G5XaHwhnyqirLkTCi5i0uegXP/ZjuRxVrGC2Jq1MYZiVe3klGDIgdtI
         7rFg==
X-Gm-Message-State: AOJu0YztSdY+F8VH9rRN7z8c8mJ5upbfql3Vxg0HBD5GqEmPlfjiEpwz
	oUM52dhDAhBxAJZPvq4JBmP4U9nASN0/0XWvOP7n+KnyJITm7uKvcRHAUvdTO7PtMw2lMTWWjFH
	ZjZAq3HchcLJ2K4OehOlW0UukA8v9nsCuFar4LVMMJAHh27zmtwirjfOpodS3gQ==
X-Received: by 2002:ac2:4db1:0:b0:513:cd23:3d60 with SMTP id h17-20020ac24db1000000b00513cd233d60mr1758798lfe.0.1710436360724;
        Thu, 14 Mar 2024 10:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZlI/n+b+LxojXkYh0Iv42sQZNJdTurTJxH0xsgCW3apd9Y3cQPJ8oYD7eJgQWqKK8su9J2A==
X-Received: by 2002:ac2:4db1:0:b0:513:cd23:3d60 with SMTP id h17-20020ac24db1000000b00513cd233d60mr1758774lfe.0.1710436360328;
        Thu, 14 Mar 2024 10:12:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:a00:7d7d:3665:5fe4:7127? (p200300cbc7090a007d7d36655fe47127.dip0.t-ipconnect.de. [2003:cb:c709:a00:7d7d:3665:5fe4:7127])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033e7eba040dsm1181293wrp.97.2024.03.14.10.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:12:39 -0700 (PDT)
Message-ID: <5aeaf72c-849a-4be2-bfa0-0425f3834788@redhat.com>
Date: Thu, 14 Mar 2024 18:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 Wupeng Ma <mawupeng1@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
 <1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.03.24 17:42, David Hildenbrand wrote:
> On 12.03.24 20:38, David Hildenbrand wrote:
>> On 12.03.24 20:22, Matthew Wilcox wrote:
>>> On Tue, Mar 12, 2024 at 07:11:18PM +0100, David Hildenbrand wrote:
>>>> PAT handling won't do the right thing in COW mappings: the first PTE
>>>> (or, in fact, all PTEs) can be replaced during write faults to point at
>>>> anon folios. Reliably recovering the correct PFN and cachemode using
>>>> follow_phys() from PTEs will not work in COW mappings.
>>>
>>> I guess the first question is: Why do we want to support COW mappings
>>> of VM_PAT areas?  What breaks if we just disallow it?
>>
>> Well, that was my first approach. Then I decided to be less radical (IOW
>> make my life easier by breaking less user space) and "fix it" with
>> minimal effort.
>>
>> Chances of breaking some weird user space is possible, although I
>> believe for most such mappings MAP_PRIVATE doesn't make too much sense
>> sense.
>>
>> Nasty COW support for VM_PFNMAP mappings dates back forever. So does PAT
>> support.
>>
>> I can try finding digging through some possible user space users tomorrow.
> 
> As discussed, MAP_PRIVATE doesn't make too much sense for most PFNMAP
> mappings.
> 
> However, /dev/mem and /proc/vmcore are still used with MAP_PRIVATE in
> some cases.
> 
> Side note: /proc/vmcore is a bit weird: mmap_vmcore() sets VM_MIXEDMAP,
> and then we might call remap_pfn_range(), which sets VM_PFNMAP. I'm not
> so sure if that's what we want to happen ...

Correction: at least mmap_vmcore() ends up clearing VM_MAYWRITE. So no 
COW mapping. We could do the same to at least keep PROT_READ|MAP_PRIVATE 
working. If user space specified PROT_WRITE for whatever reason, it's 
not that easy.

-- 
Cheers,

David / dhildenb


