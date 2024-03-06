Return-Path: <linux-kernel+bounces-94097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49B8739E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B061C20FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389C134750;
	Wed,  6 Mar 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4DEFRVV"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418D13440D;
	Wed,  6 Mar 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736943; cv=none; b=OIAtbHc+fgn/2vvRM/UpKu5OAqr907v1fpDG0t4Li7AjtYKLacrAm1XOYfR2nOvNBHeLsel7qQWi1md/RsZU23Gjl3YWUH+WDHQOsb46rWjnz9zFZBWdraIolmbKjYhfQiWY95WK4WXLFR0bfR5sczhSJ7thGTrvbsJgwdpRLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736943; c=relaxed/simple;
	bh=nfCQ5MUeAnyANkejhBsUcvuz//Jl2DIYQFseasFDrrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biOZGp3w3dFNmJ89/lJmrqQ3eZ4DIVIsafeErBUzvjDHeL0p/R2m5Q6oPAzENwuRWtrWB+iBe8eKyVv25qKXWN1kierqRCJ5NMy0qopDmCIZd3T0/2fbBxSLJjn9cKPU17sVVsB1hknGXRG/3bwA7pn2CoIgaoSsn0fUPh3bcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4DEFRVV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso5020512a12.3;
        Wed, 06 Mar 2024 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736941; x=1710341741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzzlf6zHmONYejes4XgBv/bY8vZwiwX8uYZEyJ0PkRw=;
        b=F4DEFRVVseZ3vhDZi0uJkP2V+WcT3vXQmqSF24pYB5zIzIKLAn5s9fzHg+wMkR1U+j
         3beAgYPaSQJCpH3CHf5cROAY/Kauge/C/yaHwN1CW4u/JoLqdbckBzYu15tIeoMmnSFm
         Mqdf8ZWortX4TvM8f9L50Hbw9B8vBKEYDylGFGV/5L6DF8Fu+IWanh/UZvt56X7OcN+8
         FdgQf9GOBFm4kBwMz8WMDIX5/lpnNxZ2iBpCQ89mMY+UU1Nlkiytd0ghsW7Egy+P/VES
         R31dwaxXsyG6pYytb0El8ljMIDQQIL5Y74cJNCROwP+Iiqg1fx3RTuAbr7uMP8Tjh4Dx
         yjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736941; x=1710341741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uzzlf6zHmONYejes4XgBv/bY8vZwiwX8uYZEyJ0PkRw=;
        b=njUeW0vG3zV+idUDSYfVYE+Pg0pvmfb4M8zRbWiwXzTfTjKwkrhpO9+rCHTqFghko9
         du2uZE/HgTfGla71JjUD1RZXa0Ws2xnJdKObsaYGpGXM9phyPXjW8sUp6ZLK9HSl0OMq
         44VL/EnCwFgRtKgZwmSdjBKGs/QLzKYX4TRDZzOJcLRSR+lhivbuhVMBId00D+rxStwh
         MXESdsfenKJQiKDGC7b/Zx10cIuOP/W5w4kNSEDC8RnPQgT4FKjJXc4oztNG9Cu+vQ3A
         pCswMToGiDYd87+aMG55JSdz41lVf/s9q8YCLxZDJ3fH1MvoTgiU8NUcDmtTA8MNpOPe
         DCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Eh52lyzjjQe0tJ7NtkJ7gOriJQo5VHn6fAYyR1dvuyEWDPh152Xa3JhUcGPd6AIk1IOaGM93D5DkNiGmDtvO/RBSLGCgaQtF8hatUwf1/4MNbTjgPWZvm9jQLMBKOx9di1ec
X-Gm-Message-State: AOJu0YwYFNFh6Px86yQvf5KvLvjfzKAcHfUk5q6jRyNcUW7OPgpBSTAz
	lnXKJ7B4zj+Zla68fZVLr4mk/rCEu4H25eg21qkruwF+o7LzoM3WwtPtt6kh24K8cmT/8dpv0Ei
	q4xlrYXhCIKPFLPXMdxliIzK/qC0=
X-Google-Smtp-Source: AGHT+IERw1WxNeWmELIwx8V11vsYyqfmJN5GE5CxQaDK3TtTCXLZIwuExnjJRsqXca3sDu7xmW4bOeDKVExzbt7XXVI=
X-Received: by 2002:a17:90a:f489:b0:29b:4dfc:7d32 with SMTP id
 bx9-20020a17090af48900b0029b4dfc7d32mr7490150pjb.17.1709736941476; Wed, 06
 Mar 2024 06:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211549.876981797@linuxfoundation.org> <CA+G9fYvTnAyEt-Cn7fmXQ2FK3+xLyOULmcxhrk7dMTypckDEsA@mail.gmail.com>
