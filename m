Return-Path: <linux-kernel+bounces-93768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B71873450
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1979283CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF75604D6;
	Wed,  6 Mar 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0PU2SIA"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA05FDAF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721205; cv=none; b=Te5XBTJ8YxGJNhUPHYyt5uUUqCm1bjf+qJk8PK4Dgcd90hRDVGfErzljc+3yHxol8TOZDq3lbUrIcKp/QlN4PMHTUyYk8KCAzmzXUixUz5c6fZ/UpuFQrzYCAHbNNEa597NfH0Hncza193gCL6t+WoH3vc+r3IJVUnjsmyBCNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721205; c=relaxed/simple;
	bh=r8I7d25oS9grIAnDMBNqKWHgDV8KDouDSkKqAk9Cgqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqGjJhJA6QLCHWr+NZvkpAIsYeGVRRzEX6BztUIRzSyvKPbpjIBNdPno4AIDwQN6Ru1q6NJoNLJzUSTdoRCpEGUdeqtzpYHfcg5FAWDPCoHSRMI1l8pBYDhZxyoMZQfCgVqd28dabiqUSuNQIv/K9/+c8nzXqrzX7G77YYR2ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0PU2SIA; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-472640aba12so1544763137.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709721203; x=1710326003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFkaMIm1obtudGJ1kf1EFFHAyCZ7GxqkHja4nTwRsKA=;
        b=C0PU2SIA3qaEwyrBdfLuRX5MBjFNkJ/xqs3aZufVTsXCaoxBVcNnPjnkRLZRkaU78f
         L/iU9qDQiNMj24lg5aZPdma/srV1UaulmY2Ifp3/LcHTu6zuOV3pLWG2Jwc/rJE/iYIn
         WDPytyAa8tbbt2icPrCMzgo8eBOnd/+MgkCijzxEx54uOVWhBcKNHZk7QyJCp6cD/VGc
         5CiUJE2tRI+YKJD/vRduNffdjaUryUReCOgWmP/Cwg9D93ZQFvMfiPeks/cDACjwvssV
         SyYr8+1B5Y2Ypaxfi3fWZTeXNU3ItOzk8otfvly/LD9DlgJRsoCKgub/AtpJqKunuu0d
         IyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721203; x=1710326003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFkaMIm1obtudGJ1kf1EFFHAyCZ7GxqkHja4nTwRsKA=;
        b=soFQDQqEGXJYTfo4KNuStxK0tcOwM+hDxugespwMY1cxHP9eHcimCDtuDA5g31Hys/
         1LoklE4kHE3EAIVIQisDGjUomHJEDG4VFlP9ECj14kVKcDeV48RqRVzQL/mC3pigBIaF
         eRO2MYv9gL/hvWJ2W+NOgMYgXcFiiunzOeob88rQYe3r25rvcS34fROV6oNU2KKHO5Wn
         qKrG+tPum5ghk1+9F1hvtNbham7Dmv3v99hFH4qLo+u0+q+tEx9T1W09GjYUy9ibsnSH
         4bvfQRQrsNWJLVIPEktztPOuiNdGQO2pHsWtUM1UhbQnxYcWZ2uxnmRo06kojgON71pv
         mFuw==
X-Forwarded-Encrypted: i=1; AJvYcCXNM9M5er2EPZgULiS2hMiub/JnqN+YekwdBSdu7Vvu9XATsXxBG7mPmvPyIHcKTpx6PiSxmK+RSyfR9RZT9lVuqnpRvcrqb2YfqpPM
X-Gm-Message-State: AOJu0YxU7UGiZh0DKj1uCtgLY+2+eaNp90sqCuumxgLgY1BApCArvz9H
	v7ZTiB81sbVkSM9mobUAkHpmIyAfZkkqrNVAQxFf7F0tZIGTmJWyGWqIQPX8KRvDnY0c+OJCGtL
	gEwl0HQoJSCTnDDAv7RtMdHFjCln9XkD44dCXGw==
X-Google-Smtp-Source: AGHT+IE0x77S84TtLxcOdVNEf09H8CAh/J0+qhX6uQO+4pPNNBGqMdIxF9axcvTED4L7HLfrhT+Eebw3d0oNaEqcLAk=
X-Received: by 2002:a67:fd8b:0:b0:471:e8d5:8c8c with SMTP id
 k11-20020a67fd8b000000b00471e8d58c8cmr4596459vsq.26.1709721202759; Wed, 06
 Mar 2024 02:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211556.993132804@linuxfoundation.org>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 16:03:11 +0530
Message-ID: <CA+G9fYvcS6gy_-pbiqwFoJh=s_ocLGh0TSZR-zNiTSh9smZWfg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 03:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.81-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: cf578ac947cbb5bb72cbaa7a166d0f92318c3126
* git describe: v6.1.79-411-gcf578ac947cb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
9-411-gcf578ac947cb

## Test Regressions (compared to v6.1.79)

## Metric Regressions (compared to v6.1.79)

## Test Fixes (compared to v6.1.79)

## Metric Fixes (compared to v6.1.79)

## Test result summary
total: 142733, pass: 122117, fail: 2309, skip: 18166, xfail: 141

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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

