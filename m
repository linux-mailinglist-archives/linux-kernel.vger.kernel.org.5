Return-Path: <linux-kernel+bounces-168077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0A8BB35D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F4F1F22835
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31D36B1C;
	Fri,  3 May 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Eee81c0C"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849E57C9F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761702; cv=none; b=KaxGzMTiis49iy7cIZMCaaLp1M8WdXqYAwjtYzbak9CjUdfIexEALfSezZlQg/ZYdCj0GGGplWdXw1vKCWONMh2XKZZfcsLgRHW4xpPTjZyzeEJ3FORCdZb+6ytSAYelQXJu3c1Ex688tvYzCTsjrMIvNveq4Gxtng3x6GiUs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761702; c=relaxed/simple;
	bh=71pjptQeomC726ly7T7i6i2tgcntzZ5e4dZc/Q8d4b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWGgOIpH8qNv6X7izCxwrleEaRXANiOU2MxCaQeHRTzHMd5Mk6tkrleQ6O7TgYLFsMZvuGdFmlSTjAmakLRVu63JGHkEeRzDniNi5ovjGYEAyj6XjSfmXtsdvCPGq3d5CNXh+mbsucszHm38j2IF0OJJ0Su/auEZMMCWYUUvkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Eee81c0C; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b360096cc4so9344a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714761700; x=1715366500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQj6b6uzNq4Run0h1mfKtbYDm8JqGmwqI0puPCQ5+lM=;
        b=Eee81c0CQ28YL/GsA3aCRcvkP8wuyUDjkgEhl0iziZkVJe5u7oAOthLa6LzBIvKcQg
         SGF2iXSe35mYfAtSd9Owadth7Yf5Ji5LoDLQWIl4vL/+4TDaGpWEg0oudp1Hj5kxrtwn
         tEXJaRZOMJ4VgtO29yZ0qZoxXFp6SSjYFgvJ1ZoiQuxqi9ixlIPUGwAk7+DCn46DQnbt
         LlgE/+eNrMHF2cvuWFrzg/lq3WRsJLj77h3pCteyWRPcYIDzUcsuj0ZUwpPUMeiW2Xan
         wyqyfEQWG33ov5VyPRgpjaeB9E8di1FoC5F0Gvr4/cAivYoV4LgParxfS2vnOhkt+RWg
         lUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761700; x=1715366500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQj6b6uzNq4Run0h1mfKtbYDm8JqGmwqI0puPCQ5+lM=;
        b=mWth9t9HxN89P5U2+k2tyAgdrBpgqVVfjn2ZWwRVKADD+ScA/C3yKyAL78d5wf+TV8
         v/fPmjPeiAUJHcZ5ArYn7wp3wiSWkEYBLJW1nQ3fiVWGFgOf1C57BcHhd6osOZe/EgmW
         0+GNnFxQx8Yh7KG9FY4jCeiGKbSstXrcOsW7aN8X2u/g5mHj4cHGft6m50YdCKuWJf+A
         OCb6i5/eotdE91hxjRCmmXthKFVv5kxu4zhuhrMI+eJTe6GbxzDxM7qI7rKfgLUimSGE
         6P+gPWx2lqzJxLDfsAQVG7//amzCWuRsLZeN19EqPot2P2gRCAjmw/CmgUaRcN0taxPx
         tG0g==
X-Forwarded-Encrypted: i=1; AJvYcCUcPFuKaXppn6yZ2dmyrgaPsSmSJP4ck5MxzwOrOLDpa9fLXF7GwmsvsX6W93J2pJNpR5SKRx+k+NWj/Z5wrqN8y2irV2QMraSSxQVT
X-Gm-Message-State: AOJu0Yw6j7TlL+77H1MCEkPQHs2jVfphKsZulxKxBkRLkJtW/0xeMAFi
	oneuykUhqjvcFiCI6ymi+f0E3On9M9lLsEZRr4lYi0e1122oqk2uqRRIVPCTPfs=
X-Google-Smtp-Source: AGHT+IHb7Hdo5qDQOw7BxTCL3qytUodWG6lrDud2MpwU6hr8AIQkEHW5ufSHsJY2Sdlarf5SGaznHA==
X-Received: by 2002:aa7:8d82:0:b0:6f4:4021:5596 with SMTP id i2-20020aa78d82000000b006f440215596mr3473710pfr.3.1714761700032;
        Fri, 03 May 2024 11:41:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7880b000000b006ed045e3a70sm3378730pfo.25.2024.05.03.11.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:41:39 -0700 (PDT)
Message-ID: <b5f7b99c-053d-4df5-9b2b-aaca48e6f7bd@kernel.dk>
Date: Fri, 3 May 2024 12:41:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/io-wq: Use set_bit() and test_bit() at
 worker->flags
To: Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>
Cc: leit@meta.com, "open list:IO_URING" <io-uring@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240503173711.2211911-1-leitao@debian.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240503173711.2211911-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 11:37 AM, Breno Leitao wrote:
> @@ -631,7 +631,8 @@ static int io_wq_worker(void *data)
>  	bool exit_mask = false, last_timeout = false;
>  	char buf[TASK_COMM_LEN];
>  
> -	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
> +	set_bit(IO_WORKER_F_UP, &worker->flags);
> +	set_bit(IO_WORKER_F_RUNNING, &worker->flags);

You could probably just use WRITE_ONCE() here with the mask, as it's
setup side.

-- 
Jens Axboe


