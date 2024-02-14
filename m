Return-Path: <linux-kernel+bounces-64866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519F854404
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599EE1C22746
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37935125B7;
	Wed, 14 Feb 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUFntmSk"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AF125A6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899333; cv=none; b=TlAZelGauYWGotQUv7iWapNzY/EiSKk302cDPGGpPdvjk/3dNc6lNsepaf9Qr33FKgF7jX1j8V4i49M64IRDoYJe5w3f/Z41ilVw4XCOVwEwRmwvGE28jJBPAdGfiNCVfR3uKRj4+auOIJO8vQoFBrgH7ruRWGGvwbXcUSlPW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899333; c=relaxed/simple;
	bh=z1RzFrnMZf3GiNGXTX2mQFwYpYduJ0m3d8+ydYvytKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtMjl8vbOrSzbc6RdDQVYORHXTEV31lpw/sA7nDecv8FhOvkKwtHYUQ5ZI9Lwra0Cg2bwYJkbwCWqnom1kRCyDMZf9j0t9RGMQTdbB2lphShwpBU/SilwU29bquSSB4kLOAx8YuKhpWorlPOWSsxJYeHoSix0ASeo02emR8H29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BUFntmSk; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso1823042241.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707899330; x=1708504130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuolcvOTiNcGT/sHrvkvrIkmAZtBKK3PrIqOvcXIMOg=;
        b=BUFntmSksxDULKGDSwD+vFdwekUlqzcuHIPd9KkEsVJpAywNrUr4XGAjpiXwF4BaWq
         WW874ldvJb0gSswMsuRhsdSwDe0YLNDRt0kTBrEPXh0AKddVmxvLulwcU+wqubHsmj0C
         uZl36Y7BKq6sciE/dm7vzPQ3MwL1yke80uhkpS+VhSI8WEyvyX3RotLzDVrQFsLyNyfB
         R6UMo6p7dTHpPAlHeGvyj2kd6vMRP1ftQGTckith8u6ouqffTrhVgfdn43SRdW73PF6r
         2rz45k8RXFtAUJRiaFo74wHJlaye+BrSpZdHPGn/c/32R7YdkCH2tmqNnjlmOFKwr8rZ
         PqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707899330; x=1708504130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuolcvOTiNcGT/sHrvkvrIkmAZtBKK3PrIqOvcXIMOg=;
        b=Z4QyUBSJNdmSjPREZJXKiOHap++BCDJ4FcMuFwecxMqB+12j5SSwAIFhvdml/zzy4j
         0/41GQ6YoRR7rk9kF3mRZDWwuopLIbIMdZxreQLFcBG3lYihHF8b4qKkvj08waRmQl7/
         VYLL1RsoezBbD4YXIthsRCQ3rCz8F9QK5xaG7Y9PEcbg/xT/otHD3U4OegNn8MzxiTvQ
         HNjsXA4BPoaf5sQeKAszy6DeX6wV9aU9OM8vqjOwTeRvtrYqYt1570FbBSZsQzYCQCy7
         LrgUt1tao12bk2RQn6V21X3opTnkiz0tJ6TDJm8NqqHRCLlzzmYZ9jYOx1OaV16xWKVf
         8f+A==
X-Forwarded-Encrypted: i=1; AJvYcCXRkuZ2UmhwujruJr0Qtv7qBFyn1YO6KyXH5w7PbM4Vm2w6JncDWurO4Fw6v9isM1658TcKk6IqlVT6u9OTXt4uuz7eCDYU+6OmC/2l
X-Gm-Message-State: AOJu0YyWmgpzcMay/pzv5RhyS2O+Uw1OQnXDLEUEjjof+Remz93ACrhd
	H2gSLMI+bmJVInSpOs2akjJV+Ir1PCPDM5DAxXD7WQhOW+yMRgJ4af5EHnzwaD7mnauaAqD3+0S
	GEockjmiCA4SzvQjsKASdN1k3Y3tvj0NZ6FG9gw==
X-Google-Smtp-Source: AGHT+IH5gPatoltUuSpmQuogAkITp7Yv65/QnblbYKRWzTEZiP/Cga8EbN3q0wNeVyUMaUSMn5SZXDDhJha4BoXbx+w=
X-Received: by 2002:a1f:4f04:0:b0:4c0:3000:8b26 with SMTP id
 d4-20020a1f4f04000000b004c030008b26mr1874842vkb.4.1707899330557; Wed, 14 Feb
 2024 00:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171852.948844634@linuxfoundation.org>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Feb 2024 13:58:39 +0530
Message-ID: <CA+G9fYvdvQzb8dxjeYrvAPMw-qzQ2s=6AO0Z4t1Zgs5pxY+Z=Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 22:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.17-rc1.gz
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
* kernel: 6.6.17-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: bea54b0cb986e2c93aa5d99a24eb2255850384b1
* git describe: v6.6.16-122-gbea54b0cb986
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
6-122-gbea54b0cb986

## Test Regressions (compared to v6.6.16)

## Metric Regressions (compared to v6.6.16)

## Test Fixes (compared to v6.6.16)

## Metric Fixes (compared to v6.6.16)

## Test result summary
total: 149653, pass: 129011, fail: 2047, skip: 18425, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 132 passed, 15 failed
* arm64: 54 total, 47 passed, 7 failed
* i386: 43 total, 42 passed, 1 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 12 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 48 total, 46 passed, 2 failed

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

