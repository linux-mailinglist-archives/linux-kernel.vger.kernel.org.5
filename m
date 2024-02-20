Return-Path: <linux-kernel+bounces-73396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD4085C1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BFC284A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942B76908;
	Tue, 20 Feb 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ToeNGLyu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CD768EF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448366; cv=none; b=oUUJGU9+NXcvDHWw8dSDgHKs4NpYgyML5yXqXT2v62QfS5UYOqJkvum7FfgVoUCIebMQHG39l9JQlky0ajMzDheUhXc7d0fMOESubsWcooJuFGSgY9meLBQooeJkqRP8JWc+2DwLAVg2ulCjdgLSaieahxiurHBwT+7QdR8vsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448366; c=relaxed/simple;
	bh=6ym8f8jTbmZWP67n8mpqHfZeHSbKF9DkuHJ3SUPMLWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htJVw0+BLAQhhLuwsIHU7jUM3zWLcRavzxjyMaMvMAW5Fqz7itIdOHkgdMY3DuH37N95U+pwfy4ldw0KeN8BGTvsZWnJYxsPHer2cdwQBbNosgTi8r9mQv2wyHNb7Pb8EtSRXMJPg2yvohqYnQteo/Zv/KBeLMAqAubc5l/OjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ToeNGLyu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411baa02bc3so13091785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708448362; x=1709053162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EviEX8TRRD/2iXyTrJZUWCxAWI35FiIxGgn/BSnnfY=;
        b=ToeNGLyulg/HAlktV98wzMOaSQW7/qciEqcGZsU9ZRHzmc1zOWeQUg2IEJEwtj4HNT
         avQDyMtJs7hDUNlnZsPc4vqDlLWKxVOApPgQZ5c79fegDjn+dXyWLBD14+7DgMUG/6BC
         ObV/bLWfkCLZvFPpLUXDKzsRgLyLrktJ+1POIAebEuryZiKooGi0vRnVJA3GnKy2T6ez
         9fbHnxUSBkzEkOamnR8T5OFvlF+pvXUus3JXS8Fmz42Alvq36Ejx+h+uOSwlAT8n3Sx4
         gtmp7Gndepn9bYeCovRyxbPkA9rDkTpWXYHgSew72YO/Tr4DGo8h1F/E8MxGvQUd/Aq3
         XBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448362; x=1709053162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EviEX8TRRD/2iXyTrJZUWCxAWI35FiIxGgn/BSnnfY=;
        b=nDCa6S6m4zDHKuamqNc75Ta7klXG8oSGdzFN+YldBBX8u6OM4CZwkUrQ3OnSYP297a
         K9raG8/9te8/t/Hn/bhCzCeR35Uh1MbPmv0HLnP4+uMF6lVzpJ5J29Xgdh6ZrUCgj93u
         7F2uk7yHRHl6QQ/POuKsClne9Wra6KjuVcD4bJhx8PUfLMkeVhTEBZ1F3UEtg9RJ2rU5
         BbR7Va1ZMp6k693a1ozVMESE9VQQbNsrDnQMMF4xZvx57XvW8jtjRtSShd94IXfLFTMk
         V77C/s1mAlLHh2B7+x4D7BWXl5IGX+l6tTgoNbb7JTKnZL4IQL2IEVhc+tn8HRILbml6
         9uDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLdXCKKJHwawWA+6ub2GehNRF1VLNv+tM97MnItwJZKm9o0xF5vYUksypEnbaT3PtpASUF5UCG6nMMY492d2FncvMN2hszNIhXiSXR
X-Gm-Message-State: AOJu0Yzgx2it5WbvepeQy1Im358mGw33zatAHNiHKX6PHvvStFkMIPOn
	+7UNP52SE2ap21LDg6CoqI7z1uVcV7xq0ySX8NYa5nTUfHuHRMbJDZibqPX+kpE=
X-Google-Smtp-Source: AGHT+IGQxErl3whqUl2JduTZmonP9tZ9r2pRvNgP2swc0PUclE5cXdKNpnDIqc/OizhzpT3qAwPiUQ==
X-Received: by 2002:a05:600c:3513:b0:410:7d33:25ba with SMTP id h19-20020a05600c351300b004107d3325bamr10725379wmq.4.1708448361744;
        Tue, 20 Feb 2024 08:59:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:6202:c7ea:a0cd:ad4a? ([2a01:e0a:999:a3a0:6202:c7ea:a0cd:ad4a])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm14059504wrx.79.2024.02.20.08.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 08:59:21 -0800 (PST)
