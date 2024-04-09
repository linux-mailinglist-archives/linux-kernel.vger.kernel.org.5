Return-Path: <linux-kernel+bounces-137433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD789E206
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430C31C21A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8F6156883;
	Tue,  9 Apr 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wH4GweWf"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E594C85
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685569; cv=none; b=iqySgsQY6YesPPPJF62aYVjvsAkAxLjE/7rg3fee9dHjg/JhrpphU/3byzB1/ncQPLQEiM2zFCHr8wHgQDprLUDTZ3mfcaNO2F/Bs8hqyXODJqs4lsEO0WGnsjCbZHtK6RTr7WMY3PmGvMjgOld3E4kx8uFWpBQg+E2HdH84yT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685569; c=relaxed/simple;
	bh=gERIPEmSHsEjHilcpu5pXc4M9aGva12lLhXm8WmvYGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oH4QYXtDdhGaYnP/4GH1rcp6fkwAoPk+c4asua6sIQlzZXzt+/YkSdH2TEhCxG1LV7WMvIhiO8CAOgnlr9YeIeZ7vD5cKeE5Qi2ogseFoVd3TvFtjCzMRJO0BItV6RJU9ONBBVVSDx5JSB8jvcdoRK9RhzCH6/mKn1TQgoKVzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wH4GweWf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cbc70e6-04e9-4523-9d4d-84d0794cfc74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712685565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFkudtkarTW9bOE2Z7rxixOdH6DWABVMAIpnLcA4MUY=;
	b=wH4GweWfwbyq3i1FND1UFOlCJxV+HUp0And7/LYWbsvjl9lS7xoCxPpFHqFxvU9jnSAz8r
	7yTdp9511czlKCEKpWaV+NIJz4hZS1xlfGisVwUIECMyqRZcTfYFhLYq+akB55x7xUXKqn
	o9jdXl+py+52wsTvWpoSN6K0qu0ZHMc=
Date: Tue, 9 Apr 2024 10:59:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix uninit-value in strnchr
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <0000000000009e2ff406130de279@google.com>
 <tencent_AABA5D95191FCFD28DB325F58D8212525D07@qq.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <tencent_AABA5D95191FCFD28DB325F58D8212525D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/9/24 4:37 AM, Edward Adam Davis wrote:
> According to the context in bpf_bprintf_prepare(), this is checking if fmt ends
> with a NUL word. Therefore, strnchrnul() should be used for validation instead
> of strnchr().

As your another email, this is not fixing the uninit KMSAN report.

If there was a separate bug, please post a separate patch instead of replying to 
an unrelated thread and confuse syzbot.

> 
> Reported-by: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   kernel/bpf/helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 449b9a5d3fe3..07490eba24fe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -826,7 +826,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>   	u64 cur_arg;
>   	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
>   
> -	fmt_end = strnchr(fmt, fmt_size, 0);
> +	fmt_end = strnchrnul(fmt, fmt_size, 0);

I don't think it is correct either.

>   	if (!fmt_end)

e.g. what will strnchrnul return if fmt is not NULL terminated?

The current code is correct as is. Comment snippet from strnchr:

/*
  * ...
  *
  * Note that the %NUL-terminator is considered part of the string, and can
  * be searched for.
  */
char *strnchr(const char *s, size_t count, int c)


>   		return -EINVAL;
>   	fmt_size = fmt_end - fmt;




