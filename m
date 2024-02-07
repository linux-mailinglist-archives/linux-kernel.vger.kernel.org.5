Return-Path: <linux-kernel+bounces-55884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0484C2F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978711F267E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631713FF2;
	Wed,  7 Feb 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rx98Sy7D"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C112E63
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275842; cv=none; b=eIzjagL5PCaos8vyXZljbPzHffYRiZheVUozNExtQzr392ZsyvZ/VSdOOVy3JAkP+pOZk/TB2CLqT9oKXC+6ZeYGNORLCBzSlBg8jfbh3CP+jch9VuZ3CStmayQPQom7goA1RGl4FoTomGBBT6UA5EKfnQj4QJk2r8AoXL+2ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275842; c=relaxed/simple;
	bh=WJe9IrwiBEVpqejHfVug3sy1LZ/48BArVTcHpWvhxyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDY2SlY8yxJmM8UoaOkaam1qFtlFqyG7uzXO4M0M5w/1CsiXKR43cP5pPbGVd6bOTyGJR+VAWLe20XkVNy67tUtImAsXyYTZVvLlF6n0Q9BnPK6upsVez4DmFBUC7AlgVYYzo1u2nWxOaw6ZnPcpJPWCs1/lfzaJ3IuzhsWCm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rx98Sy7D; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d987a58baaso498855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707275837; x=1707880637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGZrx2GFcYFKGySsPMA6BF/60Bvnn5WUH7P7wf0A/fI=;
        b=rx98Sy7DRsVEFVy/+aeimKiDSzcgT3qSEZvWzLedNFoK/ADWVD4H2iUw6llY1WTY3A
         yO0tfBhUTsbnYOtVn3hqbJvJyyOhMClmV+fxFhNOdvrl9e1nYYoxSbdEy9Pu1Lzx5vhg
         rMQONSOjJrgnnGKPRueqFxuc1yA6aUKAsY8fXj1k7cwICN28Sbjf/V4Ofgje5W4wLs86
         BgtllZS450DdZEvvMaSw0R3EyVPOIvc536Dt8LbHWCuu7umzzu+cZhZi2dUhmA7zBFgp
         sMWHXStvIW3vpnv1g5A5LXDaJ93ftF/jhw16vL2XkxdSoDoL0MPLT8RPjbV8K+JFqnat
         4EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275837; x=1707880637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGZrx2GFcYFKGySsPMA6BF/60Bvnn5WUH7P7wf0A/fI=;
        b=deyAkx5KAivUc9IcIMgHk1UUmKTHUaMFuC9dmyG4HT+GolOiWwuUlACd/yqlgOQwIQ
         Kk9HED8ULDRXcVuwGqAPc+GOYwJi3E+hRv8kjvtjj5E+bHoiYeAc/hlmc+Fh4qAXdZUR
         oX1pKqPViGHNf45F08HnBpCpsao+FjwiEJFnIiIiAT7Aci3O8xpwyFOGcyECud7arx9Q
         DdvIWXyfSF65bvv6YkrYAyJbWsV6Q3ZAkLFRsCeWk/UjienBdbrq+wF/5hE+19f6pWq0
         N7IPZfctqGPHqp6v764UlMvrzAJkQp04Esv6P6+VYp672W1W4Nmej4JuAG8a60e/8tmJ
         5AKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4swFSxsD+kzhZ3th5gKr0VzCPCKlGFgvNw0go/ZtLXrJewzb9q4IKAZfFD0QNkl5It36HIEUMXSWLTb5b7y0H00tgccOszZP+cnc/
X-Gm-Message-State: AOJu0Yz3XTRLL37fgeqY3aBNE5kHaEz33+6ya0nZd+bXqADfJpFSQumP
	CUr7xb0wYQVV1sHSeUpRHGCclhM+FFZRqnsjl788J+qMwo+32C4mgO3wU+eUQxM=
X-Google-Smtp-Source: AGHT+IH6/77r4A9b8Q2lN6ZzK9PsDjygC6B2KjqUxFdCbfJfQtZFdudeU8jNBALRUGJy9JtfhK/P1A==
X-Received: by 2002:a17:902:eb44:b0:1d8:dcd2:661 with SMTP id i4-20020a170902eb4400b001d8dcd20661mr4673737pli.5.1707275837539;
        Tue, 06 Feb 2024 19:17:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0p2QMcsLljMvXolcMb1ZVXqX086fNgw/+9Q427dN5ypJ1WbluENu67Dy2Hz1cGQYuR+hgKoJBfvtrP6Dj7eSf6q6894GXAF1t+rtb+R3fficOJiTqqYg1NLPtI7MeBkax0KZGmEVTn0k/om4vEu77gVImzjhkBu/EVZcBgz8jLvlslTOkr2qiXiiKL8SAO2xeEBekpIC8nuHSjavqpMVi8FkXVZs1pFnaZJNQgfYz37Spj9T8Yl1mF837nx1qoOTz6tiSWdU=
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d8fe502661sm279837plh.19.2024.02.06.19.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 19:17:16 -0800 (PST)
Message-ID: <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk>
Date: Tue, 6 Feb 2024 20:17:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Barry Song <21cnbao@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengtangquan@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
 <20240207031447.GA489524@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240207031447.GA489524@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/24 8:14 PM, Sergey Senozhatsky wrote:
> On (24/02/06 19:40), Jens Axboe wrote:
>> On 2/6/24 6:44 PM, Sergey Senozhatsky wrote:
>>> On (24/02/07 09:25), Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> Firstly, there is no need to keep zcomp_strm's buffers contiguous
>>>> physically.
>>>>
>>>> Secondly, The recent mTHP project has provided the possibility to
>>>> swapout and swapin large folios. Compressing/decompressing large
>>>> blocks can hugely decrease CPU consumption and improve compression
>>>> ratio. This requires us to make zRAM support the compression and
>>>> decompression for large objects.
>>>> With the support of large objects in zRAM of our out-of-tree code,
>>>> we have observed many allocation failures during CPU hotplug as
>>>> large objects need larger buffers. So this change is also more
>>>> future-proof once we begin to bring up multiple sizes in zRAM.
>>>>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>>
>>> Note:
>>> Taking it in NOT because of the out-of-tree code (we don't really
>>> do that), but because this is executed from CPU offline/online
>>> paths, which can happen on devices with fragmented memory (a valid
>>> concern IMHO).
>>>
>>> Minchan, if you have any objections, please chime in.
>>
>> Not Minchan, but I do have an issue with the title of the commit, it
>> doesn't make any sense. Can the maintainer please re-write that to be
>> something that is appropriate and actually describes what the patch
>> does?
> 
> Thanks Jens. I fully agree, I requested a better commit message in
> v1 feedback, we probably still can improve on this.
> 
> 
> Something like this?
> 
> ---
> 
> zram: do not allocate physically contiguous strm buffers
> 
> Currently zram allocates 2 physically contigous pages per-CPU's
> compression stream (we may have up to 3 streams per-CPU). Since
> those buffers are per-CPU we allocate them from CPU hotplug path,
> which may have higher risks of failed allocations on devices with
> fragmented memory.
> 
> Switch to virtually contiguos allocations - crypto comp does not
> seem impose requirements on compression working buffers to be
> physically contiguous.

Yep, this is much better! Thanks.

-- 
Jens Axboe


