Return-Path: <linux-kernel+bounces-93295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A6D872D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE71B28AFED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DEB14AB2;
	Wed,  6 Mar 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7dh/sgg"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA814280
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696754; cv=none; b=t8w02dO+FAyPOb5JDBziODYWFkhFbxKn5edSFUJhSQZa+iiPtOgavf+gbeBe5trp2vQ23e+YYD4sBUbd5GJZVEGaE1ey/s+Q9gqFGiDgXwcwwvcitK5F7q/khtvZxjTAJfpQ+XR0PnNllOxQwsBxC8D7fHXatnCvcXz9DINWy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696754; c=relaxed/simple;
	bh=jBAPuRGdRlyLec/G8hWJrmxIWweZDNQGFQVAySUpzDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbOzTZ4p9xFgoxSZ2XTfVnPAPOGq6kaXFi+wbPZQj4tshvMDqsgBmPETydslzTlN6Dzw61Tr2FVTGfRO2c9tkCa50eO90oph96Dkxc/I024l21BLsIFKRuD+1Oe27wibZ00bHk94nOn5girSXqxUBjz0Jqa44O2BIhF8SCnH6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7dh/sgg; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db797c5c93so73167241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709696750; x=1710301550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5tvqqOLlp/L9fDdgXTeavKp6GslrC3c7o5kKTJOuGY=;
        b=o7dh/sggH69N6FSzl5WuV5uPBLURS7y/K2nTJ6xB4Jy8RkqCM6NJqFlMFc93HSmUF0
         bpGoOP5bQTMTU74dHsjzbEIYNUtIKWNKrvQAQIEAwPzJx931YX0x/YA2ew279vVqinWr
         bK1KBcYm40gJ2aSNS28sOyEWFL1uQkoAvs3YUXYC1Zks77PUPy/oDYPLP8ayyR9akDF/
         Gks5vQMpz4Etw0Rez9d2rOBmreJxOVXaciJqM3vFwOi8x4tIFfMmpWFLRBCb+ppFRK4j
         DMx0z04Iqts7jMTL8bGqyfWwugM+Dbiv86UV0A5kqe6a4H93U5pngCpZT2gEdg5kZ7Jc
         xcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696750; x=1710301550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5tvqqOLlp/L9fDdgXTeavKp6GslrC3c7o5kKTJOuGY=;
        b=GJUVjKLJ/P7M002iqg1ifX6yc2dRLIQOzFahjE4Ipp4CT0XcDIbhlKzZIYu80DEetl
         q3lT4D3F5/1T1ygWKZfE7goEDa8ncUS4by5fMCfDVW+7gglZSsEI2Pl2Fg/IkHc9e01/
         o+8aKx9KHcbmLX5uwGKgwnlgLws1xQxmb+0ri2lMqbVbapVNzQd0xC2vB/Vee7/fqUVU
         k/X4k+IwBjEutZ01ShAi1plyr6QWt3UuWfpVN8HD97bNBp8t2IGmDy4bcfePVuV+XyuW
         YJTn6yrJzLhyK1atnkq2Ms+ZaI+/oy3HqxDnP3pkbWEFf096qvhEHEOKIpG8fluwW2Y/
         jUcA==
X-Forwarded-Encrypted: i=1; AJvYcCXSG8HFpYYO683qmOg7SVI19+R8HayP/PwHgQ7lR+KCS9CsTTcwpRhWFu32zAb5bFleZdUCEOsp03GG7GJXtxhltKdasDd6bfJCvsFN
X-Gm-Message-State: AOJu0YzX4QnwRny+gqagzgUc0G8dlO5ZEEBjCsmSJA9ULmTlwNQbJ2JA
	TQAyjs9vYY9voizt3kNU/oZUM9Hle6MwzCHK2V3KCbgZUUqZGXHZ83N/om5CjsQ478s7q12LIqc
	uXOKCieyXrloboyNMnwALGbiakC+rtWlr5JcFXA==
X-Google-Smtp-Source: AGHT+IGlgYy3++WxEbb9Vbw+tVFeATrL7uP+/E+8ROLUn4LkrKLrXnX8dPjsvyriAp4nhB6XfBccEoT5BRDkmmdMhuc=
X-Received: by 2002:a05:6122:3214:b0:4d3:4aad:22d4 with SMTP id
 ci20-20020a056122321400b004d34aad22d4mr4786922vkb.0.1709696749951; Tue, 05
 Mar 2024 19:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211534.328737119@linuxfoundation.org>
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 09:15:38 +0530
Message-ID: <CA+G9fYuFg=5Thx50TTt4VSfzjwCoPe5oe-O8+74-T+KBtN0AEw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/16] 4.19.309-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 02:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.309 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.309-rc1.gz
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
* kernel: 4.19.309-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: c854e1c772c4f07a8856c0867118ce064c11fead
* git describe: v4.19.307-70-gc854e1c772c4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
307-70-gc854e1c772c4

## Test Regressions (compared to v4.19.307)

## Metric Regressions (compared to v4.19.307)

## Test Fixes (compared to v4.19.307)

## Metric Fixes (compared to v4.19.307)

## Test result summary
total: 51688, pass: 45911, fail: 287, skip: 5449, xfail: 41

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
* kselftest-drivers-dma-buf
* kselftest-net
* kselftest-net-mptcp
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

