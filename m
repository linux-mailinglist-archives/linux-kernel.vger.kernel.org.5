Return-Path: <linux-kernel+bounces-51985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7BB84924D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAF91F21F12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895528F47;
	Mon,  5 Feb 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R74ULAnN"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99879E4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099275; cv=none; b=HnKDV64J0IX4MvgH3CG0WhwdgvpLj6pP8Wdo/kXx5dHGQRaTbkTRykT/yMH/cuV/cLpB4TGkxhtuow7YiVVfqg9NCgwEz2h2fcS79EEzQHp3QbKhBbRKipv6ZLiC66XK2mNbHK/Z5/5cSih1Uax/xZmTxV0gSrp5tkQv7bm8PcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099275; c=relaxed/simple;
	bh=pvgV0YknqsQnvCyHtVH/GSHnUSA++yYfdumu8uYYEbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaspdO1EMu5jYp7JxvydHU2QN8MlZAL3f2GzoCioFJumooxfT7aymef10AVIowHLDfg6wTJd4serS7rYhOtHS/J8JrrTDIENURykPp4RtN/6ud/Y5xW2IlOIqfG5latVZfiv1UM/vSxJ+NYNSNRVCmS9rV/w+J+E6dsKUHDUqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R74ULAnN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-295f339df52so764333a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707099274; x=1707704074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFyXg82UWmlPE+ig9jow6pwJAF00791AsGoKKK0IIVU=;
        b=R74ULAnNyRaspEwTcXk8u6zl1mJkUns22APMaSfjfQLXvpOn3ajo2nTylRiYakCvmk
         6IA8ngpaUQNnEiUTjtRKmbKktbK9VZvshDLLBfSTr7zOli0T72waXnIZuVDrBb+Hhv16
         lxP5ZpynbovyXm97ASMw6ugYYV98bnZwm4hqdy4seAJdpwzuO/5BLHpS3lZDLosu3+0V
         fKy6g60lxTnoyw7Zy15xDj8iuyy5+uORblYxQEiAfvdA3XCoQuVD+4fGc3UrVE7s7hzj
         QpvFtBlGC1+YXmiSkS/mP2tShjwAXPUegYgJH/WD23K8Dmk3G6C4bCOxqWjK5pejTpqE
         4KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099274; x=1707704074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFyXg82UWmlPE+ig9jow6pwJAF00791AsGoKKK0IIVU=;
        b=LawzRd9/fnaynEak0jWHT1YqwxN8LYqe7tlX3onp8EBYEDf1IsBplCkLVyYmAMXqu+
         O6cXOROGKnatuICMc7cnW8ERn/ZgJs71aL93cK8glsBm+miUdjbMQXDY+D7ayruvfB7k
         DBTp6KwWe7eXyz5r+qSnPCb+5B3GDAxhfCMDk07MSaiDrr0KATK0nCh5mSUFmrqZ0Zyv
         A2mhgHPWY6xbIPZcti7/OedMGuwH9chxrHaFPSO1nA2PBslxvNamvta4oCz8PmpXOadP
         w7+LahPI540kXGgQ3L7xQRkrnlFRGxaimC6b4brkxHSoHjAr8WwlMBGzT9TkNaXr3Lk8
         AQgg==
X-Gm-Message-State: AOJu0YxfX/ad7NAmOItlAZ2N6x16jFimF2vo00X3EzkKoibVQA1w/jVa
	WRbBNB5Ew6A4LxtrBUONOB6NYzMoy2ZeXCsADl4aWJs4hKvmGZf+Rn87HYbbAyc=
X-Google-Smtp-Source: AGHT+IEwQIC7jXtmYLSmgwxADVxy/6gqZeq63vbYZBJwSehUDq2LkFNeFIhCOM0IeNs5Pauzd+/fJA==
X-Received: by 2002:a17:902:ee85:b0:1d8:f06a:9b6f with SMTP id a5-20020a170902ee8500b001d8f06a9b6fmr13589434pld.1.1707099273829;
        Sun, 04 Feb 2024 18:14:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzaWXF1IGiLYQqU3QdZbMeWQAsPFYeTxr6WYf8piiX+Rb9cBUevGUYHNHanDzwgeBQAVOlflGkKjXDG1Qk9WzOYcCg8rxTD7t4AqTTUuvvvF5pPp3QE+heGBjMfpyObA62NSgQ63kf8omEk+qZAPuRwG+f2G8CtR9rq1vycChrW7KFlhIkQ0XqnBUC6wIQCaDNC09tMzQ3o6gfIWhpemvLBy7nvh69So3UtDe1jFBv6zH3Pxo=
Received: from [10.255.134.6] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001d9a422e0c0sm1602110plj.20.2024.02.04.18.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 18:14:33 -0800 (PST)
Message-ID: <d464ef84-fe06-4279-a7fb-5a0cadef4064@bytedance.com>
Date: Mon, 5 Feb 2024 10:14:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: pgtable: remove unnecessary split ptlock for
 kernel PMD page
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb_dT43-oPsRplhi@casper.infradead.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Zb_dT43-oPsRplhi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 2024/2/5 02:54, Matthew Wilcox wrote:
> On Thu, Feb 01, 2024 at 04:05:41PM +0800, Qi Zheng wrote:
>> For kernel PMD entry, we use init_mm.page_table_lock to protect it, so
>> there is no need to allocate and initialize the split ptlock for kernel
>> PMD page.
> 
> I don't think this is a great idea.  Maybe there's no need to initialise
> it, but keeping things the same between kernel & user page tables is a
> usually better.  We don't normally allocate memory for the spinlock,
> it's only in debugging scenarios like LOCKDEP.  I would drop this unless
> you have a really compelling argument to make.

The reason I first noticed this is that we didn't allocate and
initialize the ptlock in __pte_alloc_one_kernel(). So in at the PTE
level, the implementation of kernel & user page tables is already
different.

Thanks.

