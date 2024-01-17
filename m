Return-Path: <linux-kernel+bounces-29533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033AD830FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980A11F253B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0A28DB1;
	Wed, 17 Jan 2024 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="inIwrTMr"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52328DA1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532727; cv=none; b=n47aNyPaegvyWD+mbb2koDb3DS2B/G5V2+LqLXKMDgbccNP3FWxXrnOkWfhqRQMXsMMcob8OZj6B4UuHmbYO/CfNLMQOHdtAPWOXYvExeCYnlNWflh3fNqPDoofxZnRrqfOlJVT076t/dc+4VMujqPXL73wQFuZTRNVoxJXcQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532727; c=relaxed/simple;
	bh=kvRMcs2AJiiR5G0vH3bSAe9+o9cJGPIsxUiD+6tp9po=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=e2rYsJ4Xl36wF+Z95OcjY4b0vLMuc+vovMJ45an3tNnbAfy3Al76+30jurpZ059g7o+TRC2vibCJRq2vXDyy4j/NMuXsoo8Q4nJZXQYv+9TPK0wzcWRyaMcdVAgNINiUPSqgw3P+YHnpXz8xLmxg9E1kLNbUTN46Mro4iRY/35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=inIwrTMr; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso111879839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705532724; x=1706137524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZimxNNYUhQiGc9CSi8XOIRdijUq2WzHdtfDAUowK1o=;
        b=inIwrTMrllL8TPNROGPZwgFajAwytZTfbx8BOWkcTeocaum8CuBzu62uaVYU3xfMbj
         vNtyxVF2cPMB0e1bPD5IBhX2skJttV629bOG61ik9eOsqriHdegtSd1pKNloPo2Yv8Ge
         /e2lyR0vLwmMovy/S9H4SpeCiG5zCewR5A23EtPaXIDmCuoK9ihItdlw9xleK9NV2Qoe
         RSkTPpMCEdbmYjsYRcqJAGGT3Z9mBQ41PmfXhbua97KOxbRJXrEsi0OG3YJsUB6pe20D
         qajkMAxB+Nw8w4PbhdVYdVyXbpFuhWKABzsh8dW8YbU06uRrie3+eaZttThWAK4QaYJ4
         p0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532724; x=1706137524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZimxNNYUhQiGc9CSi8XOIRdijUq2WzHdtfDAUowK1o=;
        b=B70JK5vUny63lU1ITNDwb7GEmYQnuFPtnTrLo4UerAH1N26UuSXAzjXMfYShLf3idD
         xAhVwgFmqM6gvUqn5R+0k7WFKt824WIMi1aKgceJ25hOfQbOy/exyY52eEfQpNnKhgs2
         1ylV5V+JyXfimFTVTtLNsMo12F76uzuK3gTe0k5OUWr7KGRalmiqsvkB5TWbcGU4hr/H
         TdjIoDnwESBGbfwWFCzb48L3TLOUg2NlF+wUSHhZPRHcIM22Px2RQP1KMZ/h+Z12+iO5
         NRM0dcUrtVs9WbImuRUrWzy/f7NbdqrHZOTUGToCyRzn7MKobxs7l0ZtRtWCPlmgYrRW
         pZSQ==
X-Gm-Message-State: AOJu0YxM6UxOOMJd4vHKcjWhvneBExLUKe0jZdtvciANsXxlZE1fJtNF
	Y/XqLL1OBmWbJkBmwhu1dc5yJUYnAamM5fVtfBwZ21bS/mFClSJYyOljda/VwZw=
X-Google-Smtp-Source: AGHT+IFfcanp4yy9KLRbZV8wShUBiBUjvwVbwxbFFZ0iAIyyuRY5gaT5NA4w3qGsCB10QXT+7StGhA==
X-Received: by 2002:a5d:97d7:0:b0:7bf:356b:7a96 with SMTP id k23-20020a5d97d7000000b007bf356b7a96mr77714ios.2.1705532723830;
        Wed, 17 Jan 2024 15:05:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a056638258b00b0046dda6b83c1sm670895jat.25.2024.01.17.15.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 15:05:23 -0800 (PST)
Message-ID: <9677a5bc-b867-4350-9848-6a726dc9d573@kernel.dk>
Date: Wed, 17 Jan 2024 16:05:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <ZaZesiKpbMEiiTrf@infradead.org>
 <210deda9-5439-244a-0ce2-af9dc8e5d7fe@huaweicloud.com>
 <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 6:46 AM, Yu Kuai wrote:
> Hi,
> 
> ? 2024/01/16 21:23, Yu Kuai ??:
>> Hi, Christoph
>>
>> ? 2024/01/16 18:47, Christoph Hellwig ??:
>>> Hi Allison,
>>>
>>> please try this minimal fix.  I need to double check if we historically
>>> returned ENXIO or EINVAL for adding / resizing partitions, which would
>>> make things more complicated.  Or maybe you already have data for that
>>> at hand?
>>>
>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>> index 9c73a763ef8838..f2028e39767821 100644
>>> --- a/block/ioctl.c
>>> +++ b/block/ioctl.c
>>> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>>       sector_t start, length;
>>>       if (disk->flags & GENHD_FL_NO_PART)
>>> -        return -EINVAL;
>>> +        return -ENXIO;
>>
>> I think this might not be a proper fix, the reason if that before this
>> condition is added, -ENXIO is returned from bdev_del_partition(). And
>> there are also some other error number like -EACCES,-EFAULT following,
>> so this change will still make changes for user in other cases.
> 
> Please ignore the patch from last email. Sorry for the noise...
> bdev_resize_partition() will also return -ENXIO if partition does't
> exist. So the right patch should be following:

Can you send this out as a proper patch?

-- 
Jens Axboe


