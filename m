Return-Path: <linux-kernel+bounces-162406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96E8B5AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3E41C21039
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83174BED;
	Mon, 29 Apr 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf/LQtKS"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAC745ED
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399095; cv=none; b=mptUXQcnILMbAwoup2nlkwLvWFKuEZ6UZV3xePGmwzi194Qp+dq7qiyfA74oetdso33EnytYL9jMIJDa+Em6u/R3pdmwdP2a+D6fhHvqjcliO9zppNwxf4Ja5JTpoxP1fkVmACXQTyhyKjZgfWQ3xYPzjPKWzDHPuU/HPiRSUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399095; c=relaxed/simple;
	bh=5TR3YSF/jcV67NCqt6YtOkUxWNqaLwEEXUXpNMs+PzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbnU7pc30T8sriyMFfLb4ImCjQAztxv3fbp41pLw1t1BseFPqQSpyyT6LEnNznHq+f/yA2Lm4rtOrol83ypT5eBMPj39kO7MreH1LXQmCiPGTjEZ8e7e0mowzuGPhqPb3H6HHKoPOwqe3FR2u8iBF1DBz3GzsYXxyPz6s6FrZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf/LQtKS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso4195169b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714399093; x=1715003893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Iutp3QvGNDLmFtS4rQY8jY2s51O82o58EA49duc3c/U=;
        b=bf/LQtKSUlR68bVT67sVD9IkfasG4oZSLTumTV9oXdZ7lBVJXjHA/vN8eKDnszcpIt
         vizGmRf2xs9R7/FEnIseVE26uFmT7f0KF1EfIn1qBWiQBHUkjQ7PVVy2xA7OT9Oe88wp
         ylbFk+7ZI8HeUKSOIHowR90+KWB03tKYBl2ZQRRtJVNC9TBNwYBlH9Y58nUKn3MaJqvN
         2v81HjNvA7MBfgmacgteAXqZj4K9S5/2ZbrUMm3SYY/C1ztYT82FQ/ui4lZKGvA0q+Gj
         XbV0ibXknWtucvrbPGYl6gIaJDTVEAizhg/x2KLW3WNhgkmdGt24gtHl8mR77qdSrCkn
         VY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399093; x=1715003893;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iutp3QvGNDLmFtS4rQY8jY2s51O82o58EA49duc3c/U=;
        b=q3E2GYkz/Y8NOMQ8TwE1o9JmEEJ+qgMLfgXpMAgdXFHWAcvrVfLh1HwpdU5VkA8hfV
         pmezDWONEB1tAqIQeRB8B9acE+FTY2GE0Nkz4K0Mck7SgrEBSKpmc9R5i6jLwkg+AIDQ
         McLUKj324GoM7yN84U/ttoNnJWu2lz5xql5pgjjaoTerVyeoeheh6o0b2qslvONPBvcq
         jPNslFJa/PKGk9Pz2dcvgb0o1dnsfWX5puKEfBYJm7zoJQ/9iUQt/9MA0Kpq4i4nUPpo
         VC8wJ8uczUYJ7oWkb95AUlpEgU5eDqbhW3ifVxerS3jZuNZ7wNCDkMdiaJq6e0vTd+38
         CNXg==
X-Forwarded-Encrypted: i=1; AJvYcCW+K4Dc1pTem+vuYzIvXY6ucIUi4xFGQV+5AIX23n1yhaV/WMZ6MPc22YK8PG5M2itEjFWDFIKX2o9FYqYL02+FjKe6OkOMHp/tFnlL
X-Gm-Message-State: AOJu0YzHBKy9q66tbx/D2+4v1vE/v0anW4v8bM+lt3A1V8fYsO+EJoJE
	jknAaUTJBBT2ampbtU3dIg2d8ApGGbm707hAjJJVbx0S7pLM5coSVFIZYQ==
X-Google-Smtp-Source: AGHT+IEePX1T53C502DERHOmTDd2HmcKDSdVfSrLoDEsfGgM7N9xV7ZjCfUyWye4DJPQK6QiRYBa0g==
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr12132928pzb.51.1714399092687;
        Mon, 29 Apr 2024 06:58:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z18-20020aa785d2000000b006ed03220122sm18105419pfn.16.2024.04.29.06.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 06:58:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <59ea2e9e-cff1-4d99-a586-8df289964f21@roeck-us.net>
Date: Mon, 29 Apr 2024 06:58:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, chris@zankel.net,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, dennis@kernel.org, alexghiti@rivosinc.com,
 Barry Song <v-songbaohua@oppo.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot <lkp@intel.com>
References: <20240319010920.125192-1-21cnbao@gmail.com>
 <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
 <CAMo8BfJTutHPByNZcpjb-2xeUX-Nu2XkjN0DWE6w5xV=zg__Kg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMo8BfJTutHPByNZcpjb-2xeUX-Nu2XkjN0DWE6w5xV=zg__Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/28/24 22:09, Max Filippov wrote:
> On Sat, Apr 27, 2024 at 12:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Tue, Mar 19, 2024 at 02:09:20PM +1300, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
>>> generic implementation for this case in include/asm-generic/
>>> cacheflush.h.
>>>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>>   static inline void flush_dcache_page(struct page *page)
>>>   {
>>>   }
>>>
>>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>>>   #endif
>>>
>>> So remove the superfluous flush_dcache_page() definition, which also
>>> helps silence potential build warnings complaining the page variable
>>> passed to flush_dcache_page() is not used.
>>>
>>>     In file included from crypto/scompress.c:12:
>>>     include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>>>     include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>>>        76 |                 struct page *page;
>>>           |                              ^~~~
>>>     crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>>>       174 |                         struct page *dst_page = sg_page(req->dst);
>>>           |
>>>
>>> The issue was originally reported on LoongArch by kernel test
>>> robot (Huacai fixed it on LoongArch), then reported by Guenter
>>> and me on xtensa.
>>>
>>> This patch also removes lots of redundant macros which have
>>> been defined by asm-generic/cacheflush.h.
>>>
>>> Cc: Huacai Chen <chenhuacai@loongson.cn>
>>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
>>> Reported-by: Barry Song <v-songbaohua@oppo.com>
>>> Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com/
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net/
>>> Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem")
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>
>> The mainline kernel still fails to build xtensa:allmodconfig.
>>
>> Building xtensa:allmodconfig ... failed
>> --------------
>> Error log:
>> crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: error: unused variable 'dst_page' [-Werror=unused-variable]
>>    174 |                         struct page *dst_page = sg_page(req->dst);
>>
>> This patch fixes the problem. Is there a chance to get it applied to the
>> upstream kernel, or should I just stop build testing xtensa:allmodconfig ?
> 
> Applied to my xtensa tree.
> I was still hoping to see rationale for why this is a useful warning.
> 

Useful in general or here ? In general it helps a lot to identify unnecessary
or buggy code, and I think it is very useful. In this case, the other option
would have been to declare the variable as __maybe_unused. I think that
has been discussed. Personally I preferred the more comprehensive patch
because it makes the code more generic, but at this point in the release
cycle I really only want to know what to do with xtensa:allmodconfig test
builds.

Thanks,
Guenter


