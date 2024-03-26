Return-Path: <linux-kernel+bounces-119851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA688CDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EEF1F83C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5013D286;
	Tue, 26 Mar 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VS41cHi5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4D13D265
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483233; cv=none; b=CfAmMCYeixW4tRtxm27ggz0AgmXnRrdvQZD8Fi56C6D31KpiaDzEy9nLClnm5dJV7du82X0ehV0JE9brprx2T6Ob5y3ZCPWrR6KHEstJMs8bws8pD5+gKlJc08c2giHwWOkFTcByfZpjSr9ahBlB7POovGB7ZkvZsZbuLomcVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483233; c=relaxed/simple;
	bh=Unzp8uuNQUgKN7Bb79LPIlxYgOk5ijtgyJbVOjBp7gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8WGW4nup2DNkyEuXjbblgIfXX1jt8v8TTEDOExjf8P1XOokcu7mpvsd1wztA3me5rIr+72tv+LQtGf2+yUEPJFCpQUchDOplk7ykBZTApunoYI31acgRH2RAvO2ZtqgemVVMKxQ8zg+zlx4Fpb8ogGdD52SGbvkyXVPNU6OaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VS41cHi5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3688dcc5055so468185ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711483231; x=1712088031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdQUORm6h0uikhJa7u6bme4vQj7H+328dVXDreC5A9Y=;
        b=VS41cHi58CLDrYRSPfSNyKQZnjLbs9fe3UUtzE3gsTBTwO5JxQ5UZlC08JMUe7gJTb
         OR8s6eUiifNP9JcNXeoVioLP08kZqKCGBHq7ncIEJIUo+Yu0gphxHuriEUMK9pQX7aVt
         D25LNi5463b669NGqRdXgxnbKdS6ocswz4hhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483231; x=1712088031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdQUORm6h0uikhJa7u6bme4vQj7H+328dVXDreC5A9Y=;
        b=on7pf7Owm68q57ZY9dSdlMPVhYK0O3DPkthA1F9Kmf2Ou6xA5uQ1SUzlAf6ZQ4r9c/
         YydSIiwUSuYpUsEYydQqMj2YLJzE6zzJpg6/JWdNqNSH4fSUhtRRxb5feePxOPJP/qDd
         /V+S1XlwFKTHNbZvmLKWPeMfGZVLgrb1XMfJ6gGrHQzWW+bOGkhyxsD2YfX3lGgJHplr
         p418XI4ZDRR7G+OkjgLFWIMc9MWfWUU8LTo2nqDwxbDpICpYp1flo0D+D/1zoLm7Tzvu
         V0LtbEzjtxM5ASP9f/k3ggKyigz8Nxo0brwcWFyKZ0aEEzsIiYTM+XAk0EW3ohcL8LPo
         zXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYK2cqEV7mvE1wySor01F8cxEhBNLH+2RafvqJ/K1KZwpvAO3j5nw4JMJVtr/riI11d9ok1kWQeJOei67b5FMlyT47cZN2sNeJ2LKA
X-Gm-Message-State: AOJu0YzJGT2hmkfbiD5JbgSOiUyBJTbeb8gumK6mxxiD5DtBv4VfFEcm
	k+QpJle6hbLXZepY3oYiHOp1A/y404wtXx4JP6AAB4m0oXAUSbMdikxMhthAGxA=
X-Google-Smtp-Source: AGHT+IGkwAKlGDOj8puCOUOE6fJM7kC8ONKdUqDiTuB+wUaPv23IQNbHBKPUGTc418tVAF7fbtoeVw==
X-Received: by 2002:a05:6e02:1fea:b0:368:a043:4a26 with SMTP id dt10-20020a056e021fea00b00368a0434a26mr3573431ilb.3.1711483230718;
        Tue, 26 Mar 2024 13:00:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j12-20020a926e0c000000b00366a3016a30sm3105612ilc.70.2024.03.26.13.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:00:30 -0700 (PDT)
Message-ID: <a1a6f5dd-80ab-4d53-90de-eb003c996cc1@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:00:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: test_vsyscall: conform test to TAP
 format output
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240314103216.286603-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 04:32, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> Without using TAP messages, the passed/failed/skip test names cannot be
> found.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---


I am seeing lot more changes than conform and formatting changes.

