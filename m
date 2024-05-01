Return-Path: <linux-kernel+bounces-165056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A268B8725
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE591C23101
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED3502AC;
	Wed,  1 May 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQNv16TA"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9350290
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554245; cv=none; b=bs8iHXtOI0meJfVW/06ow4i9xRoe6M7hIESGXImBD7vrgeAC+cSMWZzDxRi7jbLMuqUO3TxpDiQIcuOi/3e9hgUPBsX8eEXDYKU9M2iEEhi9AYoRlSDmbL0Kst6ZVJH4WmR76Ty1WbBz7s6E1u+dpmJ7E5nkDqQ9ODrGSkAbOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554245; c=relaxed/simple;
	bh=/04T10g6EdozEY+C2zVZ8kuBIiXk1ebS/vay8YhzR58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQVJ0S6t/gQfOOdeao6akZ+5Hu0QDZl7sXTzii/6o1QZawUT4uqkYrU0XvtAWToWKlQ1kWJHhQ9iklwDJyg6P/fEK69GMPGhtJVuwGUy7Uv6/EiMMSkQxiIOac0GfW/wf7f/pQqCKzffMgGLQeNLaFjaClEcO3+NirXbPijQrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQNv16TA; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f3aee7c531so119946241.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714554242; x=1715159042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyX10059Eg5iH+PlnoXLD70w774tq1EDCW71wsUG070=;
        b=KQNv16TA5rPy4YJ603OnhKXrraivT7hUODtFrZFPHlvSpZkOO6dUakgz+FRu3XWG4z
         2jManxGOjtlZu0zUQlORZCpv7tWVXyz+lxd+Q8vHm7lwkAA+787TYkSGJaUAGF9c9Fd/
         X+BWOhNhN39kto2hdo2mgIABYRgDSkNzBwwBpJHQVIF6S1Z00joV30xdw3ERwm7ZY8Bz
         P7CD2Nmm/RqxTxASVG2LKe/mCZPYe7jCx2g+mEfjkXRsLiEuQEPYhDRSxZYfMwsClXWx
         rDErUWUITuGxWweC3mxN8/8eSatwvMMPLvpx2YmJCOoeidfVjHHUK2J0kth/wcT7n++c
         VMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554242; x=1715159042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyX10059Eg5iH+PlnoXLD70w774tq1EDCW71wsUG070=;
        b=g7aZuCVRZU3yeIPwzCJEnlPT3+XtmxnhOFxzU+1jd/yjFzpo+xB73XVKLXG4RKkI8h
         VLLVaAkkg14XfdkjuDA5Zp5Ikl+qyWHR1HUmVu6gRkNZGO2sMphZsLkJQqwVHD6Y3pi5
         08YNclnLcrVfMaqkhkYISsSaLn6ywu1Rwqta9B8pU7SIuTth2Jaf6dbPElFIxJepSByI
         zhs1mCRo7r2n/049i9tt+hck9tTtHF66TZ/cvRTCmewmZgac7UZCC4zM1nKWJrNd+TNC
         SbPbUUdf6Zehmj+ZFxPf4sda3fRWCA3eTttWMW1Fw7RQgVuIY/9niYp6cFia/9/5rkXA
         REcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnDRmRvebg7a1s+2fT+n3hQDhXC3xwSWIhrODptv85F6drH3HDf2NG2d8k5gznx5VmDC8Q8D3eXwWDEbju0dsrUJEb9Zal1QmkSCHi
X-Gm-Message-State: AOJu0YwFh0LetYRCjk9m7MiMheJ42gLLomrqQ/bt6lkAgvEbAryPEYXa
	8EbhxIli6X9cQ0npwl3OnTnB3rqZb1ucGVuHL/khApoZtEqjsN0DGIhbVfzfCu7YGJu2umkEhC0
	aPeEFSFhfb3FtnuIBMWM7pNr6goTb0HerRs1Uow==
X-Google-Smtp-Source: AGHT+IGDYxvwzt0ts5v3aobUgnwF8+JBRZfOlsknMIJWpB8Zgxqpuf1upWCYgu28djE76Xs+GufeReS3deH+IaHsvvc=
X-Received: by 2002:a05:6102:12d0:b0:47a:40ec:d6bd with SMTP id
 jd16-20020a05610212d000b0047a40ecd6bdmr1923218vsb.9.1714554240455; Wed, 01
 May 2024 02:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103058.010791820@linuxfoundation.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 14:33:48 +0530
Message-ID: <CA+G9fYuMNH3ztTLuHQ8YoM-PYKKy9-KtFaBQLTHa_P1qjF=F6A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 at 16:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.30-rc1.gz
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
* kernel: 6.6.30-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: f679e6546f84b5a2cc73e8f3388bcd8f35faaed2
* git describe: v6.6.29-187-gf679e6546f84
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2=
9-187-gf679e6546f84

## Test Regressions (compared to v6.6.27)

## Metric Regressions (compared to v6.6.27)

## Test Fixes (compared to v6.6.27)

## Metric Fixes (compared to v6.6.27)

## Test result summary
total: 177787, pass: 154198, fail: 2697, skip: 20681, xfail: 211

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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

