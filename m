Return-Path: <linux-kernel+bounces-135736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79389CA91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AF6288FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03740143896;
	Mon,  8 Apr 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0N1ia1H"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C525143880
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596560; cv=none; b=nKtJQLTNLCU0KJ/fbXBlBlT3oLcWW9qSGnf8AELkyCxlGBSY+yB7K53I7lTZC8Zdf5bQl0bGTj73dSP0Sq8trolRaNuPykNUGu/RGwZi6AwjKSZ0exjPU6otLYbAZYybKN4feLEMtifmFl2se6Wd6ethekfH1fHDQAY6CGErTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596560; c=relaxed/simple;
	bh=WzIOBFBkD2VF+X/O36wHgqJzYEwGWtCcZYrHSWH0pUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/ZrB6fNmUdc/Y0Uz3YcFHbPptqJY1YnjtBM6lEasfGnuh6XpEBYEMJeWKgu7fIw0AX1Zu3XFNjVxqO1ezYSFDLfRDuw7rbjPezK9m4HhtQPc+7wtwzF0QI67nNwz4quTFh++d1ziIs2mYhJJhIrAVpypbpN0FgiJh9BjQzxs8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0N1ia1H; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e65c56d29aso290249241.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712596556; x=1713201356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMNf7A6k8nLtZDPsfj34GNgCGUzYdTJ3ArVvRF7NLxI=;
        b=T0N1ia1HCZUIfD5me3hD/7haseWLZWvH6VnymmhWs+pzrD6F57B+znGEWdsMlx5WKB
         x1gDvHQIo/ZrOeD3AG6uR8cS3hpOpiuliQh8YVirw+Ep8gnNm0o+mhvbsKuuy0qeaIlP
         6GlmFKW4QIYRMEMuylztBvh0M+NLERW+XIOmuItmXvbZdrdYQt47bWEk0JrmE6S6BIyQ
         ltfg6vjWDWT9VmkI0cvfZsQu+qMXYryXsu3/rQEiGJZ5KwXHOOSN+C9cRtglkUddxTKP
         vwOP3f8Om2/Tkm62FKchMr8j0pFQqR9jUFd3diuaYWD2+Uoj0hH2MlcEViiWYuGTnFCF
         LLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596556; x=1713201356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMNf7A6k8nLtZDPsfj34GNgCGUzYdTJ3ArVvRF7NLxI=;
        b=DfuFuy6ZWHIstxCwPTLvr3FTuR8R2hg6yoC01AtMNN5/HAt84cXAYJ2vb8zHcLt+BN
         B5AjrjYcoSy++fUxYnKr8oihiPXPpWkOoNe3hjER9hkSsBlgeQXn/oi2rzFeqITnNNzb
         m/6wZHyig/NqRaj2V6zExZzfP6uouhE21J/irRELNknP5+97E/y6rYri4Df1YPcI4UFC
         uhj3+sDgJPkT81CZA/rRY86zjmDJ3KhLG/cBs3w7njMEZ7DS3zQ/oI9tnwIruGXi1DFk
         uzxqzvofeuSj/E5nGq7jlEfkJvg9Bi/82cHuc8v+ZkXAw6xxrWgvnaUVbqisfuEhXo01
         3Jdg==
X-Forwarded-Encrypted: i=1; AJvYcCU517VbME751oeV/GRsYw7jdKAttb3KWIWO7juwcxXjfCYWuaH9Z0cmcaM+0YTv6AOCJmXjI9jPf/cmzlMCH+O6tZBV3uP+H/0HZH6G
X-Gm-Message-State: AOJu0YwVCp8qi3/0FNZWImZuew97T5GRkNzNJORXKtoBIr4wsYJiIk0Y
	4X9fIvys/BE7gY2TyGGjSZBwIqAJW9QvlSyu5K0oLuMAjU1WXvxjjuT+MUTgA3XeG9sdgVGgoOn
	5eO5VVm8g1qqHCCmtw4MWzhDvMbqiv0P+pydkuorBB5k5mPN1aa0=
X-Google-Smtp-Source: AGHT+IGH5m+zw44aHKIWpc2eCPDcCytI9gca4fjAbaev/T3kTlbpcREmReh2WF2ua2H28ryZdpuTMcSK6lK7YYEObFE=
X-Received: by 2002:a05:6102:6ca:b0:47a:ff5:fcc5 with SMTP id
 m10-20020a05610206ca00b0047a0ff5fcc5mr1097660vsg.4.1712596555926; Mon, 08 Apr
 2024 10:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125306.643546457@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Apr 2024 22:45:44 +0530
Message-ID: <CA+G9fYsvgN2ixfmDKc_x8yFnZ3SfrmSV5Ck1QC5KfmYN89CFYQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 18:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The s390 defconfig build failed with gcc-13 and clang-17 due following
build warning / errors on Linux stable-rc linux-6.6.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
--------
arch/s390/kernel/perf_pai_crypto.c: In function 'paicrypt_stop':
arch/s390/kernel/perf_pai_crypto.c:280:51: error: 'paicrypt_root'
undeclared (first use in this function); did you mean 'paicrypt_stop'?
  280 |         struct paicrypt_mapptr *mp = this_cpu_ptr(paicrypt_root.mapptr);
      |                                                   ^~~~~~~~~~~~~

Commit detail,
  s390/pai: fix sampling event removal for PMU device driver
  [ Upstream commit e9f3af02f63909f41b43c28330434cc437639c5c ]

Steps to reproduce:
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

Links:
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23347738/suite/build/test/gcc-13-defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23347738/suite/build/test/gcc-13-defconfig/details/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eozoS8GQGxb94EUWNTPuXvYjVU/


--
Linaro LKFT
https://lkft.linaro.org

