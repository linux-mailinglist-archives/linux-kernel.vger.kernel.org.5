Return-Path: <linux-kernel+bounces-63682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9E85332F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27421C27276
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C958106;
	Tue, 13 Feb 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kzow/fJC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43957875
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834685; cv=none; b=PlbBM5xmP7mUixZOrLNJX9edR1krGoZm3QF4SKXXHhQai+V+kZrx1YeWOfl5JnV10lBQPoaeAZX2GV5EHDlIZfMVAM9IPhZoXqhkva5YAdxU7dUc/5SAzroRYpfWUvN6bsWugn3oKHAl+b1yxU1h7Z/WIBCaNEuSXJbS4C8aZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834685; c=relaxed/simple;
	bh=M96BkWpHCR2HqEV0VJrbLXGI006JWcjESW9wGCe049A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9bLwNdwsm79Z+hucLtG3RAUmPiIDOI0cT2P8j+XcFCeRu9IwEjyuzbra/nJMlaqxuoos8z9Ng7+PWUHbe3i1koCxAsbLzBbwbMWDYR2CTffLNzOuMppNWzzr8dYgPtS54PCGES6vKx02NqZ5tNCg22bUMSu1OSiJJtUw+yj9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kzow/fJC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d94b222a3aso36742625ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707834682; x=1708439482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V99/mc0VYUGKp45C9Pun5G/w1J409z65OdhG0HwAmcs=;
        b=kzow/fJCEemW0Jc+FdAk7jDybFjJgYactfICHRaSTQhcUSDFjVzse8Yl8nByreV3dO
         L3ScVtG4FIiz5TyfBRma1g4F0aCybEnslVcZDmVR7387pm06OJGr+VBdG6Jz4B9n26/L
         4k+FDLQaJcoBlA8eoh/AqNIhP49siLQfFLmHN8cLzQYUo6Rfvjr9q3UXdhkJ4W1NDhSN
         7nm0hOtcA73bSqDZ+qZj3Su45HjU2gQXWhk5KPgebSUgNCiAxtxX8MR4qAruFpxyE2UH
         rjEYZuKIrMZ8BK6X/jrVPBaXMhRs+e8UI7HsKAN+9HCap4JrfqMvnzwxUQw+m/E2O6TR
         ELqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834682; x=1708439482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V99/mc0VYUGKp45C9Pun5G/w1J409z65OdhG0HwAmcs=;
        b=p8v+qkXXqiGderWDHe6zdH+NOM52IjAGnjgsKosjaXw1JzHS2KWBSZQ+7U4oqY15Ld
         twgR9h9ATsKVXNP0C557nggOOos3R8Q4uVOUb6yZF0hU1uYYeBFSuelKzNjHniN6PZm0
         c0/zCU9MbxhXFa/K8ADqBxaVLUyO3Lv8tfstE54QaE98NWfQimZC+J1GeFtnbnz6ynOz
         HQQqnx8YurNgEPFNF8tXgQ2szwE6tgPtcPNIPWUQLzYotLah52gpePdkzpuTdLBGsIif
         x91vvT6VDu1czsdrzfA/Ubjwy9vTbJUhnl8j6ot6j5URgGMnvckgAFqUEyHpguetfHrc
         sjFA==
X-Forwarded-Encrypted: i=1; AJvYcCWx13Phm1kJrM9uLed0+ZnO+PFWpS2zj4uBHGPtwVUkqtWnyru06KgHzhcUo4iUKuaqBP3mbew/97HFQYAisT2M6PWOXIRYFBLxFz2f
X-Gm-Message-State: AOJu0YyONQk+ro/BRjTkHbvMVNqebc15wd2Q37QIug0yRZaASA32kVDI
	q88N50jb+9VQ79yBV/SWk2gPana8xZQrQ8mAzkdiI3YGGl0ms9j2624qm8RkrR4=
X-Google-Smtp-Source: AGHT+IGk1iguApZyRzMzCweyH30bvxFnhDWdmR2Rf3m7srwhrLrvHPd6ix3AaZNbU5t7d3JL7g25kA==
X-Received: by 2002:a17:902:f809:b0:1d9:7729:2a6f with SMTP id ix9-20020a170902f80900b001d977292a6fmr9763587plb.61.1707834681660;
        Tue, 13 Feb 2024 06:31:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7rdMD6LftNZV6R/QH86Kr+89QTN4sVGMtpNwTroxeOtZggX2k/6hDDuLVDEcrjTr+mH1+NCHJsHTW9ZNWy+3RINXjtFbgG/0dFz7/DS1VaMoL8aBfwNJ5G2K89JDXNAvSDcojg3L4oV7F4ORkmwU7vDf9vPguXGTfP/CFRh8Pt1Ep01YW8Ng=
Received: from [10.254.125.113] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001da1fae8a73sm2166963plg.12.2024.02.13.06.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:31:21 -0800 (PST)
Message-ID: <1e5ffefa-8c80-44b8-986f-ee574c3b3349@bytedance.com>
Date: Tue, 13 Feb 2024 22:31:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
 <CAJD7tkYdEWrrQj+MFNpDR6FHc60czXcuawh3dd1rSF=QQm6+yg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkYdEWrrQj+MFNpDR6FHc60czXcuawh3dd1rSF=QQm6+yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/13 06:42, Yosry Ahmed wrote:
> On Sun, Feb 11, 2024 at 5:58 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> All zswap entries will take a reference of zswap_pool when
>> zswap_store(), and drop it when free. Change it to use the
>> percpu_ref is better for scalability performance.
>>
>> Testing kernel build in tmpfs with memory.max=2GB
>> (zswap shrinker and writeback enabled with one 50GB swapfile).
>>
>>         mm-unstable  zswap-global-lru
>> real    63.20        63.12
>> user    1061.75      1062.95
>> sys     268.74       264.44
> 
> Are these numbers from a single run or the average of multiple runs?

The average of 5 runs. And I just checked/compared each run result,
the improvement is stable. So yes, it should be a real performance gain.

> It just seems that the improvement is small, and percpu refcnt is
> slightly less intuitive (and uses a bit more memory), so let's make
> sure there is a real performance gain first.

Right, percpu_ref use a bit more memory which should be ok for our use case,
since we almost have only one zswap_pool to be using. The performance gain is
for zswap_store/load hotpath.

> 
> It would also be useful to mention how many threads/CPUs are being used here.

My bad, the testing uses 32 threads on a 128 CPUs x86-64 machine.

Thanks.

