Return-Path: <linux-kernel+bounces-128824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12328896001
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6EC1C2109C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C145019;
	Tue,  2 Apr 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lBdxX7h/"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958434205F;
	Tue,  2 Apr 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100039; cv=none; b=lyF9xBUIf11x1XhLQeak90mMIcZoBTG5l7jp/kIl0b+GFCFMK0OCFt2ZaxWX5N6mmkMp2+Lt1EQRwGKrItCdRbHyKLrrnPBOUsNSyDGyEjJz9JAC4eRX/lS1vofCrdPvlcCFM3UGzWwSqPY8Qcd4ltmNx9YzAaMTJhgUQuzMd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100039; c=relaxed/simple;
	bh=rNRsMENYdMf0E/dZdciD6PG8aHTONVFr4fPxjmhlAOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFgLvzRTO+vpt5FfgPQ135SBIw4oLHBLO59X9qtzX5NCUNKpopsRe0mmV1R53YgHc/RnPWXHaWt+PKoa7J979XVPd6bShp1qu1xKw77tNUCdUlk9nxXMSgzrLChUAcyk5edCa7z6QurzijjDOobhuZo9c8LH03y+y7IKJcAX5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lBdxX7h/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V8P4Z6wr8z6Cnk8s;
	Tue,  2 Apr 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712100027; x=1714692028; bh=mNK0VmkJz6J6xiyneJZ80sBK
	QSOoXTWzA0U3O29ARB0=; b=lBdxX7h/BB4QtMNRc4va8Uo6qo/F8h/EvnOIBy0I
	qq/1TKKJJx+t6Ur6lOCKNwtMEFq0g8OWA9JIy2UnvpRZxNYklgyYA33wxnNTVB19
	Ad5TPGnvK649+u9p2nBWA/zK/g/gjaLVuZZR2viqnWH4KlyoPGT6lAN6A6F3aDXr
	SzOg9PHlRuyj8383HTYDM8zc2JD2kFYEkaB3n5ukBIyIA6/EggID1w0rFXbZULVE
	W+kAN9s743TqWTlv9sKa9uOfbOxzoqrZaZnM1lkyIHNGl7QbGe6QpjdgLAGm7Lwe
	Eeiv9r1h/TyKX2t4SQ+CVbdIayXlU8zBk28w6wOLaYQMaw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pRb1OrAT1Uhl; Tue,  2 Apr 2024 23:20:27 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V8P4S6SlGz6Cnk8m;
	Tue,  2 Apr 2024 23:20:24 +0000 (UTC)
Message-ID: <c56a1d54-6d7d-4105-8109-d6a81bc1adbc@acm.org>
Date: Tue, 2 Apr 2024 16:20:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com,
 Damien Le Moal <dlemoal@kernel.org>
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
 <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org>
 <CAHJ8P3K9OL6MHNrSrqmf0esbr2h1HJ3mVRmxDNVpf95ZMHQcqg@mail.gmail.com>
 <92e45c93-e2ff-4d34-b70f-7772f0596e68@acm.org>
 <CAHJ8P3KgU-tFDAgCNc5GcPbUBtDDyFmcfza2HsoD9TJ3h1DS=Q@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHJ8P3KgU-tFDAgCNc5GcPbUBtDDyFmcfza2HsoD9TJ3h1DS=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 4/1/24 10:44 PM, Zhiguo Niu wrote:
> On Tue, Apr 2, 2024 at 5:23=E2=80=AFAM Bart Van Assche <bvanassche@acm.=
org> wrote:
>> Oops, I misread your patch. After having taken another look, my
>> conclusions are as follows:
>> * sbitmap_queue_min_shallow_depth() is called. This causes
>>     sbq->wake_batch to be modified but I don't think that it is a prop=
er
>>     fix for dd_limit_depth().
> yes, it will affect sbq->wake_batch,  But judging from the following co=
de:
> [ ... ]

If we want to allow small values of dd->async_depth, min_shallow_depth
must be 1. The BFQ I/O scheduler also follows this approach.

>> * dd_limit_depth() still assigns a number in the range 1..nr_requests =
to
>>     data->shallow_depth while a number in the range 1..(1<<bt->sb.shif=
t)
>>     should be assigned.
> yes, In order to avoid the performance regression problem that Harshit
> Mogalapalli reported, this patch will not directly modify
> dd->async_depth,
> but user can modify dd->async_depth from sysfs according to user's
> request. which will modify data->shallow_depth after user modify it by
> sysfs.

It seems like there is no other option than keeping the current default
depth limit for async requests ...

> My personal opinion is to keep the current dd->aync_depth unchanged to
> avoid causing performance regression,
> but it should  allow users to set it by sysfs, and the WARN mentioned
> best to be solved.
> and just only change this part?
>   -       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async=
_depth);
>   +       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
> thanks!

The above change will suppress the kernel warning. I think the other
changes from patch 2/2 are also necessary. Otherwise the unit of
"async_depth" will depend on sbitmap word shift parameter. I don't think
that users should have to worry about which shift value has been chosen
by the sbitmap implementation.

Thanks,

Bart.


