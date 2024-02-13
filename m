Return-Path: <linux-kernel+bounces-64221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A7853C26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C9928BA32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6257060B9A;
	Tue, 13 Feb 2024 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UuRfTfEF"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89C849C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855736; cv=none; b=rkjr29dvTgA7oVIFXKp+PeF6qcWYf0lB1REs9+LmBdC6afCrxYtkGsX9VwSY8Lv5xWqCNmZI/TmuS01KvfjNGTFI70JFJoRRT4yhEMY0hHN06cnBwzcw3aTcXEJMRri5+hx+XWHpTy2Yh6o07w8mfabqiTN1XndKM4GRW5+bjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855736; c=relaxed/simple;
	bh=Aaj96pAHTIwRyQeDWfr/9ULSU1FokxTnYjG2gNM7nNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noJyzoJsKUt/lv4tHKg8XjVKffm1nE7U3HXJlgPfQlQJJPwcRP9U6xi2ePLpQko3f8PI4YTVvv4JExw6cZhIq+w/z75O4tyx5jsshCIHZq6MHD+T8k/+Q5lY/ry3/UJ/TtHjQNPqtDmjfPEYZ7ybLcFMb7uUFOW8+eZz+crVJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UuRfTfEF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-787190ab6d8so108403285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707855733; x=1708460533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbj1zy8QqmlzNiLojsCaYsf5zBj5uHHCMFq0jsBwuts=;
        b=UuRfTfEFoNt086UM4Nhhp9LfBK9MkLfKcbmR21An4QCGCibzgWkY1gqblgC225DK/M
         EGWSgzYmzo9qBzbp1lSrXnoGflWxZvUJd6mOQS9XKaEdqdX8/ihvGNvKQxv0+7tW/FJD
         S06scbxcYcSs6mXywIDAkWIWWh6L72GdlPJSYA1Xt7kxJMqdjjCqRoYkOlxnlZ+k0kOK
         c9XShdbXCaNg4xs71baOGjMim0lUziDxw5v7G0N2v1Wpt4pWDsYcO2FdOESy/dEHHzzd
         BgXlgCuX6O5pTA1onUcBjeJk7fHZAOPrr3hdjQBlNzK28bB8JJ5aOzyT1JlUc/rEgftG
         TT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855733; x=1708460533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbj1zy8QqmlzNiLojsCaYsf5zBj5uHHCMFq0jsBwuts=;
        b=QCX9Yk7ama/sGVteRXwces9x8OOc/PF5nzYBtWjOUoORw3UpNUuQ+iZ2QJnUqFAFh3
         bg35HwcVymWZFktbNPFlYwfBgOnotyajY6fB4YUOfhsOa5+9UWioiysR2ZYMVkwtJSld
         7xaxzpnSTqKArOlKb1t+NQDaKumnizomEoDqfe5gO4P/BQyXd2sk1MXAhL8uzSW/0Wfn
         LJJ6gd8gUigniJe6ykeD7NIqMw3vpfgJDmDdSx9oNIJxC8/giVBoKS5WV6fBsfSpICEb
         C5n/rh1X+XLci4NuZNBSouSjtC7w+FY4DmHAyWGFoRqtuckaCb81cPnXRQwOyPngWEL9
         B1sg==
X-Forwarded-Encrypted: i=1; AJvYcCXpF+2lNFWcbsWBHcG3ohBYrQYzovitDf4wN9T9P6pfQI2o6/smU57c+iHkgSDx/ZSuI/EA7im5bBRrqZmiwLec+pdMbL1D92Ipb/U1
X-Gm-Message-State: AOJu0YzGrLzt9scvrjBjrPG+u4n95jSIGdmjKutRa+gwGtjzGdsH5sv7
	/e/74iC6i7vKA3n5/nidquT+FJCKBAK/DE1bNBh8SC3ZLEUUXPPNWPBAgvWPoHY=
X-Google-Smtp-Source: AGHT+IGIWaKTml8GZMglfU1ZKE9O5by2hqZ6gTPJ+uUkw/X6h8kR5N9dclKsNJacPQEH0mSgwR2N/g==
X-Received: by 2002:a37:c447:0:b0:783:d369:6e5a with SMTP id h7-20020a37c447000000b00783d3696e5amr661892qkm.76.1707855733283;
        Tue, 13 Feb 2024 12:22:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfw9ZDUUDmMtZwIJU0CB5m0P2ktFgNX3kF9qXP6+F+eQXPK52OGf0c5NqOYuaBUDYToyHEyd4IevdY+M+zji8JDxM8PCxxWKK6hQQdA63+GHUbdR2Vd/e4pJbOkYGgy29Yv7yf2J5vASv3rmJSAtsfUPi7vfm0GjPUjCd8kTeCHGK0DtDFr2YWtXHX826Hb8DI0bFYspkiKF43gdtd+s5Gfh0RHsBbziq/6EaL0eqM1Bwj0Q==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a166900b00783f1e600aasm3215244qko.38.2024.02.13.12.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 12:22:12 -0800 (PST)
