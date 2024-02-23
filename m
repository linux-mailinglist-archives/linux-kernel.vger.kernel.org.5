Return-Path: <linux-kernel+bounces-78231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514386108B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE620282AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79F7A736;
	Fri, 23 Feb 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eh4GeMbs"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83B78B57
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688263; cv=none; b=r5MfzLGXMMrb8wDixmUfdWhOfmWfiOrp70YrSq2NrTPHLLhOawK7Mm18zrBhdgBKTw3C0AdCtvegU1phXuWJYV2eXA+L0KmxsCjP/rKmIsOGhCv2MIfgUN/DxP2o/W6KQce4Uf6Xy6GUVfolx0HwDsNpHW6MVaDwieXoeVVDvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688263; c=relaxed/simple;
	bh=98rPOvnAYsubAtz6pjV4Z2L0dBtqB5ZBkhj2CgpLC/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsEjrt4hs188SvrxDGIcWhkmNQAuRRWEh/NmO3HSInrAitrWPDPoPBbcs/N8UYpbfrWOQi/pNlP9W7IWUKRzMoNJHCoC9qYKJ1JTTxf31Uso9RmiV8GlZtYNuOjEg6pwUA/V3S3gDCqIJwM/oi/MEik1vcQ6Er577BkgsqGn7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eh4GeMbs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbb47852cdso5475145ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708688260; x=1709293060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYojV14l/EO4ziKOz/Cae0jSZMr1ZjtiyuI8QAd/KG4=;
        b=eh4GeMbsIaGgjLeTa4Vqzd9K9SLf0p2eoZn5nWWOxYAi+Axfl7QpegIhr0bnrLGJJ/
         EyZq8s/uzVjsTBJLl9NPQmfav691GsagVTgkmVeVMhkHFax74HpT+hdFYktdVf96bPAI
         fBbweadNe3ASS/ng+pZBioH6otZbA/4AZFnYXSNHVuqAXwrlyJSL+GIS1Ntafoj7fjbF
         LS0a4HPeRmNPSSE7a1NUcu2wYaPv+wETywHuqbqY193WI6c6+kb0ipfCw21g8NHNKOGt
         dkZzx0t1cHgXQC/YQfSvsLh2G6UdSGqBEFV8aBboTUuGbUL35KWJBnYI2CGVC/BjMoh+
         3qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688260; x=1709293060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYojV14l/EO4ziKOz/Cae0jSZMr1ZjtiyuI8QAd/KG4=;
        b=dWPDLQEXy3R7vwVaMS3kyTpKtMy1HVYUj/9hqH3lRUWt1JreNclfLfd69pZ/y7H15n
         cGBXhq0TXqnTzRxp5N5faTQL2eDWqVOuKblXR7SF8UcU39akaFdGWhd1EQV8WhG3DTjM
         fcmb0H/oKJj79zvq+02vCivGUQ9pYXkP7vfWldJm4rAWmfcl/Gt6D95s+LepRtiWEGCB
         NRkc7+SrjPaGjnl1k0ybsnughsQ1PDt5Lbil6oaIS0HjY+UhniOSlJkczHITLgjE2Xvv
         WSFxO36fWEEKk70eOg15LF7mw0R8SLp+Qa2kQrXsgBBO1765DtoayFxzxZRQMS3zgdOX
         YkhA==
X-Forwarded-Encrypted: i=1; AJvYcCW67+FIK1oi4krhUWDVRxK4FbniZeHbTPIOXJifxmZc6baEa97IcWtChYSiIwub0C0r2/k/EzoF/LGLfek4CDxKq3h5UNodGEpsDalT
X-Gm-Message-State: AOJu0Yz7WBranH8hdslAy8i3HcmMnSQXL5acXFIpMcPpWQZNmewtiFVo
	Ritz+08Jp9qVL6X7VOlkKQ5pkvAKmg7g8qjkiSNz2kgzc0/HsOtt8OkZwaMzMBo=
X-Google-Smtp-Source: AGHT+IGs7KQxlDPJ6rVKmuuRL5lhG2zXTibsWX9m7dKXUX5N8EczSlq2CLx5XxM8WOJk61IbtRHvjw==
X-Received: by 2002:a17:903:1111:b0:1dc:156c:a864 with SMTP id n17-20020a170903111100b001dc156ca864mr1471837plh.4.1708688246918;
        Fri, 23 Feb 2024 03:37:26 -0800 (PST)
