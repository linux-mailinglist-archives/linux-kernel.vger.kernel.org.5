Return-Path: <linux-kernel+bounces-140633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6198A1741
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4BB2A7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79314F11B;
	Thu, 11 Apr 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJ1jlA0Q"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90114EC55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845272; cv=none; b=uOkSXVAs34dgzLV/LrQEDrAUT0bJvDPURV8+Xcp7tJEmGJNW86O0Xq10lLrQH9cC4nKQkySYnPt931LqzPx88MKbMnJAHN/ZlzCytgn4aYJfNrkeBG6khgoBhRAU1UUVqkmX/hfpzU5vHiwUGIayOQuR0Gkg9DNL5FKHAF0QkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845272; c=relaxed/simple;
	bh=AP1yIpkD61knEsXHPu2ftMhehlLmX7WGkWX4C57FbBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxUJcQKYlCYz+jXfcPo5hdFfmC2viIyuSFqFhh+e9vgyA6L1N7DyncYSoiVh7DUAUNeXQwsLIizzDglnRKylJ8tCehpCt8m7pjaiRYsNAoHYdiu5bvkc8i1Mcg/KMqfig2gFoubkXY4AlL2ZaireEx/Jf5KM7R/PvS/sKvs0xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PJ1jlA0Q; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-479f50bcd7bso1419091137.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712845269; x=1713450069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNDwMXzZA9w/Ig5nKNfRn6E1/CKh9mEe7H9+Vh2hNJk=;
        b=PJ1jlA0QUpIBeopUNJhGB03EW1Xmp39tn43xp58eljBIyvEzkPwUYB7nJaq17uULKj
         NWkgSkD0DgFSVQ0+rIYEEdRS2I6Msd5rTnvou3CCkTnr9SdMcBQkLAV2o7TcX2Asc+o9
         wIXIchxD/UXKAXlUi8nLXptGWXnuIhx7D1P+rd3Vv5LWxzaufw+OYRdYEOZGNkcxrXfq
         WBm8+O0TqMhMACmbDPwGi76ApgLY9VoaS59EagLfXJ2ltDBJHv3Ob9x18K3JXzxCjii2
         vjEXGTTW/1WcRJUk3g6oDd/prL2J6bSCr4y45R2CDNREkE6/Avfc/O2t/vazj6rRMp0z
         9WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712845269; x=1713450069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNDwMXzZA9w/Ig5nKNfRn6E1/CKh9mEe7H9+Vh2hNJk=;
        b=enhHYr29/dpKOlMFtKZhBnp44wpD9XvYAVShQqcI0z6dyA9gZ2Ie7Oz35rlQJw4ac7
         ByT4rUU90+jGfDnT2whFWNU9G3AfJ5OZxIfQCkTLAGhXAH5g9Q5rb7rIWXxTvl89ZgEx
         Z9HcBiaDGveWCRCRBbKW5gt1La+cHcgit+crFMgzA1rie2q5PLJ4GXpYctI84F7smFk1
         7cXYa0DmMToJnYab9qisTrs9ZXzEzyL7IdkILF4/rzxbt/DOLmqWscMG9T5B6o0h8aBP
         4NLiFZdFfo9hjD/BbdE+vAYiTmHYRSV1ch33Wsf4IRqOxy3jDEpKi9TryDx9p9NJzf7c
         n87g==
X-Forwarded-Encrypted: i=1; AJvYcCWbhKXmFYvS/AWUfz6N6nrwEpOgpuJkKMHpVm6/bB+3RYCpqQFRHdtRQjc1AN3LE7d1pdmYdVrgcK8xkV7FQ06gz846CFiq4DX1OOQ6
X-Gm-Message-State: AOJu0YxMWpSJakApCCtSvW8v0hvOT26GXzuOtSO69Bl84wiCWgKptrA4
	L0vmxA7nVje1ivHsCUqSZPzfIY+ymaTvsXpMnarjDrfqkqlpiLy5WtOpQ2Eb1ytw9Q5ZhX5bEcv
	59iCgXtmDoGf/vNsJeXHqjyb7gf6bWlQngWAwIQ==
X-Google-Smtp-Source: AGHT+IF8/NngFSDZwNmkAlmPTYphRoq7xTTCiaK3Q+0SqL/mTmu76XOg2HqetJzuAV/Spk74WCqBY17Kl/UR4GPRGL0=
X-Received: by 2002:a05:6122:4d04:b0:4d3:34b1:7211 with SMTP id
 fi4-20020a0561224d0400b004d334b17211mr6042749vkb.3.1712845269210; Thu, 11 Apr
 2024 07:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095419.532012976@linuxfoundation.org>
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Apr 2024 19:50:57 +0530
Message-ID: <CA+G9fYuwCn0D6jzrn0dBKsa+X0zUBUMiuRqcYvc-qkKToXK5dA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 15:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.312 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.312-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The arm imx_v6_v7_defconfig build failed with gcc-12 and clang on Linux
stable-rc linux-4.19.y.

Regressions:
 - arm
    * gcc-12-imx_v6_v7_defconfig - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
----
drivers/gpu/drm/imx/parallel-display.c: In function
'imx_pd_bridge_atomic_check':
drivers/gpu/drm/imx/parallel-display.c:222:23: error: implicit
declaration of function 'drm_bridge_get_next_bridge'
[-Werror=implicit-function-declaration]
  222 |         next_bridge = drm_bridge_get_next_bridge(bridge);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.311-176-gf0cf5f6110a7/testrun/23411280/suite/build/test/gcc-12-imx_v6_v7_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2ex1v6eevudbi33g4ozA7hJ4fvs/

--
Linaro LKFT
https://lkft.linaro.org