>   tools/testing/selftests/x86/test_vsyscall.c | 506 +++++++++-----------
>   1 file changed, 238 insertions(+), 268 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 47cab972807c4..d4c8e8d79d389 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -21,6 +21,13 @@
>   #include <sys/uio.h>
>   
>   #include "helpers.h"
> +#include "../kselftest.h"
> +
> +#ifdef __x86_64__
> +#define TOTAL_TESTS 13
> +#else
> +#define TOTAL_TESTS 8
> +#endif
>   
>   #ifdef __x86_64__
>   # define VSYS(x) (x)
> @@ -39,18 +46,6 @@
>   /* max length of lines in /proc/self/maps - anything longer is skipped here */
>   #define MAPS_LINE_LEN 128
>   
> -static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> -		       int flags)
> -{
> -	struct sigaction sa;
> -	memset(&sa, 0, sizeof(sa));
> -	sa.sa_sigaction = handler;
> -	sa.sa_flags = SA_SIGINFO | flags;
> -	sigemptyset(&sa.sa_mask);
> -	if (sigaction(sig, &sa, 0))
> -		err(1, "sigaction");
> -}
> -

Why is this deleted?

>   /* vsyscalls and vDSO */
>   bool vsyscall_map_r = false, vsyscall_map_x = false;
>   
> @@ -75,83 +70,25 @@ static void init_vdso(void)
>   	if (!vdso)
>   		vdso = dlopen("linux-gate.so.1", RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>   	if (!vdso) {
> -		printf("[WARN]\tfailed to find vDSO\n");
> +		ksft_print_msg("[WARN] failed to find vDSO\n");
>   		return;
>   	}
>   
>   	vdso_gtod = (gtod_t)dlsym(vdso, "__vdso_gettimeofday");
>   	if (!vdso_gtod)
> -		printf("[WARN]\tfailed to find gettimeofday in vDSO\n");
> +		ksft_print_msg("[WARN] failed to find gettimeofday in vDSO\n");
>   
>   	vdso_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
>   	if (!vdso_gettime)
> -		printf("[WARN]\tfailed to find clock_gettime in vDSO\n");
> +		ksft_print_msg("[WARN] failed to find clock_gettime in vDSO\n");
>   
>   	vdso_time = (time_func_t)dlsym(vdso, "__vdso_time");
>   	if (!vdso_time)
> -		printf("[WARN]\tfailed to find time in vDSO\n");
> +		ksft_print_msg("[WARN] failed to find time in vDSO\n");
>   
>   	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
>   	if (!vdso_getcpu)
> -		printf("[WARN]\tfailed to find getcpu in vDSO\n");
> -}
> -
> -static int init_vsys(void)
> -{
> -#ifdef __x86_64__
> -	int nerrs = 0;
> -	FILE *maps;
> -	char line[MAPS_LINE_LEN];
> -	bool found = false;
> -
> -	maps = fopen("/proc/self/maps", "r");
> -	if (!maps) {
> -		printf("[WARN]\tCould not open /proc/self/maps -- assuming vsyscall is r-x\n");
> -		vsyscall_map_r = true;
> -		return 0;
> -	}
> -
> -	while (fgets(line, MAPS_LINE_LEN, maps)) {
> -		char r, x;
> -		void *start, *end;
> -		char name[MAPS_LINE_LEN];
> -
> -		/* sscanf() is safe here as strlen(name) >= strlen(line) */
> -		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> -			   &start, &end, &r, &x, name) != 5)
> -			continue;
> -
> -		if (strcmp(name, "[vsyscall]"))
> -			continue;
> -
> -		printf("\tvsyscall map: %s", line);
> -
> -		if (start != (void *)0xffffffffff600000 ||
> -		    end != (void *)0xffffffffff601000) {
> -			printf("[FAIL]\taddress range is nonsense\n");
> -			nerrs++;
> -		}
> -
> -		printf("\tvsyscall permissions are %c-%c\n", r, x);
> -		vsyscall_map_r = (r == 'r');
> -		vsyscall_map_x = (x == 'x');
> -
> -		found = true;
> -		break;
> -	}
> -
> -	fclose(maps);
> -
> -	if (!found) {
> -		printf("\tno vsyscall map in /proc/self/maps\n");
> -		vsyscall_map_r = false;
> -		vsyscall_map_x = false;
> -	}
> -
> -	return nerrs;
> -#else
> -	return 0;
> -#endif
> +		ksft_print_msg("[WARN] failed to find getcpu in vDSO\n");
>   }
>   

What's going on here?

These changes are more extensive than the changelog indicates.
Additional explanation is needed before I can accept this.

thanks,
-- Shuah

