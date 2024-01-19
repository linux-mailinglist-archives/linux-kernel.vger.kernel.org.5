Return-Path: <linux-kernel+bounces-30667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDB8322CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9791728640D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC38ECE;
	Fri, 19 Jan 2024 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F1EAAR1S"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C781E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625738; cv=none; b=lTehbCchKzGbXs8KBAaLNJlfAWT9vYMDc6hsupaxBkiQOCeYLfRaNkiPzLOAd/PAc2cx/jiT+Z08ZR2XXQqLs+OTA1Q8i5BYvuVv7nlJuac+Gib3df8kET3Ndr80AhSeJSUJJjSxRuTpK6qHjVSMXoeYSGuwuhy57HpiJORYGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625738; c=relaxed/simple;
	bh=aIJvYfmi6HJlaanfsGfkyB5yItcPr3SfQ5xVggiChrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEKfj9SXkWDVOoU7Z2vTVZGC9aYrhnMnjQL41qoyyfj66xKGmGuW9z+kJ4iuafA7EszvTEzp2rvKXjGL5r+sk2znLLQDoDpWsoUBei1W8eh3QedMIOHN82A++G7OmqrrRFSGVjX9+y15FYOB4PzWGnN7JqaDJnE3q46STK8+HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F1EAAR1S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337bcf021a4so160628f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705625735; x=1706230535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zp8xmya7ffNONLsIkwl+dwEuPGDnVZOPk1TpK+AOkSg=;
        b=F1EAAR1SpdR6TbxgMpNM7DwMVTHGBap9ggblYWepeE5p9W8r4TO8DvmWqmBGmvqvge
         4dWOiYE+gWDaAsPyx8HOnNI6RRVVJ8/YRzVfiIhZc4ii5SfhSJ7cF03NIs7kOvtUuxcp
         gb0fCntF5lVKdy3fperiLXbqE2oGABfIpGZJsq4cO59W9y1HER1lz4qO+hs/+KW0IruM
         zGBsQF28O5ZRTMG6edJEne64oI4iquAf5ZqK7CNNVI87RBT95sbWIeb3g/z+30U3LRbS
         KLbWkw/5Bt67CdncbpBB2izOJIpf5qUk4P9kObekT3ZixUc6EqCVjam7HRKBv2OAYTm2
         1ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625735; x=1706230535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp8xmya7ffNONLsIkwl+dwEuPGDnVZOPk1TpK+AOkSg=;
        b=jOyKG18NJsb8X0hsYBWG3PTS1khbn5M47wjGfLQh1U3AWQ36TzWPqauAW8VGRoAReC
         ieFjANoK2hyK3nHvEa1rubLdkc3phPm5qcrW5lbR7TjlYOPzkSOZMsRQTCJnT78NXNFw
         XB44tC96MrvHcV1e9mE7sHuVkapH9rriqEeFufEIjt85INzORYfMtZ89nBSU5FzVYHwK
         Lk0Jdf7KjryiUexNoPlGykh0+qfiVML/GHDDZi80unRrngpt4BlUQmH9Oh3AUgkMqPq3
         CzN1UoTFTsO6HsxDdJO21EWQZgDkJJjXURmyGLDiyUcIAi9HJ2e8vkLZnyWftb0VFjch
         QVCw==
X-Gm-Message-State: AOJu0Yy+xjFkAJ9UX1cb+rammzD8FxGZpPvJpPUC4suwgfZK5KZ/6Rqw
	jxGiDrClme7QQmEl2ZgaFOdZXRE5JSCa5zPVnsCpoLci7r5fyATOM0LTAyYkyFM9XsZMVkelTw+
	+
X-Google-Smtp-Source: AGHT+IEEtt9IXe34jmW2SWZlwSiC3ZqX9bmzujyx2QT1Z1XZwHpyNCAKSldgcj5KlfGZ3ySBlDK1xA==
X-Received: by 2002:adf:b319:0:b0:337:c91d:e816 with SMTP id j25-20020adfb319000000b00337c91de816mr1089220wrd.1.1705625734915;
        Thu, 18 Jan 2024 16:55:34 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7589:26fc:cf3:a5b9:2475? ([2a10:bac0:b000:7589:26fc:cf3:a5b9:2475])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d5341000000b003378e67fd2asm5183061wrv.86.2024.01.18.16.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:55:34 -0800 (PST)
Message-ID: <bd363091-22a6-4203-a7ec-b0ec4abfaf98@suse.com>
Date: Fri, 19 Jan 2024 02:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20240118160118.1899299-1-nik.borisov@suse.com>
 <e75addd3a8af6ef0243999f933df528e975d5ca3.camel@intel.com>
 <fc731bd3-4232-4906-9f78-448a96e3eb5b@suse.com>
 <7695034c0c7bf91532fb5cbd05d9a4b8cb77e70f.camel@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <7695034c0c7bf91532fb5cbd05d9a4b8cb77e70f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.01.24 г. 2:52 ч., Huang, Kai wrote:
> On Fri, 2024-01-19 at 02:49 +0200, Nikolay Borisov wrote:
>> [Adding Kirill as he has a series in flight about KEXEC]
>>
>> On 18.01.24 г. 23:31 ч., Huang, Kai wrote:
>>> On Thu, 2024-01-18 at 18:01 +0200, Nikolay Borisov wrote:
>>>> TDX doesn't currently support kexec so disable the latter when TDX
>>>> is detected at boot time. If kexec must absolutely be supported then
>>>> TDX can be disabled from the bios.
>>>>
>>>> Making this decision at run time rather than as a compile time option
>>>> allows distribution kernels to have both enabled and delegate to the
>>>> user whether they want to use TDX/Kexec.
>>>>
>>>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>>>
>>> Hi Nikolay,
>>>
>>> Thanks for the patch.
>>>
>>> I am working in progress on patches to make kexec() work with TDX.  I plan to
>>> send them out soon (e.g., next week), but I think perhaps your patch is
>>> reasonable before that is merged.
>>
>> I thought Kirill's series rectifies this ?
>>
> 
> No that's for TDX guest.

Well in this case shouldn't INTEL_TDX_GUEST also be gated on KEXEC_CORE 
being inoperable either via Kconfig option or via a similar approach to 
this one (if it's accepted)?

