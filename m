Return-Path: <linux-kernel+bounces-132023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A718898EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EB828EC32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA76133987;
	Thu,  4 Apr 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8ywuZrz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCD131BDE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258414; cv=none; b=km1qevIiSUxW8u5K3fmKfoCBUo3HphSJKFRqtJ7pQn5SJ+msIJuottOSxZz9Jk/Vlo0FF+8/Wwk1WbUI5bqtUBu0QnDPrinATbrj/ZIeS1+V9CJ9VjlUCVNlVx9U3zVdY/hga3AEd8O/JlJKgeZmM1w1BhLhC4RZoZNTm455SjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258414; c=relaxed/simple;
	bh=iqCf1IOdMlciR55nG1bS/PsxWkqf3eU5GKje1dhvkYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/+fHTz1AdctkeBP2CAxJI+RoPHJunQCa4LdznKTIToYL3VmfHPpEpLSkpZSRblrqdhQQ6K9Y7rFNJqCVY2yVdcEBqvn8NWTUmn+z2GboNxqfkGBzqXiTiazgRER2KH7CVNpOphUSfc9cAouPB/i7GeVQIhOjPLLBKO87Ovl8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8ywuZrz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712258412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gHJ8l1w5MGIDC/C/OQ5oUJg2N7gsWWlVSll0BER1pJ8=;
	b=g8ywuZrzseK+b3p1NcaM+2U0ICGgg5L/sg0J3/y8iPfpRNM+qml4mbyeMV38S7/QszHzMY
	r5aZN9fhA5Lo7jjdj4BQxckjOspuVpLAk3FahncRu+7bQ6/EVsjzeto/NO4BDz2qGamqyQ
	NQUK4ADrAuRPxbt+r4n5leqTQXp7j84=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-WToP3rrkOSSyLjADgV2yxQ-1; Thu, 04 Apr 2024 15:20:10 -0400
X-MC-Unique: WToP3rrkOSSyLjADgV2yxQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d6c94d98afso11374081fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258409; x=1712863209;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHJ8l1w5MGIDC/C/OQ5oUJg2N7gsWWlVSll0BER1pJ8=;
        b=Liya5XKDKuZR/4HxwZbv12pEu3rvcD2+B5xHD9/nDrEI6Z0VM55HcswqQIK3WTiUAo
         +a73dGmgmArwwMZU9Fxk8JSFL1wHuODPTFh3lYQ1h7Zgtgo8ScIQkV8IHR9onhCzMoXK
         iMinvPK08IDCuVvkrYQ+79mx4XbHc//GcBU/qZyafdPAekaYnBGjLqM/ukq+jOVWAH9P
         WG6HkfWy/tM/p+bOvU/K2s6m8twfV83wMCm7BUNj67vAqGVO7KahnjRwExv18P7J7ja6
         EBE8xn17qt4oyj7s+/wSgBvJqELV1o5yt/CX97nRCjkKQ+JC9PmAv4KLac0YPdAm+wBA
         3rzQ==
X-Gm-Message-State: AOJu0Yz8OjEMvo5eS3WzHePcBp/ojQpSmJKoLd2kWcLAzFWr1qlCfSNr
	ONRmbCGDkg35MZtR2WnjF9cecTsoNgT+CZyfy4ogZ/F4uSCCDu0h45BRcKASTsnznS+3+eMfL+b
	V4to3wpmdqq9bc+vdwVzQ37FbiUNO5hULGmy/Sps/mIffwag6OUN5vXS68QEDXg==
X-Received: by 2002:a05:651c:151:b0:2d7:b78:4109 with SMTP id c17-20020a05651c015100b002d70b784109mr2644648ljd.53.1712258409367;
        Thu, 04 Apr 2024 12:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX4QgSv00a5qrzc42JQnNOpczYt+OzketcyTgobwoWx0oH5Lr64hxXX6j9c7hVjuDjn8/icg==
X-Received: by 2002:a05:651c:151:b0:2d7:b78:4109 with SMTP id c17-20020a05651c015100b002d70b784109mr2644628ljd.53.1712258408866;
        Thu, 04 Apr 2024 12:20:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4811000000b003433a379a51sm99468wrq.101.2024.04.04.12.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:20:08 -0700 (PDT)
Message-ID: <bced0912-4e30-4354-93f3-d6075952b5b5@redhat.com>
Date: Thu, 4 Apr 2024 21:20:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/mm/pat: fix VM_PAT handling in COW mappings
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Fei Li <fei1.li@intel.com>,
 Nathan Chancellor <nathan@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20240403212131.929421-1-david@redhat.com>
 <20240403212131.929421-3-david@redhat.com>
 <20240403151249.0f4fc5b4f8c07630fbbb6338@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403151249.0f4fc5b4f8c07630fbbb6338@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.24 00:12, Andrew Morton wrote:
> On Wed,  3 Apr 2024 23:21:30 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> PAT handling won't do the right thing in COW mappings: the first PTE
>> (or, in fact, all PTEs) can be replaced during write faults to point at
>> anon folios. Reliably recovering the correct PFN and cachemode using
>> follow_phys() from PTEs will not work in COW mappings.
>>
>> ...
>>
>> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
>> Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
>> Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
>> Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")
> 
> These are really old.  Should we backport this?

I was asking that question myself.

With the reproducer, the worst thing that happens on most systems is the 
warning. On !RAM and with PAT, there could be memory leaks and other 
surprises.

Likely, we should just backport it to stable. Should not be too hard to 
backport to stable kernels I guess/hope.

-- 
Cheers,

David / dhildenb