Received: from [10.255.179.232] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d8f6ae51aasm11471937plc.64.2024.02.23.03.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 03:37:26 -0800 (PST)
Message-ID: <9c0aad2c-548a-4287-b3d5-c7932f40c96f@bytedance.com>
Date: Fri, 23 Feb 2024 19:37:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240222203726.1101861-1-willy@infradead.org>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20240222203726.1101861-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/23 04:37, Matthew Wilcox (Oracle) 写道:
> Rosebush is a resizing, scalable, cache-aware, RCU optimised hash table.
> I've written a load of documentation about how it works, mostly in
> Documentation/core-api/rosebush.rst but some is dotted through the
> rosebush.c file too.
> 
> You can see this code as a further exploration of the "Linked lists are
> evil" design space.  For the workloads which a hashtable is suited to,
> it has lower overhead than either the maple tree or the rhashtable.
> It cannot support ranges (so is not a replacement for the maple tree),
> but it does have per-bucket locks so is more scalable for write-heavy
> workloads.  I suspect one could reimplement the rhashtable API on top
> of the rosebush, but I am not interested in doing that work myself.
> 
> The per-object overhead is 12 bytes, as opposed to 16 bytes for the
> rhashtable and 32 bytes for the maple tree.  The constant overhead is also
> small, being just 16 bytes for the struct rosebush.  The exact amount
> of memory consumed for a given number of objects is going to depend on
> the distribution of hashes; here are some estimated consumptions for
> power-of-ten entries distributed evenly over a 32-bit hash space in the
> various data structures:
> 
> number	xarray	maple	rhash	rosebush
> 1	3472	272	280	256
> 10	32272	784	424	256
> 100	262kB	3600	1864	2080
> 1000	[1]	34576	17224	16432
> 10k	[1]	343k	168392	131344
> 100k	[1]	3.4M	1731272	2101264
> 
> As you can see, rosebush and rhashtable are close the whole way.
> Rosebush moves in larger chunks because it doubles each time; there's
> no actual need to double the bucket size, but that works well with
> the slab allocator's existing slabs.  As noted in the documentation,
> we could create our own slabs and get closer to the 12 bytes per object
> minimum consumption. [2]
> 
> Where I expect rosebush to shine is on dependent cache misses.
> I've assumed an average chain length of 10 for rhashtable in the above
> memory calculations.  That means on average a lookup would take five cache
> misses that can't be speculated.  Rosebush does a linear walk of 4-byte
> hashes looking for matches, so the CPU can usefully speculate the entire
> array of hash values (indeed, we tell it exactly how many we're going to
> look at) and then take a single cache miss fetching the correct pointer.
> Add that to the cache miss to fetch the bucket and that's just two cache
> misses rather than five.
> 
> I have not yet converted any code to use the rosebush.  The API is
> designed for use by the dcache, and I expect it will evolve as it actually
Hello,

It seems that the advantage of this hash table is that it does not need to
traverse the linked list and has fewer cache misses. I want to know how
much performance improvement is expected if it is applied to dcache?

Thanks,
Peng
> gets used.  I think there's probably some more refactoring to be done.
> I am not aware of any bugs, but the test suite is pitifully small.
> The current algorithm grows the buckets more aggressively than the table;
> that's probably exactly the wrong thing to do for good performance.
> 
> This version is full of debugging printks.  You should probably take
> them out if you're going to try to benchmark it.  The regex '^print'
> should find them all.  Contributions welcome; I really want to get back
> to working on folios, but this felt like an urgent problem to be fixed.
> 
> [1] I stopped trying to estimate the memory costs for xarray; I couldn't
> be bothered to as it's not a serious competitor for this use case.
> 
> [2] We have ideas for improving the maple tree memory consumption for
> this kind of workload; a new node type for pivots that fit in 4 bytes and
> sparse nodes to avoid putting a NULL entry after each occupied entry.
> The maple tree really is optimised for densely packed ranges at the
> moment.
> 
> Matthew Wilcox (Oracle) (1):
>    rosebush: Add new data structure
> 
>   Documentation/core-api/index.rst    |   1 +
>   Documentation/core-api/rosebush.rst | 135 ++++++
>   MAINTAINERS                         |   8 +
>   include/linux/rosebush.h            |  41 ++
>   lib/Kconfig.debug                   |   3 +
>   lib/Makefile                        |   3 +-
>   lib/rosebush.c                      | 707 ++++++++++++++++++++++++++++
>   lib/test_rosebush.c                 | 135 ++++++
>   8 files changed, 1032 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/core-api/rosebush.rst
>   create mode 100644 include/linux/rosebush.h
>   create mode 100644 lib/rosebush.c
>   create mode 100644 lib/test_rosebush.c
> 

