Return-Path: <linux-kernel+bounces-37064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58183AADB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948FF1F2BD32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B077F0D;
	Wed, 24 Jan 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKI2mq6y"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3771A28C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102640; cv=none; b=Kgc0Bo3CUxzMBUrKbKU6Qmls9J+kMP1gawqjDEJQ05+/6JmscNRISnXEF/q2IrAhFKM/kU6SefFGxsK/hijbB067mFzWQQFCTdkX5y3NpQhzbk4DmI/hOFeDHsFohwQyzg+yGKvTKRnI+j9kLC6J4qOx5Mja3K96bL5X0gifNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102640; c=relaxed/simple;
	bh=iWZac+ZaEacF+KvqnPyM6HfqTzttijNbXBaymdeQFPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JURIAExn6MqUZi9UhYc+Cu9GgDxmlVStWlkCmyFVRGRtM1m6N4VVtrV6gRF9xkrHEGvJt4k5KLwMPBanHQRz3N79LiwVvsKQJv1KmkdQ0CQlnKovkpSnecL4Mp6xNz9fiptrQECCac3bshBpdPB1AoSk7awjLuIdXIGYt9zo09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKI2mq6y; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b7e0f53437so1154363e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706102638; x=1706707438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02kXXgSqM3f0wcrI/acHfP6E2HHPpWGNtsvRtk7S0yo=;
        b=mKI2mq6ykMRuz96Tq9ilzvXDBu34Ea7YG8doPKu5+U2eiVA2CD6XhBdFtHolVXBg4y
         wg4ZoUWg0pHFMpaq9rLHlphEiIGc4HGbq1CShHc4Tu+UTEX/DdRFt4GT4B1JUEJKIyIC
         XdVkjHLrZgArUzuyZymv10/yj9Q8RM4N3SCWJ09H7/6iQkm5nRHB8un/j6azeB2cd/FC
         JYq+jvTRgo5WTrqbxjsq8yJ7bUrrs5D4gUxstmknKkb6YRLzy7wqStVdM9n159Xm+Ees
         ZkSRi7u9bXwG2Rx7zb79ewK/DbK03QP4n3OubrgXVWWcXr6jKsuuJ24o735Dq7FrAMn3
         7rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706102638; x=1706707438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02kXXgSqM3f0wcrI/acHfP6E2HHPpWGNtsvRtk7S0yo=;
        b=vfLZC4+fGSDntWzoqIrV9A8TxGZseNeku44whwOdhJtUwcIGp/pueOboUH9i+VcG04
         ZPADoNNpHIETNplo4CelfdTlKQ0C3unD32zupsrQuB6+A90JzTLo5dgie/+sEUDfNbX1
         g1kkKl1+e5Oa8xmpkpL5FzbCZYWDssWDKgYGd7CSadHxrtCsIVAx1BzMZOz7kUw8BTjv
         FI6bdVWXTZP0fc6iyolcHBfmNdBNrxzjwBzubHrvQ7PGit60NHxDtTIp1wd2KWAQqtxt
         KZkBAq90oaFnP7aVAEsrgXELIyhwqJVc09N6aVMW6rbB2yldKfQ1fumRIAVNUH+br3Hq
         juXw==
X-Gm-Message-State: AOJu0YwNl0syr82AkZIPNP7DywmHJERojpUtH+QCD2U9Ol/+ywhud5y9
	kuV0m3Z8Iu21ffcpLWJVgwouEbyFdYB8bYDAOwFhZklZp1W9G0dIK6xqMvb2Ho8yLIpGkqQCzQU
	4ICfWk1t8K0vqie8TxO0Yms6AMOHi/P84na+RhA==
X-Google-Smtp-Source: AGHT+IFH+XBA9wdCSOw1u5qUmb6O+RjCCUttprLGBuYUvW/Qx2Oj2rYBLNR6xNbkGma97W1xgWndI38Q6iyL8lz/wh0=
X-Received: by 2002:a05:6122:a0f:b0:4b7:8e5a:ed86 with SMTP id
 15-20020a0561220a0f00b004b78e5aed86mr2395856vkn.29.1706102637932; Wed, 24 Jan
 2024 05:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174533.427864181@linuxfoundation.org>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 18:53:46 +0530
Message-ID: <CA+G9fYsg4b+QF_X-GaJt1wENoEMxokx4RFoOGbjJ3-PHE6c_cQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.14-rc2.gz
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
* kernel: 6.6.14-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 86b2b02ae53b684a71d629c5ae2511c2e0d0f675
* git describe: v6.6.13-581-g86b2b02ae53b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
3-581-g86b2b02ae53b

## Test Regressions (compared to v6.6.13)

## Metric Regressions (compared to v6.6.13)

## Test Fixes (compared to v6.6.13)

## Metric Fixes (compared to v6.6.13)

## Test result summary
total: 153830, pass: 132159, fail: 2244, skip: 19241, xfail: 186

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 52 total, 49 passed, 3 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 44 passed, 2 failed

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