Message-ID: <54d2ad13-9d9c-4ec0-96d7-95a54d54a29c@rivosinc.com>
Date: Tue, 20 Feb 2024 17:59:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: hwprobe: export largest userspace address
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Robin Ehn <rehn@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
References: <20240220110950.871307-1-cleger@rivosinc.com>
 <00cae989-9640-4931-9683-dd889cd6b7db@app.fastmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <00cae989-9640-4931-9683-dd889cd6b7db@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/02/2024 17:50, Stefan O'Rear wrote:
> On Tue, Feb 20, 2024, at 6:09 AM, Clément Léger wrote:
>> Some userspace applications (OpenJDK for instance) uses the free MSBs
>> in pointers to insert additional information for their own logic and
>> need to get this information from somewhere. Currently they rely on
>> parsing /proc/cpuinfo "mmu=svxx" string to obtain the current value of
>> virtual address used bits [1]. Since this reflect the raw MMU mode
>> supported, it might differ from the logical one used internally.
>> Exporting the maximum mmappable address through hwprobe will allow a
>> more stable interface to be used. For that purpose, add a new hwprobe
>> key named RISCV_HWPROBE_MAX_KEY which will export the maximum mmappable
>> userspace address.
>>
>> Link: 
>> https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/vm_version_linux_riscv.cpp#L171 
>> [1]
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> Reviewed-by: Stefan O'Rear <sorear@fastmail.com>
> 
> Ideally, we'd have something arch-independent, but this is a good interface
> and simple enough to support in perpetuity.

Hi Stefan,

Indeed while not architecture specific, I did not found anything
relevant in which this information could easily fit. sysconf is actually
mainly compile time constants returned by the libc. And the few non
POSIX sysconf defines (_SC_xx) are actually using either /proc parsing
or the sysinfo syscall which did not changed since kernel 2.3. But maybe
someone out there knows something better suited to export this information.

Thanks,

Clément

> 
> -s
> 
>> ---
>> v2:
>>  - Note: tried sysconf to export it but this is not backed by syscall
>>    and thus does not allow exporting such information easily.
>>  - Use arch_get_mmap_end() instead of VA_BITS since it reflects the
>>    maximum logical address used by the riscv port
>>  - Change hwprobe key name from RISCV_HWPROBE_KEY_VA_BITS to
>>    RISCV_HWPROBE_KEY_MAX_ADDRESS
>>  - Link to v1: 
>> https://lore.kernel.org/lkml/20240201140319.360088-1-cleger@rivosinc.com/
>> ---
>>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>  arch/riscv/kernel/sys_hwprobe.c       | 4 ++++
>>  4 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/riscv/hwprobe.rst 
>> b/Documentation/arch/riscv/hwprobe.rst
>> index b2bcc9eed9aa..a626aa21ac74 100644
>> --- a/Documentation/arch/riscv/hwprobe.rst
>> +++ b/Documentation/arch/riscv/hwprobe.rst
>> @@ -210,3 +210,6 @@ The following keys are defined:
>>
>>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>>    represents the size of the Zicboz block in bytes.
>> +
>> +* :c:macro:`RISCV_HWPROBE_KEY_MAX_USER_ADDRESS`: An unsigned long which
>> +  represent the maximum userspace mmappable address.
>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>> index 630507dff5ea..150a9877b0af 100644
>> --- a/arch/riscv/include/asm/hwprobe.h
>> +++ b/arch/riscv/include/asm/hwprobe.h
>> @@ -8,7 +8,7 @@
>>
>>  #include <uapi/asm/hwprobe.h>
>>
>> -#define RISCV_HWPROBE_MAX_KEY 6
>> +#define RISCV_HWPROBE_MAX_KEY 7
>>
>>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>  {
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h 
>> b/arch/riscv/include/uapi/asm/hwprobe.h
>> index 9f2a8e3ff204..a6da434be9da 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>> +#define RISCV_HWPROBE_KEY_MAX_USER_ADDRESS	7
>>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>
>>  /* Flags */
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>> index a7c56b41efd2..19a47540b4a2 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -8,6 +8,7 @@
>>  #include <asm/cacheflush.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/hwprobe.h>
>> +#include <asm/processor.h>
>>  #include <asm/sbi.h>
>>  #include <asm/switch_to.h>
>>  #include <asm/uaccess.h>
>> @@ -202,6 +203,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>  			pair->value = riscv_cboz_block_size;
>>  		break;
>> +	case RISCV_HWPROBE_KEY_MAX_USER_ADDRESS:
>> +		pair->value = arch_get_mmap_end(ULONG_MAX, 0, 0);
>> +		break;
>>
>>  	/*
>>  	 * For forward compatibility, unknown keys don't fail the whole
>> -- 
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

