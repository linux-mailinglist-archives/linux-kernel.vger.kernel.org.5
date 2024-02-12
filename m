Return-Path: <linux-kernel+bounces-61673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46B851536
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC061C2144D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD703B1AC;
	Mon, 12 Feb 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="acEe3eVg"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F283B19E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744026; cv=none; b=WLCGdc5xAwCnZqge9dIhilb7Y21HZNyMGuN1tMHbHwSsDUv3xGrrWtbrKFUdXw6q5bUbLJe1NhfKohV1mAayRsdN7paNGtMBo9W0SuDd4LfIz5h9riQPoXkjBNwlkJUCQD3o1SSmXwsVKzctD0jQJAfZ2pKbK25b2aG7Oo0lxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744026; c=relaxed/simple;
	bh=Ko+xtB2TftaiVDHap1hrP2TfibjHSqNzbulst0ETq8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoJTUZDRlmn3/IvymBYRHy3moTuhX0ptunUlUxYZyhBV3O1gCOZwL8kil4zBK1rwPyqbMl9AonGfd6FEBEFjePyL4UBrjZ5ZZAKJbxxe7aK6fT1PeLXPLSyl3dBXB6u6e3+GBDtEzx+Y0AJf7zBe+TXSNGhimcWgbmPHbZzCu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=acEe3eVg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-296b2e44a3cso1514390a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707744024; x=1708348824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4+EdTqpc1q3yCsCpR8sHWu46g/mUrQ9DV1waFWyfzc=;
        b=acEe3eVgvF0SrypGOOf8xKJh+9OxQedaecVFSTsQpS3ZJKO67mKjh9Xna/jTdE6Vpp
         ck5GoF2IBriiqang9h4YTRXJ1PbfKzSwElgtmsxTxRBXM0eQb8FX2lkxgOvsnc1am4K7
         m5HbCR3c34C+qqUJhSGicI3HcDvlE6qitCoe0i93rAniQXjWSovjWEzOPnnOtyrfs4mc
         rwiyM2hD/lGCXj1AFJ6OsFS78I8Oiw8MaZyZ+/NGd+OLChhFCM05Wf9YTvviIdFe4kce
         2Z9lnJwxueFwvzCJvfNxev0/k2zB8AVtfoQl8cflZ8Tfeo3UZ3Sx1tHIfI6snWPSnBxW
         S9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744024; x=1708348824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4+EdTqpc1q3yCsCpR8sHWu46g/mUrQ9DV1waFWyfzc=;
        b=A85V2HZ48Wfw1P9KIw5n4ZfZ5cvRPSh4Xefx3PgvuJVcu44zCU7rEX7+j1k44e07Eu
         IqVTaKm6OGgOjp+BYoiu7gwEYTPzItEtGns76XZUTgF/1dSd3W4xFCS9NPrgj+v0dtUu
         KB8Avq/tuBslSzPC+DEEKxfGhBjOyvJEDWCiZa4HRBmaEsbkYJPjpohGpg9EnD+ev8Fu
         0xQOMd2ZQcM9ZaUk5cIGYyBK8/EXYTwG5RH2pjcSqY5xvojetYMVIhKLSPkvnTzp6skJ
         VF1kh9xr1Gg8maP4flYQ3AElOzmpzsuMLarBsCNxCl1IsXfASGzA2s78nBOhfO23BvnT
         r2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWypfk+ltAl3jiehvj8MeQwkXjVOwTzQyUMr0ygNSbF7wQO8AbI2TnD2PV+Q08n2AhrDczxct0Rir6V3ix/SP5VyDK/ox5r4SxoihNP
X-Gm-Message-State: AOJu0Yw1oC8ERKxA7ST2fbbtJxDCIds1wy0oP67ts3/+kspZtU/DmymX
	wVA2djct+eYhsYOfuzaPZBx0M14VGRm0R7fNX8tTgX0nDKdRQPjKIiz+nHcy1NE=
X-Google-Smtp-Source: AGHT+IFdCSZNndK16DmyxZqzpiK0lXZ/8G3rak0mybN6MDeN4MLaN0O4yjmgcVGljs5EwfCJe9VWiQ==
X-Received: by 2002:a17:90b:1005:b0:296:9d93:37c6 with SMTP id gm5-20020a17090b100500b002969d9337c6mr3511328pjb.22.1707744024134;
        Mon, 12 Feb 2024 05:20:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMjBCmyULmUEije60wQnhat4Blp6mQgXfv2F7L0PypW3Bsrc4icO59jLNcGWtQA2tipSJzszufpg1UaKYSneIT+kdx6eQ8qa5yf+FVP0gHCxBwIeTtvzaYKBs4Y8BUvrpyLs3S6usJ7iQQrgb1X3IgFrzLc9DnbfxOZbh8Zc/yY8mVqGc424+7dYYB
Received: from [10.255.183.165] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id px1-20020a17090b270100b002989855bf97sm173790pjb.42.2024.02.12.05.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:20:23 -0800 (PST)
Message-ID: <e3068889-3991-429c-8a08-b23a1b2d368a@bytedance.com>
Date: Mon, 12 Feb 2024 21:20:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all
 zswap_pools
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
 <CAKEwX=Nbbm=BZ8Rp7Knfk3P=jXK2SJnhgR_vOK9w1ovPUdF9UA@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=Nbbm=BZ8Rp7Knfk3P=jXK2SJnhgR_vOK9w1ovPUdF9UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/12 05:04, Nhat Pham wrote:
> On Sun, Feb 11, 2024 at 5:57 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Dynamic zswap_pool creation may create/reuse to have multiple
>> zswap_pools in a list, only the first will be current used.
>>
>> Each zswap_pool has its own lru and shrinker, which is not
>> necessary and has its problem:
>>
>> 1. When memory has pressure, all shrinker of zswap_pools will
>>    try to shrink its own lru, there is no order between them.
>>
>> 2. When zswap limit hit, only the last zswap_pool's shrink_work
>>    will try to shrink its lru, which is inefficient.
>>
>> Anyway, having a global lru and shrinker shared by all zswap_pools
>> is better and efficient.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> I'll do a careful review later, but IMO this is a good idea :)

Ok, thanks, take your time. :)

> 
> Chris pointed out when he reviewed the zswap shrinker patch series
> that the reclaim algorithm has to decide which pool to reclaim from,
> and I have always thought that it was a bit weird that we have to do
> it at all. We should reclaim stored objects by access ordering,
> irregardless of which pool it belongs to. Having a shared LRU and
> other associated reclaim structures is sound, and saves a bit of space
> too while we're at it.

Right, agree!

