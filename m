Return-Path: <linux-kernel+bounces-168070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E521B8BB34B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143061C2162C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F7158A18;
	Fri,  3 May 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZiuTpCTb"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A177156F2A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761165; cv=none; b=r3rruOX+2dJMAfC01chlo7nTB9u9g6iKI12KN2aO/JIypB1b78HAvTHJNk1Xs/VByQLXRkoTV0r0ZJ0mfqhlNxboY49jcM3VN3AefncTn6/9UT+sYMLoCx9RdHLqBXsA58C/7s45AII0hZXi0/o21LIOSeCS/9eA8Wi8EJgIRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761165; c=relaxed/simple;
	bh=thQpcx3ofwBl2NapX2E08oLI5uycUtew15h9Dl7Vjx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV46ebOoWJa9NkkyGL7QUKVee0BqA5hmuDsumxdefc29APvHmMrA/ZENNGmLzwPSvl0bzuXlJMlxFW4dbDu8GbTX7ZxTRSnNvudsYxSBSvUg8RhD39V07q/zF57SjtrOkT3wSdDqgUDqrQW+UV/ZaRadVLPPg5sDyU8USz8ZBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZiuTpCTb; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b1b03dc01dso783663eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714761160; x=1715365960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuIK4pZtZQgSebm0oMTfA9X2mUf1bKnvaBi7DXNsL8g=;
        b=ZiuTpCTbyyWPxNtz8DYYpWObK+C9VXY3724K6rfuJSnr1SHJcfRGTx4b6ENehDhgH1
         8MXaMS2eAVi1LMg3IhSE8i0iYnqO55AGAWQ3KwlzgWRknHoFdEwy56eJVfstBK5JsTev
         KRy/ITwVf/VYl+OHnm+DLn97+/Ktblsnp47FLjOdI9DDf0VSxv4q6LInoo0jermcBnYU
         8o9kgUyY4kM27hDhl8sZrJTBY3WToiBfjaygoggAVYXLvY0nCLu6i+lD2mCt43G9e2hY
         5/EUxGrgTV3cTXfUvMuEQfOw1SQMNIXDiNSfMRmFbTmcxtMv1Y96Ecs5nfQJmkN6YE2H
         Ng5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761160; x=1715365960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuIK4pZtZQgSebm0oMTfA9X2mUf1bKnvaBi7DXNsL8g=;
        b=rFrc6Pesqr8lG8ugk1+h4CId9yrjNvV20aSOTdvQJUMHGVF8xiWQzMI08Y/iQkmJQ2
         lwzjtIRtiLFnvwfyEASsshITDgF7oNPNt0abrWVlsrkQGfxKMBlY9G9QcYcDYkqyVoeO
         ULYDOiJTqOEBnMBWsj9REM5xBDz4yD1fptAWyT7Ok3b6bLZhoETFTJ1RiD6pfi8a5Jv2
         57gjJEELw+AoJsIIWs0a8o9VKyG7TcNsxPQFQHEO1g3TBpcWdeNlc8y/028CgRAuuqO+
         m/nLNt3hhof5bBd5Gl5cLhKj01r2Hlbe3j09tPOj8Wk92SASr3hqz3iEsn2SefWD8h8S
         lYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV308nC0usaF5UWxa+Mmc9i/NAXVRBT/Ji+NapHXUwQw0kSNZbEv1hjVZN0f3a0kRkbAgyt7SI2hMrzdyprQSfzLoWzo/VbxRlsn31r
X-Gm-Message-State: AOJu0YxWxWTE8qglAd/pMjC89K2k4+cvxAovg9LwXCfVQszXjzXKUig6
	7Rw9IxBmyH9u3ecCwqtDWNjWs/MJyAnfqzrJ50K1g80/+3ingnp/egXLqgifpQsthL35PjA39zs
	m
X-Google-Smtp-Source: AGHT+IFKeYOKGgDrM+UpggQYwnhkK46+gkjObUufaM/CkkckVM9hySHo3EPx+BdI0zv/jlzHwFkQIw==
X-Received: by 2002:a05:6359:4c9f:b0:186:865e:e34 with SMTP id kk31-20020a0563594c9f00b00186865e0e34mr3684870rwc.0.1714761160152;
        Fri, 03 May 2024 11:32:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id by22-20020a056a02059600b0061cd470b63esm1603302pgb.32.2024.05.03.11.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:32:39 -0700 (PDT)
Message-ID: <d05aa530-f0f5-4ec2-91ae-b193ae644395@kernel.dk>
Date: Fri, 3 May 2024 12:32:38 -0600
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
> Utilize set_bit() and test_bit() on worker->flags within io_uring/io-wq
> to address potential data races.
> 
> The structure io_worker->flags may be accessed through parallel data
> paths, leading to concurrency issues. When KCSAN is enabled, it reveals
> data races occurring in io_worker_handle_work and
> io_wq_activate_free_worker functions.
> 
> 	 BUG: KCSAN: data-race in io_worker_handle_work / io_wq_activate_free_worker
> 	 write to 0xffff8885c4246404 of 4 bytes by task 49071 on cpu 28:
> 	 io_worker_handle_work (io_uring/io-wq.c:434 io_uring/io-wq.c:569)
> 	 io_wq_worker (io_uring/io-wq.c:?)
> <snip>
> 
> 	 read to 0xffff8885c4246404 of 4 bytes by task 49024 on cpu 5:
> 	 io_wq_activate_free_worker (io_uring/io-wq.c:? io_uring/io-wq.c:285)
> 	 io_wq_enqueue (io_uring/io-wq.c:947)
> 	 io_queue_iowq (io_uring/io_uring.c:524)
> 	 io_req_task_submit (io_uring/io_uring.c:1511)
> 	 io_handle_tw_list (io_uring/io_uring.c:1198)
> 
> Line numbers against commit 18daea77cca6 ("Merge tag 'for-linus' of
> git://git.kernel.org/pub/scm/virt/kvm/kvm").
> 
> These races involve writes and reads to the same memory location by
> different tasks running on different CPUs. To mitigate this, refactor
> the code to use atomic operations such as set_bit(), test_bit(), and
> clear_bit() instead of basic "and" and "or" operations. This ensures
> thread-safe manipulation of worker flags.

Looks good, a few comments for v2:

> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> index 522196dfb0ff..6712d70d1f18 100644
> --- a/io_uring/io-wq.c
> +++ b/io_uring/io-wq.c
> @@ -44,7 +44,7 @@ enum {
>   */
>  struct io_worker {
>  	refcount_t ref;
> -	unsigned flags;
> +	unsigned long flags;
>  	struct hlist_nulls_node nulls_node;
>  	struct list_head all_list;
>  	struct task_struct *task;

This now creates a hole in the struct, maybe move 'lock' up after ref so
that it gets filled and the current hole after 'lock' gets removed as
well?

And then I'd renumber the flags, they take bit offsets, not
masks/values. Otherwise it's a bit confusing for someone reading the
code, using masks with test/set bit functions.

-- 
Jens Axboe


