Return-Path: <linux-kernel+bounces-30807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3583248A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC217B23486
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD663C1;
	Fri, 19 Jan 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iM3gzWnp"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A325381
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645258; cv=none; b=lzOnxdaMiP7PTH7ZSNqtKmYl4j08qBRr9gF51deVHJunPxKOiCPPLaOGdyX27Qux6ZZ+TtrfAS+eQloaP60ZIJUuT2icYA5zS0UOrFzRIOjSxEaYeKEfg5myGyXPsH5qH/htHYWdQrtuK+cSMYG4W6tEYZmv0+NB1zeePavuSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645258; c=relaxed/simple;
	bh=nkyIhW/V0YN44OOpH475TcG8PZRvB9SjnwfgrEEUXm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2eXYkPDI88eNHbRRFXlnSabc5J8N7L5yognyMI+wgL4VP7U6pORknnPkg5WuMdryPa4kABII77NohiIIJAbFlK7xcV4qzAfz5T6VZTt8WusQtyu6yCxi9c5viABE4E0+XXCoH1FF5gVW5kCGxB4BLuaT5hiKjXwxU7ZJ5qJi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iM3gzWnp; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so258554b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705645256; x=1706250056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3VHIi4EcMrxvY3GiWV/JZSeHigZUaqOcO0zANnBCwA=;
        b=iM3gzWnpAtVQ+GmG1tDkICMQTBbTobrgee6jcGUJ4lrtGrWhDlraIgtYEG5FXolS+e
         JD7wEmCJy54axnCGr7VuatjK3ysvBHCPxPQxrn9OS2nxAFVQCCcbg2ktKijVXV/PfVE/
         2Dj2aZkkXhMsigk0pNKFwpKUZ7h8kfmjTNGVWH9lKC5NqWpZmQh5WFxI9bOi6yx3YRzc
         xBwEIObmoMrmS30b+LvzPv6pINgJZTb/blQQUXXpZJABJLLdCT7GS/cJE1wUAhTFXhsg
         wNIMBXpnvOcUj/OWJM7rm4lgQ+BRdukYX0wddVyw+rO78FFeCbcc6rXKd5TgUhCwFfU1
         lmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705645256; x=1706250056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3VHIi4EcMrxvY3GiWV/JZSeHigZUaqOcO0zANnBCwA=;
        b=e/0xeP0EOUsKwlxkswiToko0bjvguXsuaswz+MX9wqUsILt84UufGNZOGddCaXdblE
         LZuu/eEovQG+C/Yv3y8xAeR/Kc03L0yPj36tvEqVj+x6KrzO7Mfl8EFJE2kYLKW9niAA
         1NzWokLV9wbsF97jftpkMs+JsVFmMLRC6Fsq2TbKeZ+4XhR4GgAe4xOvlYw1ScSSflau
         Yh0zus1x0Uk90zzBhli26wkV2At8ob3H2sMVjqc0YsbMFeRkvheAv6bYdqyoc0jEt103
         ehaeXpzVAUkAkiHravpWf3dIGsrEDBVmX7OmliJUsz+e78F4sCBbwGBtrxRGxG1ySuo3
         E9kA==
X-Gm-Message-State: AOJu0Yx5BYLwd5URRb7X8M4SbhMtrUp8ez5GtiYHlO+1fUdC7W93yQ/j
	DXq3d4c52KFAxYFggh26ZlBnXviPvLpSlYQ7TGIknETbAXBVYwy0rptSMoDf8Ec=
X-Google-Smtp-Source: AGHT+IFHQiRAGswMNeix8ZpNGARW4PZLfzYqxGE2xol7urxNVgtoqGnAaJW9l0YjX7y5yQQsxZxmKA==
X-Received: by 2002:a05:6808:2123:b0:3bd:a1bd:a9d9 with SMTP id r35-20020a056808212300b003bda1bda9d9mr1067863oiw.33.1705645256248;
        Thu, 18 Jan 2024 22:20:56 -0800 (PST)
Received: from [10.254.224.1] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s17-20020a62e711000000b006daf14dc95asm4417111pfh.142.2024.01.18.22.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:20:55 -0800 (PST)
Message-ID: <fce77b9c-0e5d-4fb5-85cc-ac88d45d8d3d@bytedance.com>
Date: Fri, 19 Jan 2024 14:20:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/zswap: split zswap rb-tree
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chriscli@google.com>,
 Nhat Pham <nphamcs@gmail.com>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <20240117-b4-zswap-lock-optimize-v1-2-23f6effe5775@bytedance.com>
 <20240118151123.GH939255@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240118151123.GH939255@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/18 23:11, Johannes Weiner wrote:
> On Wed, Jan 17, 2024 at 09:23:19AM +0000, Chengming Zhou wrote:
>> Each swapfile has one rb-tree to search the mapping of swp_entry_t to
>> zswap_entry, that use a spinlock to protect, which can cause heavy lock
>> contention if multiple tasks zswap_store/load concurrently.
>>
>> Optimize the scalability problem by splitting the zswap rb-tree into
>> multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
>> just like we did in the swap cache address_space splitting.
>>
>> Although this method can't solve the spinlock contention completely, it
>> can mitigate much of that contention. Below is the results of kernel build
>> in tmpfs with zswap shrinker enabled:
>>
>>      linux-next  zswap-lock-optimize
>> real 1m9.181s    1m3.820s
>> user 17m44.036s  17m40.100s
>> sys  7m37.297s   4m54.622s
>>
>> So there are clearly improvements.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> One minor nit:
> 
>> @@ -265,6 +266,10 @@ static bool zswap_has_pool;
>>  * helpers and fwd declarations
>>  **********************************/
>>  
>> +#define swap_zswap_tree(entry)					\
>> +	(&zswap_trees[swp_type(entry)][swp_offset(entry)	\
>> +		>> SWAP_ADDRESS_SPACE_SHIFT])
> 
> Make this a static inline function instead?

Good suggestion, will do.

Thanks.

