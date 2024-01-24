Return-Path: <linux-kernel+bounces-36552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7F83A2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C92282C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90EE171A9;
	Wed, 24 Jan 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyvmtfj/"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB9171A3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081785; cv=none; b=Y7eKPVXm1do/mxLblAZeiuXqIt4C5Qce4xdtmBB6ceWwk1qmuYXIJiV/sYc2abxDj2CZcmQ4w+4S+/e58e472fAQu557OMiP/293V9+an4CYft3q3bAzQ5VnNUg3bMqrtj1gmrHsuXSeHP+2bDysh0r5rb3HWcONP44r3OesEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081785; c=relaxed/simple;
	bh=e0BbWjmXTF4mDW+eBPrjFjLN6oi3tqAJ0DmGgPhLp9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVV8bsZbgYEBOw3BjMhzALmxncH8WViSAj3hh0fGoCvT5AJ8PdmzMQHwtGGnRIbRkwHwMhbKxwgeqP+AKqoBb4MckxXU2x3QyjcS2GAHHhbG9KKJw688bg3eVAgsJys/NSu4YSDcLJP9sbKGTShoXnPvGijXfGqpQURn0oLaQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kyvmtfj/; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7cbeaacbcb8so1278302241.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081783; x=1706686583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tnlKPFQfe226jCabO0DUQvdKB30ImwOaBg4mp/H49k=;
        b=kyvmtfj/J8qkhpXo5Ou+slRP9v1bpOykweNins6pbdeB0+93IBfyozXGBNrXQWuxMY
         4oWl+DeRhSwe8gCTUzM1D1PrnKFCqOMwZuuUhLuhuKJyHBBrIfLi0GxJ7qhUqldAlWT/
         Za7/bYrrhRPfASJSJCR9QXWcRSAh4bfxy3AphlLfkLBpAuXHoMK2C3hwJbNrtEAf2dwY
         Sb7P2hL6czodr0aPDpfSIGpzMtr1MnJl4IwIvzVTWQJAxiyx/7ln2G5CNmyrMSsxQPf4
         tZRR43BqCjw1aFxj2MP6+qHPOs6VFBQjL972OgaBvU/16WZwoN/zkmwpNpgWnAsCMZYj
         GXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081783; x=1706686583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tnlKPFQfe226jCabO0DUQvdKB30ImwOaBg4mp/H49k=;
        b=Un2VrOx1M2/ttEtH3YOQ3Y2OVOSXI3ntk7WOX3Z4dAbV4F+RgM8r/vKXNpqldFOF8y
         809X6HRiTPsC+0LWL7aHR4Ywl49UtfnSB1n/wWXOvZQgyvCW1v8t4jqMp1/AvMRN+AvA
         SZ1ArRGoJbou+8mlCJO7YU9JBeCHAtPqkqQ3FVx5b+63ELuj/tzuAQZSUuRdE7NRQm1n
         w9ZPqV7FRbEQUv/xL/UVtwM/zZ4TyhxANMzJzTI+tWj+I58bKFSQUxE+jY70dfhrz3ft
         QQUiXK8aOElxi68PTvM7FXi29Jp8G6Vz86sJzI7gt5ObHRG8w9qZGGWlyxWsur4IFcWD
         USRA==
X-Gm-Message-State: AOJu0YxYIVoRLIWk2AFsnVtPk47dioNqMziWbq93et4e6fb5ZSizm1ya
	MQA0Yh9ZBTbTmW8u2RM6SpYOs7kLGspnQuP7CWepQ3xCUuHWkSQtQWElwKd8GnyFHYXnixQQ5RO
	AWRACnI7wAer8JCSauLy5jA1mjyOsOMuNlG+xog==
X-Google-Smtp-Source: AGHT+IGFlsBJwlAN5HEFORTByTKreth26xjwcga15o9ftsYVovMY0UJ34jdMY7lM6EopfZGcrjAIX0tjKN+xMDljZEU=
X-Received: by 2002:a05:6102:3753:b0:469:bcbe:b10a with SMTP id
 u19-20020a056102375300b00469bcbeb10amr3503077vst.2.1706081783017; Tue, 23 Jan
 2024 23:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235712.442097787@linuxfoundation.org>
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 13:06:11 +0530
Message-ID: <CA+G9fYvhkpjBgZ8XaSVJ+c_cdOU3=PYxDK0u-1Q1BaKDsVQfFg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/148] 4.19.306-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 05:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.306 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.306-rc1.gz
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
* kernel: 4.19.306-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 7d9c60a8fe13297cfc26524269c271688d817a98
* git describe: v4.19.305-149-g7d9c60a8fe13
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
305-149-g7d9c60a8fe13

## Test Regressions (compared to v4.19.305)

## Metric Regressions (compared to v4.19.305)

## Test Fixes (compared to v4.19.305)

## Metric Fixes (compared to v4.19.305)

## Test result summary
total: 55285, pass: 46655, fail: 1600, skip: 6997, xfail: 33

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 114 total, 107 passed, 7 failed
* arm64: 40 total, 34 passed, 6 failed
* i386: 23 total, 20 passed, 3 failed
* mips: 23 total, 22 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 27 total, 26 passed, 1 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 34 total, 28 passed, 6 failed

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
* kselftest-vm
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

