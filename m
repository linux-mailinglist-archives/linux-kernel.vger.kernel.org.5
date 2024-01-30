Return-Path: <linux-kernel+bounces-44725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10F84268F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31201C2435B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B46D1C9;
	Tue, 30 Jan 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvOEngd6"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAC6D1B1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623311; cv=none; b=k+Ph+YnGXJvsP/MRYWwpq3J+PlW7wkBI6wQ4K18Kq1ci5F+3cjdnFNpg+KFWwDfBiP6CZjVDTbvOK3kYC0K7TjPcNftbg/7AqsVaOktep0TBJM37R4Pmy7YYmftcysRLpFCcyKTf40hWIm3zA3CViw5Y+OfIfN5F2Ep4eAzh/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623311; c=relaxed/simple;
	bh=6DCS0Oj55OflOp7nlHnePCZnOAMysSY8w/6eTlboMdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/CCFm/EFEPPAJ1NQbaUqQhYiCQsvbJI0WYUbHkCJ6aKgKZ22fQSxB3yfEZma8d8xIOelv9RFGnnfpb9ekaZbd8iSukh2MBwX2DStkwEuu2fPUdUoZm1aPsuclPanIabz8AiyAz6+5HLZbVtmOqjs4nhqOTivQxzNA2t8qLiM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MvOEngd6; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d2c21d77afso2953894241.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706623309; x=1707228109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhWdASthvpkbvQ4KQAM9U5VqvXZH5mkW6c06Mi4APZI=;
        b=MvOEngd60iuq0mgyvMxpfCyaYMQ6tQu5LpZ+7RhdAlAwoC6ZNT+buzXKSiznhE/x0Z
         zNy/n2Up/F+F5Ex0ulDNt1xWS/eW90fXHWnwTEwQMIwbObZXc9H78mJeDFjWg/TrzNyA
         sdXzlo3N8YwukkS856R3JfLPV+UsTdAvA4TU+5ojhj4RM3I8Bgn8pFjxZjYOFz2b/hik
         GxoxsAfUcGYQCPDPIUDhrpbBr36v7beHHHgI2SXnv/c9Kd/pfzxLjYaI7AA7DclWPllC
         e6spo0uc2QW86i2OLxq7ZSiInQNate12a75NullwUUECHd+xO0S5ceyZ8gOkJHTAtqsO
         V7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706623309; x=1707228109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhWdASthvpkbvQ4KQAM9U5VqvXZH5mkW6c06Mi4APZI=;
        b=GE+8knxXGGtIzqpiVXNz1RUyqB74qxwsfua2RlNwUj+cF8RvydMs/dAmacGVXZLZ5a
         03pqq3DjrPhtjst9j7BS7/WoCYDadSq1Cl7PQULeAFAUYVTw220lRFWWP4tUpnvPtO3c
         mFAaOJDQYB2999zHbkB6yNpaLb3kJK2yV4nrATmGxxzC0y5BBqQ/nzsRamUjvl7PNU9A
         AvAkkeV7H5S5wBRW6oYbOS5mjd9k/0e6LfsIid/EhAi9aWU5tZ3HgBmw9sbwuHT5GuDk
         oKsBzkwE46XmBxkIUjgkD4iIgqRz5F6LrCU28x6uRhogxLmGGjA2zbDGpOo5p3fTWerv
         EN0Q==
X-Gm-Message-State: AOJu0Yx102zuU0PiSG263NM+ZpFkZH089K4jyU+PLMV93Ldu23FWt1u6
	f2XX3BJnD2bcsncdJoQYfqFvmUKKLS7TW21R5E62drd+LW5xPdCCXhaoy+2MA595PX5/p/+v8nG
	1+jGNtXR8FEgMAbNNiXgOJvjYdQgotK1JsEN5mg==
X-Google-Smtp-Source: AGHT+IHf+VS2jFrbSbjXX4kagP4nzGXxze3Kp7IrRANN49qQrr75JeajfFzbIK6dPJBvnyJ9cOn0MqcJ4YAMmlsMSzg=
X-Received: by 2002:a05:6122:218a:b0:4b9:d307:b34e with SMTP id
 j10-20020a056122218a00b004b9d307b34emr601837vkd.10.1706623308572; Tue, 30 Jan
 2024 06:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170014.969142961@linuxfoundation.org>
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Jan 2024 19:31:37 +0530
Message-ID: <CA+G9fYtijU2v+UnPP_C-nxaOBWL54GVbuhPkEWz+gUQ28sLuaA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 at 22:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.15-rc1.gz
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
* kernel: 6.6.15-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 1ff49073b88be8a41ff42ecbbc2bb82e18783a7e
* git describe: v6.6.14-332-g1ff49073b88b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
4-332-g1ff49073b88b

## Test Regressions (compared to v6.6.13-581-g86b2b02ae53b)

## Metric Regressions (compared to v6.6.13-581-g86b2b02ae53b)

## Test Fixes (compared to v6.6.13-581-g86b2b02ae53b)

## Metric Fixes (compared to v6.6.13-581-g86b2b02ae53b)

## Test result summary
total: 155176, pass: 133177, fail: 2238, skip: 19572, xfail: 189

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 44 passed, 2 failed

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
* kselftest-vm
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
* ltp-fsx
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
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

