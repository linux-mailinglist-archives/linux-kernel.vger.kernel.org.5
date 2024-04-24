Return-Path: <linux-kernel+bounces-157287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB78B0F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1F3B30C71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88DD16EBF2;
	Wed, 24 Apr 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qjzz91bB"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EC16E887
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974422; cv=none; b=P8yC7uuApF592WSqsqYY1eKInwam1UtEFNaJJK8Flp+7s4oOYnnAdIvX3juToxr4YsTrLsbz9v4YkVqQKAy8We+F0RtRTfKcGeIdoPWOaRiiBpdfCUW6B7Kjbe9rXaq9eTt9cJyN/k8KhMzJ1d+0xQdZfUc1mqCFH7xfFgxQSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974422; c=relaxed/simple;
	bh=xoLdkUYFk5RZBDCISpGx424cY6NvUVaAOejPC6YvY0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQOi68KgtufZP304f8z7n6cpqxBYW7VeYiqy+tKGsKtQstudqDb6Nay3U6LlhanRQ/sMDojytG+uv4Y88i5LE0SYfhu/kmk3qugoQsYDCPNSTYJ3X4W+cFvuYwNSl68Gkc8LYgkLOVbi1noayQRCfgKGj/O0TeJIMdrghhMBW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qjzz91bB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ab936993abso9108a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713974420; x=1714579220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35eDMi2/q83wJ4GUHa2jqX6/eKKmPqQTJX+6m9vKCdE=;
        b=Qjzz91bBmBLu/+gQvaTQVvlx6fiVbcQhjVQtHUX0MfBd8ALX7Lpa8mS1G+lSt4Es0Q
         xgtjvai5Qy4rGSglhkKvUVR1bNNCrLlicrOWWY54shdLQRy5IceyZNWRL5UdAQCt2bXR
         c8SUYoUd5zvLClvKUm5gr4ra0IdQXvPIQhBj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974420; x=1714579220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35eDMi2/q83wJ4GUHa2jqX6/eKKmPqQTJX+6m9vKCdE=;
        b=qW4aCRNHP7Ug5UunLjVPdXVzbHqCbiEhT6DFcTnIrzmeodWlKORPVjRVnGOQXaoReo
         kg/jKdtXP9Fd0pKeyaGLUe5SReSZMyD1zr/rdrrf4tm6SKUMbokz4dmQ+EGLg0XPDNsu
         eUpaqtDf0xDK+wSK2d+FsoTdqJQ1qndIe4wTLdZV5ZLc7YWe82Fu10i5qHvuaKO2GcJs
         CJqKwO+n7TCQ0tcEmUepKYlJHi6X9gi+HDgJNA1bvG7Nld0EcRHhsJDOvfrwr9cTDnSV
         aG7NssYs3wsUm612vWx4+TT+IoNHf+Nly+EOK/0vChlNMgibzGOhawcP8+4CGn2p9V+F
         dadw==
X-Forwarded-Encrypted: i=1; AJvYcCW++cmlhxJ3Ypv1nVyqys5clVCpm3wRPHw5oO1eO1Db0Id54V6i4gduOcATEuBwT6Mq22RprdXOC1LMp7YILIbOzau7jIRd3fAHkSnq
X-Gm-Message-State: AOJu0YwLVYmaAQ/TV4oK4KAOsu7LiuZ4X02RK/ofDD0mlk1F/to89gMI
	0fhBVPdmra38E5Npf1Bd7RvgzEYG78+RVU4grF630VsGjhjsrGhnseGbfw732ljzgU4iTMCMqIs
	7DINocA==
X-Google-Smtp-Source: AGHT+IGeah6Znyank5/1D413kUlUkY/1RPj9CkwgSALF8YxSMDdoqn7V4afIyUbB8wHmTj8YqHpqQw==
X-Received: by 2002:a17:902:b095:b0:1dd:b54c:df51 with SMTP id p21-20020a170902b09500b001ddb54cdf51mr3044405plr.4.1713974420201;
        Wed, 24 Apr 2024 09:00:20 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001e81c778784sm12047040plk.67.2024.04.24.09.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:00:19 -0700 (PDT)
Message-ID: <ba14458b-8f69-4947-ade2-d77e3290d4ed@linuxfoundation.org>
Date: Wed, 24 Apr 2024 10:00:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Make ksft_exit functions return void instead
 of int
To: Nathan Chancellor <nathan@kernel.org>
Cc: shuah@kernel.org, tglx@linutronix.de, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
 <bb5fd480-bd43-42c9-b326-2ee7addcda33@linuxfoundation.org>
 <20240424150513.GA304587@dev-arch.thelio-3990X>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240424150513.GA304587@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 09:05, Nathan Chancellor wrote:
