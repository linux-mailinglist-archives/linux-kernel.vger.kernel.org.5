Return-Path: <linux-kernel+bounces-84700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDA86AA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163A61F24958
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69E2D605;
	Wed, 28 Feb 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIt6z4JV"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0581F608
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110210; cv=none; b=n3fz5EpV2MyKU+5rRTHO82KXmID5Y20A8pt7YbpiZ8nRTnC1DE4OY3raaU0T1wOueHVLMiIVHX++/nFjMDDZJuXt35eMJQF+/vXBml4Pr8o2AwGJIBWF5+jJUec9uo3OCEZ4RD1I+SaN/rFWf6PCq3SA7w6575VqJPskPb8PAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110210; c=relaxed/simple;
	bh=mLh6+aNUh4FntiPlQM+P2aEMsa+DZhrGXjkKdK+LLcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0uNpFIJ6L4SZumi8638xskan0CgRr4fsIsqTMZvo5dx5wQe6dI5DwXbP7YkrYgQ9R8I3xpQt1i001eAcvrRgykPUa7aKnzGHWRekTX3KystO8ncSEGK/NPs+30n7vuBEFSRL0YYGZtRvg+rZB/B9M8Ls894A2qwpP4gUj/mI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIt6z4JV; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso2669786241.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709110207; x=1709715007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfLLRr+7TVO9BIvaySCbRAIq29D/g1YN79CAfZ4LjO4=;
        b=IIt6z4JV9PCz5TFU72hNW/YZZvY1eyCfGJm+sD41vaKJyIwk2u4oLVcFfm250OiZIi
         cVsAL3AEwgF20/oDTjtPKzD5aDzac/HrKqdeOtqaL4v4zx+gqR63LVIWCTkiS1Ep9dw7
         LCvCtJHxr6y6lKLDB2jQ9VlI/HiXQ/hWQ21ChULMYzliOLYNWEQx1fjaU6suH9Zm5uXz
         K6nj+0gzYi1OmzuB90dC2LzpLrdAmTGRZqrc2+pI/Yp0yi8gV0zUMPZJgqZqD8lVwf8m
         G/0Rr7CDjSsH15NV6zQFh4vXyqr54ZJOv1B1ocscoehJBEEcPvPQgokcJ0DJVVu5bHGy
         HhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110207; x=1709715007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfLLRr+7TVO9BIvaySCbRAIq29D/g1YN79CAfZ4LjO4=;
        b=BoSe1UwgFnLCN/Mj9g4TLs+O79d853/m8xL/i4UzUqTFHSKwRBrH0O/mclr74Z7Xbj
         GVM+9PucDZISts/vhAhpUVu/q1xwBhe69SpH4oJ1ejvFgsu/gUuQpp3ShN5BLVPyClq7
         UfQNanaiV6QI9eZPVVLsxJ+TgJN9VRS/BDM6JC1LjmXN6tvNTeBvJST02THlf3UVWJN6
         kZyK4neHwW1po5AQUdnjjlMAbwYC4SNrocx3OXNmhrqmVOvT0EJqzq0XMes0WkJDD0VQ
         n5URuhFBJC7UA9cvpE2J36R4JidZbMWW7o07bnPzTIV9vQUslRl4t3TbP90km7J6dBNZ
         Fb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSSHk/65pDqDXuCop/pj3rluoo8iiZILO4BiNF83igFdijd9BoixjT3nQcENVEd3yz2/gy7VLAQQVElGJMYtsob5xTD0gX9g1eJEvp
X-Gm-Message-State: AOJu0YyHkfo/SyTtXwVQWUJDycyACig36Hr8pKWEw+mM6ye3zEhdCeVr
	NtjzE84vhAwBiE7c70lFKpHlmt80N/7GSzYkwFQzWXmSz/9iP3a+18jsHt5MuT1cp1NZbpVsh4N
	ruNdy1o0+Pga+8ibRUDArsiXjXeXlVzgKaM3snQ==
X-Google-Smtp-Source: AGHT+IFnsrl6gjCAhHgO8koFIoHLY5w/+IhehRrtWDWApTw4cgij5r0Xf31CBOYKUW7xMtxXK+PbUVZOw3b+zV+49jo=
X-Received: by 2002:a1f:4e82:0:b0:4d1:34a1:c05f with SMTP id
 c124-20020a1f4e82000000b004d134a1c05fmr8561580vkb.0.1709110207559; Wed, 28
 Feb 2024 00:50:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131548.514622258@linuxfoundation.org>
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Feb 2024 14:19:56 +0530
Message-ID: <CA+G9fYvzwLgC5i-vzN22x_ocjDRD6EkYwtYyKrH=DUZjumz7vg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/52] 4.19.308-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 19:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.308 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.308-rc1.gz
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
* kernel: 4.19.308-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 6ea6c59b4f34e92143ce345e6b727f8d88ca98d5
* git describe: v4.19.307-35-g6ea6c59b4f34
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
307-35-g6ea6c59b4f34

## Test Regressions (compared to v4.19.307)

## Metric Regressions (compared to v4.19.307)

## Test Fixes (compared to v4.19.307)

## Metric Fixes (compared to v4.19.307)

## Test result summary
total: 50056, pass: 43934, fail: 563, skip: 5518, xfail: 41

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 102 passed, 6 failed
* arm64: 33 total, 28 passed, 5 failed
* i386: 18 total, 15 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 23 passed, 5 failed

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
* kselftest-user
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