In-Reply-To: <CA+G9fYvTnAyEt-Cn7fmXQ2FK3+xLyOULmcxhrk7dMTypckDEsA@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 6 Mar 2024 15:55:29 +0100
Message-ID: <CADo9pHjuCRuj7KyWFK1PDcnT-Y4_JaUCtrBksph0de0UpX63GQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 6 mars 2024 kl 13:56 skrev Naresh Kamboju <naresh.kamboju@linaro.or=
g>:
>
> On Tue, 5 Mar 2024 at 03:07, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.21 release.
> > There are 143 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.6.21-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Build
> * kernel: 6.6.21-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.6.y
> * git commit: 5f9255b6ac459ba1b98dfffa0680a5700447d28c
> * git describe: v6.6.18-445-g5f9255b6ac45
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6=
18-445-g5f9255b6ac45
>
> ## Test Regressions (compared to v6.6.18)
>
> ## Metric Regressions (compared to v6.6.18)
>
> ## Test Fixes (compared to v6.6.18)
>
> ## Metric Fixes (compared to v6.6.18)
>
> ## Test result summary
> total: 168781, pass: 145491, fail: 2395, skip: 20734, xfail: 161
>
> ## Build Summary
> * arc: 5 total, 5 passed, 0 failed
> * arm: 135 total, 132 passed, 3 failed
> * arm64: 43 total, 41 passed, 2 failed
> * i386: 35 total, 30 passed, 5 failed
> * mips: 26 total, 23 passed, 3 failed
> * parisc: 4 total, 4 passed, 0 failed
> * powerpc: 36 total, 28 passed, 8 failed
> * riscv: 18 total, 18 passed, 0 failed
> * s390: 13 total, 13 passed, 0 failed
> * sh: 10 total, 10 passed, 0 failed
> * sparc: 8 total, 8 passed, 0 failed
> * x86_64: 39 total, 34 passed, 5 failed
>
> ## Test suites summary
> * boot
> * kselftest-android
> * kselftest-arm64
> * kselftest-breakpoints
> * kselftest-capabilities
> * kselftest-cgroup
> * kselftest-clone3
> * kselftest-core
> * kselftest-cpu-hotplug
> * kselftest-cpufreq
> * kselftest-drivers-dma-buf
> * kselftest-efivarfs
> * kselftest-exec
> * kselftest-filesystems
> * kselftest-filesystems-binderfs
> * kselftest-filesystems-epoll
> * kselftest-firmware
> * kselftest-fpu
> * kselftest-ftrace
> * kselftest-futex
> * kselftest-gpio
> * kselftest-intel_pstate
> * kselftest-ipc
> * kselftest-ir
> * kselftest-kcmp
> * kselftest-kexec
> * kselftest-kvm
> * kselftest-lib
> * kselftest-livepatch
> * kselftest-membarrier
> * kselftest-memfd
> * kselftest-memory-hotplug
> * kselftest-mincore
> * kselftest-mm
> * kselftest-mount
> * kselftest-mqueue
> * kselftest-net
> * kselftest-net-forwarding
> * kselftest-net-mptcp
> * kselftest-netfilter
> * kselftest-nsfs
> * kselftest-openat2
> * kselftest-pid_namespace
> * kselftest-pidfd
> * kselftest-proc
> * kselftest-pstore
> * kselftest-ptrace
> * kselftest-rseq
> * kselftest-rtc
> * kselftest-seccomp
> * kselftest-sigaltstack
> * kselftest-size
> * kselftest-splice
> * kselftest-static_keys
> * kselftest-sync
> * kselftest-sysctl
> * kselftest-tc-testing
> * kselftest-timens
> * kselftest-timers
> * kselftest-tmpfs
> * kselftest-tpm2
> * kselftest-user
> * kselftest-user_events
> * kselftest-vDSO
> * kselftest-watchdog
> * kselftest-x86
> * kselftest-zram
> * kunit
> * kvm-unit-tests
> * libgpiod
> * libhugetlbfs
> * log-parser-boot
> * log-parser-test
> * ltp-cap_bounds
> * ltp-commands
> * ltp-containers
> * ltp-controllers
> * ltp-cpuhotplug
> * ltp-crypto
> * ltp-cve
> * ltp-dio
> * ltp-fcntl-locktests
> * ltp-filecaps
> * ltp-fs
> * ltp-fs_bind
> * ltp-fs_perms_simple
> * ltp-hugetlb
> * ltp-io
> * ltp-ipc
> * ltp-math
> * ltp-mm
> * ltp-nptl
> * ltp-pty
> * ltp-sched
> * ltp-securebits
> * ltp-smoke
> * ltp-smoketest
> * ltp-syscalls
> * ltp-tracing
> * perf
> * rcutorture
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>

