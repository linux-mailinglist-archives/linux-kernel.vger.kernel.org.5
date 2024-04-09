Return-Path: <linux-kernel+bounces-137154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6589DDAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF31F25E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7EA7FBD3;
	Tue,  9 Apr 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hePO1DSO"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523052EAE5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674990; cv=none; b=AhUhivH3ONYo/X7LXi+nSF5KIM5/OmcLa1qHOfUSF7QAzaKiYlXtKwT6RRAjLCqxfd6THlWAAiqNEvrJ5eREHoFr28sSwFZFT+xmcY1L6szTTJ7anDJuIdKuT9rVvgdPqnK/O6nLe8j++1i7FzB4h4R+piTWHltAFdcw0FkocoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674990; c=relaxed/simple;
	bh=7Pli8mbYdTy25PLJf6La0wc+s9jWwupaI8bdrmGO1fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHHYJO/f5CK344MWtBvZwexdLXl2moUdezTvJ+2UNRWX9gwjN6qqYED23u9cH+2a+t0wBe0bhpa8SkPPRvGQxOKMFF7HMN9wpoc+dQ1pEYRl5Txfkj65jWRwkpHLEsDAiBmRZ0CuFbHh1I9IvBv+7p/kKxFdzbD7hH1Ud+uEgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hePO1DSO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-699413fbd66so22903596d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712674987; x=1713279787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+XDk1cLK4NPYhK11Tcj+zbN7BAXH1rZn8LVf3IXTLo=;
        b=hePO1DSOoSbHKQn+Wz2l6WkRB3OerbM6U0pKT971ToGDglZTmUots14clXtk6MfptK
         FPj2AZw9pHrOQ6N7RM6UegQQX4/y/gLLNyB6xXQoGJObVXWOsW/7ptukCFkq+CT4RK/M
         gAWzvE1Gsb8BF0bJbU+uotMo2EgOEevhaQGC9bAxU401USz6A9f3i6d3N9/hgUGQnOY8
         m11Lap9zcXrhOBHSO2EfNLkjEXj4c5bEt6v3iO72LWel4FJgMF9H/zePv95BViybXFhx
         GTXEXiSFhKybsWAOxESNBCNG55XEX2ULd+O2eAnRxLxH5zl1cKcm/FSVhD/B1s2QLko9
         G1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674987; x=1713279787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+XDk1cLK4NPYhK11Tcj+zbN7BAXH1rZn8LVf3IXTLo=;
        b=JyCS8SLZZztwzqbLL6zRlPlVJoaJfWlE/AnBc13I3x5VFdeyyRz9a1qOwhq4Fpj3yg
         o6ldbg3pAKNA3CFcOEj3UPwO752/pD4U4/+xzRSm2dOK4p1INf9oPnEVFKQOtrOb6cxk
         5v9JsPUSCdK2XJ3BlHXvWrWSpQlZ8FGrJvQ70upK0IxLG9T14FXuUJTrje8zVbQTIC9S
         vWlKK2L2JhMtmgC2V9Xg8AvQZU7zzuhbSOcsjQxRcAdC5o+HS992rF0usnr06R6+RAgO
         hn90+db5G9oMp1x3Xsm0/Kr48Wkh1y2S76oxv/+mkHAmFihx49r0fJ/3/7qWgaTQmpof
         5AHA==
X-Forwarded-Encrypted: i=1; AJvYcCW/z8ijMeAyaivFil4W5Kb3DKx/fUXuQGNgWjU/vdl9Asbjfs+kCT3NJcVyAim2bH/o+BZ4vpvQWs8BKx/fs/GG3RsxoZSALku6ZL6f
X-Gm-Message-State: AOJu0YxdzZcB1fJOqvAY0Rmb92HWtEjtfFMYMnJkSABTJtGvIlTlnq9T
	p+XwsKLbnU0JNFp6K2xCxQbCKHuBM+oeUFXb2hpUH0CDBFFvosBz5wGn1OExcwQo2qlahW4jmXa
	v6zSStyxb+GyOqqwj9y6NbcCS5h0iIs1Tqh7NzQ==
