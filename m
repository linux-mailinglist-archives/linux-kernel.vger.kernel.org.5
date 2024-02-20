Return-Path: <linux-kernel+bounces-73830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49685CC22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37772283C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B8154BFE;
	Tue, 20 Feb 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cnunaKmc"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7478688
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472464; cv=none; b=bF96j4feHhKO8uxi/ktIhx1FX0sXDS+Rb+UVXlyPk0Y+xTXHrS4gZ7I307lU0BuzI4vAjAakd5NCruJlcOrx5KCVb0F7545TjC8379Q7CeoZb7Gl1cSgRIIp9DpV6VKsBk0pPEh8WWTm+xtAJdSYwTHmizWADnqc/eu4eA0Fuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472464; c=relaxed/simple;
	bh=gronH/sTNUv0ew6QhMarwGTwQTMnrQvjlXgLIvPHrTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV5TFq5IppaaPsEQy48ly0CNxJ8Lbw2htbwttZstOhjyOn6DixOgA8Aef4Wk/qKQOGF9hH4IpXjeCQmWLsn682qvxeUr64LKLPnw1wgsQ5SdDf4AaC+y+XVgqYHFG4UmWOKrvxwE6eQnL7rlhRWI6TCMrkQksBDp6sI/zpE/eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cnunaKmc; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-365306a6455so2685695ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708472462; x=1709077262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UnsYW6EfxqDbmgBg2KeWLKrmKZBH6vvHprlR2Mupzo=;
        b=cnunaKmcTUL60+n3ggFcjlJnoFbbm2R8RNjxO7kKE0z5N6cYt34SAn8arkC4XZt4Jk
         jXPQCQD1svKf4i5jEZPRlu68RmlZvI0J6oc6SqU4mcO/X7v3TQg9/0Sd5v/1s3jBqkE+
         zmX6BCpLa+7UEeXzopMHN2jCF6S+pNvWw6oB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472462; x=1709077262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UnsYW6EfxqDbmgBg2KeWLKrmKZBH6vvHprlR2Mupzo=;
        b=A5gnXMtgBGBIHXZpedWpl5/qtluGLw4Sz9c641sge0t3OlwbJIsUIcf7B1xzNopnfq
         Sgm4TYCgPWOFoagtGz61HVxvqZzDKaxsG6J0Gg/cKyQOrnwYGJXLqVenUCTlyRBStBic
         KvAJhJNII/IiX+X1L9sGwgNKNx5eGv7vuCnLkQK0itsnSgqs7oTksbDhbBZnwK0kGgJm
         8wm4IAqYWpNGY5XWZKn8zTs71ijG/vSEmlShWZ0iz4UJavacY53lAH8tOwnXx1pO9kxI
         h2EeTt1ZiDE/8dqCyt6UexLpQ5e4Wwm541rtE15QkilWor5upzGgvx8zhteo3XeLpMHM
         MSfA==
X-Gm-Message-State: AOJu0YzJRoGQ578pIRwC+mGbQvdSWa93ABF0iQ5nC461aqua7X8XTolg
	a71YUBdMKf7l6r+XsemhRZamCuSS/HT3npncRFTLf+W5E0C91O9uJo9dZzKOFfHBwCRm6QoDlw2
	1
X-Google-Smtp-Source: AGHT+IHRrBQWlgEVXB8xMK0wKYzUDkVobcMgKCKkpm5C0SCWhawsu+rb5R/+xQm4pWfEmEPUTiYoBA==
X-Received: by 2002:a05:6e02:198d:b0:363:b545:3a97 with SMTP id g13-20020a056e02198d00b00363b5453a97mr14198470ilf.0.1708472462498;
        Tue, 20 Feb 2024 15:41:02 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b19-20020a026f53000000b00473c4bc1f7bsm2447107jae.20.2024.02.20.15.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:41:02 -0800 (PST)
Message-ID: <7459e07b-80fb-4eae-9414-3dee68cfd173@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: ftrace: fix minor typo in log
Content-Language: en-US
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240211111818.610211-1-vincenzo.mezzela@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240211111818.610211-1-vincenzo.mezzela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 04:18, Vincenzo Mezzela wrote:
> Resolves a spelling error in the test log, preventing potential
> confusion.
> 
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
> 
> It is submitted as part of my application to the "Linux Kernel
> Bug Fixing Spring Unpaid 2024" mentorship program of the Linux
> Foundation.
> 
>   .../testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
> index 4562e13cb26b..717898894ef7 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
> @@ -40,7 +40,7 @@ grep "id: \(unknown_\|sys_\)" events/raw_syscalls/sys_exit/hist > /dev/null || \
>   
>   reset_trigger
>   
> -echo "Test histgram with log2 modifier"
> +echo "Test histogram with log2 modifier"
>   
>   echo 'hist:keys=bytes_req.log2' > events/kmem/kmalloc/trigger
>   for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done

Steve,

I picked this up fpr next for Linux 6.9-rc1

thanks,
-- Shuah

