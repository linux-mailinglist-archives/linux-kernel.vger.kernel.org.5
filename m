Return-Path: <linux-kernel+bounces-30520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD0831FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A346287E58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA402E41A;
	Thu, 18 Jan 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s7DUPnSj"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248B2E407
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606469; cv=none; b=gulLcNo/JA9q7JKeCmGBjmg8OH10imny+3IbtjGJwyTv1tqkPCrtwlArbK94PXGTmzFHqqj5nWwDEjmi4XT1MSlhTm8uXKu1I2pub3+at2ClcM1Ij5WnuUvqOla4tmdU0Pe8AeEQzLvL9Ry/2ZrC8Sb84n/EXitJy4Zo/RnrGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606469; c=relaxed/simple;
	bh=b5FwYCmuMfyWIbHYKlxaJmyq3KKcGbifob/gUmbvP/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlqoYamdv+Ek11dkms4HeM71lL0L3yQBFzZWLm0B/RzHURohQdF2Uy6+zsCbkGvNWS3Bx/pT4KxjqbW6BVUFgUDAhZlaiH3aaKfauZRU6WuAhzKSKt9+QA1d5H5NRx+JGPEqvGcFYaZNf7mKA63gl72kxCgmdKydNCPxNJFxki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s7DUPnSj; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bee01886baso9339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705606466; x=1706211266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnrFrxp56NFMNrnCrVwG/+HU/kQ2wnZfA81brF/kE/g=;
        b=s7DUPnSjvzH8ztOmxWoTjRejRWH9+BLgAludHyKS+97LON4U40nxUONP/pfx/wYy2P
         Rf+14QZqqPvqg43SHB2jI4P9dz5cF8KTlrh3RQ8b78LTAJTeWLszqQULhUt8JvAs6MKL
         YKr0niNx0+p1lb7qWg74pb2FK3mO2RR1Vk+F4r5Je9enlKjLtO+DRYjbDFaEkumQJnJP
         /p3Nx0N/00DniiqeWJVhORCDpLpzKcTewCUDcIe0RHZeq7mNwsJFMY5NTxKmy9Id/iIH
         ETPFbnt3OsOToA2Ny8xx+tT0m2l8YulQl+Fhi3yPoIwLaYd5gP2+TkH6bmZUK4Fyhxou
         Jwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606466; x=1706211266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnrFrxp56NFMNrnCrVwG/+HU/kQ2wnZfA81brF/kE/g=;
        b=gZE7OwPy1tDAmfJGKxpioS2PnsTXXRld8cVwsOTyp0UcstC1mTK1QxW8ckBOEt/0jx
         nu7pbsRmL6qrpO3StWxNrXQ24qiqa9Oci2fQYqwAfpmmMrPtov6I2OyYAiOqS7vLOND8
         ysaJjL7qg4r1tmRLxi+nlSCD5sjh6gRPRFn50MQujQ1ydsXkdGvVJiYT3e498GHd3XGz
         UI2zB4pMmYBRu0OpQnMERiATTcDtw3cbbe8wV/YcfFigM8lGUCt2YEczL1G3zZUkExOi
         UdvmzWVle1NQ74yb2pBXFKo18OZ5xK+ejFq1h6jTzOp8kzXvm5v8t1hS7T+UE7HdTMhr
         zwmw==
X-Gm-Message-State: AOJu0Ywx4ylHMQMWD1QNEgFAUXBIomPfDudllrMPgob75q2dJ4dj6Wdi
	L4JpqtkiZdcY0JEbzDohFe/giklzZjc9gOSyzy6hdSppy9Pu9fkLshog6ZCfovb3rKSq2dnlpmu
	9AbU=
X-Google-Smtp-Source: AGHT+IGjnDssC0Sb4H6/cdD4B1H0ME2lB4ZEcABBsnEX+OR63qzpBD3GVy93LXTChdbdT8mVElQe0g==
X-Received: by 2002:a6b:5a0d:0:b0:7bf:35d5:bd21 with SMTP id o13-20020a6b5a0d000000b007bf35d5bd21mr388653iob.1.1705606466230;
        Thu, 18 Jan 2024 11:34:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j24-20020a02a698000000b0046ebbcf956bsm358743jam.53.2024.01.18.11.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:34:25 -0800 (PST)
Message-ID: <8e104175-7388-4930-b6a2-405fb9143a2d@kernel.dk>
Date: Thu, 18 Jan 2024 12:34:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To: Xiaobing Li <xiaobing.li@samsung.com>, asml.silence@gmail.com
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
 kundan.kumar@samsung.com, wenwen.chen@samsung.com, ruyi.zhang@samsung.com,
 cliang01.li@samsung.com, xue01.he@samsung.com
References: <CGME20240118073844epcas5p2f346bc8ef02a2f48eef0020a6ad5165d@epcas5p2.samsung.com>
 <20240118073032.15015-1-xiaobing.li@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240118073032.15015-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 12:30 AM, Xiaobing Li wrote:
> diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
> index 976e9500f651..24a7452ed98e 100644
> --- a/io_uring/fdinfo.c
> +++ b/io_uring/fdinfo.c
> @@ -64,6 +64,7 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
>  	unsigned int sq_shift = 0;
>  	unsigned int sq_entries, cq_entries;
>  	int sq_pid = -1, sq_cpu = -1;
> +	long long sq_total_time = 0, sq_work_time = 0;
>  	bool has_lock;
>  	unsigned int i;
>  
> @@ -147,10 +148,17 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  		sq_pid = sq->task_pid;
>  		sq_cpu = sq->sq_cpu;
> +		struct rusage r;
> +
> +		getrusage(sq->thread, RUSAGE_SELF, &r);
> +		sq_total_time = r.ru_stime.tv_sec * 1000000 + r.ru_stime.tv_usec;
> +		sq_work_time = sq->work_time;
>  	}

I guess getrusage() is fine here, though I would probably just grab it
directly.

> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
> index 65b5dbe3c850..f3e9fda72400 100644
> --- a/io_uring/sqpoll.c
> +++ b/io_uring/sqpoll.c
> @@ -251,6 +251,9 @@ static int io_sq_thread(void *data)
>  		}
>  
>  		cap_entries = !list_is_singular(&sqd->ctx_list);
> +		ktime_t start, diff;
> +
> +		start = ktime_get();
>  		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
>  			int ret = __io_sq_thread(ctx, cap_entries);

But why on earth is this part then not doing getrusage() as well?


> diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
> index 8df37e8c9149..c14c00240443 100644
> --- a/io_uring/sqpoll.h
> +++ b/io_uring/sqpoll.h
> @@ -16,6 +16,7 @@ struct io_sq_data {
>  	pid_t			task_pid;
>  	pid_t			task_tgid;
>  
> +	long long			work_time;
>  	unsigned long		state;
>  	struct completion	exited;
>  };

Probably just make that an u64.

As Pavel mentioned, I think we really need to consider if fdinfo is the
appropriate API for this. It's fine if you're running stuff directly and
you're just curious, but it's a very cumbersome API in general as you
need to know the pid of the task holding the ring, the fd of the ring,
and then you can get it as a textual description. If this is something
that is deemed useful, would it not make more sense to make it
programatically available in addition, or even exclusively?

-- 
Jens Axboe


