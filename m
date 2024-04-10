Return-Path: <linux-kernel+bounces-138415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8789F0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A38828C020
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5B15990D;
	Wed, 10 Apr 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPAENpGo"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801891598EB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748737; cv=none; b=dOhrSy2i8NonnCSgwyWZ1oGcIotIUYp+i7+yBPPQZanlXo1OIwOjU/AP7ZPjzzvURYA6nRSev4S5X4EL7pEdkdb0OLNZPvj480MTdM1elj6TjyzNtXVinmWEjMZvaPRETCsvdSyDo7Ym8s1Iw+q2rNtgw9Ykpf5S1wlZoMNxRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748737; c=relaxed/simple;
	bh=LMXzBsCBkD5PGmPWNDZ56ClOzx9ewbOx15xHxK1A9cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEmlupy8jHu++wxQ38NtyTezfiWQDgFw4EdpIxRYmJNSPs9fNN7ayflxMIBmfOvWC5pHfUPJx+kNol9Yo9KR7MjEPp5HyQYLXxiQVDDGzykCvwIRv6pppzOLB2tMCjocUzO9Ho6t/MZG6aFPq0UTrdY9EarpAJEFW88FFH3hs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPAENpGo; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c603f6eb37so482084b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712748733; x=1713353533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JvKG5w4RwC7ETFUBrTzr99BNRj7EiMJi8Q/PGI+6f0=;
        b=oPAENpGoGhrSVIhYjmNr1bTzPIW3jWqVKliA3k6fwu9U1XEUA9opP0NSPqhFGiFtXJ
         H//95BfvBMStIDsQW+lRl/WmYx8XyUC2Pv2uP/SfFqDmFL5mSryMxI5dLd764xkRShWY
         9kZRu9B/e/KnmZp5pk8+aU0P0tb+fdF/I3z0RvJUj0X5qVxP1EGQX5nq64wope2UUBCZ
         j5qY+eaWRgXd1MzgLipCqwr6zjnKHWYMRcrfvn5D9TwKoKoKYeTUBJ+bvOWXPpK7YZqP
         CySevwsFSU4iREW2qYtWbOfhoH2GMxRFhEz6TvS2KCPd9hjVW728d9/+GstGumGv7huF
         yKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712748733; x=1713353533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JvKG5w4RwC7ETFUBrTzr99BNRj7EiMJi8Q/PGI+6f0=;
        b=TTt5IIMAWQ1qiThgXZZnhq7uHrKX48Qg7cTGkDzD0j2PSmQajZwOU/HbDJDqNBgSCt
         uRaNRgZlW2wEAb5UFOG2NWgaaXeYEa5JQGVXwkEMsC1kiUgkclJ6qqschs+EJdJ7fUjT
         0WWnYJcZCjVxdJxD0Ey4SaCc6fdXszIAgY7MfhMHUpvJIfbUJuXLIRXM+oPakMsfC11x
         EYvBGmAl4JNgI27pLhPjYvSYzFypzDd48u3AGifVy+Lf1F1t0XN0k36H91+Z4tYAMV2z
         0D6aCxXfouGo00nzamVinTdJYCKnXZnK04s8uC+JdHQASH14awGDR4sb4Q3soP5Ds4qF
         JECg==
X-Forwarded-Encrypted: i=1; AJvYcCXfmD19BYhRMkNPU6Dx6avtakrK5fmakr+zVvvtLNRm80ODHUU4c5pxAelBlD2QVaIuXsZt9IkRB2YSB4jjOKmXuC78vLm1NeztYZHg
X-Gm-Message-State: AOJu0Yx4Ky8lQdAcPbW5PYl6+5dTH3tiCDsFceFYnU9GIcYCIUaWoNbK
	nTU2scj2EqUcJZJWRAQ4wgeOBNPGH7Kp+PaWT8IQ7IJfwAQCv1K23/VzEiux/H5UjbjNT00+MkY
	JmrOobDEFsocfVk2yKaxvKiOl0NbELWtjAmh/gw==
X-Google-Smtp-Source: AGHT+IHnESeFbylzD7DsY/rZ/yOCyt6H+JQI+c768R+T1SiiVV41DvW9OL0gkD4KowAYkHM6epWfo2sYkXQE8/LcfmY=
X-Received: by 2002:a05:6808:1815:b0:3c3:b623:1d21 with SMTP id
 bh21-20020a056808181500b003c3b6231d21mr2580110oib.4.1712748733490; Wed, 10
 Apr 2024 04:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173628.028890390@linuxfoundation.org>
In-Reply-To: <20240409173628.028890390@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 17:02:01 +0530
Message-ID: <CA+G9fYvUqvQyaG+OFLMpjtrkFJ0wPWFEsw_wjs8o11WL2LyJ3Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/697] 5.15.154-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 at 23:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 697 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.154-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.154-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 8bdd6a2f1b3b20acaf3db5dfde2da36cbafc3cd4
* git describe: v5.15.153-698-g8bdd6a2f1b3b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
153-698-g8bdd6a2f1b3b

## Test Regressions (compared to v5.15.152)

## Metric Regressions (compared to v5.15.152)

## Test Fixes (compared to v5.15.152)

## Metric Fixes (compared to v5.15.152)

## Test result summary
total: 95232, pass: 75353, fail: 2545, skip: 17268, xfail: 66

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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

