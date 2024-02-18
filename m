Return-Path: <linux-kernel+bounces-70419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D551D859782
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0557F1C20AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D46BFC9;
	Sun, 18 Feb 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CHGqBHM6"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FA290F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268420; cv=none; b=GTYEkvmMaiMjBqd/863F3xefFtX0l0LIHqAX6J3bMGffhOylSQM7h8Dq4af+zLGXXPUNWC4I5nbgb1toh+MM+FBavcaxGuxw9+MLYntHPCFY4UKqHJjvXVBPBBkCOWuzn+l5FPp1G0m8glQokMS256Jp/HrYdZameJbJUoWXc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268420; c=relaxed/simple;
	bh=osQUHtBwtBRheFzZo4xkNmo8cCfrMkRjejuzkGYonU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3c0011s9GdqxD4WnW+RR7oKiNpy1kybbgmzEDgEYXmZf/2289WNqEl1YlsDiPUmn8sqJEtjL7WG5uxgxjlyWCBdGFEzfx8kHLhDmyvpmd2vTBzeGDvqqd5VNPTBLVVxtEl5bmxEmePx5aRmxZMdIx++RvT2YIuH+03SX4qLrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CHGqBHM6; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c049ccb623so1523117b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708268417; x=1708873217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYnBOQzEOcAAi3/k4Sm826rCOnB3o3IMwXvp4z4B03c=;
        b=CHGqBHM6BY1SSAY/QvM9vWjzj+EAuWj5DDM4oLKoRtLbQ85COnSnXyAox9nNGEQjyZ
         91ejFqe0gdamsxkDa9MNwwGaQFf9sMvh9CA1yW/5mHh8EHQH6p5YT/mnwMpS51QgHLpF
         TlZSJpqYzyIkR5JWNOxkAPvmc1Aqh2jsZpho9OMvhAxxNMTXeXQo0gwY84vPlNbmgSGj
         Sx7Y6E8ztxPcdPSzcVFH+aJXzKn41nUyh3Y77TkJ/J1tMKwbkbvcYWUgcgiJ3j4U8BRN
         HwjxCr7epO+g/Lesk4rZ6qKM134/NYUCfEDCj5CDQEK+SU5aG6C8ltSbzvdArQZY1MFo
         IoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268417; x=1708873217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYnBOQzEOcAAi3/k4Sm826rCOnB3o3IMwXvp4z4B03c=;
        b=S3XIctCUmEUXIxvIXNTqln8HW6BmYJOjJDwQQWTx6kHuHQYL7TxgIBpgqyXD9t6rBk
         UlN3Zkm7AZ+JgydOKczSOX4kGXwxg0h8dEd5D2nSXlanMxZG6GdLx8SEpPT/208bAlNr
         B7gj4jeuFza66f9tu24arK6R1tvdVsrw7OXL7Of99oVuL0rBlp4MT8SxL2NkiuPT1zw+
         S6MGm4DtbCvF94ma29axReWlmPjQxC4sRHBTFeP0A/7x+rBto4op9+v0I0tyhry5NQiZ
         DQIP6j8cNAH8C9ceYc0OKjE8V9qw67x4cNttE41WhcblV4NBaxhOJd3vW2QYSCDHpE71
         K5oA==
X-Forwarded-Encrypted: i=1; AJvYcCX7MzZXgfF0oNxSqqh8EJ7hSfMyZ0K54Q8VgBD2qdASpymLIQv6gcgLCUWPQySm2Hpu+RlV+wMIubA+2X1oeQaHCmf79ddGlO7KdlNV
X-Gm-Message-State: AOJu0YxcPw4yq4j3P81Khvr40v6DHsoNjn4oreagNdWDGgDlaR2HEQcU
	UcrT8+Jc6AQXt9RB+bnWvzcp+bjpVJkT+qIaapJai6a6Qr4EkPKFQjhxysLUMuY=
