Return-Path: <linux-kernel+bounces-104157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3387C9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5281C223B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F91171A2;
	Fri, 15 Mar 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zApqR7MQ"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99F1758B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490927; cv=none; b=N2DMcfGEWkPYjuOTil6+PiHlLPOzFE2Dsb6FzSg1fHCAA/HfN22SAsfsdQB9RXRg0NDYNbjNN8vEppTy6aXm8yJCjbIGl5HyuXGT9ukkgt2rEDyhF+AbKPsLPg3FsbPyoUgHwPXYQxro+sLyPIeSvMgRBIVLFtNCqlsDp/OXZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490927; c=relaxed/simple;
	bh=NHcjghFzW9Udi8NNQzelu23zMyXFWmPqHl0AWI5pxwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6mLc7QtS3gbj5bbtiHrrRt3vEEDQoe9NsIPK3sqsTi6+3CkgfJwWmprQO3yUORRmECNYgcUD3gnBguhS1tqOYE6vGJCCzcpeItMYQi3oLL5oIEByWwn9NHud0hgTXmM4uNVOVHaCwcbGoTKyrA18Uln8s7fxgT31rmSi4dzbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zApqR7MQ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so735355241.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710490924; x=1711095724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWszRLEA5u7NZjC0N75EPYOmHlRnU3yIkg/QcVhnGWg=;
        b=zApqR7MQiyAIlRvbb0zw2pLz6yo7ERKO5yDTwZnj5KLlhmduBNzYtrrT0lw8fuhC3c
         /uhycn7h2c2l0ehHWISh4wYvMCAMGhDY3EWcJ9Z+WDugwVAKY8E5H6VKBdL4OyxZK4LD
         Nkc8wU+tbE1jnkAoBSPlZEsaSkuz/bwkAxlZM9wvMGXOC6Bke0YnElxugFpljYOhflki
         vytV7N2DgaHavsg27pSWObxa/7kEivYwtL25RRPq4Uq0v9Cu5hewD1RVt4Bvnqfw2Pnf
         HwjHKWIFWpESv8mHbl4FmI51fNzwjvI2W/CTWUu2hrR3cFM3o4OGipyl4jl6wqB4/uYB
         WMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490924; x=1711095724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWszRLEA5u7NZjC0N75EPYOmHlRnU3yIkg/QcVhnGWg=;
        b=E3C7LqSNjD9GFb9b+hIgJ6PKciCYW9YTsiofBXCi/K3rvjfATPGIvjFxSyYuz4hfX2
         6H+76pS8vcN1oiVRHLHDCrTgQgOXv8qXu9OWIYKCqOAwi3Ve2w8SqQN2wEvj7XIFSbrZ
         F4cUBdse4Kh+kLZNCIeyWws4GdRY3+zrkRotN5f1+LwLBaRUF8kJUNyjjtb2jqPqK0jN
         YAd2byNTmby3/GSejFkTQLrhes9TQIG7PYGNN4PjJ3IYMMewlbolBmK/R/RmDWhHKXrB
         uT7RR8EdUFhrlUdGJbZVWBBM8lk4R9badcauUqmap+LPzrtbEIfU23UVuNVOLLCICkaV
         89uw==
X-Gm-Message-State: AOJu0Ywc2Omm0WCe6zdplPdPQZiKkQnvUVg5LZBlRaMeMzgXVSdHjh2m
	myWHpdCPzGnm7RvIngpPifz8yFn4GdNszi4nzSie5UBEsZwVJk09nT0Fn7YgQ2NOhetZ+70TTj/
	yf/PGKYFcMWNM/+DpiF+3c3NTPxIlK14oSuvAogHAKmiWFe/wh5M=
X-Google-Smtp-Source: AGHT+IFLjPB5jQkDt/QazJk0rqAjAY9BjaB+1OhLzRmkQ4De70CJMtVzbkRs5xdYYF3CaVP690QHO9BmJ/IKKwvPNy8=
X-Received: by 2002:a05:6102:304c:b0:476:148:7edc with SMTP id
 w12-20020a056102304c00b0047601487edcmr3107359vsa.4.1710490924137; Fri, 15 Mar
 2024 01:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313170435.616724-1-sashal@kernel.org>
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Mar 2024 13:51:52 +0530
Message-ID: <CA+G9fYunhZ8zgfKUzb72ydN69zuKChf6idgyHVm8Eof0mB8C8Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/41] 4.19.310-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:34, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.19.310 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 05:04:34 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.19.y&id2=3Dv4.19.309
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

## Build
* kernel: 4.19.310-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: f1886f673a708e0b053e08ac007aa8785d7f128d
* git describe: v4.19.309-41-gf1886f673a70
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
309-41-gf1886f673a70

## Test Regressions (compared to v4.19.309)

## Metric Regressions (compared to v4.19.309)

## Test Fixes (compared to v4.19.309)

## Metric Fixes (compared to v4.19.309)

## Test result summary
total: 47695, pass: 41616, fail: 867, skip: 5180, xfail: 32

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 106 total, 99 passed, 7 failed
* arm64: 31 total, 25 passed, 6 failed
* i386: 18 total, 15 passed, 3 failed
* mips: 23 total, 22 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 27 total, 26 passed, 1 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 27 total, 21 passed, 6 failed

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

