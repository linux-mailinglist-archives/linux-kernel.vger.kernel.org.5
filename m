Return-Path: <linux-kernel+bounces-103436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AF87BF50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112CA1F217B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02771725;
	Thu, 14 Mar 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBsVU3Vy"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9B14A8C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427847; cv=none; b=kKkUAHTXLLd0jvdKdvtv9msMkLGbMrt9pRtdfvX65FzD1Uq/BtmgXCo5IvCnD5C8WcCa7Mnp1qEDgIt8ZzR6Z5rTTmYtVMXsghP4qQMPlMe/pUHPMnyOJJgtJD8Ffg2CGRasxYn8565PsLsS8UrPuJP+Ip1T5D+/HosvvjZbf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427847; c=relaxed/simple;
	bh=nusdC47d6K9rSemiFlrvIZXrDWn4OPB85HumBqC4UI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHzMrbeGRw3vsosDCAQtSo4c/5vq4ZI8PsnkIp8y1RFqBpq7ZhBpziM5Oi3A03NZkBwJVKubyVfwpdPw3EYgEDXLrpDArRvWesicmfzbYa/k3jNbsZAViYULauKmKcmU5M6uvlPkKbETVzOOQaPV515UU8ifYqmtDnjTY69NeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBsVU3Vy; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47603a066daso291545137.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710427845; x=1711032645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6j7ITIcI1fBrnE7P5xQCJkGWh4vmPcXrPbZsBeZKcU=;
        b=WBsVU3VyekVh5uzSlmGHUDIAqz9xIOcdMoNsL4HGa8smxvRQoPtWdLmNDQaE0AraTM
         WAweuiiEvSn2OwATi/tYbU941cKzOwOj8Wh5huYcaSlHmkjKsyyec88bCwa6ywo/Xmur
         ABBRXHIFWri1P66oA8UR7wMh0QYWdgq1miWde3/prfCwKoofm816WzxuEWWvAugQxZqV
         fWbR9U3sOBwKN/3JLW+NcvYWkFX0Wkc9+kxkeY+s6+PB1JKa0qsV8sZQiQJQh7psGRrk
         evkIGM5ElP5FNm7yzqXe+Ls9OVEcKQpg/v/guZgb5NSqMfVlt3wcVAUUOPVxKxxZXRc5
         e26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427845; x=1711032645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6j7ITIcI1fBrnE7P5xQCJkGWh4vmPcXrPbZsBeZKcU=;
        b=oQ3ebeOzMFlduvsmh4iu04pJKZm0GNXMiKy6zkYMG2lwu+FydIPkMqW1BNyzf97VM9
         BB6VDp9Pudm7wIMw0fv4UWDWnKYd455O8RClSZSFGHrjRdKZXJf5sqshmaNxViGrANDq
         ySrnzJU3P6zKaw5fkBd/JIetgoEi5iX8bdUURX89DLGZu7tUQ+ijK5+hTO7+nnp2XMw5
         aAOm8jf3LAw0MrwBTaeJ6HymfDVsLawNynx427227nsgeuxEb2tVFOoBYNoal3j2fAn6
         dJ15MOK8yYcnJHZLKo/VS6mUuzc6nyVEsO7invX6xeCBqwyxrSnO1uGxyUa4BSnAeGZ8
         pqhQ==
X-Gm-Message-State: AOJu0YyrBnMMbrghrNK64PuXaZMt4sIoXtVBKekMFB0xLvoZEtvA7+Cf
	n5kvvKdQ24tS4kzDblBI0TmMfSemOKgpK1F00kYneTePobJVYUAnl17fcpI4434Pgh2T8aUHY4Q
	q+Fysn62Mj44/XY3QVtmM87jTIie3udFwG/l35A==
X-Google-Smtp-Source: AGHT+IGD3fsBoTMktdAAi8YT+vKoRLGrGYDwWAvklu5wx/OPwqcGtgztRY7LgobAH1NFdHiQo02ZmoZaZ3hiB8MVGZM=
X-Received: by 2002:a05:6102:3713:b0:476:262:123e with SMTP id
 s19-20020a056102371300b004760262123emr533801vst.8.1710427844681; Thu, 14 Mar
 2024 07:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313164640.616049-1-sashal@kernel.org>
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 20:20:33 +0530
Message-ID: <CA+G9fYu1SAg6u-u4aO5auHbE7iM0=2bQ60c9cWTo+-r0XkgN5w@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:16, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.10.y&id2=3Dv5.10.212
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.213-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 0a70dd1e1aa9dfe25d4647f86675dc6dac41631e
* git describe: v5.10.212-73-g0a70dd1e1aa9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
212-73-g0a70dd1e1aa9

## Test Regressions (compared to v5.10.212)

## Metric Regressions (compared to v5.10.212)

## Test Fixes (compared to v5.10.212)

## Metric Fixes (compared to v5.10.212)

## Test result summary
total: 73104, pass: 57812, fail: 1619, skip: 13626, xfail: 47

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 107 total, 107 passed, 0 failed
* arm64: 33 total, 33 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 30 total, 30 passed, 0 failed

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
* kvm-unit-tests
* libgpiod
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