Message-ID: <ff3bd436-12f8-4cde-881d-89a005ad85c0@sifive.com>
Date: Tue, 13 Feb 2024 14:22:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm and
 Ss
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Stefan O'Rear <sorear@fastmail.com>,
 stable@vger.kernel.org
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
 <20240213-dangle-taco-2742f6087a3e@spud>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240213-dangle-taco-2742f6087a3e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-13 12:07 PM, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 07:37:34PM -0800, Samuel Holland wrote:
>> Previously, all extension version numbers were ignored. However, the
>> version number is important for these two extensions. The simplest way
>> to implement this is to use a separate bitmap bit for each supported
>> version, with each successive version implying all of the previous ones.
>> This allows alternatives and riscv_has_extension_[un]likely() to work
>> naturally.
>>
>> To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
>> field allows hiding all but the newest implemented version of an
>> extension.
>>
>> Cc: <stable@vger.kernel.org> # v6.7+
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> Changes in v2:
>>  - New patch for v2
>>
>>  arch/riscv/include/asm/cpufeature.h |  1 +
>>  arch/riscv/include/asm/hwcap.h      |  8 ++++++
>>  arch/riscv/kernel/cpu.c             |  5 ++++
>>  arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++----
>>  4 files changed, 51 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index 0bd11862b760..ac71384e7bc4 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
>>  	const char *property;
>>  	const unsigned int *subset_ext_ids;
>>  	const unsigned int subset_ext_size;
>> +	const unsigned int successor_id;
>>  };
>>  
>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index 5340f818746b..5b51aa1db15b 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -80,13 +80,21 @@
>>  #define RISCV_ISA_EXT_ZFA		71
>>  #define RISCV_ISA_EXT_ZTSO		72
>>  #define RISCV_ISA_EXT_ZACAS		73
>> +#define RISCV_ISA_EXT_SM1p11		74
>> +#define RISCV_ISA_EXT_SM1p12		75
>> +#define RISCV_ISA_EXT_SS1p11		76
>> +#define RISCV_ISA_EXT_SS1p12		77
>>  
>>  #define RISCV_ISA_EXT_MAX		128
>>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>>  
>>  #ifdef CONFIG_RISCV_M_MODE
>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
>>  #else
>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
>>  #endif
>>  
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index d11d6320fb0d..2e6b90ed0d51 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>>  		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>>  			continue;
>>  
>> +		/* Only show the newest implemented version of an extension */
>> +		if (riscv_isa_ext[i].successor_id != RISCV_ISA_EXT_INVALID &&
>> +		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].successor_id))
>> +			continue;
>> +
>>  		/* Only multi-letter extensions are split by underscores */
>>  		if (strnlen(riscv_isa_ext[i].name, 2) != 1)
>>  			seq_puts(f, "_");
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index c5b13f7dd482..8e10b50120e9 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -113,23 +113,29 @@ static bool riscv_isa_extension_check(int id)
>>  	return true;
>>  }
>>  
>> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
>> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _successor) {	\
>>  	.name = #_name,								\
>>  	.property = #_name,							\
>>  	.id = _id,								\
>>  	.subset_ext_ids = _subset_exts,						\
>> -	.subset_ext_size = _subset_exts_size					\
>> +	.subset_ext_size = _subset_exts_size,					\
>> +	.successor_id = _successor,						\
>>  }
>>  
>> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
>> +#define __RISCV_ISA_EXT_DATA(_name, _id) \
>> +	_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, RISCV_ISA_EXT_INVALID)
>>  
>>  /* Used to declare pure "lasso" extension (Zk for instance) */
>>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
>> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
>> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, \
>> +			    _bundled_exts, ARRAY_SIZE(_bundled_exts), RISCV_ISA_EXT_INVALID)
>>  
>>  /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
>>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
>> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
>> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), RISCV_ISA_EXT_INVALID)
>> +
>> +#define __RISCV_ISA_EXT_VERSION(_name, _id, _preds, _preds_size, _successor) \
>> +	_RISCV_ISA_EXT_DATA(_name, _id, _preds, _preds_size, _successor)
>>  
>>  static const unsigned int riscv_zk_bundled_exts[] = {
>>  	RISCV_ISA_EXT_ZBKB,
>> @@ -201,6 +207,16 @@ static const unsigned int riscv_zvbb_exts[] = {
>>  	RISCV_ISA_EXT_ZVKB
>>  };
>>  
>> +static const unsigned int riscv_sm_ext_versions[] = {
>> +	RISCV_ISA_EXT_SM1p11,
>> +	RISCV_ISA_EXT_SM1p12,
>> +};
>> +
>> +static const unsigned int riscv_ss_ext_versions[] = {
>> +	RISCV_ISA_EXT_SS1p11,
>> +	RISCV_ISA_EXT_SS1p12,
>> +};
>> +
>>  /*
>>   * The canonical order of ISA extension names in the ISA string is defined in
>>   * chapter 27 of the unprivileged specification.
>> @@ -299,8 +315,16 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
>>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
>>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>> +	__RISCV_ISA_EXT_VERSION(sm1p11, RISCV_ISA_EXT_SM1p11, riscv_sm_ext_versions, 0,
>> +				RISCV_ISA_EXT_SM1p12),
>> +	__RISCV_ISA_EXT_VERSION(sm1p12, RISCV_ISA_EXT_SM1p12, riscv_sm_ext_versions, 1,
>> +				RISCV_ISA_EXT_INVALID),
>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>> +	__RISCV_ISA_EXT_VERSION(ss1p11, RISCV_ISA_EXT_SS1p11, riscv_ss_ext_versions, 0,
>> +				RISCV_ISA_EXT_SS1p12),
>> +	__RISCV_ISA_EXT_VERSION(ss1p12, RISCV_ISA_EXT_SS1p12, riscv_ss_ext_versions, 1,
>> +				RISCV_ISA_EXT_INVALID),
>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>> @@ -414,6 +438,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>  				;
>>  
>>  			++ext_end;
>> +
>> +			/*
>> +			 * As a special case for the Sm and Ss extensions, where the version
>> +			 * number is important, include it in the extension name.
>> +			 */
>> +			if (ext_end - ext == 2 && tolower(ext[0]) == 's' &&
>> +			    (tolower(ext[1]) == 'm' || tolower(ext[1]) == 's'))
>> +				ext_end = isa;
>>  			break;
>>  		default:
>>  			/*
> 
> 
> Hmm, looking at all of this (especially this hack to the "old" parser),
> I feel more like these should be promoted to a property of their own.
> The "old" parser was designed to handle numbers, and here when you're
> interested in the values behind the numbers (which is a first iirc), you
> don't make any use of that. I don't really want to see a world where

I had a version of this code that parsed the numbers and stored them as integers
in `struct riscv_isainfo`. It didn't work with of_property_match_string() as
used for riscv,isa-extensions, since that function expects the extension name to
be the full string. Either we would need to change the code to parse a version
number out of each string in the riscv,isa-extensions list (and make the binding
a bunch of regexes), or we need a separate "extension" entry (and DT binding
entry) for each supported version.

I chose the second option, and as a consequence I didn't actually need to parse
the integer value in the ISA string code path either.

> we have every single iteration of smNpM under the sun in the property,
> because there's a fair bit of churn in the isa. Granted, this applies to
> all the various, the difference for me is the level of churn.

Indeed. In fact, one thought I had while looking at this code is that we should
be ignoring any extension in the ISA string with a version < 1.0 or >= 2.0,
since those won't be compatible with what we expect.

> Or maybe we can still with the properties you have, but instead of
> treating them like any other extension, handle these separately,
> focusing on the numbering, so that only having the exact version
> supported by a cpu is possible.

Maybe I'm misunderstanding what you're saying here, but it is already the case
that the DT for a CPU would only contain the exact version of the privileged ISA
supported by that CPU.

With this implementation, the fact that the integer version gets expanded to a
series of flags is supposed to be invisible in the DT and to userspace. I
realize I don't quite succeed there: putting "ss1p13" in the ISA string should
work, but does not.

> I'm still pretty undecided, I'd like to think about this a little bit,
> but I think we can do better here.

Sure, no problem. I'm happy to implement whatever we agree on. Though one
consideration I had is that this is all in support of fixing a bug in v6.7, so I
wanted the changes to be backportable.

I suppose the easy way out for backporting is to check for RISCV_ISA_EXT_ZICBOZ
for now, and then solve the larger problem once there is some other user of the
envcfg CSR (or another Ss1p12 feature).

Regards,
Samuel