> On Wed, Apr 24, 2024 at 07:44:31AM -0600, Shuah Khan wrote:
>> On 4/17/24 09:37, Nathan Chancellor wrote:
>>> Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
>>> unconditionally call exit() as __noreturn") marked functions that call
>>> exit() as __noreturn but it did not change the return type of these
>>> functions from 'void' to 'int' like it should have (since a noreturn
>>> function by definition cannot return an integer because it does not
>>> return...) because there are many tests that return the result of the
>>> ksft_exit function, even though it has never been used due to calling
>>> exit().
>>>
>>> Prior to adding __noreturn, the compiler would not know that the functions
>>> that call exit() will not return, so code like
>>>
>>>     void ksft_exit_fail(void)
>>>     {
>>>       exit(1);
>>>     }
>>>
>>>     void ksft_exit_pass(void)
>>>     {
>>>       exit(0);
>>>     }
>>>
>>>     int main(void)
>>>     {
>>>       int ret;
>>>
>>>       ret = foo();
>>>       if (ret)
>>>         ksft_exit_fail();
>>>       ksft_exit_pass();
>>>     }
>>>
>>> would cause the compiler to complain that main() does not return an
>>> integer, even though when ksft_exit_pass() is called, exit() will cause
>>> the program to terminate. So ksft_exit_...() returns int to make the
>>> compiler happy.
>>>
>>>     int ksft_exit_fail(void)
>>>     {
>>>       exit(1);
>>>     }
>>>
>>>     int ksft_exit_pass(void)
>>>     {
>>>       exit(0);
>>>     }
>>>
>>>     int main(void)
>>>     {
>>>       int ret;
>>>
>>>       ret = foo();
>>>       if (ret)
>>>         return ksft_exit_fail();
>>>       return ksft_exit_pass();
>>>     }
>>>
>>> While this results in no warnings, it is weird semantically and it has
>>> issues as noted in the aforementioned __noreturn change. Now that
>>> __noreturn has been added to these functions, it is much cleaner to
>>> change the functions to 'void' and eliminate the return statements, as
>>> it has been made clear to the compiler that these functions terminate
>>> the program. Drop the return before all instances of ksft_exit_...() in
>>> a mechanical way. Only two manually changes were made to transform
>>>
>>>     return !ret ? ksft_exit_pass() : ksft_exit_fail();
>>>
>>> into the more idiomatic
>>>
>>>     if (ret)
>>>       ksft_exit_fail();
>>>     ksft_exit_pass();
>>>
>>> as well as a few style clean ups now that the code is shorter.
>>>
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> ---
>>>    tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
>>>    tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-
>>>    tools/testing/selftests/ipc/msgque.c                         | 11 +++++------
>>>    tools/testing/selftests/kselftest.h                          | 12 ++++++------
>>>    .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
>>>    .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-
>>>    tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
>>>    tools/testing/selftests/mm/cow.c                             |  2 +-
>>>    tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
>>>    tools/testing/selftests/mm/gup_test.c                        |  4 ++--
>>>    tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
>>>    tools/testing/selftests/mm/madv_populate.c                   |  2 +-
>>>    tools/testing/selftests/mm/mkdirty.c                         |  2 +-
>>>    tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
>>>    tools/testing/selftests/mm/soft-dirty.c                      |  2 +-
>>>    tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
>>>    tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
>>>    tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
>>>    tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-
>>>    tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---
>>>    tools/testing/selftests/sync/sync_test.c                     |  3 +--
>>>    tools/testing/selftests/timers/adjtick.c                     |  4 ++--
>>>    tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
>>>    tools/testing/selftests/timers/change_skew.c                 |  4 ++--
>>>    tools/testing/selftests/timers/freq-step.c                   |  4 ++--
>>>    tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
>>>    tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
>>>    tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
>>>    tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
>>>    tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
>>>    tools/testing/selftests/timers/set-2038.c                    |  4 ++--
>>>    tools/testing/selftests/timers/set-tai.c                     |  4 ++--
>>>    tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
>>>    tools/testing/selftests/timers/set-tz.c                      |  4 ++--
>>>    tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
>>>    tools/testing/selftests/timers/threadtest.c                  |  2 +-
>>>    tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---
>>>    tools/testing/selftests/x86/lam.c                            |  2 +-
>>>    38 files changed, 81 insertions(+), 79 deletions(-)
>>>
>>
>> Please generate separate patches for each test so it is easy to apply
>> them and also reduce merge conflicts.
> 
> Is applying 30+ patches easier than applying just one? It is not a
> trivial amount of work for me to break this series up into individual
> patches but I will do so if you really want me to. I based this on the
> kselftest tree directly so that it would apply cleanly.
> 

I am not asking each file to be a separate patch.
> How does breaking apart the changes reduce merge conflicts? The diff is
> going to be the same and semantic conflicts can still occur due to the
> kselftest.h changes.

selftest patches go through various repos. With this patch touching
several tests, there will be conflicts with multiple trees.

If this patch can't be split due to dependency on kselftest.h, I will
pull it in, but I do need you to include all the maintainers.

> 
>> You are missing maintainers for clone3, mm, pidfd tests. I can take these
>> through kselftest tree, but I need the changes split.
> 
> Fair enough, I should have CC'd them, although given this is a change to
> the kselftest API, I was not sure they would care too much.
> 

The reason for cc'ing the maintainers is to keep them in the loop about this
change that could result in merge conflicts between kselftest tree and theirs.

Besides I would rather not have developers make calls on who should or shouldn't
care about a change. :)

thanks,
-- Shuah


