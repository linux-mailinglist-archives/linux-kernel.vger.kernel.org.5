Return-Path: <linux-kernel+bounces-165144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC638B889A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1460BB21B63
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD5B26AE6;
	Wed,  1 May 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvG+sSYu"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FBD520
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559470; cv=none; b=MBiFGFV9amAQPhCAiPf2Df2pb+QCiS5fOxBZ4HXuShnE5dW2MQsjIIXdOYujhzDklgOzLgGcTbsLzZuUMAvNuQUK8guDdVq+DZkmObgiY81BfW+frxqcd1NvhBbLz1Nkz7mq93FaW+q9oaj/VOHbeZev/zp2d5BaCop+60Wt1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559470; c=relaxed/simple;
	bh=4Q7P25SMYMYLyy+WOkh7aWxBP4ADpV2ba15PV0+TtRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWVWyj6jDxW7PKQE73s0yC165K0qvKxOjj0zc51I1frjwjDuNoKpA0cmaBUq5JXMkvhd37Z5IUHXTH1x5te21PLukTlc/UdeezxYzR0Y1J8Ct542w86Vb3Z73nYNUVbpbRbu98nMmLZfClSn9DteVXxVZP33Mb9PiILEQg6wo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvG+sSYu; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7f15256cb89so665627241.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714559467; x=1715164267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8FQnKsxIS9geA2jHjBOkkgdXnuOqTnOA0DqM9I2eTg=;
        b=uvG+sSYuMESK99436+7BrFYHKOdQJBt6jKQb681TPea+gSgRHUExS55ArAt0a0suw1
         RJY+smJZ+BHzaSzqeqiTfA6pwd5hJx8Rymf1fINaN7BbCU5IyD4jS5ffmRGUB3vZBtL9
         uZVoHSR9BBeeSvMRcfmPx3RGaUQ1QRJEJKy2kG/1MVZnYxn+SgUigczCUuEUC/1ftDCM
         ztQautNw9NpjE9C+BQ649iRDioBzDSljuz9VDQ3yeEUqMy6SlRDC9W9r9k76YgP1qmu/
         O5SAbyPzGyPlz2UDJjXpkkvFU+Ci8hSM7dbtT+dTJ2CFp4yZvQ49t+EjQDXH+BRYR3A+
         Po6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559467; x=1715164267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8FQnKsxIS9geA2jHjBOkkgdXnuOqTnOA0DqM9I2eTg=;
        b=CtbgQwn4g9zPxo6KEsJ1wApzTi1q/tKIbhoNlvkYJ6hVbkXyB/zDJ7uC175c5TIcJX
         TYD95IGotzDd2K5GZbSFkGtQmuK816pO1HvcWHfpSVD2rXspSU2Ov42NXDpsaSBd+8t2
         lc/fxQoDB5yDgeQeWkc+XSPdZEcyfdtIXXwn8uN41+X3fYIBcDeNKAHQLth4qXKZqw2G
         4KjKCWAkIeFbq/7tNx5SdyTOvC7vxZzGz7LJXNeMJ2IYf5obQmKpq3xDIRos4DCoQs1+
         tj+vrnecuVBmM5NTyzHRZwQW02awaipdh5wf2pv0LoKni/k7Q2h63Sj3KamFeA0g+Gm+
         kf9A==
X-Forwarded-Encrypted: i=1; AJvYcCWfvA2PJ6CybDZvYIi1+HkV93ktrphNmOn4Kxh+nFEm7Gu8DgAnztgCZi39xt61kJT08MOjE1/RvKgjOU4ZTCwrkKTLH7dq2oEFenhD
X-Gm-Message-State: AOJu0Yz3pjbQQAQitdXyQQ8TO3eSSXb40CMkUBT+wc2A2FmzLzgkwzAI
	uGQKyPNW65i1oZ1pIUyeXEFg3XwngvxqDfnoD5VyCp2VQHXW9kLenQqk9PgWq3QF2/4proEn9Cd
	qgJSyDgOGQq15XBjwlkRZ7E5RZ7YIYqeilc67ow==
X-Google-Smtp-Source: AGHT+IFEjAYEUmgf1+5TgUMSZTBA4Fc0E53KiGFYgdpdlvTMmFgs2/9PUnYRZDMF+uqDN/NmAYBHEP/HxIhEcSu4pyc=
X-Received: by 2002:a05:6122:3698:b0:4de:daa8:b8e2 with SMTP id
 ec24-20020a056122369800b004dedaa8b8e2mr2270757vkb.3.1714559467450; Wed, 01
 May 2024 03:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103043.397234724@linuxfoundation.org>
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 May 2024 16:00:54 +0530
Message-ID: <CA+G9fYs60XZ3TNPOaxwZ3dR_uecnz2AjUBYHPo7DX+AY2WsTHQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
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

On Tue, 30 Apr 2024 at 16:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.158 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.158-rc1.gz
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
* kernel: 5.15.158-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: d6b90d569cec2513e2bd695321ba651a37d4267f
* git describe: v5.15.157-81-gd6b90d569cec
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
157-81-gd6b90d569cec

## Test Regressions (compared to v5.15.155)

## Metric Regressions (compared to v5.15.155)

## Test Fixes (compared to v5.15.155)

## Metric Fixes (compared to v5.15.155)

## Test result summary
total: 91343, pass: 73626, fail: 2525, skip: 15124, xfail: 68

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 103 total, 103 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 9 total, 9 passed, 0 failed
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

