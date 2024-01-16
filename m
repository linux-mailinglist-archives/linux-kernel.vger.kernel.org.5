Return-Path: <linux-kernel+bounces-27350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5082EE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5745EB223D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92C1B95A;
	Tue, 16 Jan 2024 11:53:13 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207361B94D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e86c02054so1159095e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705405989; x=1706010789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfZGs9layKIX9fwbjXHkjF4XGGcTxC9dx97HshOMXdc=;
        b=vjn2ScmJ4ShYGHrhu5LWybhDZzyNJrjl5HTNRlCkT4XWrZ+VKU7sarNTd189PEgufH
         +0HD5GQO4Q4SCBRpfqGDycIGubJcMbvLpkZSFSLXEzX3XTtlQ4cg5KZ7VuY0evljcIH6
         AX0M4VsJX3lOoeDi77rQpKAYCjXSVM4emVtlTkISJab+VU3UI3jSMOFuJOtF8aPtxWDM
         3p8ohCNOMOMsegCaIMVo7fk8mkbnF5+i4MkfzbrG8UZpusM+VS6OVhVleq3izrPjl6xQ
         SjWp55zPt2fZUdFr/ge/Z38EhBP64vonFCwSIcR4kbb6AAym4WMVWPtsL+b4hwq8rWwP
         Ja+A==
X-Gm-Message-State: AOJu0YwBXri0UMIn/xoZXeZyzWMq+xqOpVEiZHo4wUbyzRSYS/bbdRMG
	LS6LCZkaTNnHDxGsrBqujygAzYbHxeRGx4He
X-Google-Smtp-Source: AGHT+IGNcZVKJEAFWeJad2acy/pdnNubIlKA4fuuNk/qjLyZYa+6smDv3tPnJx9gi3LnkHkUE4eo1Q==
X-Received: by 2002:a05:600c:4ecc:b0:40e:500c:23d8 with SMTP id g12-20020a05600c4ecc00b0040e500c23d8mr3608197wmq.151.1705405989091;
        Tue, 16 Jan 2024 03:53:09 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b0040e6ea6d2d0sm3260112wms.24.2024.01.16.03.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:53:08 -0800 (PST)
Message-ID: <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
Date: Tue, 16 Jan 2024 12:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Content-Language: en-US
To: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@fb.com,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Christoph Lameter <cl@linux.com>
References: <20220809142457.4751229f@imladris.surriel.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20220809142457.4751229f@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 09. 08. 22, 20:24, Rik van Riel wrote:
> Align larger anonymous memory mappings on THP boundaries by
> going through thp_get_unmapped_area if THPs are enabled for
> the current process.
> 
> With this patch, larger anonymous mappings are now THP aligned.
> When a malloc library allocates a 2MB or larger arena, that
> arena can now be mapped with THPs right from the start, which
> can result in better TLB hit rates and execution time.

This appears to break 32bit processes on x86_64 (at least). In 
particular, 32bit kernel or firefox builds in our build system.

Reverting this on top of 6.7 makes it work again.

Downstream report:
  https://bugzilla.suse.com/show_bug.cgi?id=1218841

So running:
pahole -J --btf_gen_floats -j --lang_exclude=rust 
--skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf

crashes or errors out with some random errors:
[182671] STRUCT idr's field 'idr_next' offset=128 bit_size=0 type=181346 
Error emitting field

strace shows mmap() fails with ENOMEM right before the errors:
1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
..
1223  <... mmap2 resumed>)              = -1 ENOMEM (Cannot allocate memory)

Note the .tmp_vmlinux.btf above can be arbitrary, but likely large 
enough. For reference, one is available at:
https://decibel.fi.muni.cz/~xslaby/n/btf

Any ideas?

> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
> v2: avoid the chicken & egg issue with MMF_VM_HUGEPAGE (Yang Shi)
> 
>   mm/mmap.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c035020d0c89..1d859893436d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2229,6 +2229,9 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>   		 */
>   		pgoff = 0;
>   		get_area = shmem_get_unmapped_area;
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +		/* Ensures that larger anonymous mappings are THP aligned. */
> +		get_area = thp_get_unmapped_area;
>   	}
>   
>   	addr = get_area(file, addr, len, pgoff, flags);

thanks,
-- 
js
suse labs


