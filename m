Return-Path: <linux-kernel+bounces-103272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10787BD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D1F286A49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B55B03A;
	Thu, 14 Mar 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yB0oxqsX"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55755C35
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421746; cv=none; b=gHWhS+HZFOQTzpgoOQbL+K/YbeP7ObaNumjsdQ4U39vmC0LgTTPsw4SzsK1EHQN2GF15fNzExsaXbm9Raup1MDcSb5Q5gucefKSL3c4MIUHS5hwoa5ykNuyHHAmkCr4BNq8q3LCfe+vbnzd4Iycboa3EpM5KCcwfqKTl/w8y3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421746; c=relaxed/simple;
	bh=OXNnG2OSKepIwOFJTF5sqKFiQf2gnowOfmiTwS1sUCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGqIeu2WvQsn8TSve3a9m8dGiqNNjkzbDEh5FLsTOBMsxwHVGyrp9RDzoH2RQ7M3uTLMQSHifKVikAAm+Swple+47PQ8SLJ3DFkfOR9nJMskqZuO80rIeQX9v2PAKV34e44NLarfjuHNqSk9XU0OzEvJ+W5SjYIFPLoNUKjCm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yB0oxqsX; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1a1e1e539so802701b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710421744; x=1711026544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj9aaciVFOrb3f961IsQptBiXzEC/Zae1YSAifn/Zj8=;
        b=yB0oxqsXDu3n5ilhA2ulybQlIYo3LI0yyVm7pZNloowTp3j/s/TcuUwqdJ3Nf5/7e4
         NM35TYiuilQlv3IUNahpL1JDPXl3wug60vRxIdbWVYEkdEv2Dk9z+2CYB/5L6j4ilADH
         6QaNseCHH+kvFsRIB4dMIUJipDO8eCgMkY9tt1d/mDk9QbgI50/K1yK66rmOqwyiEKVP
         ESyWjS4PjrhBrExfpSju6dKnfm0GFcsP2rTrcfH3uUCJlmKlbNt085V0d1YGUWMb6PaD
         ZoIC1j9z54XmYPIcqJvJC9eMtyvZkhbZjFNE9TCzSwXLpJclxLuC9dcarYi4Yh+8A28C
         a3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421744; x=1711026544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj9aaciVFOrb3f961IsQptBiXzEC/Zae1YSAifn/Zj8=;
        b=tz80yPrk2VJX+A3FXbrPv69my+LOVqSLvo4YwoZ9BJl+K1vSmjVneKkhmqDbcMZv7q
         Cs/QpDRb3oQeKueLRD7AHvj5mcEe9GgkwiMhzBGGuNHB1qgr5oHIaKP//5sI6thSC3fz
         zXeffCOG2HThnKE0vuf84faL98+owLDJ9eE4U/D0OLJzyUbcSIbJpbpDlB4B138rPGOV
         do4P6rNCKJkD464u4a6GTa+KC6IJITBnabJ5OK9J53ZWxmrbPVaO6v6Nut6z14BtPs5H
         5PHVbuaGQ4KQZP6WuMA6Jm7/Rj5NEhRozpe6sQ5KnrDzX1NguUezP1OpIsBGHBc+b5Vz
         AHtg==
X-Gm-Message-State: AOJu0YzN3m9q/xll+xRAnGTrIpOicWJEj3FsCTEiI57hsY0+kj9gNZXD
	S7Q8JmEFdcDEovOU37couU5LpIFNZJT5jzGWGelmI3FtWUqHo8Cm6ADkvuD4JWJP1mPiKF/tiMN
	dp/hyJ5bs8LunOKoOEWJBCZPBJTH5wH6Pc6GPmH89E67y2AVe9fw=
X-Google-Smtp-Source: AGHT+IFdXbNFeBqaBvns6RQe+VNjTlllRFtY348iv7L8lXnU2RsxEauDQYDz2tsqh8mhtF7nqRppcNu8q4sMztH/HKo=
X-Received: by 2002:a05:6808:3308:b0:3c3:5599:fcce with SMTP id
 ca8-20020a056808330800b003c35599fccemr2189679oib.46.1710421743741; Thu, 14
 Mar 2024 06:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163236.613880-1-sashal@kernel.org>
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 18:38:52 +0530
Message-ID: <CA+G9fYsPXCLOK-m26yVZmi3yCrNh0b_fLp3nyZBJpUWacGg1ug@mail.gmail.com>
Subject: Re: [PATCH 6.7 00/61] 6.7.10-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:02, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:32:27 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.7.y&id2=3Dv6.7.9
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.10-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: b103e69cd70cdeef14f92bdca721df82e6dcbe0a
* git describe: v6.7.9-61-gb103e69cd70c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.9=
-61-gb103e69cd70c

## Test Regressions (compared to v6.7.9)

## Metric Regressions (compared to v6.7.9)

## Test Fixes (compared to v6.7.9)

## Metric Fixes (compared to v6.7.9)

## Test result summary
total: 185974, pass: 159975, fail: 2323, skip: 23481, xfail: 195

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 129 passed, 4 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 33 total, 28 passed, 5 failed
* mips: 26 total, 23 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 28 passed, 8 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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

