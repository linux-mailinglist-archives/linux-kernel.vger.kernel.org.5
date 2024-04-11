Return-Path: <linux-kernel+bounces-141607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6398A20A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEA21F23DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8036A2BD18;
	Thu, 11 Apr 2024 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A3WtTUkA"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817593C699
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869450; cv=none; b=GbnNLd37Vx3/iqIIWZryZJIPK61QFRiJM+YzxBHNZFd2xP/RIheIsrXV7hP7plX75HB3EbFbzH4PW0T8/M7jhgDPxvlSPT8G4nT5Gdd/xshC/PrDkwnbPSPzDbLBf0wFxxZq8f9FGc8VhDUx2xyM0hbNqmQGA3HX+fCQm0QgWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869450; c=relaxed/simple;
	bh=9QuO6BYTsmplOuE/hQFARvTiNY0alp0xXqrG4P0kAo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3YJhtYqSqymxroVKf0UqW+c/yNtuv9PYaIufI4fTGYUhbqWLotDoxglVyC5ottpJh5jEQa/36iHiWP+/nPwU06dlTN3CJYVqzj/0SI71p2hQyidloDUTnYMkWFuYm1JCYlHXJo0X1M9nEoZxhMk/zrdxlKtL/ywGhrdlTVfggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A3WtTUkA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a29832cbdso348045ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869449; x=1713474249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TuTiWcX4Y8DY4u+xZNnrYgu/EvbcTtLk+NQFTWO1Ns=;
        b=A3WtTUkANLKjLpllh4hoR6Fbyx1lwigxuZPys/n3n5k8zv4KWeEWx8dE/8SWVmtgN3
         06RS3eFtdCHvMbTQlbh3ZVFwt5JTpAujmV/ptijw7sQQf+OVM3fUAuSjZDaSzWZizMBu
         BfXd8M86Qyfx09tFjVhuNfO/AegVhylQttaHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869449; x=1713474249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TuTiWcX4Y8DY4u+xZNnrYgu/EvbcTtLk+NQFTWO1Ns=;
        b=spYNwXXKnKAOxFveDzC4HIADe2ZRhhc1eAmg9xO3GJs6l1E6rLAzN4X6V+svgnI2uK
         puf1XSRv4pC3QZjOXNuG8+gtZK4e86bAlBUJE2GQpRL9zym5gpewQAMxcw4PrZc+i4za
         3VVMg5Fz1Lanf4mJy0kK3icmGiPvifVt+0hrcBI+VKOiSeCsp4fh5WPLWU8ct2wxho3G
         GjZFXVOhF4kJ2+ZePUJz2TLUmcRSRKtR57JqC+goqkQHsMg1/5k/9rpxurdkfHWfxjrB
         upOd7Y6ZS1ymVncqhzDxJgpzWiu3QuQeZPoPpuu1Wcq5JzdQZxo0QWc0/Crv/p174OgT
         PniA==
X-Gm-Message-State: AOJu0YyzUvBopUnUqniuhZhWG3z85bYHGNtPaOD4Br+9mJrcO/Qa+YMq
	WFb3zxCP+wV+5ryexFBMV0uQabqtPDWLBR3WxZWjji/3aMIjy1rGUBV0sG8Mrt4=
X-Google-Smtp-Source: AGHT+IHG+pQPO6KcbDu18ykiy4QGeKOajDiBNItJBLgSxxwoQw8J9scYu4BS+mOOQgBpwruIUJi20g==
X-Received: by 2002:a5e:9247:0:b0:7d6:a165:217a with SMTP id z7-20020a5e9247000000b007d6a165217amr625104iop.2.1712869448773;
        Thu, 11 Apr 2024 14:04:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g7-20020a05660226c700b007d5c66e048fsm615248ioo.34.2024.04.11.14.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:04:08 -0700 (PDT)
Message-ID: <55e05bd2-eeaa-4baa-bb10-42ba15e67867@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:04:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/clone3: Fix compiler warning
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240409-clone3-warning-fix-v1-1-03720200f1b4@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240409-clone3-warning-fix-v1-1-03720200f1b4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/9/24 16:24, Mark Brown wrote:
> Shuah reported a compiler warning with an Ubuntu GCC 13 build, I've been
> unable to reproduce it but hopefully this fixes the issue:
> 
> clone3_set_tid.c:136:43: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t’ {aka ‘long unsigned int’} [-Wformat=]
> 
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/clone3/clone3_set_tid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index 9ae38733cb6e..fbf813a5a06f 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -133,7 +133,7 @@ static void test_clone3_set_tid(const char *desc,
>   		"[%d] clone3() with CLONE_SET_TID %d says: %d - expected %d\n",
>   		getpid(), set_tid[0], ret, expected);
>   
> -	ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
> +	ksft_test_result(ret == expected, "%s with %zu TIDs and flags 0x%x\n",
>   			 desc, set_tid_size, flags);
>   }
>   
> 
> ---
> base-commit: a053fd3ca5d1b927a8655f239c84b0d790218fda
> change-id: 20240409-clone3-warning-fix-89a363c6899e
> 
> Best regards,

Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah

