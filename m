Return-Path: <linux-kernel+bounces-11085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86581E122
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134681F2224C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFC1EA76;
	Mon, 25 Dec 2023 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTHFvc+w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EA1DDD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d2350636d6so3349240b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703514778; x=1704119578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLJwaknLZDjEeoCIcHASwS2cRi032Xc+xd0onyr4mDI=;
        b=OTHFvc+wpMFPEbMPZ8KaxeZoYHbdrEP0GVks3Gg3CCFLUSticWxecnMxIDE5yjiZHU
         CVwYAuY/bkMK7Kl5M5ln60GOQ33p2hcPZwfxCzYCgP5R/8VWfchFG1YvHQyyqG/kBu6G
         x9p9qD6YhyCUeqEk4MIlRJzzNHmgLwxCDvFt7tUSRAwAIurbAfo3coW2VZfTZCUjBy/U
         tlX/6fGBjNeMZy62nNypmhIpB29epefWYUWzAZ7c/E+zDcGFDnpYQfD/vpPYFZpnScFk
         w12KOSTKtck9XdC5lS4/oJBvr8OeucvUYcc1r0qAO4ERnn/tG/CX+kfbo9CgJyJjaaLM
         u1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703514778; x=1704119578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLJwaknLZDjEeoCIcHASwS2cRi032Xc+xd0onyr4mDI=;
        b=NyynoGC7FbJwYr3bkOA+bssANrvLm2BLa6l8LoBYQhPnf3GtZO3daFA6i9miz/rCBx
         FrFerRo2wpXrguM9I9T3gXLwOYn9UcMvSJugOluUe54HSjKQ0nuAFDaxAhh63FlFTuSh
         An/5FtLfG83k7onrEXa3vhPuo7EmgCk9Wfwzpm5U+1U+kusjcu3uPq5Ys1NPMch+IefE
         uPjFCartjqACtCcrJLezgNa0Vs/ZRJzdwhwee8uOIst5+MFaluMMQdmyMtZ4u7ZO1OVh
         qQ5ZluF2MZQGkJNMqFoVUgimLpVeVIfNI/KgWLHP5iR/ozCAakzceBLR/AwrBJ9rKspP
         uSwQ==
X-Gm-Message-State: AOJu0YyiJ7qKvFy9+iiqojA6agHodAAjMg2VX8bplb54DjInLyIxN3jj
	HNs6KBUNGuYoCwCX8M0J7zPOEWepUp1xOw==
X-Google-Smtp-Source: AGHT+IFHA9tZu4HDYWQPfdl1A3ES590rB3P8abnapC73FPUp70BWgaVDGE5VDZrbPBcxMpUgtCLJHA==
X-Received: by 2002:a05:6a20:ba82:b0:194:c6d3:1bda with SMTP id fb2-20020a056a20ba8200b00194c6d31bdamr6166408pzb.120.1703514778309;
        Mon, 25 Dec 2023 06:32:58 -0800 (PST)
Received: from [10.254.172.83] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id e17-20020a630f11000000b005c6007a13b5sm7807307pgl.25.2023.12.25.06.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 06:32:57 -0800 (PST)
Message-ID: <7d4e59b7-ddaf-45b9-909c-9ecb8ff5a34d@bytedance.com>
Date: Mon, 25 Dec 2023 22:32:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in
 load/store
To: Chris Li <chriscli@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com>
 <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
 <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
 <2a22e9b5-dc8c-4c4d-81c2-2f4e1850cf3d@bytedance.com>
 <CAF8kJuPe3njSJhii92xOefCjyqRrWC3nSA=Dv7BQ6=Mf=6gKAQ@mail.gmail.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuPe3njSJhii92xOefCjyqRrWC3nSA=Dv7BQ6=Mf=6gKAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/23 01:37, Chris Li wrote:
> Hi Chengming,
> 
> The patch looks good to me.
> 
> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> 

Thanks.

[...]
>>
>> I think there are two viewpoints here, both works ok to me.
>>
>> The first is from ownship or lifetime, these percpu mutex and dstmem
>> are shared between all pools, so no one pool own the mutex and dstmem,
>> nor does the percpu acomp_ctx in each pool.
>>
>> The second is from usage, these percpu mutex and dstmem are used by
>> the percpu acomp_ctx in each pool, so it's easy to use to put pointers
>> to them in the percpu acomp_ctx.
>>
>> Actually I think it's simpler to let the percpu acomp_ctx has its own
>> mutex and dstmem, which in fact are the necessary parts when it use
>> the acomp interfaces.
> 
> Agree, that is why I prefer to keep the struct together. I am fine
> with what Yosry suggested and the anonymous struct, just consider it
> is not critically necessary.
> 

Agree, I have no strong opinion about it, so will just leave it as it is.

>>
>> This way, we could delete the percpu mutex and dstmem, and its hotplugs,
> 
> That is the real value of this patch. Thanks for doing that.
> 
>> and not shared anymore between all pools. Maybe we would have many pools
>> at the same time in the future, like different compression algorithm or
>> different zpool for different memcg workloads. Who knows? :-)
> 
> As long as the zswap is not re-enterable, e.g. never have the nested
> page fault that causes zswap_load within another zswap_load, I think
> we are fine having more than one pool share the buffer. In fact, if we
> trigger the nested zswap load, I expect the kernel will dead lock on
> the nested mutex acquire because the mutex is already taken. We will
> know about kernel panic rather than selient memory corruption.
> 
>>
>> So how about this patch below? Just RFC.
>>
>> Subject: [PATCH] mm/zswap: make each acomp_ctx has its own mutex and dstmem
> 
> Thank you for doing that, you can consider submitting it as the real
> patch instead of the RFC. I see real value in this patch removing some
> per CPU fields.

Ok, will update.

Thanks!

