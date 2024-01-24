Return-Path: <linux-kernel+bounces-36971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6CF83A9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6351F2B1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7E8634FB;
	Wed, 24 Jan 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4Z//HQg"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64518634E9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099048; cv=none; b=QuTKv69IXTs+S4Oq70qbsOrDxPuwznQOrfFL6zvF9KX9uoJ/l04ENYs/3BS7TnCGC7Wx+yyGPA1x5e7JMceYtkgBpDUqBa86OPdDvSY3PuiQezZ1yj6LyLRCmjHwl0DGPVrL/oB/eKGIS35PZvdBCqG+SGUguzC+L8rEROkmFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099048; c=relaxed/simple;
	bh=rGdFk8uHaZxrli54fy00MBEoautph1gscqn+/tFyVKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op4F9a0M/zdEqMz8aPBjWsNLmmhtumW1w9bGxTLe3y40qPQ72CfP8he27xaFMZeCctgMduEYUdtzuKJKd0H75DsBoHM6XZ849Sl/XN1+Ae+n+sYxVErD5vgY6DLX0wa/iZQWzXv/QYCtuktJxd4VJbyLDi/15FvQa66sxeC6mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4Z//HQg; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4bd3dcee54eso764431e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099045; x=1706703845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B/KKXJqlXiP4vwNoP9M2ztX30MmH6mObOLpZu8w8tU=;
        b=G4Z//HQgvOgOkQHVGkOJ1IY1GtNE4UxO39ePWuJeqYS5nfNENRSPOOoiP6TSezNcNh
         6CWlXren5o4V4+6nOC/koNUSqomrl6fizb+whHF4Ns/g7sPbmNq2nIRU0focE4o8Q1Em
         YEi0+yU02JIIhdBpQAxReDtTonH+Ez9fq7ldVHJ9J8RitL5ssUguWWrSLbVJGC0clwfi
         pHjyHzDgcqmDMMjxxwWKx22Wpzu1tLTL0FPbe1IKE+ZOQNJwYAB7ypMFF0xSIwxZPnRC
         crb5Kt661ibdfFtrSljjUEfkCK7KbHBRI81Be1xDGC+PAoDIupkVvBQUjeX3jxnwqrAG
         weLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099045; x=1706703845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B/KKXJqlXiP4vwNoP9M2ztX30MmH6mObOLpZu8w8tU=;
        b=PBs8VsrfVDymBqka/xR2z/41f2y3SgajhBCZyCAng5wN8rKHNECGiktw/e01IX0yoo
         9eSHaFnV4TfJdmzokEQ5kjZSWepPd/TjAlh6H21ntUzMqtnvHcegwAHJbiT3tbmK7UkG
         tKQQBVOqQlBd14kIvz1+fGF0EyQNbPnSEXgk6mnFyg4gcyue8U5iZvS22On0Dxo06/BL
         SNm3JhkFR22P2snn5wzYK7lVIWbTaYq9Go5q59PXmkrDEUjJkkSLoGloELy1OMTZXJW1
         omjt+WHGGs0RCvp+XeU2lv+GxYnj4BEYVMIKeLuJJiTJhyXnBOi9s/W47IzrL/3ALOsm
         GXew==
X-Gm-Message-State: AOJu0YzBCDcyGJrw5dnp6gZHab5lsfKgUWjuh2r6aQUy2E9sFnqkaCBF
	fBDF6MFJqDkTuBzvMDkbh5LPuo0UaXrU7pwd13lV7XOmlglrCW9wRiPlI60HFOZ3LlfmFlOBNVG
	ZHEy8TTVcTt/BxSVaMWu0lbWs/OGocLmrnBnruw==
X-Google-Smtp-Source: AGHT+IGku4y0SXA0K+K1f2yfKzalu4Ew+iZYDkbMtOJf/XET/MR7IHirdCrkQGkQf3c4pXRvooJ32OSvS3GM8KahpKI=
X-Received: by 2002:a05:6122:44b:b0:4b6:dbc2:1079 with SMTP id
 f11-20020a056122044b00b004b6dbc21079mr535782vkk.0.1706099045094; Wed, 24 Jan
 2024 04:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174544.648088948@linuxfoundation.org>
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jan 2024 17:53:52 +0530
Message-ID: <CA+G9fYu1pXV_9LSn2T0PNaSUpH-WWtuhaDqj1h4u211DYXMT2A@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
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
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.2-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: 2320541f64baa0c9f5313c2100809a2e26d333de
* git describe: v6.7.1-639-g2320541f64ba
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.1=
-639-g2320541f64ba

## Test Regressions (compared to v6.7.1)

## Metric Regressions (compared to v6.7.1)

## Test Fixes (compared to v6.7.1)

## Metric Fixes (compared to v6.7.1)

## Test result summary
total: 142436, pass: 124243, fail: 1105, skip: 16870, xfail: 218

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
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