X-Google-Smtp-Source: AGHT+IGRp3AEp9PX2ocswnFBxtOEGeqzjtdyzUlJ4Nf2rGtKqFzy/FpVtaXefQuS72e/ExoLl/XhgA==
X-Received: by 2002:a05:6358:5389:b0:178:dac3:2b99 with SMTP id z9-20020a056358538900b00178dac32b99mr10932785rwe.1.1708268417100;
        Sun, 18 Feb 2024 07:00:17 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id d5-20020ac84e25000000b0042de98f38f3sm1706235qtw.63.2024.02.18.07.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 07:00:16 -0800 (PST)
Message-ID: <90a7443c-feca-4fbb-8c2e-fa050c0e6141@sifive.com>
Date: Sun, 18 Feb 2024 09:00:14 -0600
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
To: Conor Dooley <conor@kernel.org>, Stefan O'Rear <sorear@fastmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
 <20240213-dangle-taco-2742f6087a3e@spud>
 <ff3bd436-12f8-4cde-881d-89a005ad85c0@sifive.com>
 <b7ad2bd4-a19e-486e-8be2-3b56f288d5d0@app.fastmail.com>
 <20240213-earflap-easing-370492840507@spud>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240213-earflap-easing-370492840507@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor, Stefan,

Thanks for the discussion!

