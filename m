Return-Path: <linux-kernel+bounces-116761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72088A37B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BF71F3C102
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDBA15920C;
	Mon, 25 Mar 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfL/hraE"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847A183BA4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359725; cv=none; b=M9EgEGuRVs2rbXOy6xPZjHqpCGxRZgzIx1DOf71Iygp6Ywmrwg4nOFd9qSTo89e2b/WS6de42t4qLhyEXhBqZF151fKWf1M6FixfAmLMobjzy4BdTOq2lCoBCzEKqs4R5BWxzQ+7PblDXN0OsbdBR6mrWbL1yEi7AxSsRgRuNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359725; c=relaxed/simple;
	bh=mgmBjav3rZynbJ1mYiMRayuXnORVSBOK5ibhz91RhOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJudtaPKxwmLcck2XHt1vZDbQ3CwkJ3utqArOQx7zlRC69+eTUtkjr0Y3fRjtIlI08+1Xz0DIG1Wet8CwWd6fNwSl4IVFrWKXiKqhUIATsWe+OdSIum/NerqErkRVZk7qT8wam4iGlMvRBsVHpnzeLvdkfIr3qzvuQTQ+WBi1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yfL/hraE; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d8804a553dso395088e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711359721; x=1711964521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H3DoSiXc8Yp8uuBDk6EiaF3on1eVJFgP2CMpJotYW4U=;
        b=yfL/hraE6BrTEM4P7ZNfa+3OMqcksXaARCCw83ABPAjKwpZQem/GWiE3/bYmoVXckS
         au8iTvwSSIp98a9UCjHsPrBgS8QJPG7IFSzI0UKIQNqXi8Qr3rMu+q/XwFZ72W8escHm
         NGBR3wQfZ+PWzH+NH8ydUQzEeqC0sLK+zVLKzaShSWLGrKrYXrDwRu9juRIA+UA/1wH+
         cKe8BKyN5y5J3INNe6V41kGi+K1JmdEut36Munm9lVnI8EDJZlFM9xX4MAguDXSmI3hl
         BcxV59SLimsVO4A+5rWglSQCpT5Y4gu23ySpbeMdIkfjYqr86XBLkl2AM3S5ZpPhsZQ5
         SXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359721; x=1711964521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3DoSiXc8Yp8uuBDk6EiaF3on1eVJFgP2CMpJotYW4U=;
        b=rK2A9gYPkTv4ERxSaVFhEh65XRxgJAUnMvAZCrQ49wicqWghuB3i3z0I5dMxAMOSR8
         qWjyX9BghMJOimPHcwwvNkzcMngj1UdXcIkLMsuEb6Ms4vjdTZRKqWsYFCsf33vv0kQm
         f0Lpn3d1JKZwGCEbJHUz1Rwz+EKhwbCXgQm2Vag3NSFjibX0/Wj3X7GdFPwZNmgfXrUd
         tZNk+lztk6D9g9nBocTfw6WtyJm7QO/YUmbkqymFD+2cat5m7gLMS7S4PXHvW3sfXCwZ
         rbeoYzP9WAKqcFNxiuoKH5rr8BN9YvXJzNv9jRoyX8UkIzVSnOumdjlvMu1E0EOvoxBX
         dJGA==
X-Gm-Message-State: AOJu0YzbhI5NLV7+FgG8yy7bU6IVVFLwdnLyEOfyHg+wmxOaF1Aq8438
	Ek39YjnkhHP8gSA1EF5EwDLK/67TDIJBTlaGDxCgiY+cQuitEzly3Ai2mxX+8Bo0TZkw3v4toDI
	T/9/DEh429blF9aOFDAnezUsVGz9XbVw0KbFcoA==
X-Google-Smtp-Source: AGHT+IGsnuKrGIgppmDbZ5qB5PCahd/U7K9yFBI8vV7C0Q0Y/IrpHBMv5VHW+jQvIwvalqRtoeVjhf0a3ebzv0+7YqA=
X-Received: by 2002:a05:6122:1815:b0:4d1:34a1:c892 with SMTP id
 ay21-20020a056122181500b004d134a1c892mr4401327vkb.13.1711359721603; Mon, 25
 Mar 2024 02:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324231207.1351418-1-sashal@kernel.org>
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 15:11:50 +0530
Message-ID: <CA+G9fYuFh7K4XO+hVyJ59vWbfCaGpNf1ko9bUaZ0qV86wLbreQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/451] 6.1.83-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 04:42, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 451 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:11:59 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

The regression detected while building allmodconfig builds with clang-17
failed on all the architectures. But gcc-12 builds passed.

> Andrii Nakryiko (5):
>   libbpf: Fix faccessat() usage on Android
>   libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
>     API
>   selftests/bpf: Convert test_global_funcs test to test_loader framework
>   selftests/bpf: Add global subprog context passing tests
>   bpf: don't infer PTR_TO_CTX for programs with unnamed context type

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
------------
kernel/bpf/btf.c:5140:10: error: expression which evaluates to zero
treated as a null pointer constant of type 'const struct btf_member *'
[-Werror,-Wnon-literal-null-conversion]
 5140 |                 return false;
      |                        ^~~~~
1 error generated.
make[4]: *** [scripts/Makefile.build:250: kernel/bpf/btf.o] Error 1h

Steps to reproduce:
# tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
--kconfig allmodconfig LLVM=1 LLVM_IAS=1

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.82-451-ga5b0d68e1b0f/testrun/23155982/suite/build/test/clang-17-allmodconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eAPAL6GZr1JrCuFjUfBrCjccbe/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.82-451-ga5b0d68e1b0f/testrun/23155982/suite/build/test/clang-17-allmodconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

