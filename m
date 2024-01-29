Return-Path: <linux-kernel+bounces-42854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3D8407BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302051C22F72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96EA657D0;
	Mon, 29 Jan 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QAESJruz"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F2657B3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536846; cv=none; b=lc/xsKcbblgQuEM+yzix3avgKsrb1MV5epURRsPkpURvCzhvWFGdTlPGxuZfFB80K44xZuVSGCVrSsUuPNp9/N+ubyAHgkzC0gLCPucHgbz2lPyH5jrfcJxnZ8n4fHhZ122C7Wh8T4ceZqznkuAT1kUZDYDhdGiKLL1Teul1pDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536846; c=relaxed/simple;
	bh=SQ04STe/aYVjnCBxYeWBjsaMc9GpyngM0NMmL+Lhc24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfxVkd0GdaTFxhl1BI2cwisAICHT5RYdjvEeeIMux2sJbTKHo2N80Y+omwct2o3H/OD4afyuPuEZ2LiQp0xYUIM/4oWYsVXh1ovYz9A1sT2H9v6+SEwy73sY906O7HoNnV3g01qp4Vh6PMQHVOPNNCoJ4KhiIyDHXLI00GZ17BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QAESJruz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d748f1320aso3916865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706536842; x=1707141642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPwleXPZEicef5bpuduhRFgNi3FvwGm9SY6PNmOkghM=;
        b=QAESJruzc6Ul4WUtsezjJyP37fftVpXQHOkS9mGGLZZx67mL+MEPNTczo4sGps516S
         JTIoE81Ia8PQOqLsn5mlMxbiUGSwWeKspn3z64LUerA4UHfpMFL+FfhJbjwWLqUIgdml
         lVP2LnrO29rjetqfQHayzU4VttDssIJ6lYKKyFAGZZwH1PTRdQfLbZYDOgo5KPHjJ/I+
         4IBxKSlfZJFVBTZz7EeAuYY242xbqhJSWKpzbJN7G/cuWTKl/MM4cZwgzynFtaUvCPw1
         O6PW0Mk7zjNyYwAw7cLtSXGtE6nXMO/HCmmRCF+D1qatJGDVz3rqSHGqSzSr7+OIOhJx
         Hpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536842; x=1707141642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPwleXPZEicef5bpuduhRFgNi3FvwGm9SY6PNmOkghM=;
        b=ZmRN0EAAoiS+m8v0dQOPGA6MBebF0c0s6+kY73guLAM3tP9VSaOC6KntwdAyke7Scn
         ln2dp501m65vMHwWkmcQn3++v103shwnBEk8DY9HJK0iney0KYGr6cTYoEmxWo00G1bm
         g3wCTr2tvdT66+KhjSxauiGN5YLJddKdfhRjN5PdjXE8Du9jIWN8wbPZdT00QiCjqTZ5
         i65bue+IKvW0lBPpH//y3pPQWUqF5Bx0HMebtQXjOGeN3Ag+25bOldALkFvyQfjoEQFz
         lN2e8CEvNgQoxH9KEsJSl6fNUkxgq00U8CfwylJI4gP7gitRJq3MJdIxdvNPi5+gKmHY
         Q94w==
X-Forwarded-Encrypted: i=0; AJvYcCVejm002qqGVcQPwKF51llWEQwG8+wud4FOS3oAQsqD/0Z4KWmfCflhLt7Tql2N7orpcR2FGuum3oVpJGq2P8ivZ4ol6xnf222amta/
X-Gm-Message-State: AOJu0Yz788lotHLQDpNDSYMbYkNho+wLzpFVG5e7qdk49VNg2axFyZD5
	1lvri8a/Z94kFmmkbzUFoCu6LeF+cKlO/U/uZ9c7tC2m1+8K4Y3y0V+tuflbbgLussXmwVVXw4B
	Xrm4=
X-Google-Smtp-Source: AGHT+IGECYKLe+3ih3dbmJmXhd+Ud4nfFuMaOsev360L1iI0PLRcAM13Jno4R0i5Y1dRZV0aqbpz2Q==
X-Received: by 2002:a17:903:32c5:b0:1d3:e503:5b55 with SMTP id i5-20020a17090332c500b001d3e5035b55mr8368129plr.2.1706536841622;
        Mon, 29 Jan 2024 06:00:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001d5d736d1b2sm5354692plv.261.2024.01.29.06.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:00:41 -0800 (PST)
Message-ID: <e2a84850-95a3-48a8-b4ce-e5b005fbf186@kernel.dk>
Date: Mon, 29 Jan 2024 07:00:39 -0700
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
To: Xiaobing Li <xiaobing.li@samsung.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, kun.dou@samsung.com, peiwei.li@samsung.com,
 joshi.k@samsung.com, kundan.kumar@samsung.com, wenwen.chen@samsung.com,
 ruyi.zhang@samsung.com
References: <8e104175-7388-4930-b6a2-405fb9143a2d@kernel.dk>
 <CGME20240129072655epcas5p35d140dba2234e1658b7aa40770b93314@epcas5p3.samsung.com>
 <20240129071844.317225-1-xiaobing.li@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240129071844.317225-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 12:18 AM, Xiaobing Li wrote:
> On 1/18/24 19:34, Jens Axboe wrote:
>>> diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
>>> index 8df37e8c9149..c14c00240443 100644
>>> --- a/io_uring/sqpoll.h
>>> +++ b/io_uring/sqpoll.h
>>> @@ -16,6 +16,7 @@ struct io_sq_data {
>>>  	pid_t			task_pid;
>>>  	pid_t			task_tgid;
>>>  
>>> +	long long			work_time;
>>>  	unsigned long		state;
>>>  	struct completion	exited;
>>>  };
>>
>> Probably just make that an u64.
>>
>> As Pavel mentioned, I think we really need to consider if fdinfo is the
>> appropriate API for this. It's fine if you're running stuff directly and
>> you're just curious, but it's a very cumbersome API in general as you
>> need to know the pid of the task holding the ring, the fd of the ring,
>> and then you can get it as a textual description. If this is something
>> that is deemed useful, would it not make more sense to make it
>> programatically available in addition, or even exclusively?
> 
> Hi, Jens and Pavel
> sorry for the late reply.
> 
> I've tried some other methods, but overall, I haven't found a more suitable 
> method than fdinfo.
> If you think it is troublesome to obtain the PID,  then I can provide
>  a shell script to output the total_time and work_time of all sqpoll threads 
>  to the terminal, so that we do not have to manually obtain the PID of each 
>  thread (the script can be placed in tools/ include/io_uring).
> 
> eg:
> 
> PID    WorkTime(us)   TotalTime(us)   COMMAND
> 9330   1106578        2215321         iou-sqp-9329
> 9454   1510658        1715321         iou-sqp-9453
> 9478   165785         223219          iou-sqp-9477
> 9587   106578         153217          iou-sqp-9586
> 
> What do you think of this solution?

I don't think it's a great interface, but at the same time, I don't feel
that strongly about it and perhaps bundling a script that outputs the
above in liburing would be Good Enough. I'm a bit reluctant to add a
stats API via io_uring_register() just for this.

So maybe spin a v8 with the s/long long/u64 change and include your
script as well?

-- 
Jens Axboe


