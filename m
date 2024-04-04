Return-Path: <linux-kernel+bounces-131828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A30C898C48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0234B2A5F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBA1C69C;
	Thu,  4 Apr 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znyZghLJ"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E911C697
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248620; cv=none; b=uN3IL6TAQ4Y8TzkRdv0SuDCKhW+c95IVRMioK/xyBOy/2b/hx3idJGiMHdDJ9WFMvwozrcGUhP5acKYplKrH943mu+InzhRRRBbZfvXaLBRkCHYOeDStOJyu04xniZcD5RIhYy1oXwfaAn7MSAob9bWc5bUlcHKqyrfKexegvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248620; c=relaxed/simple;
	bh=RxA9yYFCilY5dxmQyD6NB24l+ixiHdRnI4CJyWiUqBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmngztT9L7Ra1xUHWdaKNenRbc+/V59SJJxiPtbSezPjWxgQQwbC0uzbiOYdnCl6iJ+uE4AHNquz+t3e1WQ6RBtI3k0bv+tjT8i3bHfGa6O6MfN4LVk5eHsR5WVbwSKnqwTvGBZBDmGLkBrCLSu+A8AcEHlsX007D/8vNytFucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znyZghLJ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e3e522d803so896010241.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712248617; x=1712853417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQYUGCMQImaV9Z+lvySiwhsUlOBH+IYL8YIHyQv3Kjo=;
        b=znyZghLJUZ4ryPU/aGl5SrX20OWJLUExmdl36u9TmRv1U7S71E/VfHBiUd5A51T97K
         Y3C/ueatWp+7SxOdT6JqWqEC00WEiBfiU4apHRUHdlSxF8kkkYQ373YZ08BVozDohHqi
         q3fMoNV0WNltdWAKJteuipJWLLFmBLqaG4XwClifhUGyAaJQiF3ynOs6TZIMSCM7Da03
         ZkBVmstE05HRCgXC2TOSG3/v7iXMsqx7OjOYKHlkp4mJOa6FbosNpjTM4N0RqPqCpt5b
         DBK29ZvVY/GSl3UupOKpGVH9TlAYgJ9JCtdB0G6v2DJqpKdSd1hWeAUTdpxao/sU9Lfj
         xWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248617; x=1712853417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQYUGCMQImaV9Z+lvySiwhsUlOBH+IYL8YIHyQv3Kjo=;
        b=j3Rtr1ciFDnIkcngtZ2AxRMB7d0Nwf1e+1wi5kDALbceMENUVNrcCQpRXTj1E9/P2d
         nzjoP3G0FpElve5icDuIhrdTAlQa3RiWJ/0Qm477t+jFP2zB9KXvdXPqxwNf+qHE5UTh
         9TZfNFAnZ3qJCJUHxrsgJ2ktUBkgJ7LVPLj5AVta4zK64tl55SJnC8JbLgMNP8xvq+eA
         Iz+2AvEj/9NHj/URgAIebuvuNcDEizQrq4bEsS8/27lZy0QHJlDLDSbERHi+lYWSGv/V
         I0ufzddEhBfX+e/ESvmo8S9r3MLx9cWW4tdYUxl8z/hBDoV5iXQ7O96JSSOjeZkfeOaP
         pgcA==
X-Forwarded-Encrypted: i=1; AJvYcCXMCCf+kTxbzoK5aRdjZseYmQp+teO5hrqm2kAhYs8CfD+tZKAWHd3rWAIKqaDy3jnW+8/roEgZHTLe//T46+v5kCBzuAHCiCcqss8+
X-Gm-Message-State: AOJu0YyCEYqtbfiBHpA+US58b3Q6nZsUjzfHaArW6ppYPiA9NXcJ1aKQ
	AAvZR8GrJnkc6ObLxtUq6a9506YYOZdpwyoR/d8TTIEbJhq3rVfefuEe6Y+YsDNAMIdG4cBHN1g
	YCWee9kqWbBo233I/70cl/Hs3W/HKjvJZCQ1Beg==
X-Google-Smtp-Source: AGHT+IEB9OXnZlZWlV9PleCenI5Q0zAtZD2Kw/+SFx8BdfUpqKlCCn5Racdz3Kw/HfsDbCK6I8MQMETqmUG9rxjKzqM=
X-Received: by 2002:a1f:f44c:0:b0:4c7:7760:8f14 with SMTP id
 s73-20020a1ff44c000000b004c777608f14mr16412vkh.7.1712248617418; Thu, 04 Apr
 2024 09:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403175126.839589571@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Apr 2024 22:06:45 +0530
Message-ID: <CA+G9fYs9XEgjM2M7G9kTGs34Khn=CWuBNhTZVMgnM1R9=Hc2Zg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
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

On Wed, 3 Apr 2024 at 23:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.25-rc1.gz
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
* kernel: 6.6.25-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: e253a5c1b7de55d37ff656141e7001bdfd035d8c
* git describe: v6.6.24-12-ge253a5c1b7de
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2=
4-12-ge253a5c1b7de

## Test Regressions (compared to v6.6.21)

## Metric Regressions (compared to v6.6.21)

## Test Fixes (compared to v6.6.21)

## Metric Fixes (compared to v6.6.21)

## Test result summary
total: 121780, pass: 106264, fail: 997, skip: 14420, xfail: 99

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 40 total, 39 passed, 1 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

