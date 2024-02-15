Return-Path: <linux-kernel+bounces-66387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBA855BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D94C1F210E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8811CB7;
	Thu, 15 Feb 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICTB6BL5"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B5DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984525; cv=none; b=DKfR7dFaUKsYh4XRmbaNDG9fsNGglRPIZ8k1DR0vjeAQye/NBDhCbXvEZhUuY2F8dsquYb08ukd+HkXsi960RkyBW79oj7H2BfwY7+28zYtWj047j/MfHKTFlia0LZSA/ZKQjkTGEIUCzYDpTZ6WtfayXb2WVCVb6VDqolJoQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984525; c=relaxed/simple;
	bh=hYgkvMsQtK+ETh0AblIROYVFdBFiUIh6qTlKz1TrFcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEwrPGHFismd6R28McDAI47vmvVpeuiZZgBPCR1vXZw9nfG2x6JFb7hDXGIz3GjrGO71tzDUAVyaj8BtX6TuP71N08aUuJYDgGIq/zNb+GaGbJ3G3mVNAL3L6NfkXHWuMAhPdRgbAXSacU+HHyinns/r6dvheFmBehtiINZ62PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ICTB6BL5; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c514944fso718407241.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707984522; x=1708589322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZza9eXq/7qnw+VGazGn9BUZdsH6eOUwjl6kHoofvAM=;
        b=ICTB6BL5EfOEjOXz7npcGVKH3odrcoorf6e6FIlBu9oGEYVwWNHaEjGXnuV4PVUqBH
         fjfURazqaHEErFyEiTcOQbrvd1dl6nXoFpj40lC17sVcm9hzep6WeRnzl235+T5xhCji
         paJxIFpd00Fm5gdhaz7u1Pic2tb/wF4fghCKKhikqWKODGkhgFBecbSJTh3s4XXEgL3K
         LHJrmcTUuFOGe639cgAUkSqUNd3O85UwMlWCmZnEixJtundAo39iAulFHnBmBi4s29Vp
         nFBrZ1bJxvk/YZeJ5fgnsZ8hKnpAlz9X8Rtmv1BCfFk0fm17A2jA45EBVERxGO2Db1pY
         4P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707984522; x=1708589322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZza9eXq/7qnw+VGazGn9BUZdsH6eOUwjl6kHoofvAM=;
        b=cX/FdS0Xm/wSziXpfytRot5ij+w1NKVtxey7R80+e3EP78iDy7php3psQL6UMbJ3YM
         tDXoo9poEtTuLjX2X64MVxM9z7yfq8X4AbQ7pfRWF/+CCxGRCvGNtFE3rP/DlCvQEzCb
         Y5VnW3oisbdWRlaclF/hM7l4pHkoo68TZ+ggVaHXLdgpKj4ICINHN7kRJo9YXdXWa1Rv
         SOvNY8jkMUkfJPOMMP6ZA15grZwOpIcdKT7TjmnZAKHebXgy0xKqwoaklyYotjNla7gK
         W60RK/aQ8KA86QvkMHqdJsFPN+aiE6d59PmNZtA9l/q/iNl/aRyFCbSiXCaR9KuFZUMG
         661Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4l+ufP0ty7CsJx4SGLgZK9fRD+RoIP3HYpphF9uIMOctsDC4BtEqLnKa0K82KgwqcpKac8OmY2y0ogAFM6WjXXWdwujdXfeL6GFKT
X-Gm-Message-State: AOJu0YwWRZj4+31KpK5mbafunKOzu0Yx7OK5IVLi6aKrFvLm01i4lPqe
	BmWhch0RrddlWj7NfHcyg748LLfIApvEEy3QWKj63KFd6dgIjtx/Djmpsqd87ZznqfwXJPZTgFE
	gCyWAIIJmqG3fH3ock808o5Ho5fWZaBeHIB7KtQ==
X-Google-Smtp-Source: AGHT+IG7HQ61+CHPZ/gIKYILDONTh5/DyVTUTQl+3RmwxIjcHcYqksAx3lGqgC9hlU0YQ6qgXpB0Lozl6ba1nOUORdk=
X-Received: by 2002:a05:6122:4f01:b0:4bd:800d:7308 with SMTP id
 gh1-20020a0561224f0100b004bd800d7308mr4034158vkb.3.1707984522485; Thu, 15 Feb
 2024 00:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142244.209814342@linuxfoundation.org>
In-Reply-To: <20240214142244.209814342@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 Feb 2024 13:38:31 +0530
Message-ID: <CA+G9fYuy2iUDjzyQrdqVNdvjhgc_U40D9i8togAJ0kHCex6cLw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 20:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.5-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: c94a8b48bd4bfaa53e96a60b980470dfc8465e35
* git describe: v6.7.4-128-gc94a8b48bd4b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.4=
-128-gc94a8b48bd4b

## Test Regressions (compared to v6.7.4)

## Metric Regressions (compared to v6.7.4)

## Test Fixes (compared to v6.7.4)

## Metric Fixes (compared to v6.7.4)

## Test result summary
total: 152701, pass: 131930, fail: 2379, skip: 18206, xfail: 186

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 52 total, 51 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

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

