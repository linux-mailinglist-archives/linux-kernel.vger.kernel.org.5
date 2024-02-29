Return-Path: <linux-kernel+bounces-87208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DA86D11B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637EC2823ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B570AFD;
	Thu, 29 Feb 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NZxTIiEr"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81770AD1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228988; cv=none; b=TX5txXMVoYu45nc9KZQT5tdUMWbn47rq7xzg1HxXGLPyrg0wzFt7UYlkTGINNZ/X0Uq7EEEOGmzwKBB4SKoPyBBWC5iHdESvt/t9xrCsqjBl+0o1rE6SxjY8n9wltvotttGvjJCLJ/LKjrJ6t/nmYhC/95k3g9Iz/tIGCWmfj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228988; c=relaxed/simple;
	bh=eIoPVAUf6xaGNqq1sBBQPXY9RNXPt8vYvvIJpMjG+Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfkWZoXohK99u565UbzaWh9Um1o0i3lTNMBwvLqw52GL89adpOmGckEBUN8/rNcwGBWpJYQAIONcGjIXZmURlHh3v40ffwOlRRzHPRuon22wdTkg0B3sL0MfnL58MlT+boGHFdQlcPtfqWiyCxDSo9frgRer7RrTKfSrQwzWGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NZxTIiEr; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c7bd118546so7374239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709228985; x=1709833785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiYm6YpIsJziJr0cSiPO0yde29VWCxecp6O1ZLr/6X4=;
        b=NZxTIiEramkHvivhNkcDLeWowEBz+coktZSqVMs9nRzEFeUZo1m46d/XL8BgFsvGkB
         qKn/fmTsyPIgCwRBfTM24HImLncx/8SRRoqzokBlwll7ZApRxkIx2pT8KaIIX5x4OvuY
         AFeXgVKhALNFCLfeZ3TA+JwUWghPyCgBb6j09uHHbbZcTLxy1HyRF9Tf/gZEN3jTBkTa
         OVm6HiMOOO7tFpPOE4j2XuQ65cWNZiohrJha+hKwt60AKf1XJZTA3R6dEzwwVe/Famz8
         PeSguwiI8qLBhenzIKayb2QliF7He+lhDoUQ60WtHfgwOuqAfT2IF0QaMeTQEtxppMPb
         wFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228985; x=1709833785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiYm6YpIsJziJr0cSiPO0yde29VWCxecp6O1ZLr/6X4=;
        b=nkKSSp0mfwmfRxC/gDe+rLPTgyAcmqg3dhpYs69jtFPgA/yRryLPrTJPfKGwY1jw6r
         UT915OViA+rK9xgyR7SgaXgKIPhr48FDqKT5OXdhdx2UgBOu5TaLNFALzJtl7T6qfQTQ
         bkrRkDQ81A4AU04D1vd5atOcy0mbJnTgHTKJZNbWdf91MjZwXsa6aLG3R6FTBzLXOtyh
         mRVYFUTB1fxjKJ1BWb/0WG7rQ5O3OqraJ/TpAKT44/fmJXivLgP9GUluulKEFUybcMFH
         YUSGne+rBqiLFyezmeja02HEuuyHe1NjSryHOoFGr9a0UXfcRpMbB3JI8mxXtfrOODBw
         zy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGAvHyn2ndXWv7XQs3cVRbyr7t0cmiDIrD7k2wBwgGfCqvYjAgXlb01iubGieOGXwi/e+fyN8qYjnaHalAp7hsWYPSUK+EfSAHKODw
X-Gm-Message-State: AOJu0Ywx2NNm2dj+oNWyoF+6Dul9Ooa+Hj4eX0tPpMorD3MRmEA5xHCB
	GW33CNExMbNSvDivwm0KBSexSzLh3WzXkgVmzIs0EwIExU1ID2OSdjfXnNk4Xc8=
X-Google-Smtp-Source: AGHT+IH5Cin3AqwTfyabvBRdAEa1W3Mss9ze0/ydVLfUHhfSSClXwwy53WbahTvUqK/IUM3ItB/Prw==
X-Received: by 2002:a6b:580f:0:b0:7c7:99f8:2893 with SMTP id m15-20020a6b580f000000b007c799f82893mr2632799iob.2.1709228984892;
        Thu, 29 Feb 2024 09:49:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v25-20020a02cbb9000000b00474a5ac435dsm414881jap.179.2024.02.29.09.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:49:44 -0800 (PST)
Message-ID: <edd520ab-b95f-4a60-a35a-2490a6d5057f@kernel.dk>
Date: Thu, 29 Feb 2024 10:49:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk> <8734tb8b57.ffs@tglx>
 <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk> <87wmqn6uaw.ffs@tglx>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87wmqn6uaw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 10:42 AM, Thomas Gleixner wrote:
> On Thu, Feb 29 2024 at 10:19, Jens Axboe wrote:
>> On 2/29/24 9:53 AM, Thomas Gleixner wrote:
>>> On Wed, Feb 28 2024 at 12:16, Jens Axboe wrote:
>>>> In 3 of the 4 spots where we modify rq->nr_iowait we already hold the
>>>
>>> We modify something and hold locks? It's documented that changelogs
>>> should not impersonate code. It simply does not make any sense.
>>
>> Agree it doesn't read that well... It's meant to say that we already
>> hold the rq lock in 3 of the 4 spots, hence using atomic_inc/dec is
>> pointless for those cases.
> 
> That and the 'we'. Write it neutral.
> 
> The accounting of rq::nr_iowait is using an atomic_t but 3 out of 4
> places hold runqueue lock already. ....

Will do

> So but I just noticed that there is actually an issue with this:
> 
>>  unsigned int nr_iowait_cpu(int cpu)
>>  {
>> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>> +	struct rq *rq = cpu_rq(cpu);
>> +
>> +	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);
> 
> The access to rq->nr_iowait is not protected by the runqueue lock and
> therefore a data race when @cpu is not the current CPU.
> 
> This needs to be properly annotated and explained why it does not
> matter.

But that was always racy before as well, if someone else is inc/dec'ing
->nr_iowait while it's being read, you could get either the before or
after value. This doesn't really change that. I could've sworn I
mentioned that in the commit message, but I did not.

> So s/Reviewed-by/Un-Reviewed-by/
> 
> Though thinking about it some more. Is this split a real benefit over
> always using the atomic? Do you have numbers to show?

It was more on Peter's complaint that now we're trading a single atomic
for two, hence I got to thinking about nr_iowait in general. I don't
have numbers showing it matters, as mentioned in another email the most
costly part about this seems to be fetching task->in_iowait and not the
actual atomic.

-- 
Jens Axboe


