Return-Path: <linux-kernel+bounces-118615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2B88BD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B199C3010C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E245970;
	Tue, 26 Mar 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gk71ixTj"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49B3DBBC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444174; cv=none; b=ah3viPSfCXxyYECefkTW+2JmGedODKla0pto5eX0GbinrqVWWMxuy+YvlelpWFDYj4kyMa1FUtDMFQZjgGkblYvSO+zdmCS1K82qmLcXg65t4xBkEKQ1bxZ9XPIMhnLVR0CggDkTQuW9NWOp2s7S63tmyiN17rzHbfnIQvHxpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444174; c=relaxed/simple;
	bh=1Cx04eoFiCYEMrDDelgoUoSzamLHHlA1rhJsIdRIBW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNSfwY7FRYLayixc3j76Uux2QX6lZGNs7P1XGUPcKPH+2i+DRzzI082/N7pBfn4KoNbU5lvoFwV9NI8qNljTBUULS5PV4ymCsE6ymu41a/VyiSPQZKrv99D/Kkk/WQmRxNCns6z3F3Qe4vFoNcWffTtWbHLsJFBZ6Ci+wG+NiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gk71ixTj; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4782cb1162fso112255137.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444171; x=1712048971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAx6tSw5bngfa9pZvJuMCVZUG5IHWQgCi2l9He96K10=;
        b=gk71ixTjsgxPchoIeZj8MnktiAUX7IwHPGbGkEND2X0onR+cmTGx8s5j6naynnbEoq
         1ht/LSbn0zTmwjr+iJOA+Zs4gr0KdYJfPItUGBQQoKZiVBhJymCluRtDlm5NZRKe6ktO
         TS9V3MzRX2urzZP1Nfxw0m3LAy1AWDVkz3Kred/bmk/w7EFImGTbHZkPH5RluodGy1OT
         j2hIC10XUu2OPBca+ceQyQM3R154BjS+F0msnVzhBRGWduy0ApFjm1qNFCB+hzYa7xmG
         ekmR+JWbvTk6J7WGoM3VKipZuHNKvWEIeV5ZEejkv7BdY5WJtofimPgV2cGWQSEpfrAQ
         6uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444171; x=1712048971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAx6tSw5bngfa9pZvJuMCVZUG5IHWQgCi2l9He96K10=;
        b=APMAdqeG3Tdlt4kB9/U/pC0uBnUqipf6IQbtADjq850TF68ykZPdIv88RqTezjIhHV
         U/05n8MH12FjWNdMhpNsCU962PH50j0dbNB3a9hWqaVINElWkUbK6yuCPmlifpiDV/V3
         8HwB2jbPZwqGm43PXs4iMoPNPa44pm2XcurZXO8wMDfmZ/hy0WZR29fsKASH4TNzKniM
         FUF8IaXeExL+NvJpApWKrqRI+bI1F6+SrQIYIhN1r+mkuOW4B5/Znn0Yr61/jnh9LzP5
         U89b9vg+9W8iS3jiPe8lDooGbQ5LNIgp0CfKS/fIIh+ys5uHm/RxRjM00UbxMMebz4Ro
         ea+A==
X-Gm-Message-State: AOJu0Yw1qbGsicxBpQqCGVPwO7I5dvqXscMycAg9zVWweP/8mCCMOMv9
	7km7jbLA+dzprnoMEf8Z2ws7LyDMkj2s9SbrkS6aZP0Q/08kn4okunQF6saPHsjg9nO8RGjEVtt
	hMTtIESUG5rU1bU8Gl3F/gPtDRvS92BBusEZPPw==
X-Google-Smtp-Source: AGHT+IE2Mo8dZr0zEYy0HYiuowiRTncW+PpF8fWgvwpCE9Jngga7EXDxavWkCcitmMsbxsuVQJmvhzqXy3SOPTfeWS0=
X-Received: by 2002:a67:f589:0:b0:476:f91b:2fd6 with SMTP id
 i9-20020a67f589000000b00476f91b2fd6mr4755379vso.0.1711444171518; Tue, 26 Mar
 2024 02:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325115854.1764898-1-sashal@kernel.org>
In-Reply-To: <20240325115854.1764898-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Mar 2024 14:39:20 +0530
Message-ID: <CA+G9fYt2ZsvL4s4593Ew0QSgdJwGMVZyZFcVk7=9V_0hhRNecw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 17:29, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.19.311 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:58:33 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.19.y&id2=3Dv4.19.310
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The build warning and bisection commit is already reported by Daniel [1].

drivers/cpufreq/brcmstb-avs-cpufreq.c:462:2: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
     struct private_data *priv =3D policy->driver_data;
     ^~~~~~
ref:
 [1] https://lore.kernel.org/stable/83814bca-1e33-4914-b00d-4b84ff1a1a23@li=
naro.org/

## Build
* kernel: 4.19.311-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 1bea8803c64aa7439e4ee582691a3cef582f06fa
* git describe: v4.19.310-147-g1bea8803c64a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
310-147-g1bea8803c64a

## Test Regressions (compared to v4.19.310)

## Metric Regressions (compared to v4.19.310)

## Test Fixes (compared to v4.19.310)

## Metric Fixes (compared to v4.19.310)

## Test result summary
total: 48913, pass: 43062, fail: 581, skip: 5230, xfail: 40

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 103 total, 97 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 16 total, 13 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

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
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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

