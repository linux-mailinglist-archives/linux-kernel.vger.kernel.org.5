Return-Path: <linux-kernel+bounces-116746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB53088A334
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3B11C39CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA516FF37;
	Mon, 25 Mar 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+6ZXBPD"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABB145B0E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358917; cv=none; b=lB4gq3f9MHx0hdfcAjaIJ3qRJK0ImjpSHgaKZN115JDz1WKxdrHpXlgRpJTtz/B8Ql+JMVKS2fvdC/fviaOKSvanoubb52TZ1xP13CpQP3fl/newPcwvsizrlsUxhs51xXUn+LDOFcIYBxRCnovhO5XXX1fKiydZVPSjtBw5GhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358917; c=relaxed/simple;
	bh=uGQJQqqOoV40xJP1y95HDFRdz87FEyHED2qs0kLU3bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpTbLT2loJY+XFoVndzwkF8EbNcjO/LBW9Z9QZnpkDfZc4EOSKCgCJKDv4NnPSUUyhmUHqxlS5omEVQElEfs0WWOlfQXHCcIAOyierw7horWZlhncNJhLVTaoCmqKjx4iVWQTirG3BzvXbiaGQlBX5SiiUv/igd8jHeIBY1JN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+6ZXBPD; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d88360fd7bso826175e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711358915; x=1711963715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5m0Gh/qeDl7am+4YY8jkZ+PZB+SobIFHIAWFvx2/qhk=;
        b=S+6ZXBPDlwwzO1ciPHumxH/ZKhaC8u3XW8FOQgQxZsqG48Al1G3YM4sQ73Wh+RzJEt
         yXC+yytqoPa8IWRDSTUJGpSrpSxN7mlPuRqYZpaGVboBSDFEugTi16kwSPoivdbb8a94
         PZQ7WvnKBOiobSUUGbAU20copVrIWcGJnsOBs052oFBorhhkIDCWqUliepKbfV56Tkql
         FdUs3kkjoxXI/UeB4H0njtF5fuWDKB2gcWi3lp8EAzarpAEE1G+cW9656wvgC+8s+OIY
         kZSOtmKSr9QdbQwC49KWWL6XhfZyT6lXQ/633DD2ZjEY3c0zxVTe3tVLfDvuWray5EVY
         58aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711358915; x=1711963715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5m0Gh/qeDl7am+4YY8jkZ+PZB+SobIFHIAWFvx2/qhk=;
        b=afvzsocD4eeXQFLh/ouC2EJzbLO0kGeqI3ZbbQkIMMxPsaJDJaybhd2u/B6F+WstVb
         zzHm4hBv958/Rd+DDBWHHL3rZ492HbrYgFX7qIeAz1LDfR7gan5S0IFw2Govp7g8bOwf
         AdBA3fEh4aWTTp+iTDrEriyQfrvX/+cMy2ajzis7w9K9xFM/bZEvJqW7miirrrqvJJ7h
         EKubS9AUSOZtqm+BI0VJOpjxghqUDGwhJ513E7RBGlau7MuczqoN+n3IRpM8aot8zfz4
         EKe/qAW1Lg2NpgDev9Sr25xLbFy9jZ/NObk9yJX1c3c6Wf46wvWPq2ijj3rUG4tvX/bi
         N7Fg==
X-Gm-Message-State: AOJu0Yx0NzkQHfonT/v8GzDV3V0QrOsOXI6/e7Eeb9y2V/+fj8wmANKm
	L15+JSwuScNoYjps/idORcJCHgJTy1wtccwIkfGOAmbZgmCzf91Rp5PuTKKUO//TYAnKu0XNYqx
	tJJ3M6otH9ndZJF+L830DMupgIQz+GLXF0m0tDw==
X-Google-Smtp-Source: AGHT+IGM/UyGpUfBFfVFl91MwB4yzh9yxciE0bsa3uvnOjvb8RmeOSlIGcBZRayBfFukhUTmD2y7dkNO9tJXQIK0PSU=
X-Received: by 2002:a05:6122:12b7:b0:4d3:3334:f2fe with SMTP id
 j23-20020a05612212b700b004d33334f2femr2658521vkp.1.1711358913507; Mon, 25 Mar
 2024 02:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324233458.1352854-1-sashal@kernel.org>
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 14:58:22 +0530
Message-ID: <CA+G9fYtU7A1XxOS9BvmoQAjhcuUsaSPQKnOzz-qYV6ORnG9k-g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/317] 5.15.153-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@intel.com>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 05:05, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:34:43 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

As I have already reported on 5.10 regarding powerpc ppc6xx_defconfig
build regressions noticed on 5.15.

> Thomas Zimmermann (1):
>   arch/powerpc: Remove <linux/fb.h> from backlight code

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
------------
drivers/macintosh/via-pmu-backlight.c:22:20: error:
'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
   22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
      |                    ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/kernel.h:16,
                 from arch/powerpc/include/asm/page.h:11,
                 from arch/powerpc/include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:60,
                 from arch/powerpc/include/asm/ptrace.h:323,
                 from drivers/macintosh/via-pmu-backlight.c:11:
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_curve_lookup':
include/linux/minmax.h:36:9: error: first argument to
'__builtin_choose_expr' not a constant
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |         ^~~~~~~~~~~~~~~~~~~~~


Steps to reproduce:
# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12
--kconfig ppc6xx_defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23147157/suite/build/test/gcc-12-ppc6xx_defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9uOwIbkt3JA6me39nPospWfFL/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23147157/suite/build/test/gcc-12-ppc6xx_defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

