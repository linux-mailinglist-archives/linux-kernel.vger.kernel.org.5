Return-Path: <linux-kernel+bounces-164944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4F78B854C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B781C21B10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6E481AA;
	Wed,  1 May 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StNcsZf0"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B445C10
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541121; cv=none; b=qtO340jT7UEWbTAZ5iTCIVP2WoaYv6j5hj08nuQPYIqTOJSjbU1wS3r5HtqyORz/QJCcBf3onE/WsZHSVW1DHinCu06Ke7x/C3adnf55WhAJjLNIFKBROIEz3FG6UqCd4nhc/V7UF5SJYVtEdfqyYaDnaJCG78umyqD3a89aNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541121; c=relaxed/simple;
	bh=XYEu0XIuOSc0LaJT7C2brLowA3qUmNusleJOEIspl+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWN/Nu4c7b2rzpWAvLyu1wyGaDDS/s3thpyLC14mMFok5jHzZUhL93s+2hrw2k+4bja9hwyrmyFLiGtBIR4DmmQ8rhkcq26CzHVgEYDnMjsYn/5aJuZftAK40MNRPgUv0aLny/Uh3L2D9emLRIEZ+BZ1YEu2qm+54+ufu3siziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=StNcsZf0; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f3c389c04aso4281241.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714541119; x=1715145919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKAyEdFLTMYMkl+qSVoB2MJ6thzzQhoOyIz3GNSqdnM=;
        b=StNcsZf0Ktqqbm4weo57gONo5Nc/yfhKQh9tXlOIqwY7JMriixep/lqKqmm4mwGIsN
         Ikwl7zqzjpW8SnQQfcXMm4vUt3RkTnzBowsUkqKc4KGLCqs4XJ1F44g/FpBXxBnZbO1E
         68/jzeC1Fo7MQULKdeRwU84prqrTluqq9YjRSEyxIbRt2SAOfW6mynmrxZ78qkk2U6HF
         FwTT3QbKO0V9+FE89Rq9J6DfAxxgRwFohMWHrylNESNp/cR80VS+NQqqfShOpJ61rofh
         oaF6H7lhVI/NepUXptLm/TDQEdYDbV0ZaUQ3ndGH4KYW+z2cQOzXy/CQiIT2Ns+uD/UF
         K3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714541119; x=1715145919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKAyEdFLTMYMkl+qSVoB2MJ6thzzQhoOyIz3GNSqdnM=;
        b=HLnNge5+L1n9CK66oEu/KkNwpkfh+AP62UQ4dhaQZM67ihgNWRKn0y+MbvxXQ+J/8Z
         sh4KiYsb6hCQTtpR4PDYJuz862TZq/ZDGinl4jewNalkShXnycctqRcytjeYAUmcUsaf
         S1m9U2TV5wzQEHk+mTjs5K7qKoKFN+H5mEdoZo04xvaghiCzkjijYgVWWGjol6xbj3BI
         ILcSvh0gU2VPjUOn8GAct/FhpvTGBO5QXE4pzFB6InTIRy0mXawJmNRCFQPsZXQiMB/9
         bbpMXf2D5IdGZl5GlunvPzNgyp2L2OaCg/VFmtNmQm31qYSGiaomiCFls1REDmVWLvrZ
         UvIw==
X-Forwarded-Encrypted: i=1; AJvYcCXcKF6pcTGpvhjGFsvLdzz1XRd01NdYvTv3iRSvMuS2/uU1STx3HmmqqzjkdO0Uc7PVcJ/B9MNFCPWaTsNiCS2bKW5CVq4I//uVD9lv
X-Gm-Message-State: AOJu0Yw9ADE1+4vghuFddYrSM+YS27Mc561fIHvtZWcOJhVVEGOQtiBI
	F2d8BzKgPfAxHpFGc/pr9VTq6Wt41X4aeBFDYZWPWGNC+PnLdF+yqy6QqlNw/UxQFKikYEp7R6k
	O+/PlC2wPokMCYKAvnFxObhufWRfJDcJPE2mdQw==
X-Google-Smtp-Source: AGHT+IFaTwbAOGGQgTMTWh5C4q1xJ0CQP0io+qNF6sfe6mCxfRvM40+XEe7ALLxyceaH9yvTKgHEi63DC1Eqs61SBzk=
X-Received: by 2002:a05:6102:364f:b0:47a:2f1b:f54b with SMTP id
 s15-20020a056102364f00b0047a2f1bf54bmr1860316vsu.22.1714541118704; Tue, 30
 Apr 2024 22:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103103.806426847@linuxfoundation.org>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 10:55:06 +0530
Message-ID: <CA+G9fYtBaczXNRZuCRc=_qVs5Nd_Je6QP2uLi8p6Rw9hv2ue8A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
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

On Tue, 30 Apr 2024 at 16:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.9-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: f9518a4bb35acff7e26782f5951a06e7b8fd18ed
* git describe: v6.8.8-229-gf9518a4bb35a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.8=
-229-gf9518a4bb35a

## Test Regressions (compared to v6.8.7)

## Metric Regressions (compared to v6.8.7)

## Test Fixes (compared to v6.8.7)

## Metric Fixes (compared to v6.8.7)

## Test result summary
total: 262953, pass: 228626, fail: 3434, skip: 30557, xfail: 336

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
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
* ltp-cpu[
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

