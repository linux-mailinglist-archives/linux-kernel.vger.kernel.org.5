Return-Path: <linux-kernel+bounces-70386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5048596E9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D583BB20F54
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE96BB4C;
	Sun, 18 Feb 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pMPXiKr1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60117EAD6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708260323; cv=none; b=Cff0w/+y49hzefDI6H5TuhRzNpanoifkcBtVEEljHDNGPKGgyYsfX9xg+qUqvaGp90DhMoo1cqtZGrfISL7dJNFYO4SxPtUFRmTRpusmUq/z0euE/tFJ6pR9G7exsnseFhn8xh5v+0HT9DHwFbdZXhUfIubutE7GiurYD1taWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708260323; c=relaxed/simple;
	bh=qOsvK8DXGP2m+hr2c3+5eDoiqjvovviL9OkSOVd6+xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdNi+HcGyWEqyLWfCXIDFgIURLYlrNxwPkLV0P+jWDqLB9Pk74EqhkCkCzHJ/yC/+Fuqq1BvM3IoHqht14pz5wuRlMhybdXmi6Af0xNt0fS8LHOaMrk1da/gcmlniIS0ZxolWEBliVuml0B4mNoQuaJaCD8tL1y0su5qryOvlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pMPXiKr1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2866b15b013so990098a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708260318; x=1708865118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpqTiU/7yQrm0r8tMp8al7wzn/Zvghd4JxEhQBfnYt8=;
        b=pMPXiKr1yslMDT0uJt0JwGTsolNdLQjC/H1YBCCuCcqukNLbYYmlQ2LyPX21wXIDvz
         rRRgKeAXuv7ikFe75SdedKUccQh5n1+LCJOvYP/sHqQo7F/HNn4ua5X3l42cEjJqAWZy
         uqoSgtS1MOukgMDTWC5shFgpJ8sEMJqka6gR72bjmYIG8fyzJYSgYOuqXjvpxdYpy2Uc
         O5BW8vzQGlfZkJ9VxAeUAI9NP3sWgwSCXmtvysVhM2nj7kXlaute6JenAKyrvPzT2mxp
         iBrGF5RK+6LS4t2+QKWZyWP0OPcibOTZ5g6kzRVdw/49Cu7QgLV8QYxEIWAiPdxJS7ap
         XTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708260318; x=1708865118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpqTiU/7yQrm0r8tMp8al7wzn/Zvghd4JxEhQBfnYt8=;
        b=V5leLVkV4roMbFIewi4jBZuTo/iDyfWg84wJVu/dt84tBnhB9kv9+YZFWCDAQXWyCM
         6Ilk36omsWkHvzvLHaVnxAmpZoaKrfUPDEK9sG5f5XA5uXQmVu1wK2llm10YdhLjLSKI
         /gd1h62ypkR7vggOMI33Y9bGTo545kwbqs84KdWnRK7hJebz4J0nydmVmLVRGBs5K727
         qCUo+wruosvE5SRsVRdzCI1lGGYGg43dXvG/FfS3Hy6QLbaFHbL7XCjTJXW7xGJ7y33e
         BvYusAzGY4quN8v6eLuACM1dbXTdL8qZsP1BQqmw4IzL1MfLEEl7dsZklUGBVH8G9YHD
         rdYA==
X-Forwarded-Encrypted: i=1; AJvYcCWk6Wp0FiGnQR7V86wM9ln399JZ0nNKDABP9+S8J1KKx1KmzqF+tUG8OLqZFZiwj6pC4t+d3QQ/5SvoEnTjyRI+/uNAm1majbaryIqK
X-Gm-Message-State: AOJu0Yx78rFaB3UMbDgrCtjtMtWbOBYEykc8fqzKwKdvZl0wWZbZYZKK
	rR2kglRoo8AkNnLp6sECZ+HP31DyAtQOOlZIUalgUh8orlXwQaLUfRuQ5PBzryrzqwPgWYoy0yB
	7
X-Google-Smtp-Source: AGHT+IH24HwrBk8tEWIT7JqmpPJrZ/d4JKpTlgjSlcTALopVPOXPC97qtBxXOGQUj4oQ/TdfbN+HGw==
X-Received: by 2002:a05:6a00:2d96:b0:6e1:bcb:d4e3 with SMTP id fb22-20020a056a002d9600b006e10bcbd4e3mr12343970pfb.1.1708260318493;
        Sun, 18 Feb 2024 04:45:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z16-20020aa791d0000000b006e141794208sm2968092pfa.165.2024.02.18.04.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 04:45:17 -0800 (PST)
