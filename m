Return-Path: <linux-kernel+bounces-76758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A585FC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C709B243F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4714D43C;
	Thu, 22 Feb 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWHiGsi3"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03614A0BE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614988; cv=none; b=tdQ6yKvf+Sx2xAsgUZ/rf+ZPo6cF6Wj7tusLalc4x51DOH8JE/lO7sN8WjB4ocbUu1JsMxBkqfukRWJ0AR6T75RWKNifSrxMGUivMs2IoJsrURaiHN0ASI1iDtcUWlNfc5/kTZndsW90hDXN74GPUtkuvXkpJ8ErFQQMs++GIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614988; c=relaxed/simple;
	bh=icxcY8uc+o2IJThcPoIsSP21PpsdAb6o+f7z+Pdo2xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nn6JqUaalvFzqaS6hz5Ymy5HTmVFv7mR3gVha+NQo4CURsSC1Mg902k7LI9XB3pIIW0k9NYy6tK2AB8Hwkv0HDL3qNvXxOa3yXwTPzYZkHJZo7MnB6pDbctpoEYDczypQmHZf7+8rkdZZpm1yZnLpnKAJwpqh0HnylsGEEhTYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWHiGsi3; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c15d67b83cso1814779b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614985; x=1709219785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOdoTYWG4356EXT02DJVT6VCmhVf4Pj9aUeOKw00wQE=;
        b=oWHiGsi36O7i/kEQxaD6GjAk+Ik6oek+Wzv980PYR/qNnVoVnH7R5R5PlKtWD1i2n3
         ysljFBaOeydAUSos5Ml9NR4gR1o+ezFPQiCQdtxK7mv05JzPkppODX5JWgDGqeY0lVq8
         SS+BTH/06HXTT7f6Wcnt/lp/b+3FCOiNPDC32QJmaU9SeLLg7mi/sMS/Ep5CaPPWbzXW
         go7cuvNouDDdGiY6t4UmFCg119OBNf/rtaV+V/z0aKMjWKGVbgqL3oseD/Wqy3N0Li8A
         ypOgya7cDuE4VBHc2+ESkhcu08MwTSat2kV8ure6h00e3VlUKzFWbU0WM+9X5mOeFsNc
         nkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614985; x=1709219785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOdoTYWG4356EXT02DJVT6VCmhVf4Pj9aUeOKw00wQE=;
        b=o3lTAe/ofb3HbecGWZOKlh0MBqvpf09SSMg1D6Z5ImAT3qBlMfTvM59OKFBxVn17Qj
         IQ6AY9PWZQjJNiaFH4v5NV7HyorSayCXBup9F/8RrfDtE2aL5qzjjSfTQG70ZRY3JXnI
         +aGWKN9D6UykFRIxodxsA9eHnKv2Z1vcSNe/yw8RV0OtRx/D2pkbFFbzCAMWbEtUfRoJ
         bbSYehjADMuc1R84R6NtVimMCQmJkRlrN+fagzqHg8DwDDHwVzODAaS5nNlTfAhFFBaU
         cbc7Ik/CUAV1hHUvEVVReZt04K5tn45hI4zJJWwMzUS55j8HncIUqgxMr1AImSshaQ0o
         sfsg==
X-Forwarded-Encrypted: i=1; AJvYcCW0F0ZUjHy+8Fxf/QWiU7duiL1YDGNR/v6bD0jAS6+KEGpWrxlp7dTgnA5J/E483/MvgjBBUlIKIzc2Uy9qtZISikyDbghIGrY+2jjI
X-Gm-Message-State: AOJu0YxJojJ2I8uYqh554p2NXDWiztpqDvFV73N1Dey3w8ygmJ5I5Zd0
	QAU6RrysBRLebTOi/gpDTpiIV/9JaW6Bs7WcZmNczOunFAFEQi7xHCsyZLqKmCfuJ0DAONdmK3M
	AqjpQjgQZkYC6WIkpkjiey3LU4uvwyZkcCuGBuA==
X-Google-Smtp-Source: AGHT+IGCT330ABEop5oo+JQQNQCzzjy/J0/pVrUJRTO4UAFq1whof9j5GRM6HGVl3q5ruQnmMDsqA0wmrtK8eiuZQa0=
X-Received: by 2002:a05:6808:1719:b0:3c0:33a6:bbfa with SMTP id
 bc25-20020a056808171900b003c033a6bbfamr23615419oib.48.1708614984711; Thu, 22
 Feb 2024 07:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125931.742034354@linuxfoundation.org>
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 20:46:13 +0530
Message-ID: <CA+G9fYsch0VPsmTTfR-VN+RDZCNC4F=3WXiN9KuK2yNWTK0sMQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/202] 4.19.307-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 18:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.307 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.307-rc1.gz
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
* kernel: 4.19.307-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 05a45288956cb4f8bd2d47d10050520cddfa9063
* git describe: v4.19.306-203-g05a45288956c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
306-203-g05a45288956c

## Test Regressions (compared to v4.19.306-165-g6d7461510b51)

## Metric Regressions (compared to v4.19.306-165-g6d7461510b51)

## Test Fixes (compared to v4.19.306-165-g6d7461510b51)

## Metric Fixes (compared to v4.19.306-165-g6d7461510b51)

## Test result summary
total: 58627, pass: 50543, fail: 940, skip: 7095, xfail: 49

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 36 total, 31 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
* kselftest-user
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

