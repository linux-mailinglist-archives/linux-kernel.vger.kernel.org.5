Return-Path: <linux-kernel+bounces-72453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAB85B3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53350B21BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63985A104;
	Tue, 20 Feb 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fL1xtiSB"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773115A0EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412996; cv=none; b=jlduOXjPmOn9W6p2/u/sIpCA4na2UEp7IEe4zxdZjEyGIA0xs4BM573UxBdFM59PdyOY6Nv2puLMtkEMN8BWXHzWstDtObb0TfA3ZquPsLzZrZcQXBYDdy5iVoRsz3KEYmyivOXbGDSs7sBp5pPMmmUzCSBC7CV0nfeiC417tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412996; c=relaxed/simple;
	bh=k/AlvDORrERnkjHtpNpfdx2Pcua0s45Yh20nTW+qW7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RW5Mk18k4MF2meAc0CPqgSzVj1RaS49BP8SYTSOla5ENjN8emvSw3zO1jJAJ5y9tXh9pYUBU+t8pPBK64ogaZ25oEs7MCMVHacE9v7yLMR03kG6DS8RRgmmSAAZMAbq8FlOEtQZeYL6UYx0xnGaw+X5LzjlxFjpOIIXskzSImeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fL1xtiSB; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21e45ed41d7so1987290fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708412993; x=1709017793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na0GZp1wrFYb5HNRZwa2JvGSSRG5B5+T3o+rgHxKIug=;
        b=fL1xtiSBQ5FDhFl4J/FWsX6NXZRmZzxHFkgIDHdBWzzxjYKfU6XZxRGm0Gylv24Q6B
         j6VqQkIhD1OH4bKDNYgXN6SYrPZNrnBQoU0tc140R0tHg+o3TS0hufdGJ1VpXSq0LDyD
         Q7unXYepQWKKG9/8p+ZPcxMZqEQY4LdulSI1rc0V2MkanU5TNi+8j9Um2jKXGOKbtmrS
         VMxz3iKgHVZp/MpSqWlaK2mqNTIJ/wT9foP1DYdtiAXQwY4GkXAThVIY4VQKA0YXCiDu
         pGT/HI8/77MxznZ7MgLFJVcYv/dclyTsFQXZxI5KBo3XHVSvDHysoPo4kZ+/4eNO+RTQ
         Mhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708412993; x=1709017793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na0GZp1wrFYb5HNRZwa2JvGSSRG5B5+T3o+rgHxKIug=;
        b=iClYvaaGqWEZSx3nNBloap1bj4/zeg/AgNYwt5n+TS/yQ7JrBFO6VJbatjG0sr3j8+
         lCorqonePCEkW0GA3sCOu7HP8MdQxy5dMwEQPIHBxD5z3AL0PY/l7R7rBYsXTP6tStSh
         9dOc6Mz40MDKUTdvHZWdBmPtEOug4NXGjQPcspx7lG78SMvIYl6f0Sz364DbfDkYRTAy
         r9zOwLCExah8tITv7nQIzK1ucEAbSFXS3RYXkspxD8s9QGX5KH3puBGBv0yvT3naBOtE
         rq3aNgZ5EQCl6KzNhCvItOEoD7NW17z+CwC3ffbhi4JsS8Ld7/ZWAPUR1r5ibhzJaecO
         G/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUsK63Fn2YkNk3d+BRGNIz7CrRKy/slFQGvXKd80y/JN+eyUsHPyhVE013CsEJOtexandCyJqDMWROffbod7OBwFd6t+xm//saJykeL
X-Gm-Message-State: AOJu0Yxa7pRSMGw73U22mycm8AcMtvWwn0PMTUwmy7GyDKOCtGhP81VT
	+VyVtxWbSTm2cj9BpNCS23Bte+UaR4JVX+AZn2Po7nUhFiiVg7wfNnbBV1YweOw=
X-Google-Smtp-Source: AGHT+IFv7SXTWLZHqqL9gNiuxSqL7e6FSWDqF8e5eOt4Engq96hwUBYVJZ7+Ftk/qijPy2QADmWRqw==
X-Received: by 2002:a05:6870:989a:b0:219:4603:d14a with SMTP id eg26-20020a056870989a00b002194603d14amr11784156oab.22.1708412993452;
        Mon, 19 Feb 2024 23:09:53 -0800 (PST)
Received: from [10.254.117.3] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e24-20020a656898000000b005ce998b9391sm4919297pgt.67.2024.02.19.23.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 23:09:53 -0800 (PST)
Message-ID: <ad844581-2533-4a9c-8367-e14bf7b494d7@bytedance.com>
Date: Tue, 20 Feb 2024 15:09:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Introduce slabinfo version 2.2
Content-Language: en-US
To: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Cc: Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <5cb54690-b357-4e7b-ac6f-23fc8dfe575a@bytedance.com>
 <CA+kNDJKCbd8ygfsZYELKHjCa0BNUSvMM40zWCnkPo7Hrg=HBhQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CA+kNDJKCbd8ygfsZYELKHjCa0BNUSvMM40zWCnkPo7Hrg=HBhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/20 14:25, zhang fangzheng wrote:
> On Mon, Feb 19, 2024 at 7:29 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2024/2/19 11:19, Fangzheng Zhang wrote:
>>> Hi all,
>>>
>>> This series introduces slabinfo version 2.2 to users.
>>> In slabinfo V2.2, we added a slabreclaim column to
>>> record whether each slab pool is of reclaim type.
>>> This will be more conducive for users to obtain
>>> the type of each slabdata more intuitively than through
>>> the interface /sys/kernel/slab/$cache/reclaim_account.
>>
>> I want to recommend a better tool: drgn[1] for these tasks, instead of changing
>> the output format of /proc/slabinfo, which may break existing userspace tools.
>>
>> [1] https://drgn.readthedocs.io/en/latest/index.html#
>>
> 
> Thank you very much for providing a new way.
> I have the following three questions about the new tool you provided:
> ---- 1. From the introduction, the tool is described as an alternative
> to the crash utility.
>           Will the permission requirements have different effects when
> used, user or userdebug?
> ----  2. The 'Helpers' chapter introduces the simple use of
> common.memory, but there is no output example.
>            It involves the use of slab objects, but it also needs to
> provide a specific slab_cache_name,
>            which cannot give an intuitive overall information like
> proc/slabinfo.

You can of course use drgn to iterate over all slabs by using the global
"slab_caches" list. (All kernel space is at your hand.)

>            I guess it is difficult to achieve direct output of slab
> type (reclaim or unreclaim). I don’t know, right?

It's easy for drgn to inspect each slab's information.

> ---- 3. Regarding the supported versions, is it supported for both
> arm/arm64? I don't seem to have seen any similar instructions.
> Finally, I would like to express my gratitude again. This tool will be
> very helpful for me in other future work.

Please check https://github.com/osandov/drgn for details.

Thanks.

