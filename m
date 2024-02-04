Return-Path: <linux-kernel+bounces-51809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CA848F90
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469D01F21E52
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172C249F3;
	Sun,  4 Feb 2024 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjHIS+rM"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372C2375F
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066264; cv=none; b=a9A8IV/XB/ytHT4FKBHWWrPnncZisCHKNTU1aQRj7Joz9/WYVxbbvh2TIS2HotR1v1axeN5vUQR9H6/gh2esAfMj9+qJAImJKFOCrrjCDFancZ1ABvIinhnwJwZ0FLHxgaCwkTrYRATsQdMmy1fg1jgEDPMAOppVubP6Z4PtIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066264; c=relaxed/simple;
	bh=yX+h8IvK+A/IWb9Fj7CnGrWJGC/nKsEUvKUrijLKEUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcEAS+n7Fp6HFy9fteLKPjECENlErXGj4RfW9HNjUz9D+PP7UgAAhK3iktGyfVgaLjNKCBkoI91SrOBReU2ZVsVD0naRtzJ4muSxTh8UuQLSFs2PYD1FxfhBROBYQAXpKt7doBFQmtCKVt0VgN/UACV7EkIqzJs6663IIzVDbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vjHIS+rM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e1214ae9d4so2031258a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707066261; x=1707671061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ87Ikp1Acr0lR8nPCsHqhfw5EfhYftxf6b1PHlKALQ=;
        b=vjHIS+rMbbP7/Qqf6WxjvFfpWhbZfMGwOjTFB9GRjucIHHFOQE5dVVkjSSbPfNBjVw
         8/cISihkaUfVSuj2k+w/h8id2R7kyVZBYsHTgixoisfXjMpj4HvwO/Dzcs2uMS9Hco/y
         eNbHm8SAYWpD7LlIJ6cXEc1sz9stRYEDvCXHXRsaitcE1gZ8dLt3xrjhukukULjHdHLo
         0NKAoeipQdWCdT7w5/DC0nYv68+aShMiiaBf/JO2UU7/uZQz+ItE5c5tZspt6tDk/r48
         sTGibq0Vcedl0e8Fv54htTXZvd8VMv0XYhsdLwztjQr9d2dLLlUM49YGJRwOLvXVmvRy
         8mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707066261; x=1707671061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ87Ikp1Acr0lR8nPCsHqhfw5EfhYftxf6b1PHlKALQ=;
        b=H6ERy5EOR1L6fiZ2+QeTk8rlHuvEr+1JGHjF7N5OFrfrQNKu/+/pc3rHD5oqfHP9JJ
         ztMQfnQ9gPKMjJDD5uq9Tzkcyy9M2vdQ+DSvbgVhlUVKYMv+JJAD/QX4KdVCJnn767J8
         0drsL449XasQRX+gRrbp8HlDCdw6Ls0+LpCSh/1E34Iu+elnF1p/rS60lNtTX9+qCy+Z
         gZSxk1Oc24jV2k+DuTOhcNKqc1fMUI0ZNOG0kzIPbRYL7etjXvz7owlHESJz+q+6zI3h
         Xfj7yDXoyvvu/mMPUb/OLcLc6gw/qMmRrNt5ZLLcUg7GcXz9ceAiLXfYoiZmvazY0ovY
         bAqA==
X-Gm-Message-State: AOJu0YzGF8BrGJeovVgJdeQFcm6wE6CpL/MmW+eXYIN3Hz4WM/Q0ATz3
	0NskIXIth1DtHjZVeV2UlyOr8KTkSgZrp3k6IqXJ7gUQK3WW7fXWLJ0WNdjGpJaGxWMH3DnLfPv
	3knLvnekiy1yrkjHcd8+ckZhgb3jtGrJ+vF87OQ==
X-Google-Smtp-Source: AGHT+IFyki3C2fHB5tLh21Mi14JEHuS5/4QIiLwhXFkotGmhY7RN+9cmNc/XKl960Uwp8wmTxGzsZFEJhWTLUUDFFkc=
X-Received: by 2002:a05:6870:c6a4:b0:218:ea20:4a7e with SMTP id
 cv36-20020a056870c6a400b00218ea204a7emr6467887oab.42.1707066260676; Sun, 04
 Feb 2024 09:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174810.768708706@linuxfoundation.org>
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 4 Feb 2024 22:34:09 +0530
Message-ID: <CA+G9fYunza75sqMnFW8TOr9UsNfwuBFRDm=+BnMQ5kXJmMSFmw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Feb 2024 at 23:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.16-rc2.gz
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

NOTE:
----
Following Powerpc defconfig clang nightly build errors noticed linux-6.7.y,
linux-6.6.y, linux-6.1.y and Linux next-20240201 tag.

  error: option '-msoft-float' cannot be specified with '-maltivec'
  make[5]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Err=
or 1

We may have to wait for the following clang fix patch to get accepted
into mainline
 - https://lore.kernel.org/llvm/20240127-ppc-xor_vmx-drop-msoft-float-v1-1-=
f24140e81376@kernel.org/


## Build
* kernel: 6.6.16-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 8e1719211b07ef9172b231100722f54ffc23ed27
* git describe: v6.6.15-327-g8e1719211b07
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
5-327-g8e1719211b07

## Test Regressions (compared to v6.6.15)

## Metric Regressions (compared to v6.6.15)

## Test Fixes (compared to v6.6.15)

## Metric Fixes (compared to v6.6.15)

## Test result summary
total: 155032, pass: 133733, fail: 2219, skip: 18908, xfail: 172

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 147 total, 146 passed, 1 failed
* arm64: 53 total, 52 passed, 1 failed
* i386: 43 total, 42 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 34 passed, 2 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
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