X-Google-Smtp-Source: AGHT+IEHbOrG/9DH09j60Pe7SxKUOq9Ym1Y7VnToNV102gwrT9SVtmfrVuhTOUUNdqXEbQ9n5Uq3zUZDf7JEYq59ICg=
X-Received: by 2002:a05:6214:1bcc:b0:69b:2664:cda2 with SMTP id
 m12-20020a0562141bcc00b0069b2664cda2mr3821192qvc.8.1712674987177; Tue, 09 Apr
 2024 08:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125306.643546457@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 9 Apr 2024 17:02:55 +0200
Message-ID: <CADYN=9L6PFLhfC9cKAgTEAxzQO_J4ymp_DibEKoJZoLC8eaRVQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Alexander@wetzel-home.de, bvanassche@acm.org, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 15:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
Regressions on x86_64, and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following kernel warnings have been noticed on x86_64, qemu-x86_64 and
qemu-i386 while running LTP cve ioctl_sg01 tests the kernel with stable-rc
6.6.26-rc1 and 6.8.5-rc1.

Reverted this patch and I couldn't see the repoted warning.
scsi: sg: Avoid sg device teardown race
[ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]

This has been reported on stable-rc 6.6.24-rc1 [1].

------------[ cut here ]------------
[  839.268407] WARNING: CPU: 0 PID: 92507 at drivers/scsi/sg.c:2237
sg_remove_sfp_usercontext+0x145/0x150
[  839.277715] Modules linked in: algif_hash x86_pkg_temp_thermal
[  839.284952] CPU: 0 PID: 92507 Comm: kworker/0:0 Not tainted 6.6.26-rc1 #1
[  839.293108] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[  839.300514] Workqueue: events sg_remove_sfp_usercontext
[  839.307122] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150

<trim>

[  839.415941] Call Trace:
[  839.419788]  <TASK>
[  839.421924]  ? show_regs+0x69/0x80
[  839.425337]  ? __warn+0x8d/0x150
[  839.429950]  ? sg_remove_sfp_usercontext+0x145/0x150
[  839.434923]  ? report_bug+0x171/0x1a0
[  839.439968]  ? handle_bug+0x42/0x80
[  839.443466]  ? exc_invalid_op+0x1c/0x70
[  839.448688]  ? asm_exc_invalid_op+0x1f/0x30
[  839.452878]  ? call_rcu+0x12/0x20
[  839.457579]  ? sg_remove_sfp_usercontext+0x145/0x150
[  839.462551]  process_one_work+0x13e/0x300
[  839.467946]  worker_thread+0x2f6/0x430
[  839.471704]  ? _raw_spin_unlock_irqrestore+0x22/0x50
[  839.478049]  ? __pfx_worker_thread+0x10/0x10
[  839.482326]  kthread+0x102/0x140
[  839.486942]  ? __pfx_kthread+0x10/0x10
[  839.490699]  ret_from_fork+0x3e/0x60
[  839.495658]  ? __pfx_kthread+0x10/0x10
[  839.499419]  ret_from_fork_asm+0x1b/0x30
[  839.504727]  </TASK>
[  839.506923] ---[ end trace 0000000000000000 ]---

[1]
 - https://lore.kernel.org/stable/CA+G9fYs5MZaPV+tTukfUbJtdztQMExfixo=ZwbBr1A6Oga+OLQ@mail.gmail.com/

[2]
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23360303/suite/log-parser-test/tests/

## Build
* kernel: 6.6.26-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: ec59b99017e96d3bc8a6d5b87c01f47ec5a9bcb9
* git describe: v6.6.25-253-gec59b99017e9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9

## Test result summary
total: 165396, pass: 142577, fail: 2173, skip: 20493, xfail: 153

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 8 passed, 4 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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

