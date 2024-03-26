Return-Path: <linux-kernel+bounces-118572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98588BCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA08B21C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DEB17722;
	Tue, 26 Mar 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9MlTvoG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B214A8E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442921; cv=none; b=mECoHmbSt9h7yZ/e839W9/OnKIgaQIOFNVlpnhJPPY9l7XO6yqKq1JVAwYbHEU0sjoCa2KHdR2HGo88JRgK8z2mh0dPLyQmdBDpxQpYtEyLgcTzL1gtB0mLEfR+zdN47OCmcfL5Zrw/rI7Svv5UT1enF2P99AGVirTqUo+qreHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442921; c=relaxed/simple;
	bh=D8XgC1O5xlXz4PYdorgayTU2zrKCTqzG4WpmHmIKjVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkXiYZ8PkIWcdNx8ga+bSUioK7lXrIRqVmfxGpGM9gAF6s43dpV78I/XLK+R0TmNDf4C5f0lBF3ibLAefZv6oeLm7rm2a6MATcSugpOMsprYyv5a2ZRZkENg63CrZ5LmPn6nb9NkulBmjuvfAP7hRf+hnOr0m/tsUFPwOOBER/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9MlTvoG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711442918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B4Ry2gv91UBkoNi7nbBo8t0svMaWG3chrCLs53k5H2g=;
	b=e9MlTvoG52a9PWbZu2+kt7HWE6VyKLxTxUwnzeMUhPdg1pmZkMLwRskxcUqEucA3BHxxtd
	z/QAIYgRUZzFUuKfItmVWaaG2UKqcecEH8Dt2HmcLmNbLYGfc2eqosCbmLxIpKZf0N5SMZ
	Cb5wZSKrA64aUkL/amKvWwBrNYTn9Sk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Yr7CsFopM6W4yD9LyOfH2Q-1; Tue, 26 Mar 2024 04:48:37 -0400
X-MC-Unique: Yr7CsFopM6W4yD9LyOfH2Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ecf15c037so4177872f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711442916; x=1712047716;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4Ry2gv91UBkoNi7nbBo8t0svMaWG3chrCLs53k5H2g=;
        b=J5T7U9Ui6TSpq8bjW1ELzNPMrKJxDrrp1mWfJ8u0HvZrTez6MPuLna7AxqJlcW/3lK
         3bkfEOWzUflEVOSAwSJPAxNP/s2cU6XvIHjleb0SMkPKEBNHFtM87RqPupWkO9ArUg4f
         8jAvJyuUpUB/sfAZ1PvXQywR+/FJGjUQ6JSErzMdIsV3b2mNRJGz1tdN1SntnC5ViCzt
         w0I+gt8/NhMcA/0DkHYm7jHWwE0b7we4lsSwclMVP8uGipfaoVrDa83pJP7USkY7wcJu
         Jx57lrtnAUX0b/cvh5/Ud2L4cll0uYIHuq5N0E5jX6nRicW5A9J66oXoEaGX6+ZAhIoS
         R3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnUhLVOkwYm8DjR3HLkN0ZyNB2hKMKJoAygMH8Tam7CMapTeMZ/sDsuLNtqZUwp3XKuGSj+7wTzob/D8qy8mfLhSblzJiM6higYPon
X-Gm-Message-State: AOJu0Yy7vmjvNefdVdDI8Kug+oSIuD8olrJgdZp9Eh0F8EWJGZ+GKKAa
	NVBsDFWRXZnGPyjTef4M+4bGRkHnlAIQ5ZKy/H6XvgMaraTHYMHRYZCtGm57TFWGXL+OlFvkD+v
	WOA2g6rdWXu4GxEPP2lPmZUQcaJweOYzVNgPJvqa302AvTAaIKlCiaEAkXkRv0w==
X-Received: by 2002:a5d:598c:0:b0:341:d33e:da1b with SMTP id n12-20020a5d598c000000b00341d33eda1bmr3200340wri.31.1711442915740;
        Tue, 26 Mar 2024 01:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuY5Yj3ajQDnV6GgZmnPv2xsMNqVuRcJG25flrYbPykPRdxVltpwXtCArL/fHuAFF9/1uGVg==
X-Received: by 2002:a5d:598c:0:b0:341:d33e:da1b with SMTP id n12-20020a5d598c000000b00341d33eda1bmr3200305wri.31.1711442915198;
        Tue, 26 Mar 2024 01:48:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id bf12-20020a0560001ccc00b0033e745b8bcfsm11595254wrb.88.2024.03.26.01.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:48:34 -0700 (PDT)
Message-ID: <922c5f99-1194-4118-9fe2-09b4f4a8cf04@redhat.com>
Date: Tue, 26 Mar 2024 09:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, Wupeng Ma <mawupeng1@huawei.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240312181118.318701-1-david@redhat.com>
 <ZfCrkL-Aieer2EAg@casper.infradead.org>
 <5bc9de2f-c3ba-46e7-a234-3d3a46e53ba1@redhat.com>
 <ZgKIVogEUEnUMgpF@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZgKIVogEUEnUMgpF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 09:33, Ingo Molnar wrote:
> 
> * David Hildenbrand <david@redhat.com> wrote:
> 
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
>> Chances of breaking some weird user space is possible, although I believe
>> for most such mappings MAP_PRIVATE doesn't make too much sense sense.
>>
>> Nasty COW support for VM_PFNMAP mappings dates back forever. So does PAT
>> support.
>>
>> I can try finding digging through some possible user space users
>> tomorrow.
> 
> I'd much prefer restricting VM_PAT areas than expanding support. Could we

Note that we're not expanding support, we're fixing what used to be
possible before but mostly broke silently.

But I agree that we should rather remove these corner cases instead of fixing
them.

> try the trivial restriction approach first, and only go with your original
> patch if that fails?

Which version would you prefer, I had two alternatives (excluding comment
changes, white-space expected to be broken).


1) Disallow when we would have set VM_PAT on is_cow_mapping()

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0d72183b5dd0..6979912b1a5d 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -994,6 +994,9 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
                                 && size == (vma->vm_end - vma->vm_start))) {
                 int ret;
  
+               if (is_cow_mapping(vma->vm_flags))
+                       return -EINVAL;
+
                 ret = reserve_pfn_range(paddr, size, prot, 0);
                 if (ret == 0 && vma)
                         vm_flags_set(vma, VM_PAT);


2) Fallback to !VM_PAT

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0d72183b5dd0..8e97156c9be8 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -990,8 +990,8 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
         enum page_cache_mode pcm;
  
         /* reserve the whole chunk starting from paddr */
-       if (!vma || (addr == vma->vm_start
-                               && size == (vma->vm_end - vma->vm_start))) {
+       if (!vma || (!is_cow_mapping(vma->vm_flags) && addr == vma->vm_start &&
+                    size == (vma->vm_end - vma->vm_start))) {
                 int ret;
  
                 ret = reserve_pfn_range(paddr, size, prot, 0);



Personally, I'd go for 2).

-- 
Cheers,

David / dhildenb


