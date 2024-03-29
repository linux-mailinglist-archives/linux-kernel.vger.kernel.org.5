Return-Path: <linux-kernel+bounces-125106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96314892033
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79A41C292B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74705130496;
	Fri, 29 Mar 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjViRqzn"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02455535C6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724471; cv=none; b=h40uu+3pOojZxUSMCah+ZbAjIcKE2HjMouOuI9Nsb4Qg/iT589+Rca+AlTC2VtT0shH3sVPgqDq7nff/StuWV5Bi5Yp04jEoOewYSKWPWp6fDL1kD3AbdculEPoEY+XIeUhMeK4DWUu7gkdNfzJKcDzhYF5GFTpr9I6uba4IyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724471; c=relaxed/simple;
	bh=ffdHJ38YwyVCLmNFOjiqvMFT3PDctpIMfDS+lYCox44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwD/dEz1O10Sh7TVWGVfblhCs52O7ttht0kqJ7n6aAhzaNqSvyjxZqLV7BOuppQ4DiMhj7JDHe4aeJ4+sv8BMhSiTuWMQ0c4OsKvQUQ5tHtCxDATcuutgJsXxWSjo/qN3Ly1DMXjtx5+GRfh1G0GTpr8nNgxYXLNXGvbJcbz+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjViRqzn; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso40247339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711724469; x=1712329269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtoEDyZIOtyf1NNzpmG9xc+HrwPC7aA39C/nFjVgExE=;
        b=XjViRqznjIrrjk9eo96ZbLoNSR2rTPfkV84nnZA5wBh1gWdC+Jglr39tQW5zS7Q/mT
         I3yvyKKAFIk0/SFbnoQ1oKN2scsZuQa+lwEUUxWdE57rNArUybU7HEKr+QVRwTZUEypo
         Pi7TmKcgy9oc7dXbPJvLdQ4GwJvMbuq6L8O5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724469; x=1712329269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtoEDyZIOtyf1NNzpmG9xc+HrwPC7aA39C/nFjVgExE=;
        b=kqKKGTCkunpW48pymHTkO18nZ/xWWwRju86NXTk8fW+XwHOEDW1+LILi9FpVR+QwdQ
         23hKFqzgDK8gLUN+v6itoJxEclLZZe1E128YkzFpFLv5k99s89PD9uYJiVOBb6D2TKES
         RTw1TyQkTS3Zgt3z1dVMpQeWkD4ZnpLPxJhIfURShIwdzZ/VPEZdlN4k4BqTkTLXepZO
         W0e8oQmwHLlYxX/rEhQ4eu6a7OD6OrEc3pVyUcR0yUp25nkunURipb9tfuY1Me+pEbSK
         i4+4H8X/bQUQ3JHEgnSiEdYHR6co1UOiIyjQ1aLNJ8x+iIWd75kNNVEYex0WthQCl/NC
         pP0g==
X-Forwarded-Encrypted: i=1; AJvYcCUSXGaeMuvVdaqKaTE+OjLkLBTjv8MWelh2AONzu0ehJYf9bizyW4JKZ9CcATZRyx4PZsH0If76rQ/RIVfw1zWASEWJTZzqP940fUBU
X-Gm-Message-State: AOJu0Yw8r1rLz2pU6ix7CepLdzb9jL+wND2M2ud7+FM0XKBrt59aB5eo
	7UIBlk9BQQRwOQk9hu7GPqifYNxRYYWmYRL7nnge9k/pcQTZg9rusyFmqwlqd3w=
X-Google-Smtp-Source: AGHT+IEsg/ZZqDBbVwkvLa12KFDitUrXoXtj6hRWutQdOzYWvVyuAe79yZsw8QVMun+yJkJvJshGLQ==
X-Received: by 2002:a92:4b11:0:b0:368:aaa8:f557 with SMTP id m17-20020a924b11000000b00368aaa8f557mr2132805ilg.3.1711724469043;
        Fri, 29 Mar 2024 08:01:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h17-20020a92d851000000b003696b5f5662sm134109ilq.49.2024.03.29.08.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 08:01:08 -0700 (PDT)
Message-ID: <70698a24-3794-4621-ac74-7aaeae01a750@linuxfoundation.org>
Date: Fri, 29 Mar 2024 09:01:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Ingo Molnar <mingo@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>,
 kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
 <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>
 <ZgZvaUbZIr0qpxK5@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZgZvaUbZIr0qpxK5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 01:36, Ingo Molnar wrote:
> 
> * Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 3/27/24 05:17, Muhammad Usama Anjum wrote:
>>> Skip instead of failing when prerequisite conditions aren't fulfilled,
>>> such as invalid xstate values etc. This patch would make the tests show
>>> as skip when run by:
>>>     make -C tools/testing/selftests/ TARGETS=x86 run_tests
>>>
>>>     ...
>>>     # timeout set to 45
>>>     # selftests: x86: amx_64
>>>     # # xstate cpuid: invalid tile data size/offset: 0/0
>>>     ok 42 selftests: x86: amx_64 # SKIP
>>>     # timeout set to 45
>>>     # selftests: x86: lam_64
>>>     # # Unsupported LAM feature!
>>>     ok 43 selftests: x86: lam_64 # SKIP
>>>     ...
>>>
>>> In amx test, Move away from check_cpuid_xsave() and start using
>>> arch_prctl() to find out if amx support is present or not. In the
>>> kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
>>> backward compatible.
>>>
>>> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
>>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v2:
>>> - Update the changelog
>>>
>>
>> Thank you - applied to linux-kselftest next for 6.10-rc1
> 
> Please don't, I've applied the patch to tip:x86/cpu with a tidied up
> changelog.
> 

Thanks. I will drop it.

thanks,
-- Shuah


