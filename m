Return-Path: <linux-kernel+bounces-133768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60289A862
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6A31F218AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F4125C1;
	Sat,  6 Apr 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OJ/f+Zky"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25B1171C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712369412; cv=none; b=QLTvJUN4uoBPtmSK/xgjFTDfa4kiMtRy1AuihQd3Czqe2b5fwsZLyAnjrPgx9p9N7eXOlBKMCVWYFsS3JgSMwGR3Meeqc2+ScibNCycc9gub6GnYGVOo2QBUskLNeOfnqIeDLHWuWtavvHZMRiq0kACuKfKIvavSxMah0CZV+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712369412; c=relaxed/simple;
	bh=iPU1wDle54Dhh2Jag3TFgfIYW2xBm/4/mcjxBC9aWWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Du63Dech9eHTGqjtOFmVvX+VSoDRUtEPUmBeZJD4OysZwuSFGVlbUTr8HVyhE5m0uKsTHZHW3xDSAt1AnP47jCBysKju6mYHdyilAYuIs5p8c8XbArC3wvSq7wHNkp0MbT0epwslhQlsehcIHyW+TVT0nyPQG5hNeSX2KlWh62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OJ/f+Zky; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d341631262so47507539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712369410; x=1712974210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cCv5VcWhStgJ4vCE9L+2KiQe3Q2pQoluor1fRLFK9E=;
        b=OJ/f+ZkyG3cZl6xcriW+jcc5SzhHLzcRQhi4fk7Wo9GO3OqPAWei4wZJcBu+EYhHgG
         MFU8hxTWQNk/NWoWVCqwhKqsZPEjT2XPZD9cPzWzWBmTdTlxze0gMBuh01qdzXosDhEL
         f8z51TZAf1NUyWvujlh9X+B3rq3zj0DJOW5Wi8TyjmmFEJRZ4YJm5LhU3PraFSd/ryPR
         NIT3sAEFz3Q1LVFDYlYMJqgRqpUxivQaNzHft/4cgtoOMpDhjCcjVSIq08I20raUkyZz
         JyF2SwSTlylM/0jByHXdj3wCSJ2DE7XHXFwyt9DbZmF/gBO/qqINzFBDNB216HhkTDjh
         R+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712369410; x=1712974210;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cCv5VcWhStgJ4vCE9L+2KiQe3Q2pQoluor1fRLFK9E=;
        b=wAJeVDZqSr7fXcssI0UpxLYp0/hsRjYbFR28nbQTVNnpsQKWU2Ge5Txl+miujUUA8C
         q+HqbhPXlGAguJ4pxZIKuRxRr6+5+vV6HKSA3g8C2sqebF3HfW0729flELBeH0eovNFY
         6dIL2tFWOhy9J8jYSSThEkQ4gReCMo8pR9GfqBkO3ohqT4WnHCQqx41F7DVTjyLQjMCR
         30inPXzsS4lAQB21zTC0/twUn2o4CaN491apiCiFqXOOZNkkHeBPYblPhc/m79k+z2yq
         9eh79fEa5+rfert5HSAXy4XaoTIX+kFexBndOm+LQiEH9DqclfTtThjPCC1yUcL+DWqY
         pFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTxzh5tk8U/OfYsSt7Om6kiLDru8zOexoUYaf0the4oHZFPXZ/jFegkXAHaqWQLIskDDhvMegRmUk5cjXKjekSPczDLyuf8njJFMsx
X-Gm-Message-State: AOJu0YzKiVrlB3dQtLCdKH0PmaQmG6IEhAalilfH7mNcXd0h8BMgham3
	5mzAqZO/h5fTrKR7FWAxztJiQHwKGaZVtVH1Z76gEVa290Xsntr5oPYI1wMrJzAFQJ2O5NjCiUq
	H
X-Google-Smtp-Source: AGHT+IGN8BSnqjv3LU00TTGUDfx8VQfSQp0U3i+zESsBq9d8LHP4DpckfjoiRKtuga7gxqJKeYYQEg==
X-Received: by 2002:a05:6e02:19cd:b0:368:9b64:fa7a with SMTP id r13-20020a056e0219cd00b003689b64fa7amr3938452ill.0.1712369409735;
        Fri, 05 Apr 2024 19:10:09 -0700 (PDT)
Received: from [172.19.0.169] ([99.196.135.167])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cb05000000b0036a0e23db86sm612548ilo.33.2024.04.05.19.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 19:10:09 -0700 (PDT)
Message-ID: <ef230b61-cee8-4486-831e-ac4993b65a78@kernel.dk>
Date: Fri, 5 Apr 2024 20:10:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 015/715] io_uring: remove unconditional looping in
 local task_work handling
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-16-sashal@kernel.org>
 <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
 <2ff5d891-2120-475d-be8e-82bf20a8b7b7@kernel.dk>
 <29df48ef-aafe-4918-b903-0aabda94fd0b@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <29df48ef-aafe-4918-b903-0aabda94fd0b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 1:06 AM, Jiri Slaby wrote:
> On 02. 04. 24, 15:41, Jens Axboe wrote:
>> On 4/2/24 2:12 AM, Jiri Slaby wrote:
>>> On 24. 03. 24, 23:23, Sasha Levin wrote:
>>>> From: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> [ Upstream commit 9fe3eaea4a3530ca34a8d8ff00b1848c528789ca ]
>>>>
>>>> If we have a ton of notifications coming in, we can be looping in here
>>>> for a long time. This can be problematic for various reasons, mostly
>>>> because we can starve userspace. If the application is waiting on N
>>>> events, then only re-run if we need more events.
>>>
>>> This commit breaks test/recv-multishot.c from liburing:
>>> early error: res 4
>>> test stream=1 wait_each=0 recvmsg=0 early_error=0  defer=1 failed
>>>
>>> The behaviour is the same in 6.9-rc2 (which contains the commit too).
>>>
>>> Reverting the commit on the top of 6.8.2 makes it pass again.
>>>
>>> Should the test be updated or is the commit wrong?
>>
>> The commit is fine, it's the test that is buggy. Sometimes test cases
>> make odd assumptions that are just wrong but happen to work, for some
>> definition of work. Eg it would work fine on an idle system, but not
>> necessarily if not. For this one, the fix is in liburing:
>>
>> https://git.kernel.dk/cgit/liburing/commit/test/recv-multishot.c?id=a1d5e4b863a60af93d0cab9d4bbf578733337a90
> 
> Thanks, that worked.
> 
> Any plans to release 2.6 with the above?
> 
> Note that for 2.4->2.5 update I also needed to take 9dc95a03e4a76 from
> post-2.5.

Yep, 2.6 should be released very soon.

-- 
Jens Axboe


