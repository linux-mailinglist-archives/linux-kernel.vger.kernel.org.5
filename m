Return-Path: <linux-kernel+bounces-30810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543183248E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33A31C22CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699DC142;
	Fri, 19 Jan 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fg1AUJnO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF55BA2E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645468; cv=none; b=VC5Gk1aEF2aICHV9/sLTDalGyZpTo7ENnRKU8dRIL5BR8YVvDzRdjGfX028qGebYePC8FWhsD6v49Py5xpgDx9je+SphMyGehf8d8e2tOSivTEUL90/Xq4DnFxbIjzO0XnHv8TOCzcpzW0rnU5DHgd/Qazib3De8tPkg3jtWuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645468; c=relaxed/simple;
	bh=NjXRZzRQRfi2WqiVfEKjjPOfMA6nHiBOBvPolNtw6Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yc6mnBvvNAKMisJienXnXLup4/0EPCb1uEEpAXt871iTp/QWMmfExqgbxW0q1WLExyw+z48OW5YRKL85ghrvLdF30BbfTMOQfOYGD+B5ypL46Y1rJKQ8lQpHUmxGctXT8PwkaBXkLXXg6JxPKxkyFtzsuDZt9LAAPhIK1+8+xJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fg1AUJnO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71c844811so2085055ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705645467; x=1706250267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezGigqCkcdld0LRuOuJDBfz/9AsfE2OTVy2IitNYYM8=;
        b=Fg1AUJnO5U6UK5VGg2rzQAfxTV62ERztv2aNZFsHt+uw/SSAW7w/shhbD14OMig8yC
         RKelynFjupAa1O4ZzgSEdIaJO3gBnTwSxZbNHtULVEu2VQ+WhXr9r1hwSs15MgRcIFQW
         4WmMpLbltrMZ1tqO/vU8PKv7FTE5AgiM3KE8NLIQgkGoNJu8KTWrC+NGAguQqV5yaN2d
         pRBxWeIgJCe7O1tvxogjup1AsbOIAKZO9dk1x8/UrhaulZlhcbR/GPgkmo0wfrTfZEeG
         0q8NOwIQKmXeKxV3Jb0ZYyRvQSNqFRTXYAlNrqpX4NTJJ0ukP+lew4ukLdx78CJF/KrD
         hqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705645467; x=1706250267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezGigqCkcdld0LRuOuJDBfz/9AsfE2OTVy2IitNYYM8=;
        b=V3wltNpUQSrPMtjNzTmyeASNWFw3pN1dGkXkuxgMOc2d3QIWxLzRggcUKVnqoC2M9Z
         3wf7/eIcZHxD+EZPTZOJmPpVF4ex+GkMHlhfmT3Rge5Xp9CXhJZm/jkrGE8jv0NA4MOV
         +0iqGTzSOCHkk+GMhr8KE7uj4wAX00ZNVdsQjXqA94O59JBbWv5Nzki0WmROO2nr8oN8
         uYJRjqpEYTuok5lJN1MoEN99JEm4HEUycnx/8ko7YDg9wWlzmVUGisYMWUgWhdCuN2pp
         rUZsK5bJOtsxwufdrxbzIxrla0rMEYFPbPv2yg6364oNRnZoPuSGuHXdT3XXstupdAa+
         n21g==
X-Gm-Message-State: AOJu0YyuCpndZ1Z8Cw/0S+QAvfrzLjXzWiH0X8cvvDusjEAa3joxZQE2
	/ahR0kxo7e+UwfKgKhKp8VbW6ZTsYDIXdtCdCvM7thk3JMaqYzsmg9KEaFYl2eo=
X-Google-Smtp-Source: AGHT+IHbs1UCb6N4UA5U9mggCoxh/GqergCZhsihImGoe010eTwzBJXzkJPka6nGusHM57gdVMc67w==
X-Received: by 2002:a17:902:c3d1:b0:1d7:19ec:2e55 with SMTP id j17-20020a170902c3d100b001d719ec2e55mr951130plj.59.1705645466629;
        Thu, 18 Jan 2024 22:24:26 -0800 (PST)
Received: from [10.254.224.1] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id jf4-20020a170903268400b001d0d312bc2asm2301115plb.193.2024.01.18.22.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:24:26 -0800 (PST)
Message-ID: <fa586d2c-179c-4315-9e32-0832cf22e186@bytedance.com>
Date: Fri, 19 Jan 2024 14:24:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/zswap: split zswap rb-tree
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 Chris Li <chriscli@google.com>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <20240117-b4-zswap-lock-optimize-v1-2-23f6effe5775@bytedance.com>
 <CAKEwX=Op6XTawUZg-4pDM70z4kB4-5Wo6Ss+ptyzkd+Ub3PDEQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=Op6XTawUZg-4pDM70z4kB4-5Wo6Ss+ptyzkd+Ub3PDEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/19 03:24, Nhat Pham wrote:
> On Wed, Jan 17, 2024 at 1:23 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
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
> 
> That's really impressive, especially the sys time reduction :) Well done.
> 

Thanks!

>>
>> So there are clearly improvements.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Code looks solid too. I haven't read the xarray patch series too
> closely yet, but this patch series is clearly already an improvement.
> It is simple, with existing precedent (from swap cache), and
> experiments show that it works quite well to improve zswap's
> performance.
> 
> If the xarray patch proves to be even better, we can always combine it
> with this approach (a per-range xarray?), or replace it with the
> xarray. But for now:
> 
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> 

Right, I agree. We should combine both approaches.

