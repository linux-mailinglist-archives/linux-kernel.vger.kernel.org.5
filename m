Return-Path: <linux-kernel+bounces-84718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C680186AAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0A2B269D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F72D05B;
	Wed, 28 Feb 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0+LQ1TZ"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B72D60F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110931; cv=none; b=kfCdeOx656wm/Qe4g1ERcWiUjaDYwsk2UWKULfiBtAGeAh5y4FHtB0Zzp91JB6rru4ubxNonbSGmGngl2u4NXM7rhvzeqtRaG7bzXuogUyCwp1NQmcnZXpyGpynEatAUetdN9Lt59GfMyVfKx7Terope3sChZjUJpjdyE20kRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110931; c=relaxed/simple;
	bh=ZMaKOz4kgMNNRt2VxWzeT8t81S2VAk8T72wyHWXGDb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg7xbPIq+YKPD/J9ra4pJ24dZxiMuLqmLURwmLDDFaodUGCGcLOYXBC9nP/IdyKFVV72q9rn8OXvlXMjyr9QDl7+p2VnY+zvKfnchjwVP6sJHym3v9Uf14MOejRWdZyGaPpMrzIgPizhe5V6rOQWnuiNVZl14v5sMe0e5b3OthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0+LQ1TZ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so3483899241.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709110929; x=1709715729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWY0BBSyws6wCr0c2Mm0akqjikh7cNb+jYcFd0PutUs=;
        b=X0+LQ1TZpXXKlcAR16CoeWSzWogsJGBGt5UtddL8Llc/vAeOrK0rZslMGgQ2FQGBvV
         h+llcO+yzlFmFvVJGbeVec0ApCf8SIj0pHJlyWQba3EMH8tUMtfbPrbpEmA+9P8p2wuB
         Y1R1dGpjYfj/Tas9nM8Zvf86zxW+NL/zZuJUI/JoCbkFZ0Ur0u+i/R+07z5DKEHqoR2L
         TKjoK23NApIiS1pqxP5J3lWMARnFfrtzgBjOUdK72oIdh/p9eZ33kWdV8bhjd9z/Vg+W
         FU0kQEGjPrbY4YeA8Rc05ZJaWHPg4IteVu/1rDe/xXwcd+/QlSu46Dnm7s82HwvmTLAP
         DMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110929; x=1709715729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWY0BBSyws6wCr0c2Mm0akqjikh7cNb+jYcFd0PutUs=;
        b=hsJFSSTjfPPYO01HA7iyJTn0GqKRU47Kaz/c+lRiFLNVzTCkHdPda4Uh/zvFPG/nLd
         h2yCwTVHAp40Oq2bLQc15xl+2U3pG/2UHzwr2kRpRNR5rRPcmxb9x7EY9enHVwhZuKCZ
         G80+j9bPE3diaggFbWJZkeadAXNltvW0pYMP7q07xVo/QyYa2IU6Ynfx6SyBqTzlroZE
         by3MKFjvRTSqL3f5SWOm9NEYdj2FNYHzJ/JPXFZ4eB7UGmekdy3CKyku/7+ZG0EL+KpH
         zODlrSLshbjvlBvZfE9+brVx8ryPjG9tiWv+EXxghTF3FQI8R0IFePVR6AC121tTROtY
         aaSw==
X-Forwarded-Encrypted: i=1; AJvYcCVaClorEIy1iTvx/eUBQETmA0uImzDdpJIkGP27l5FnKWbuicgCA9IEf2G8cWnZkV3ikJp1XcPlPwoGHxrLA2fxDJPk57wqpTGM2xR5
X-Gm-Message-State: AOJu0YwGxun2sXr6w5BKQdDvQgbsRYjq7335rhmd55J7qr1sKstpVTqh
	ukKB2egbIu5MxP7lR6uj8rQqtfErpLIjZHNAQxt8XExPM2eOPEZ3632clKmMSPQtSiVyhC9uz2+
	8kUw9K8n07kHLkgwwoudsdvjyZJDESrWuKgl+DA==
X-Google-Smtp-Source: AGHT+IF8UMF77lNbQVO0jl1IN5cufp+czJD5g9ynQkVZ5P408vOejql5uu7KuvwuxL/047tN6mI7Lu8hNyGD6kndylA=
X-Received: by 2002:a1f:c982:0:b0:4cb:2930:7470 with SMTP id
 z124-20020a1fc982000000b004cb29307470mr8703134vkf.12.1709110928901; Wed, 28
 Feb 2024 01:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131610.391465389@linuxfoundation.org>
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Feb 2024 14:31:57 +0530
Message-ID: <CA+G9fYuS497NG-NrQE+VxK65_K-nkZQ=mqZL63W2AE=QTfNYhA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 19:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.80-rc1.gz
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
* kernel: 6.1.80-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 8b73abf80c8ee1f8776dd96ae9a3ade68848024b
* git describe: v6.1.79-196-g8b73abf80c8e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.7=
9-196-g8b73abf80c8e

## Test Regressions (compared to v6.1.79)

## Metric Regressions (compared to v6.1.79)

## Test Fixes (compared to v6.1.79)

## Metric Fixes (compared to v6.1.79)

## Test result summary
total: 147985, pass: 125712, fail: 2533, skip: 19591, xfail: 149

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 32 passed, 2 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

