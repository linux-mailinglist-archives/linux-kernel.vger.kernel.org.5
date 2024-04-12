Return-Path: <linux-kernel+bounces-143197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E618A3596
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7011F22B75
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9414EC57;
	Fri, 12 Apr 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ct90XKBv"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834014E2ED
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946308; cv=none; b=TrUkkfc/oiCnqhKY4I7wLkKNUOz0cdiKZYKhFcWOiDTLl31XsuEWKPIvpif1/fc4s1vQcEBHZ4gyBc9ZVaTsrhW2dSzI/xmi3z8/MxWknlm+nJ71j4Y9V8mClILD9J1JDQRF8CYWciC8bffO6xXjDOHOoTqsntBGzfFqlppXdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946308; c=relaxed/simple;
	bh=ry66YQlyt3rAYniCDBOFkCGxY2ZiHVBUqgNRBCuc3PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNMFDrM1FfKNH3j858l/a6tNiseJkcBQMvMod0Ptd5US1GFkYjh2EahcazNzpU2Vz6Cij36PZLvZwMZAqh/0VOAR9TD/6hOjUPgLLe6eh35N/001V8q1U2UtOfXDh7/ZMUczV3NJVFDKcyt6KzfHQrPcfdLngm2LwiCJS/FqLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ct90XKBv; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dabc6f141bso384942e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712946305; x=1713551105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQVC4UrxcWEkIXkGeGXm7dBR+1G2Vzp/gIdMFXmEOQM=;
        b=ct90XKBvrGBu7+PmkCT5eFkaYTDuHA0NpasPZUHElDejtrA0EphD08Bv0sAi+LSJEB
         yp1xWUj1f5lqfrYuC3oqULSuDPVGLXIjGliaFioVaRd9WuWf+hUYYeu9+urWB3IIKuen
         GK2jXSTN6VxuyOKIMfQ80gLPqU0eFB1IxZw6Vzaz6eSdKES0UPOZsljwFBsllI4QDCSV
         uodknjDMEmF1OFtYb7KZQu+jgUtwd/iiBFFxS6yuB9IG6dKKZ25QjrtzPMujAKR0FUlW
         yFZXTYj75QRgaeKbs+nHmaMZzQ4Gmx8WdzBoZ5OfQAL47k0xYz8OHxRTdBPlfv9COgH4
         EXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946305; x=1713551105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQVC4UrxcWEkIXkGeGXm7dBR+1G2Vzp/gIdMFXmEOQM=;
        b=ejyG3W5Vwy19IHQpc2fP4H60aiCLGfzJD+d4tUJqJSccpi1XJ1Hzv3bD7KvYNnVrx2
         v4JvsW+6misX3jUBt5leHG4e/QUkd9Tp/5FgII9qG4HvhVdE0s/RayGxlrCY4W9qOCQx
         SivwP36faLCMUNkyJ1OAYvO34F5+ngaPUgHnKSxX2z5rWptmGI28PbOBy2aLHvdb0Dst
         rzKphIQ2bn0McjmfquKNn85ycMWikcRjQSEmDfvsLmyBXz9deUO2Sbgg2Bk4CMYWFYwi
         bB9K+m0XAO9EtizwA8SO5uF6xafRTeZTP8IVxJHsaNVDDq3/Gh8ATTTJ2xFI2g00176h
         pahQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKfMSEcf+RY76ir0bwsZaWBb0ktYi6pu7JEwNT7Gc14T5ydqY3TvI91F3lPf3dehggXzYgDesWc+4bKvgMhe2bo3yTqhsKRB+LI1hw
X-Gm-Message-State: AOJu0YyqEWJThtF+LBSWKKy7U2r2e7zc5Gyzic9mB73U/dPGKabffjvg
	B8hlbKiMh03XH36f2F/2wyM+bRIAgnaTwcwUlu4Q/vQtbJV7Ro0bkqx5Jdv2jipYGc0fL6HuODS
	rGuoNJlO8UpZWhhaKGvXyHn7JExy1bjVBNwJAHQ==
X-Google-Smtp-Source: AGHT+IHMP9iSKz9Wkqt1WKRSp65sfJmSOV5flXRlhZ3cVhkWjFku5qz8AJVj/wKL3Vrf+35SNZ0bmN6Lzol/yZLlCLs=
X-Received: by 2002:a05:6122:3c56:b0:4da:9d3e:a7df with SMTP id
 fv22-20020a0561223c5600b004da9d3ea7dfmr3994403vkb.5.1712946305324; Fri, 12
 Apr 2024 11:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095407.982258070@linuxfoundation.org>
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Apr 2024 23:54:54 +0530
Message-ID: <CA+G9fYvGhW9dNHWiDwe1nCOtEMqbVuK7zC9kWQjvYPTb4hrHHA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
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

On Thu, 11 Apr 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.155-rc1.gz
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

NOTE:
LKFT test setup using NFSv4 do not notice LTP syscalls fcntl17 test failure=
s.

## Build
* kernel: 5.15.155-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: 857e7024b96feefc0c2ab59eb5e661df777e6a72
* git describe: v5.15.154-58-g857e7024b96f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
154-58-g857e7024b96f

## Test Regressions (compared to v5.15.154)

## Metric Regressions (compared to v5.15.154)

## Test Fixes (compared to v5.15.154)

## Metric Fixes (compared to v5.15.154)

## Test result summary
total: 93809, pass: 74866, fail: 2649, skip: 16230, xfail: 64

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