On 2024-02-13 5:15 PM, Conor Dooley wrote:
> On Tue, Feb 13, 2024 at 03:43:27PM -0500, Stefan O'Rear wrote:
>> On Tue, Feb 13, 2024, at 3:22 PM, Samuel Holland wrote:
>>> On 2024-02-13 12:07 PM, Conor Dooley wrote:
>>>> On Mon, Feb 12, 2024 at 07:37:34PM -0800, Samuel Holland wrote:
>>>>> Previously, all extension version numbers were ignored. However, the
>>>>> version number is important for these two extensions. The simplest way
>>>>> to implement this is to use a separate bitmap bit for each supported
>>>>> version, with each successive version implying all of the previous ones.
>>>>> This allows alternatives and riscv_has_extension_[un]likely() to work
>>>>> naturally.
>>>>>
>>>>> To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
>>>>> field allows hiding all but the newest implemented version of an
>>>>> extension.
>>>>>
>>>>> Cc: <stable@vger.kernel.org> # v6.7+
>>>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>>  - New patch for v2
>>>>>
>>>>>  arch/riscv/include/asm/cpufeature.h |  1 +
>>>>>  arch/riscv/include/asm/hwcap.h      |  8 ++++++
>>>>>  arch/riscv/kernel/cpu.c             |  5 ++++
>>>>>  arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++----
>>>>>  4 files changed, 51 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>>>> index 0bd11862b760..ac71384e7bc4 100644
>>>>> --- a/arch/riscv/include/asm/cpufeature.h
>>>>> +++ b/arch/riscv/include/asm/cpufeature.h
>>>>> @@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
>>>>>  	const char *property;
>>>>>  	const unsigned int *subset_ext_ids;
>>>>>  	const unsigned int subset_ext_size;
>>>>> +	const unsigned int successor_id;
>>>>>  };
>>>>>  
>>>>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>>>> index 5340f818746b..5b51aa1db15b 100644
>>>>> --- a/arch/riscv/include/asm/hwcap.h
>>>>> +++ b/arch/riscv/include/asm/hwcap.h
>>>>> @@ -80,13 +80,21 @@
>>>>>  #define RISCV_ISA_EXT_ZFA		71
>>>>>  #define RISCV_ISA_EXT_ZTSO		72
>>>>>  #define RISCV_ISA_EXT_ZACAS		73
>>>>> +#define RISCV_ISA_EXT_SM1p11		74
>>>>> +#define RISCV_ISA_EXT_SM1p12		75
>>>>> +#define RISCV_ISA_EXT_SS1p11		76
>>>>> +#define RISCV_ISA_EXT_SS1p12		77
>>>>>  
>>>>>  #define RISCV_ISA_EXT_MAX		128
>>>>>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>>>>>  
>>>>>  #ifdef CONFIG_RISCV_M_MODE
>>>>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
>>>>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
>>>>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
>>>>>  #else
>>>>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
>>>>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
>>>>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
>>>>>  #endif
>>>>>  
>>>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>>>> index d11d6320fb0d..2e6b90ed0d51 100644
>>>>> --- a/arch/riscv/kernel/cpu.c
>>>>> +++ b/arch/riscv/kernel/cpu.c
>>>>> @@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>>>>>  		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>>>>>  			continue;
>>>>>  
>>>>> +		/* Only show the newest implemented version of an extension */
>>>>> +		if (riscv_isa_ext[i].successor_id != RISCV_ISA_EXT_INVALID &&
>>>>> +		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].successor_id))
>>>>> +			continue;
>>>>> +
>>>>>  		/* Only multi-letter extensions are split by underscores */
>>>>>  		if (strnlen(riscv_isa_ext[i].name, 2) != 1)
>>>>>  			seq_puts(f, "_");
>>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>>> index c5b13f7dd482..8e10b50120e9 100644
>>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>>> @@ -113,23 +113,29 @@ static bool riscv_isa_extension_check(int id)
>>>>>  	return true;
>>>>>  }
>>>>>  
>>>>> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
>>>>> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _successor) {	\
>>>>>  	.name = #_name,								\
>>>>>  	.property = #_name,							\
>>>>>  	.id = _id,								\
>>>>>  	.subset_ext_ids = _subset_exts,						\
>>>>> -	.subset_ext_size = _subset_exts_size					\
>>>>> +	.subset_ext_size = _subset_exts_size,					\
>>>>> +	.successor_id = _successor,						\
>>>>>  }
>>>>>  
>>>>> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
>>>>> +#define __RISCV_ISA_EXT_DATA(_name, _id) \
>>>>> +	_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, RISCV_ISA_EXT_INVALID)
>>>>>  
>>>>>  /* Used to declare pure "lasso" extension (Zk for instance) */
>>>>>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
>>>>> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
>>>>> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, \
>>>>> +			    _bundled_exts, ARRAY_SIZE(_bundled_exts), RISCV_ISA_EXT_INVALID)
>>>>>  
>>>>>  /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
>>>>>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
>>>>> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
>>>>> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), RISCV_ISA_EXT_INVALID)
>>>>> +
>>>>> +#define __RISCV_ISA_EXT_VERSION(_name, _id, _preds, _preds_size, _successor) \
>>>>> +	_RISCV_ISA_EXT_DATA(_name, _id, _preds, _preds_size, _successor)
>>>>>  
>>>>>  static const unsigned int riscv_zk_bundled_exts[] = {
>>>>>  	RISCV_ISA_EXT_ZBKB,
>>>>> @@ -201,6 +207,16 @@ static const unsigned int riscv_zvbb_exts[] = {
>>>>>  	RISCV_ISA_EXT_ZVKB
>>>>>  };
>>>>>  
>>>>> +static const unsigned int riscv_sm_ext_versions[] = {
>>>>> +	RISCV_ISA_EXT_SM1p11,
>>>>> +	RISCV_ISA_EXT_SM1p12,
>>>>> +};
>>>>> +
>>>>> +static const unsigned int riscv_ss_ext_versions[] = {
>>>>> +	RISCV_ISA_EXT_SS1p11,
>>>>> +	RISCV_ISA_EXT_SS1p12,
>>>>> +};
>>>>> +
>>>>>  /*
>>>>>   * The canonical order of ISA extension names in the ISA string is defined in
>>>>>   * chapter 27 of the unprivileged specification.
>>>>> @@ -299,8 +315,16 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>>>>  	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
>>>>>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
>>>>>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>>>>> +	__RISCV_ISA_EXT_VERSION(sm1p11, RISCV_ISA_EXT_SM1p11, riscv_sm_ext_versions, 0,
>>>>> +				RISCV_ISA_EXT_SM1p12),
>>>>> +	__RISCV_ISA_EXT_VERSION(sm1p12, RISCV_ISA_EXT_SM1p12, riscv_sm_ext_versions, 1,
>>>>> +				RISCV_ISA_EXT_INVALID),
>>>>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>>>>>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>>>>> +	__RISCV_ISA_EXT_VERSION(ss1p11, RISCV_ISA_EXT_SS1p11, riscv_ss_ext_versions, 0,
>>>>> +				RISCV_ISA_EXT_SS1p12),
>>>>> +	__RISCV_ISA_EXT_VERSION(ss1p12, RISCV_ISA_EXT_SS1p12, riscv_ss_ext_versions, 1,
>>>>> +				RISCV_ISA_EXT_INVALID),
>>>>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>>>>>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>>>>>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>>>>> @@ -414,6 +438,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>>>>  				;
>>>>>  
>>>>>  			++ext_end;
>>>>> +
>>>>> +			/*
>>>>> +			 * As a special case for the Sm and Ss extensions, where the version
>>>>> +			 * number is important, include it in the extension name.
>>>>> +			 */
>>>>> +			if (ext_end - ext == 2 && tolower(ext[0]) == 's' &&
>>>>> +			    (tolower(ext[1]) == 'm' || tolower(ext[1]) == 's'))
>>>>> +				ext_end = isa;
>>>>>  			break;
>>>>>  		default:
>>>>>  			/*
>>>>
>>>>
>>>> Hmm, looking at all of this (especially this hack to the "old" parser),
>>>> I feel more like these should be promoted to a property of their own.
>>>> The "old" parser was designed to handle numbers, and here when you're
>>>> interested in the values behind the numbers (which is a first iirc), you
>>>> don't make any use of that. I don't really want to see a world where
>>>
>>> I had a version of this code that parsed the numbers and stored them as integers
>>> in `struct riscv_isainfo`. It didn't work with of_property_match_string() as
>>> used for riscv,isa-extensions, since that function expects the extension name to
>>> be the full string.
> 
> I don't think I actually want what I am about to say, but it's not as if we
> are forced to parse it in that way for all properties. It's handy AF to be
> able to reuse reuse that function, and that was part of my goal originally
> with the property, but we are not locked into using
> of_property_match_string() if there's some specific property where that's
> getting in our way. That's kinda an aside though..
> 
>>> Either we would need to change the code to parse a version
>>> number out of each string in the riscv,isa-extensions list (and make the binding
>>> a bunch of regexes), or we need a separate "extension" entry (and DT binding
>>> entry) for each supported version.
>>
>> Version numbers aren't real, there's no compatibility promise that we can
>> consistently rely on so we treat riscv,isa-extensions as simply containing
>> alphanumeric extensions.  This was an intentional part of simplifying riscv,isa
>> into riscv,isa-extensions.
> 
> You seem to recall my motivations better than I do!
> 
>>> I chose the second option, and as a consequence I didn't actually need to parse
>>> the integer value in the ISA string code path either.
>>>
>>>> we have every single iteration of smNpM under the sun in the property,
>>>> because there's a fair bit of churn in the isa. Granted, this applies to
>>>> all the various, the difference for me is the level of churn.
>>>
>>> Indeed. In fact, one thought I had while looking at this code is that we should
>>> be ignoring any extension in the ISA string with a version < 1.0 or >= 2.0,
>>> since those won't be compatible with what we expect.
>>
>> I might go further and say that we should only accept specific exact versions of
>> extensions other than Ss/Sm.
> 
> This is what we do, right? Every property is supposed to match to
> exactly the frozen or ratified spec, so they do have exactly one version
> at present. The property descriptions should contain that information.
> 
>> This could be revisited after the recent "semver
>> for ISA extensions" policy is tested at least once under real-world conditions.
>>
>> Right now we have two ratified versions of Ss/Sm, soon to be three, and one

My understanding (from hwprobe.rst and various ML comments) is that Linux
assumes Ss1p10. That's why I started counting with Ss1p11. It looks like Ss1p10
was never ratified, but that doesn't prevent us from referencing it in the
binding, if needed. Should we start enumerating extensions at Ss1p11 or
something else?

>> ratified version of all other extensions.  I hardly think this is an excessive
>> amount of churn.
> 
> Yeah, maybe it's fine. I'm just overthinking it and there isn't a
> problem.

My interpretation of this and the above comments is that we do actually want to
enumerate every supported "version" of the privileged ISA in the binding, and
parse them as entirely independent extensions that just happen to have
similar-looking names. Is that correct?

>>>> Or maybe we can still with the properties you have, but instead of
>>>> treating them like any other extension, handle these separately,
>>>> focusing on the numbering, so that only having the exact version
>>>> supported by a cpu is possible.
>>>
>>> Maybe I'm misunderstanding what you're saying here, but it is already the case
>>> that the DT for a CPU would only contain the exact version of the privileged ISA
>>> supported by that CPU.
>>
>> If privileged spec versions are boolean extensions, then you would say "ss1p11",
>> "ss1p12", "ss1p13" as separate/simultaneous extensions.
> 
>> This is needed in order
>> to allow simple support checks as described in the riscv,isa-extensions cover
>> letter.
> 
> Yes, it is explicitly a goal of riscv,isa-extensions that you can look
> for a specific extension in the list if that is all you care about. If
> you go and drop ss1p11 because you support ss1p12 it defeats that.

Okay, that makes sense, but that is not how the parsing code works right now,
which is probably what led me down the wrong path. :)

To have the intended semantics, we cannot parse _anything_ in
riscv,isa-extensions as a "bundled" or "superset" extension. Because to
accomplish your goal, each extension in the bundle must be listed explicitly, in
case the consumer only cares about that one extension. So it sounds like
riscv_fill_hwcap_from_ext_list() needs to ignore subset_ext_size/subset_ext_ids.

> I don't know off the top of my head how to enforce ss1p12 requiring ss1p11
> in json schema, but I do have an idea of where to start...

Yeah, this is different from normal "dependencies:" because it is a string list.

I think we need to add dependencies in the binding for the bundled extensions as
well, and maybe even between extensions like "d" and "f".

>>> With this implementation, the fact that the integer version gets expanded to a
>>> series of flags is supposed to be invisible in the DT and to userspace. I
>>> realize I don't quite succeed there: putting "ss1p13" in the ISA string should
>>> work, but does not.
>>>
>>>> I'm still pretty undecided, I'd like to think about this a little bit,
>>>> but I think we can do better here.
>>>
>>> Sure, no problem. I'm happy to implement whatever we agree on. Though one
>>> consideration I had is that this is all in support of fixing a bug in v6.7, so I
>>> wanted the changes to be backportable.
>>>
>>> I suppose the easy way out for backporting is to check for RISCV_ISA_EXT_ZICBOZ
>>> for now, and then solve the larger problem once there is some other user of the
>>> envcfg CSR (or another Ss1p12 feature).
>>
>> I support that course of action.
> 
> I saw another mail suggesting that Zicbom implied Ss1p12, I think that
> should be reasonable position to take for now.

Like I mentioned in my other email, I don't think Zicboz is sufficient to imply
Ss1p12. So I'd prefer to either stay with checking Zicboz (like v3 does); or add
a bit for specifically the existence of the the envcfg CSR, that doesn't map to
anything in the ISA string (i.e. is not listed in riscv_isa_ext). Of course, if
we start ignoring subset_ext_ids, I'll have to reconsider how to actually
implement that.

Regards,
Samuel


