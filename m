Return-Path: <linux-kernel+bounces-79481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6B8622DE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B611C219F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C29E17588;
	Sat, 24 Feb 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FvWkBAki"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828B168BA;
	Sat, 24 Feb 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754938; cv=none; b=EAF8EWQXdzNEZ213xae/OoiculxQOb2eywUyIeXmjyqdAk6Sex/hH51bLMfHQsp/0EyOgimFonOHm3CKzm9kNVaG1GjjpzUayozrJJK6hWGqRKqS4IZ6XwnyE+MnZLpzCsLqw2/EEiK2yPCimKFazgcPtT38qr3H0sgBeITCVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754938; c=relaxed/simple;
	bh=CdqA7Mje/ef5cIg71mUk7qVCGjOoAxXKI8baVre1G+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GygaFDVh5eaJhfxguAhXHZLRwrO9TAZM3yelProw299Ot0K6fKXEj6k8cuuva2hNbfJXVzpwtPSMM99ynuph5+9zx5hdul87W+brybHSldv47BsT52aAXxTubbzw41O2Igt8ukt/9iGIWeCk+wdhucWwDa+UI2tlQlO71I9bqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FvWkBAki; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708754927; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mCwCZ2rNrkkFhS7Epeg6isWMlkKLV7R/5ALQmiiXG2Q=;
	b=FvWkBAkiQYlNPijAVD5MPDlHTYvF5klwHKHKyj2lOJp3/NhZ9+7+w2ki5ZmTecp4RNxW9gIXvlNipgk7tRxrha+C8xm/Z1HpFYXj44JqIaW7ZqEyi6y7th/dnQsN3H95AHt+rC+gqlzeK7KRkOMdZl2pRhE1xxK6xM9YNzsn9co=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W15zPT3_1708754923;
Received: from 30.240.112.52(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W15zPT3_1708754923)
          by smtp.aliyun-inc.com;
          Sat, 24 Feb 2024 14:08:45 +0800
Message-ID: <00126cf9-bb59-4c05-8046-478d0d7f4297@linux.alibaba.com>
Date: Sat, 24 Feb 2024 14:08:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: Ira Weiny <ira.weiny@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "james.morse@arm.com" <james.morse@arm.com>, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
 <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
 <65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240223120813.00005d1f@Huawei.com> <20240223121701.00004bcf@Huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240223121701.00004bcf@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/23 20:17, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 12:08:13 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Thu, 22 Feb 2024 21:26:43 -0800
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> Shuai Xue wrote:  
>>>>
>>>>
>>>> On 2024/2/19 17:25, Borislav Petkov wrote:    
>>>>> On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:    
>>>>>> Synchronous error was detected as a result of user-space process accessing
>>>>>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>>>>>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>>>>>> memory_failure() work which poisons the related page, unmaps the page, and
>>>>>> then sends a SIGBUS to the process, so that a system wide panic can be
>>>>>> avoided.
>>>>>>
>>>>>> However, no memory_failure() work will be queued when abnormal synchronous
>>>>>> errors occur. These errors can include situations such as invalid PA,
>>>>>> unexpected severity, no memory failure config support, invalid GUID
>>>>>> section, etc. In such case, the user-space process will trigger SEA again.
>>>>>> This loop can potentially exceed the platform firmware threshold or even
>>>>>> trigger a kernel hard lockup, leading to a system reboot.
>>>>>>
>>>>>> Fix it by performing a force kill if no memory_failure() work is queued
>>>>>> for synchronous errors.
>>>>>>
>>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>>> ---
>>>>>>  drivers/acpi/apei/ghes.c | 9 +++++++++
>>>>>>  1 file changed, 9 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>>>> index 7b7c605166e0..0892550732d4 100644
>>>>>> --- a/drivers/acpi/apei/ghes.c
>>>>>> +++ b/drivers/acpi/apei/ghes.c
>>>>>> @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>>>  		}
>>>>>>  	}
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * If no memory failure work is queued for abnormal synchronous
>>>>>> +	 * errors, do a force kill.
>>>>>> +	 */
>>>>>> +	if (sync && !queued) {
>>>>>> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
>>>>>> +		force_sig(SIGBUS);
>>>>>> +	}    
>>>>>
>>>>> Except that there are a bunch of CXL GUIDs being handled there too and
>>>>> this will sigbus those processes now automatically.    
>>>>
>>>> Before the CXL GUIDs added, @Tony confirmed that the HEST notifications are always
>>>> asynchronous on x86 platform, so only Synchronous External Abort (SEA) on ARM is
>>>> delivered as a synchronous notification.
>>>>
>>>> Will the CXL component trigger synchronous events for which we need to terminate the
>>>> current process by sending sigbus to process?    
>>>
>>> None of the CXL component errors should be handled as synchronous
>>> events. They are either asynchronous protocol errors, or effectively
>>> equivalent to CPER_SEC_PLATFORM_MEM notifications.  
>>
>> Not a good example, CPER_SEC_PLATFORM_MEM is sometimes signaled via SEA.
>>
> 
> Premature send.:(
> 
> One example I can point at is how we do signaling of memory
> errors detected by the host into a VM on arm64.
> https://elixir.bootlin.com/qemu/latest/source/hw/acpi/ghes.c#L391
> CPER_SEC_PLATFORM_MEM via ARM Synchronous External Abort (SEA).
> 
> Right now we've only used async in QEMU for proposed CXL error
> CPER records signalling but your reference to them being similar
> to CPER_SEC_PLATFORM_MEM is valid so 'maybe' they will be
> synchronous in some physical systems as it's one viable way to
> provide rich information for synchronous reception of poison.
> For the VM case my assumption today is we don't care about providing the
> VM with rich data, so CPER_SEC_PLATFORM_MEM is fine as a path for
> errors whether from CXL CPER records or not.
> 
> Jonathan

Thank you for your confirmation and explanation.

So I think the condition:

- `sync` for synchronous event,
- `!queued` for CPER_SEC_PLATFORM_MEM notifications which do not handle memory failures.

is fine.

@Borislav, do you have any other concerns?

Best Regards,
Shuai

