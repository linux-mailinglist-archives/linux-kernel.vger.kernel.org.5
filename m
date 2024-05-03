Return-Path: <linux-kernel+bounces-168143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FC8BB435
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD671C23BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34A158A07;
	Fri,  3 May 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lX4R/emq"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C961339A1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765002; cv=none; b=u2hHh3bUsfMjBfZ6c33mqj65pY4ovAx9WhCookxHl5zGzAHgWJTARoDTOmpH/N+pkJ+Y1p8FC2dMIleL46xCHauh07iXKbwe9Zqh/irvzb+Mbp4RKOeVe4Jm32AGA6GSf7U+IpPi0fumIWGh3pKyNwIT4qEmiT8XaIYGgubenLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765002; c=relaxed/simple;
	bh=oHuI/jeVID32qGhNu8sGNdAF06WXodfHJzkeKTuF0sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPfIZ1bpM+VVXL+zpzqIgQnqhrgUsRC/jGGn/O4CQ3VdT6XZVs7wj9RWFGwyj0IRNTPC3HFP0zoJhZX2x0VWGNe6KJtrSsyXPFPTGpJu4QG9FV5KRvhE00l6Q+qmbPRF8sptsgdFKLOE1vvuxlBlxUbyU4cPNL6sY7FxVyHgm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lX4R/emq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ab48c1c007so22203a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714765001; x=1715369801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMBLZ/zvKFdTxoq427Gr/2rcTGYHZsDg0CySgyar1zU=;
        b=lX4R/emq9L6nOg5f4SGhAZA/xjk6FWVtWdZOU9i7MgNgtgPz3+n0XROcipLc+/sp4j
         7US8wfzwq3csFoE0iOyuTTJJoeTAwH/BIBQewZ8uGy0fkWk8IBD/G5qOKojl2qCoJZbJ
         2+FQyYY/Ju+u/iogwnDVqoZnPgcNySq/GBfOK1HI7n/XsbF1jeW9BKdJCdqW98nGDku8
         WG8mB5WNdk50j20IA0Um77vTetbOuCVbGYYXvwiYR8Deh8hyGgm0hCJxuVr9DuFe5XlX
         u3OvyD3XnG6uZx+5wIcmOJitfW8TTn59dJT5PmzuCrt7Fotx2AnwAZW5k/G3g/Pfwx09
         agSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765001; x=1715369801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMBLZ/zvKFdTxoq427Gr/2rcTGYHZsDg0CySgyar1zU=;
        b=hJHyRrIUTxBc5EbOpWxlfvDEPsWlNuVhdmPk8T+z+sbf2Ooql6WNxcKWASBe9plpLW
         5YA7zqpG1ukFK1o2SECB119T1JzhyK/6TMK19OrSFM/g1mLRc7qQaV8XCyrkZcUcLM+N
         zAzpyc4ATlDPkc0FCFmmEPlVRDYry6L/S7oieV7qONWF2NdmCxteMtNgYJuK96KQJREf
         gjYDib84UKRJxDBqj68DFnuklm82rBAbawDQHdeAcb/qe3bBI8Ew0AHGT+Wm+OcJX4KO
         DspF8BX68vWspJAmC3ukCaf7TmZwS1X871HDS0HtXWVCMO46/t7RwKg1igcY+WdhOh4v
         Ml6A==
X-Forwarded-Encrypted: i=1; AJvYcCVhAnPJfsBwF+tSkTrbkQaMv2blmG2ZbUleCI2olKj4RbUMLrC9wDvrp4HTd2uIoKGaYXdj3ywHOzFzZzA9B1kpRbK6muNICEuokUS7
X-Gm-Message-State: AOJu0Yx3pdi5uW9fiKfoi33I5FHQUfH23joZ5PW2/V5doh9iuTYIujPb
	KN/VL8btaLtJjnHzr+21W1VGN13bygpJZqT0qC8HdqBwXugjl7tVz9oRheAbsBL6uFqhrwPIKQM
	J
X-Google-Smtp-Source: AGHT+IFhmXIfSwx1rXzxyjEPkULhcoajiCfJT+cq1gYbdeEx3PEZgnUEekcYltdyFSQeaHYC1YF8nw==
X-Received: by 2002:a05:6a20:3944:b0:1aa:aa2f:a511 with SMTP id r4-20020a056a20394400b001aaaa2fa511mr4512425pzg.6.1714765000695;
        Fri, 03 May 2024 12:36:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x16-20020a056a000bd000b006ea918dab9csm3434168pfu.157.2024.05.03.12.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:36:40 -0700 (PDT)
Message-ID: <0f9c6f92-7160-46b1-86ee-2a4233c7860f@kernel.dk>
Date: Fri, 3 May 2024 13:36:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/io-wq: Use set_bit() and test_bit() at
 worker->flags
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>
Cc: leit@meta.com, "open list:IO_URING" <io-uring@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240503173711.2211911-1-leitao@debian.org>
 <b5f7b99c-053d-4df5-9b2b-aaca48e6f7bd@kernel.dk>
 <75ae8634-72ad-4c6f-92af-76eaa1d3b1d9@wanadoo.fr>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <75ae8634-72ad-4c6f-92af-76eaa1d3b1d9@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 1:24 PM, Christophe JAILLET wrote:
> Le 03/05/2024 ? 20:41, Jens Axboe a ?crit :
>> On 5/3/24 11:37 AM, Breno Leitao wrote:
>>> @@ -631,7 +631,8 @@ static int io_wq_worker(void *data)
>>>       bool exit_mask = false, last_timeout = false;
>>>       char buf[TASK_COMM_LEN];
>>>   -    worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
>>> +    set_bit(IO_WORKER_F_UP, &worker->flags);
>>> +    set_bit(IO_WORKER_F_RUNNING, &worker->flags);
>>
>> You could probably just use WRITE_ONCE() here with the mask, as it's
>> setup side.
>>
> 
> Or simply:
>    set_mask_bits(&worker->flags, 0, IO_WORKER_F_UP | IO_WORKER_F_RUNNING);

Looks like overkill, as we don't really need that kind of assurances
here. WRITE_ONCE should be fine. Not that it _really_ matters as it's
not a performance critical part, but it also sends wrong hints to the
reader of the code on which kind of guarantees are needing here.

-- 
Jens Axboe


