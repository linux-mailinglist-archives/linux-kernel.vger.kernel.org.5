Return-Path: <linux-kernel+bounces-157320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD198B0FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4361D28B29B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2B161B7C;
	Wed, 24 Apr 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f6VcMYOv"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D116190A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976085; cv=none; b=TMSXmTqHOTKJm2wSfBIoMnqx8FC24IsjG7nu+LOGfjIf6xkAWdSGsVARQWv1nqW+mrWHFeqsbOu20CMACZULhfivlv8VIfy6FK+8NJH384ef+59w7FbjefzaTpjWzrhjoGijoTVZPhXKDiKEBGScXCNEM56o5KfbK2OjEyiBYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976085; c=relaxed/simple;
	bh=V74XErXb5mOshzhsLFALwFLRBHGhL6q3WN4ByroeZdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuP2sB3ic8k4+VIkicS0IAQ5aLrvhFEW9W67jaM5DpNHnd9DTZO4gilNwV3y+iB85gRUY17Sk14pfxwlJ2Kr+YzBxjelBAGduDUQ7M+/7U2pw2xF6OwjaeMfiVKB+BfzgFRyWDzKlIX+vDcOxhTBUiEGK6RolGRBXMPRgb8/6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f6VcMYOv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f055602a7bso13022b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713976083; x=1714580883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dt2KVRYxDBRXLbNK/m8PvF4OR+Oty/TNCiiqaQpoANU=;
        b=f6VcMYOvL5uCOryEBMw9sLKprQ201cbcO6UMDm0li4CkuUHqswl+bHX9phTQ5/Y38n
         8qnvxoaXtlJH9BDwob03RLA5SkohiK104hFodM6QotNogJEYyGsiraQZhF1e0X6ylgtI
         RK+d+lpmqwDcmfUzM8zglbqlPjHSxj9iVR5ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976083; x=1714580883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt2KVRYxDBRXLbNK/m8PvF4OR+Oty/TNCiiqaQpoANU=;
        b=CFB2TIKviYgrVPdZzjF6Bq4/8ZW0fM1we14WL4/3BcopFuvUZOYKfnhZoUALLnHMez
         pF18RwMOl01nU9HoLufA7y8TiOO81I+aXKM/Lm7p/DcOGrV93Huhs/vUQHEF4NC+Qbwr
         /ZarQnNfXUuD+RNSU7SspUMqFUCuiVBsh20/fqE0kWJkLYWh/6Lvv7A1hHlMHOShVJv7
         CHBrNqQpfVXBZqSOMMerfgwbpKeuvIeLUqshyW0T3aD9I06tdv+2k/O1DHUFCepKSMBm
         KYJG0CBmxdgoAT+YC8FGjSd7sP7txQwk2cXO5FpUYtwL1MZIjtTtK1Nka3pVmfG6sabY
         0bIw==
X-Forwarded-Encrypted: i=1; AJvYcCXkfDTpfw0+qtvWSviGdHV5A6pRkRylKJDrNkEZ9pHgFW3N70ZT3YUM/j6eKMUUmtW8xNR5jmW8GKFcQlbDpP6ckFNRj9CW8tSqlfZr
X-Gm-Message-State: AOJu0YyIkiRJmAa6uSUIBppuZLxEYSG8Od3dySuxZAfN1ZHsDKtrSxjZ
	XtDZlhZHz9LvDDsVRryORUw7lkEMCkf/fojthT2tjmRiUxPXtJGx+aOBr/AF2Hg=
X-Google-Smtp-Source: AGHT+IEM22IfPFG/x1imwFqf85wR7jBR5YFXWlluajTgpg+q7Vh0S2I3mIE4aEXTjGeND0JxII15uw==
X-Received: by 2002:a05:6a00:898a:b0:6ea:b1f5:8aa with SMTP id hx10-20020a056a00898a00b006eab1f508aamr3276274pfb.3.1713976083513;
        Wed, 24 Apr 2024 09:28:03 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78648000000b006eade394613sm11622481pfo.198.2024.04.24.09.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:28:03 -0700 (PDT)
Message-ID: <9cceb519-e627-4041-bbd4-227e47d5d209@linuxfoundation.org>
Date: Wed, 24 Apr 2024 10:27:59 -0600
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
 <ba14458b-8f69-4947-ade2-d77e3290d4ed@linuxfoundation.org>
 <20240424161059.GA904896@dev-arch.thelio-3990X>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240424161059.GA904896@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 10:10, Nathan Chancellor wrote:
> On Wed, Apr 24, 2024 at 10:00:12AM -0600, Shuah Khan wrote:

>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>>> ---

clone patch

>>>>>     tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
>>>>>     tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-

ipc patch

>>>>>     tools/testing/selftests/ipc/msgque.c                         | 11 +++++------

kselftest.h patch

>>>>>     tools/testing/selftests/kselftest.h                          | 12 ++++++------

membarrier patch   etc...

>>>>>     .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
>>>>>     .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-

>>>>>     tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
>>>>>     tools/testing/selftests/mm/cow.c                             |  2 +-
>>>>>     tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
>>>>>     tools/testing/selftests/mm/gup_test.c                        |  4 ++--
>>>>>     tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
>>>>>     tools/testing/selftests/mm/madv_populate.c                   |  2 +-
>>>>>     tools/testing/selftests/mm/mkdirty.c                         |  2 +-
>>>>>     tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
>>>>>     tools/testing/selftests/mm/soft-dirty.c                      |  2 +-

>>>>>     tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
>>>>>     tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
>>>>>     tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
>>>>>     tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-

>>>>>     tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---

>>>>>     tools/testing/selftests/sync/sync_test.c                     |  3 +--

>>>>>     tools/testing/selftests/timers/adjtick.c                     |  4 ++--
>>>>>     tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
>>>>>     tools/testing/selftests/timers/change_skew.c                 |  4 ++--
>>>>>     tools/testing/selftests/timers/freq-step.c                   |  4 ++--
>>>>>     tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
>>>>>     tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
>>>>>     tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
>>>>>     tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
>>>>>     tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
>>>>>     tools/testing/selftests/timers/set-2038.c                    |  4 ++--
>>>>>     tools/testing/selftests/timers/set-tai.c                     |  4 ++--
>>>>>     tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
>>>>>     tools/testing/selftests/timers/set-tz.c                      |  4 ++--
>>>>>     tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
>>>>>     tools/testing/selftests/timers/threadtest.c                  |  2 +-
>>>>>     tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---

>>>>>     tools/testing/selftests/x86/lam.c                            |  2 +-

>>>>>     38 files changed, 81 insertions(+), 79 deletions(-)
>>>>>
>>>>
>>>> Please generate separate patches for each test so it is easy to apply
>>>> them and also reduce merge conflicts.
>>>
>>> Is applying 30+ patches easier than applying just one? It is not a
>>> trivial amount of work for me to break this series up into individual
>>> patches but I will do so if you really want me to. I based this on the
>>> kselftest tree directly so that it would apply cleanly.
>>>
>>
>> I am not asking each file to be a separate patch.
> 
> What granularity would you like? One per folder in
> tools/testing/selftest (i.e., clone3, ipc, membarrier, etc)?

Correct. It will be 10 patches. Please see above for the split I have
in mind.

thanks,
-- Shuah


