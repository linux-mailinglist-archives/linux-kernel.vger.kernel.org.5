Return-Path: <linux-kernel+bounces-1728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D581533F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32672820B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424E47F77;
	Fri, 15 Dec 2023 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyl5T/AH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A218EA1;
	Fri, 15 Dec 2023 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702677911; x=1734213911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C5u28TsTHMLf5q16FNbW/X5Am7vYw8OdDCzN+TJXAIg=;
  b=cyl5T/AHtQOO2AT82x4mrvIF5+Mg7MaKc5PKBVjykijQtuChAgTbj/Q3
   FmjTHJEaD+OHM9SrHWV8Poyqm/CIN4Nu5EeD2i3roX4KThg+W/AExsObr
   am9dyoqMAo/0phYOqG8huAiHDLiw0nEEK0BQFdlnlJf5UrfT776om4WMD
   ApnrRks2zqf9PQFMjZWPqJCf+8v1uRD+zlzKxvSpyevxnfxzhxbE2Iwca
   FV9G2OA8HHHDao70FfC03Ct3kvVM5uRHsAWSm6bgMG85orI4Iocl2LNAF
   Dcc9QqyumvLC7l/JuP0UxitJwvDfuw2H5Z5pgjg40+q0TzPQ9dxItsn2E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="481520359"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="481520359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="803849500"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="803849500"
Received: from jwaxmons-hp.amr.corp.intel.com (HELO [10.212.150.221]) ([10.212.150.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:05:10 -0800
Message-ID: <b0157588-14a0-423e-8330-e717ebd03e77@intel.com>
Date: Fri, 15 Dec 2023 14:05:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: allocate kernel above bzImage's pref_address
Content-Language: en-US
To: Chris Koch <chrisko@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Cloud Hsu <cloudhsu@google.com>
References: <20231215190521.3796022-1-chrisko@google.com>
 <b086fd82-2989-4987-a3f6-021a4ae9bec4@intel.com>
 <CAA0N8zb0ddnDpZdaOeb0G2azd-jPu3qtxWPQgaWC24f6VgqY6Q@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAA0N8zb0ddnDpZdaOeb0G2azd-jPu3qtxWPQgaWC24f6VgqY6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/23 13:38, Chris Koch wrote:
> On Fri, Dec 15, 2023 at 1:17 PM Dave Hansen <dave.hansen@intel.com> wrote:
...
>> Are you reporting a bug and is this a bug fix?  It's not super clear
>> from the changelog.
> 
> I reported it as a bug yesterday in
> https://lkml.org/lkml/2023/12/14/1529 -- I'm happy to reword this in
> some way that indicates it's a bug fix.

Ahh, thanks for the link!

Please do include things like this as a "Link:" tag in the changelog
(and use lore.kernel.org URLs when possible).

>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
>>> index 22cc7a040dae..49bea8986620 100644
>>> --- a/Documentation/arch/x86/boot.rst
>>> +++ b/Documentation/arch/x86/boot.rst
>>> @@ -878,7 +878,8 @@ Protocol: 2.10+
>>>    address if possible.
>>>
>>>    A non-relocatable kernel will unconditionally move itself and to run
>>> -  at this address.
>>> +  at this address. A relocatable kernel will move itself to this address if it
>>> +  loaded below this address.
>>
>> I think we should avoid saying the same things over and over again in
>> different spots.
>>
>> Here, it doesn't really help to enumerate the different interpretations
>> of 'pref_address'.  All that matters is that the bootloader can avoid
>> the overhead of a later copy if it can place the kernel at
>> 'pref_address'.  The exact reasons that various kernels might decide to
>> relocate are unimportant here.
> 
> I think it's important documentation for bootloader authors. It's not
> about avoiding overhead, it's about avoiding clobbering areas of
> memory that may be reserved in e820 / EFI memory map, which the kernel
> will do when it relocates itself to pref_address without checking
> what's reserved and what's not. It emphasizes the importance of
> choosing an address above pref_address. Happy to reword some way to
> reflect that.

Could we give this as a direction to bootloader authors?  They should
read 'pref_address' as a big, fat, "the kernel may blow this address
away" message.

...
>>>         In normal kdump cases one does not have to set/change this option
>>>         as now bzImage can be compiled as a completely relocatable image
>>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>>> index a61c12c01270..5dcd232d58bf 100644
>>> --- a/arch/x86/kernel/kexec-bzimage64.c
>>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>>> @@ -498,7 +498,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>>>       kbuf.bufsz =  kernel_len - kern16_size;
>>>       kbuf.memsz = PAGE_ALIGN(header->init_size);
>>>       kbuf.buf_align = header->kernel_alignment;
>>> -     kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
>>> +     if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
>>> +             kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
>>> +     else
>>> +             kbuf.buf_min = header->pref_address;
>>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>       ret = kexec_add_buffer(&kbuf);
>>>       if (ret)
>>
>> Comment, please.
>>
>> It isn't clear from this hunk why or how this fixes the bug.  How does
>> this manage to avoid clobbering reserved areas?
> 
> When allocated above pref_address, the kernel will not relocate itself
> to an area that potentially overlaps with reserved memory. I'll add a
> comment.

Sounds good.

> Not sure what the etiquette is on immediately sending a patch v2, or
> waiting for more comments. I'll err on waiting on a couple more
> comments before sending v2. Thanks for the review

Please wait another few days.

