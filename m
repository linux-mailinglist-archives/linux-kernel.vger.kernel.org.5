Return-Path: <linux-kernel+bounces-80748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06283866BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714E11F240C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E231CA8E;
	Mon, 26 Feb 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsDtxfb/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC81CA8C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935644; cv=none; b=EpWeOn77fx85V1K/W8dRUwLq3Kmtp5WEmxKfLmmxq7hrD/89k5M/EJWlmYZZnsLtdDNAuRO0eSn/2eqCux4cJESJm2+wmrKI91JpMPlzIrNkhPT7lJco7fYO6u2dPwYRP1ANixSpbSlYb4H9Fw1GstA+f8l4Pp3nlk5BfGXm4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935644; c=relaxed/simple;
	bh=j3+tFvtNZiFkeqi8qTZ6zqfkt9p4fIvZPgYDBk4Sn9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG0GpyNzIGS6HJ53CqaxtiLes+T0+CKFIImMHaRG4hNWHg1JZsYRdg5KaYnG1B8RXcpfeZgPmFMzwsW6ddYJY7spWNY9tcwKAAzOvkq9JpuRP9zrWEUgRr4G8xizVfH8NaiZ9cI0+hg1GQ/fZV286ksCBT9Nb8Lf+szuX5soiaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsDtxfb/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708935641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lAYldR0fK4tTd9TE2wbM3YoZFnDFxA0d2Rj/ium+yx8=;
	b=PsDtxfb/FiMT149epR5qirTcisv0tgGmk6qgMd/aU220FSANpT6vWgMvdiNfEhsoZrefMR
	lbONeJ+BnHS1kE8YkE+8fzmPBPH5k9A28WsuhiU47+jGIxczRALvfT7BoVXbaFN4uP0ulC
	b1Zy71VZPZPAL+Zd0hijRqizlHtBM5Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-taB37TMfP-yf9Iw1cBlH1A-1; Mon, 26 Feb 2024 03:20:39 -0500
X-MC-Unique: taB37TMfP-yf9Iw1cBlH1A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d2654a942cso20815091fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935638; x=1709540438;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAYldR0fK4tTd9TE2wbM3YoZFnDFxA0d2Rj/ium+yx8=;
        b=geuTSPL01pDcExdpF+SQ4sNbLsvnRtnw1Q7Q1ox76IUQtBDQWWa82S9O2E62AA4OeR
         icoWoC3MjPQmzH7+6gpR3oAk64lO6rtl1np5vLoQUNHTWP0xf3Kk0wz0ehLtuEQWTyEL
         9UNp3m5YR1ecUgQweGK4Y2/dbXCgr6f4hyCcS4FxOrYgukOrS3x87+pK/9T8HXSfl1L6
         ClNwuolf40MiGnfnDE3nZ3EKkvPg2/PUlJoxU/Gmtarv42MD5CqYPuPnTdDJxu3Qbmex
         WPErE4vh/rqSHUwCKZ+zHvjP15i3f+F7bpLc/d8NXfmwzXoTJyEujzg/cpJtqBYve10s
         XP7g==
X-Forwarded-Encrypted: i=1; AJvYcCUG9LUzDS0tv2inJPoRn3rrMu5Dm62HW0K9TjvtMNNqH83v8fIeLlAJGh6NrwQVnBT6K8DroZP64ronB0DuQ61OMgLfx/w6KOl7tIJH
X-Gm-Message-State: AOJu0YxfRoSz3ylNCE4RatSCA0UiOhYUnv3gLeym8YVUGAqW5PueFFLm
	Cn7jvtMK1sJ2Bk8Q+vXf2BDjiscYooXck86qdhv4F1WyatSTg/2dp6VIDy8eKZkTEMNBOh9g9XU
	sQ8Fb2B2POegRWwzVbwgLwM49EQAIlLW7ahHCHH9kyuRtRPDwU0c07VYIHl7xeA==
X-Received: by 2002:a05:651c:30f:b0:2d2:478a:83e with SMTP id a15-20020a05651c030f00b002d2478a083emr3296233ljp.24.1708935638254;
        Mon, 26 Feb 2024 00:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjTYgt6d9sTOD10Hmw94l69n7vevxciXTbrdfSvk5bxa08tN5wc7sxhlBp/1si11MxbhESZA==
X-Received: by 2002:a05:651c:30f:b0:2d2:478a:83e with SMTP id a15-20020a05651c030f00b002d2478a083emr3296216ljp.24.1708935637827;
        Mon, 26 Feb 2024 00:20:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d6ad0000000b0033b6e26f0f9sm7429275wrw.42.2024.02.26.00.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:20:37 -0800 (PST)
Message-ID: <fdbe3a71-ff6b-4397-8276-9ca2f3e6db89@redhat.com>
Date: Mon, 26 Feb 2024 09:20:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>,
 "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, willy@infradead.org, fengwei.yin@intel.com,
 aneesh.kumar@linux.ibm.com, shy828301@gmail.com, hughd@google.com,
 wangkefeng.wang@huawei.com, Nanyong Sun <sunnanyong@huawei.com>
References: <20240206092627.1421712-1-zhangpeng362@huawei.com>
 <87jznhypxy.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a905dea7-018e-80c0-ab54-85766add8d96@huawei.com>
 <87frxfhibt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <43182940-ddaa-7073-001a-e95d0999c5ba@huawei.com>
 <87il2bek6f.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87il2bek6f.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 08:52, Huang, Ying wrote:
> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
> 
>> On 2024/2/26 14:04, Huang, Ying wrote:
>>
>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>
>>>> On 2024/2/7 10:21, Huang, Ying wrote:
>>>>
>>>>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>
>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>>
>>>>>> This caused by temporarily cleared PTE during a read+clear/modify/write
>>>>>> update of the PTE, eg, do_numa_page()/change_pte_range().
>>>>>>
>>>>>> For the data segment of the user-mode program, the global variable area
>>>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>>
>>>>>> At this time, the original private file page may have been reclaimed.
>>>>>> If the page cache is not available at this time, a major fault will be
>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>
>>>>>> Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
>>>>>> before triggering a major fault.
>>>>>>
>>>>>> Testing file anonymous page read and write page fault performance in ext4
>>>>>> and ramdisk using will-it-scale[2] on a x86 physical machine. The data
>>>>>> is the average change compared with the mainline after the patch is
>>>>>> applied. The test results are within the range of fluctuation, and there
>>>>>> is no obvious difference. The test results are as follows:
>>>>> You still claim that there's no difference in the test results.  If so,
>>>>> why do you implement the patch?  IMHO, you need to prove your patch can
>>>>> improve the performance in some cases.
>>>> I'm sorry that maybe I didn't express myself clearly.
>>>>
>>>> The purpose of this patch is to fix the issue that major fault may still be triggered
>>>> with mlockall(), thereby improving a little performance. This patch is more of a bugfix
>>>> than a performance improvement patch.
>>>>
>>>> This issue affects our traffic analysis service. The inbound traffic is heavy. If a major
>>>> fault occurs, the I/O schedule is triggered and the original I/O is suspended. Generally,
>>>> the I/O schedule is 0.7 ms. If other applications are operating disks, the system needs
>>>> to wait for more than 10 ms. However, the inbound traffic is heavy and the NIC buffer is
>>>> small. As a result, packet loss occurs. The traffic analysis service can't tolerate packet
>>>> loss.
>>>>
>>>> To prevent packet loss, we use the mlockall() function to prevent I/O. It is unreasonable
>>>> that major faults will still be triggered after mlockall() is used.
>>>>
>>>> In our service test environment, the baseline is 7 major faults/12 hours. After applied the
>>>> unlock patch, the probability of triggering the major fault is 1 major faults/12 hours. After
>>>> applied the lock patch, no major fault will be triggered. So only the locked patch can actually
>>>> solve our problem.
>>> This is the data I asked for.
>>>
>>> But, you said that this is a feature bug fix instead of performance
>>> improvement.  So, I checked the mlock(2), and found the following words,
>>>
>>> "
>>>          mlockall() locks all pages mapped into the address space of the calling
>>>          process.  This includes the pages of the code, data, and stack segment,
>>>          as well as shared libraries, user space kernel data, shared memory, and
>>>          memory-mapped files.  All mapped pages are guaranteed to be resident in
>>>          RAM when the call returns successfully; the  pages  are  guaranteed  to
>>>          stay in RAM until later unlocked.
>>> "
>>>
>>> In theory, the locked page are in RAM.  So, IIUC, we don't violate the
>>> ABI.  But, in effect, we does do that.
>>
>> "mlockall() locks all pages mapped into the address space of the calling process."
>> For a private mapping, mlockall() can lock COW pages (anonymous pages), but the
>> original file pages can't be locked. Maybe, we violate the ABI here.
> 
> If so, please make it explicit and loudly.
> 
>> This is also
>> the cause of this issue. The patch fix the impact of this issue: prevent major
>> faults, reduce IO, and fix the service packet loss issue.
>>
>> Preventing major faults, and thus reducing IO, could be an important reason to use
>> mlockall(). Could we fix this with the locked patch? Or is there another way?
> 
> Unfortunately, locked patch cause performance regressions for more
> common cases.  Is it possible for us to change ptep_modify_prot_start()
> to use some magic PTE value instead of 0?  That may be possible.  But,
> that isn't enough, you need to change all ptep_get_and_clear() users.

Trigger (false) major faults for mlocked memory is suboptimal.

Having such pages temporarily not mapped (e.g., page migration) is 
acceptable (pages are in RAM but are getting moved). We handle that 
using nonswap migration entries.

Let me understand the issue first:

1) MAP_PRIVATE file mapping that is mlocked.

2) We caused COW, so we now have an anonymous page mapped. That anon
    page is mlocked.

3) Change of protection (under PT lock) will temporarily clear the PTE

4) Page fault will trigger and find the PTE still cleared (without PT
    lock)

5) We don't realize that there is a page mapped and, therefore, trigger
    a major fault.

Using the PT lock would fix it properly. Doing it as in this patch can 
only be considered an optimization, not a proper fix.

Using a magic PTE to work around "just use the PT lock like everyone 
else" feels a bit odd. The patch states "We don't hold PTL here as 
acquiring PTL hurts performance" -- do we have any numbers on that?

We could special-case that for MLOCK'ed VMAs with MCL_FUTURE, meaning, 
take the PTL to double-check only in such VMAs.

-- 
Cheers,

David / dhildenb


