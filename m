Return-Path: <linux-kernel+bounces-7397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0581A756
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FE8288DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0314879C;
	Wed, 20 Dec 2023 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpzBeXEp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684748782;
	Wed, 20 Dec 2023 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5cece20f006so599317b3.3;
        Wed, 20 Dec 2023 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703101102; x=1703705902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNikzNGiijk+3h/nmRItuAzAl46HZPOUR0AnDs8oHAs=;
        b=EpzBeXEptxqHdFWGhDLRq3NHk42ef3GV57/pecw6fXLIEbNz3tLSBGC+2YntpB2jC6
         0RzYuEWrlCGjVPrZS9Ed+zpSlGM/Kd5P5RgbWiSCUOcy7YqAERDmwQwkoax6PPFBqS36
         IOthdin9V6XQgWvTCCaP8s8aZwItQABogzQNJUxgZLTRlRVZOBrN3reK5qlkbWwXZH0D
         hQhStjnkQ+AthmQxzKip6iNT17gF2fD3dKJ09iC96J8hUu41QVM/bAnY1jDrlqVVWfjO
         vWupDy9Ey29ICLyR+h4HO8/2WadTLwBe2xyd3qF1Xxa272m7Vp0rthPAae7zhRPQZ2TI
         FFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703101102; x=1703705902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNikzNGiijk+3h/nmRItuAzAl46HZPOUR0AnDs8oHAs=;
        b=Hi72uksgKRJUG1aJpDxsCQbjf66GNMzOWnr4tfA5UqZhPS1S2iTdbLNrox3LJGwAKM
         LqFm4CR5BU6Vlk+li6i1dbz/eaMN429sJ6mw6ZCCKpmOdyHLmK2/6YDbcvCSIcY/gHD/
         L5zVPMFDdEkOzJBJyKtKVBaHn/kMknR3xH0Q49PWPq8XZSTkitu09b0knYLQwVKtWPFZ
         C5Cv3cuKZYN5TesvGXnwXgsBQtfrObUxFpCliw7uAF3x7LE6TJoYCD+tZh7YrrBlY7Ze
         +PAd/6i/6EXmAppKafuFs93z9Eq4TJ/2x99XNb46Stuzf0HcdsnCmWORsDxWu3YNZbNz
         p+Ww==
X-Gm-Message-State: AOJu0YzYVJErcesDZJPE8bTQTmrN3U4IsguirugebNg+s4t0ysZaYr8q
	ZgZgjkSuK+ZfIyxUO5PpY1ajlSGiTuNGsR8E+ATdBJsECB0=
X-Google-Smtp-Source: AGHT+IEMLWLLWrpL4vLO9ZfDNGdjGTubUBWV4duV4vjBrXovq3mYS2P65ifXEI//SW/K+wcmQozczFA57TH//CkBO5s=
X-Received: by 2002:a0d:f4c5:0:b0:5d8:5727:80fb with SMTP id
 d188-20020a0df4c5000000b005d8572780fbmr240889ywf.84.1703101101988; Wed, 20
 Dec 2023 11:38:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220160931.251686445@linuxfoundation.org>
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 20 Dec 2023 11:38:10 -0800
Message-ID: <CAOMdWSLiqXs2zg0HBKf--htX+Ve0d-=RjGXwaoNrf4CbBS1JOQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/159] 5.15.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.145 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.145-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