Message-ID: <1f7fa75e-f920-47d8-ae4f-cc7595b5e732@kernel.dk>
Date: Sun, 18 Feb 2024 05:45:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To: Xiaobing Li <xiaobing.li@samsung.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, kun.dou@samsung.com, peiwei.li@samsung.com,
 joshi.k@samsung.com, kundan.kumar@samsung.com, wenwen.chen@samsung.com,
 ruyi.zhang@samsung.com
References: <20240206023910.11307-1-xiaobing.li@samsung.com>
 <CGME20240218055523epcas5p390fe990f970cf2b9b1f96edd5d7bc9b5@epcas5p3.samsung.com>
 <20240218055513.38601-1-xiaobing.li@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240218055513.38601-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/24 10:55 PM, Xiaobing Li wrote:
> On 2/6/24 10:39 AM, Xiaobing Li wrote:
>> io_uring/fdinfo.c | 8 ++++++++
>> io_uring/sqpoll.c | 8 ++++++++
>> io_uring/sqpoll.h | 1 +
>> 3 files changed, 17 insertions(+)
>>
>> diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
>> index 976e9500f651..18c6f4aa4a48 100644
>> --- a/io_uring/fdinfo.c
>> +++ b/io_uring/fdinfo.c
>> @@ -64,6 +64,7 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
>> 	unsigned int sq_shift = 0;
>> 	unsigned int sq_entries, cq_entries;
>> 	int sq_pid = -1, sq_cpu = -1;
>> +	u64 sq_total_time = 0, sq_work_time = 0;
>> 	bool has_lock;
>> 	unsigned int i;
>>
>> @@ -147,10 +148,17 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
>>
>> 		sq_pid = sq->task_pid;
>> 		sq_cpu = sq->sq_cpu;
>> +		struct rusage r;
>> +
>> +		getrusage(sq->thread, RUSAGE_SELF, &r);
>> +		sq_total_time = r.ru_stime.tv_sec * 1000000 + r.ru_stime.tv_usec;
>> +		sq_work_time = sq->work_time;
>> 	}
>>
>> 	seq_printf(m, "SqThread:\t%d\n", sq_pid);
>> 	seq_printf(m, "SqThreadCpu:\t%d\n", sq_cpu);
>> +	seq_printf(m, "SqTotalTime:\t%llu\n", sq_total_time);
>> +	seq_printf(m, "SqWorkTime:\t%llu\n", sq_work_time);
>> 	seq_printf(m, "UserFiles:\t%u\n", ctx->nr_user_files);
>> 	for (i = 0; has_lock && i < ctx->nr_user_files; i++) {
>> 		struct file *f = io_file_from_index(&ctx->file_table, i);
>> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
>> index 65b5dbe3c850..9155fc0b5eee 100644
>> --- a/io_uring/sqpoll.c
>> +++ b/io_uring/sqpoll.c
>> @@ -251,6 +251,9 @@ static int io_sq_thread(void *data)
>> 		}
>>
>> 		cap_entries = !list_is_singular(&sqd->ctx_list);
>> +		struct rusage start, end;
>> +
>> +		getrusage(current, RUSAGE_SELF, &start);
>> 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
>> 			int ret = __io_sq_thread(ctx, cap_entries);
>>
>> @@ -260,6 +263,11 @@ static int io_sq_thread(void *data)
>> 		if (io_run_task_work())
>> 			sqt_spin = true;
>>
>> +		getrusage(current, RUSAGE_SELF, &end);
>> +		if (sqt_spin == true)
>> +			sqd->work_time += (end.ru_stime.tv_sec - start.ru_stime.tv_sec) *
>> +					1000000 + (end.ru_stime.tv_usec - start.ru_stime.tv_usec);
>> +
>> 		if (sqt_spin || !time_after(jiffies, timeout)) {
>> 			if (sqt_spin)
>> 				timeout = jiffies + sqd->sq_thread_idle;
>> diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
>> index 8df37e8c9149..e99f5423a3c3 100644
>> --- a/io_uring/sqpoll.h
>> +++ b/io_uring/sqpoll.h
>> @@ -16,6 +16,7 @@ struct io_sq_data {
>> 	pid_t			task_pid;
>> 	pid_t			task_tgid;
>>
>> +	u64					work_time;
>> 	unsigned long		state;
>> 	struct completion	exited;
>> };
>  
> Hi, Jens and Pavel
> This patch has been modified according to your previous opinions.
> Do you have any other comments?

I don't have any further complaints on the patch, I think it looks
pretty straight forward now. I'll get it applied, thanks.

-- 
Jens Axboe


