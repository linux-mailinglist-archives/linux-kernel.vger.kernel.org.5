Return-Path: <linux-kernel+bounces-93930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74901873710
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC0D2813E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4EB12C53E;
	Wed,  6 Mar 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEEOSUi1"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918923745
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729768; cv=none; b=P/kIiO/3WGoHzCs3zZ/sjBD/WmvX1YYuGQoEMe7VajgEgjYK7vJvG415lfLU/AYEN3/871ceBWK2yqAkmMUOz2GJ0EPIHi6nImvKBR51lR1nSxtE0g8BEDYAsk/auIPOnVXIwByBDOxy6tShANoGoXmRe197rVWohIYXuhtwfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729768; c=relaxed/simple;
	bh=PgHt/os8BmHr6ku0XPfx09raukbvgI1JM8YKUigkwqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArIbKt8u0j08oXPPf2GYeDyzdQAo7Wl7F7KmCWKqH8uTQuxNRxOl+rkcKqCzRVKmXa24rQQ16QKJqUW7QOuILxVVc9QaeGz1UKJkjhOm5jpouVkK+ViJ56qFObe8hKqP1aoiuNzrEiwu5FHZlCD4p/WW0O+73zDadTaJ+d8t4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEEOSUi1; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d367dadd14so783353e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709729766; x=1710334566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF51TmcU3SYCWdS+xut7sKhWkD9/Cw1BL/jjWneKjIw=;
        b=xEEOSUi1nYSQQibeYAe5XHCnSljYTAapCekVtIG+OWuZWOBUv/cM+hzWT3/jtVQ9ro
         u30IxDV4Ens0zed/T5Hp6YVBdIsygUK5pv4JUlJquNxHYqJTfF5Q9lOkuCk5FEzFnNl3
         jpK7DnydXdqmPYXPGD0b3fMijmA5hbbdNhNEY9XCtoCC0uC3oQ8PGUWsNoojC5diq5uS
         932WJOsZR0BfbbdNdS0JDQnoEqO5ihZe6YIeMS4kuQs0O6R2n3C68dGJ/IAQDkSwbNpg
         SasZaVKgW9K3bU/hXq901hhS09PA9zYLRBsZt9+K4ekT6L7UON32TRAMxmysooKFmbLL
         KLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729766; x=1710334566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF51TmcU3SYCWdS+xut7sKhWkD9/Cw1BL/jjWneKjIw=;
        b=vUiO1M1uEr1xWwwjG1UqIs5KMGiYQrymvg2dJ5Fcq74t0e43+/g0D6qksvVq0nWqoC
         JSjdxLFETXBGyox7ElDH6iOwGbDuw3+SvPWf6MCEG1SMefljfVkYKOWNLCxPta8Qo1gG
         4qbbs3clQ08z/AWjmFaDt96SLfrxQn6sDcu9T9ASZm+aHK6Se5NDqM6MThCN9aetrP1U
         yeMnRF8DVJW8HWcFvh9jFH4BE6ZdOPRpfhuruOUZX7ntE8WRYT5fWbjTqVWoxXL6GLgc
         V2/V6Wtfv/84u1fYi2GHvTCVrTXaSmvfPlKUMvvhPJINTlgvt93RVHFgMM/mA5Zqwoj3
         qwSw==
X-Forwarded-Encrypted: i=1; AJvYcCUGyoiHafXWiDX3iDgCVEuHZs8CboAZfR/eM2+L3DMIgxW6AOlG0kuRIiFAre540FJgB/9h+zyU3cwH4kgRntwZ/DGloVFfb9IqKNla
X-Gm-Message-State: AOJu0YwsGaq/X175H00oyOBimUn42r4osDMg8cKetN+Nk6ZpOVHaAU3l
	9alf+lWkdxI5jryw43aDijR7tYv+7F8HxUj/WuiYsioKFybXvpPR57C/rZBkTEKMilYaQLcClc7
	G+LGBKC+CBie1nOTA1M9BhFUjEr38uUH9IQwYtw==
X-Google-Smtp-Source: AGHT+IGYfA7GXwmmA55ca5fewYia6cPXDbMo0V4xJFmtFcpijfX6V7O8HrKJ4j/b4c4yZ/koOoyYa9hnBv9GtCTyue0=
X-Received: by 2002:a05:6122:3683:b0:4cd:b55a:bb0d with SMTP id
 ec3-20020a056122368300b004cdb55abb0dmr5608477vkb.2.1709729765868; Wed, 06 Mar
 2024 04:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211549.876981797@linuxfoundation.org>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 18:25:54 +0530
Message-ID: <CA+G9fYvTnAyEt-Cn7fmXQ2FK3+xLyOULmcxhrk7dMTypckDEsA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 03:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.21-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 5f9255b6ac459ba1b98dfffa0680a5700447d28c
* git describe: v6.6.18-445-g5f9255b6ac45
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
8-445-g5f9255b6ac45

## Test Regressions (compared to v6.6.18)

## Metric Regressions (compared to v6.6.18)

## Test Fixes (compared to v6.6.18)

## Metric Fixes (compared to v6.6.18)

## Test result summary
total: 168781, pass: 145491, fail: 2395, skip: 20734, xfail: 161

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 132 passed, 3 failed
* arm64: 43 total, 41 passed, 2 failed
* i386: 35 total, 30 passed, 5 failed
* mips: 26 total, 23 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 28 passed, 8 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 39 total, 34 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

