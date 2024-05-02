Return-Path: <linux-kernel+bounces-166076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A348B9599
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CF8B223F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5924B4A;
	Thu,  2 May 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjruYvQ5"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CF22EF2
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636171; cv=none; b=ZNbPrfyf08Tyi5VGMhaGN/R43jimWEfZiP1GKfqCYSw1vW3trb6hHYek/SbqOF+mWpoGwELPupLCNNhrDtxmFwN/9DHW7wHpZdoTdN3aCSKBbw6J5X/3UibEKZ1vz2KDwC9qBHv8BnDSfIK8ox60WCxjMUKBSx61UV5vOZedxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636171; c=relaxed/simple;
	bh=iA68F+rolBZJXO5nKHvOSs3bHRYMcxCkn6pFYHHPzwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TW85cge3LeX4/8UcnbhT3x0Koou3kuB7ncIvo7FSU6pjx5lVYM/fC7eIjt3/z+FrgWyaE+xrQa5uyXTRb+LgmDxkSU379GsnlIG9Xg9v0kE2GKAeHlLV3zlUi5braPLfIdIwPul0KnISTa9uHvK066enRaxRgjTIMEE3DlVJCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OjruYvQ5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dae8b2d29bso2181383e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714636168; x=1715240968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kYlRErK1YBUSRqRp4uQ5pB7GNRgpJXOvW08NiRbyrs=;
        b=OjruYvQ5oTNS07s9G/+unsRhAy5meQS5lID9gNz1/XQqvVeP9etQY5i7dIr5QzsSEs
         YAR1BujFE3PBdeErLsmsCJXIuQ7H5k1+nO9mWL53+1oC1hQiTbtyLpCvnN9Bl+QFDKxY
         Cae9bUcl03x0TyWutpMyAKIqyoylJlVJs5pXpjZL5hNsoZm+q4VAvviZTAueMvD3i8Be
         OjlJi+x+nrG64iDq6gFe9ddhN2Ifz5JDKhAo5jDDm2D/1qAbkM09DkcO15tG5aiym8DE
         JlyHDHiFsuj6mahTdXKV44phTbghNdYlZxfVONUGBnlfAmR+KnVmZN0IvRvO9Byp0Qp7
         5ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636168; x=1715240968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kYlRErK1YBUSRqRp4uQ5pB7GNRgpJXOvW08NiRbyrs=;
        b=b6OGpGjq4x4MK16/mXJWdxPwdzF0HvgpPuB8dSLqIUyVyQpL5C3YsvVw/RlF5iLVJa
         CvZhwYZIqH2mkuIpDwGpAMpDyUBHBirS+N+9rwPF99XMyUiNDAF/9zBiwWKHNNp7xHDD
         ASE86kDI7j0L7ToMVE/dYHFuSHJJsVylEKVMJZ+HZgxtmHQWEcNBQR2sDavb0K940jEI
         p+qKWQIazfcsaAVKcizpcoovvSAVtL9PtUQv7sVou0ah4goodwUDayKVYVE7AErvjcA7
         lXOMpx8GDR1bnZlZrytehfh51y46PMqaL2xdGgkS3GsCytQ6yF9zQfmaTgdduVbF2RIA
         KUfg==
X-Forwarded-Encrypted: i=1; AJvYcCWeypNw0AmEiTZHbBp2ju64FjSQnhsduah9NNPDDXtTjwLpQpFfIL+HA4gPGZ8sDU3tnanEUHHjds0KQMsvTDhKY7V3cSH9P2xOlXWh
X-Gm-Message-State: AOJu0YxRlcrkMvR1fIbE1G6pyUh6mvyTENrdU2lo6r5iOJmACvxP/YQ3
	Ephi9tFrKEASMZAQKpzTZtrd81roW4u78mEayVWMk4rCUb5EEk+y+7S0ON/aedKu13WdLG+7aUl
	sOxhZGRGAwu2qbWDBYS91JdDf7WK8CFIzzk5LPrj+sn2Pmh8ZyQU=
X-Google-Smtp-Source: AGHT+IG/WtFFdu70A40C+YumlSi2AtUlDf5sl3ZyZPbvCoeRfjJUwghUfhnYfNUoTcZEQV24IGGKlefR+GwWI4HOlWw=
X-Received: by 2002:a05:6122:c9f:b0:4d8:79c1:2a21 with SMTP id
 ba31-20020a0561220c9f00b004d879c12a21mr1367427vkb.7.1714636167735; Thu, 02
 May 2024 00:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103041.111219002@linuxfoundation.org>
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 May 2024 13:19:15 +0530
Message-ID: <CA+G9fYu=HarRpHDvZkuWN1vviKj88ZTZy-6nGg5tQR7Ans=p-A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
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

On Tue, 30 Apr 2024 at 16:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.313-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.313-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: f656c346d44e96711a4616bce8f1f313b63f9175
* git describe: v4.19.312-78-gf656c346d44e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
312-78-gf656c346d44e

## Test Regressions (compared to v4.19.312)

## Metric Regressions (compared to v4.19.312)

## Test Fixes (compared to v4.19.312)

## Metric Fixes (compared to v4.19.312)

## Test result summary
total: 58160, pass: 49914, fail: 1047, skip: 7150, xfail: 49

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
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
* kselftest-zram
* kunit
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

