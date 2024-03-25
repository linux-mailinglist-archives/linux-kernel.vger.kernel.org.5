Return-Path: <linux-kernel+bounces-117353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97C88AA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C8E2A7CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C613C901;
	Mon, 25 Mar 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbTVfxZc"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E14137C3D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380062; cv=none; b=ZNPfpn8YhZ+iGwPmLNjqAGA3kR9rHTn4j8WYn2UbtBwRtr2jpMbZvHfpNf2Q+6XqhzSNxHmhjtDksW82ixHbOs7ZFrq+1mEOehGKsPZbKn6XBrsZCyLOHlPbeyQEnL7oezIvw2C1nNH7tvwyiQuj18nwyMWo+sFuCJMqzVuEvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380062; c=relaxed/simple;
	bh=yuP0LootthFVjZqLZ7OhKsvkRtgx0FUVczcscmPg1So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE7hdGOW3YDur7oDR3OfdSmHalKuE2XQ/sZGUVjoxdB/bGGBe6n3F+3pzFuv1mrMtCyHwWAIIDQ9ZVieYYZUqKBGYYF2/qOA3i9Ve68Q/26InylqaeGGLBDwo3dbFoFS6ecv7OhI8crnz7eBvq2A/x7bHBvc2lWHXpBGd8LJst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbTVfxZc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2512336a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711380060; x=1711984860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHq8iFwza+iunIPn5PLdl3BksOKsh6oEq+D/J9zc1k4=;
        b=gbTVfxZc/Cwk7ApLcp4uaKeQ7CWEC7taxwaDF94WOwUE071Ri/4ccri+4QwsNeUVOy
         6sF88SFeMPp8mOcoLc/6ti7lNNjUWfFHeuYF5TWfyppd08SDX14DYSwG1mpiUtLf8SJF
         Po+EbrRteHx9iCFE4exMvX1pu9/SHzpNekijeNo4eWfeVJf7QPR+DOIYUL8g8IsziXZd
         uP+a7SUyOzLl4DSyYho/xXOaFh0TffR6e2SQCt5aUUJpTqOLUqdnezK7qgGtBATi90ZD
         rZ/3hkKReQmdgs+VFuyxgNsZSUiRRS+/bZNRYt2x7KuVCew4vC7Y87yYEVud4AP4623H
         reLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380060; x=1711984860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHq8iFwza+iunIPn5PLdl3BksOKsh6oEq+D/J9zc1k4=;
        b=xPCO6SAyJKRyrqR+QNqiHfNrrkswt+lJyoJRwKZGcNaxCVkjATc+posKmKjdGgOqne
         1NJ+e2bbDPPu7+L25+7r1iRUm9ZaYsiTlfVfcAj/P+zJox7x3rjsFYWWPe7KDyn6uyFg
         iWdeRxKSGKiK7SOoTb757+e04BEo9xaKeibKBWXWbmtF6K6cC5h3uUyZfyn2Qs1qCMqV
         zF51PEyEtf4a4wl0W0FMPZCKaa9XqPnTHaeDcOHBoghu7qJ7ZeREC4tFzy9Zk3LCxHIh
         JTC8EgjNT9jEgUukQezDO2r+4kENva0iFfZQ31Ik88DafPmVzm3tz+7S+jH0Am43nbTE
         IEVA==
X-Forwarded-Encrypted: i=1; AJvYcCWbkJFaxFIF6R30PL9UX8mCxLv9OFFxPqbOBi9o2Mwbj3S6OJCrpxhxN8aAPlo7l2A35bWa1LAvcg+GWBG66bVZqhEIwk37TsIIuufQ
X-Gm-Message-State: AOJu0Yyw/g4lWcGgQxX+FJovDPWwsiFtXw3iAXed8NPN3bqMuJ/VYe69
	57PRy0FIWUJZGV192LcV5bRKly6ZFTBun+7249lIaffEzxjp2yzYGO7Vqc4y0Wbpt4cQ44YSVKh
	GQVtBH2tOzD0T9djhARuBb3PXL1eeQvO9hYcVDQ==
X-Google-Smtp-Source: AGHT+IHUqjE6K8PE/BfJg5LdFdqFJY793Odjj5Ln/S88wAfb3Da691z4eQcIZhdfiHjSynzDc2YkPCsBlD8T2UgSdio=
X-Received: by 2002:a17:90a:7409:b0:299:73b3:cf15 with SMTP id
 a9-20020a17090a740900b0029973b3cf15mr5120956pjg.12.1711380059991; Mon, 25 Mar
 2024 08:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313164640.616049-1-sashal@kernel.org> <cd76c1d0-9622-4a05-9e98-51824bec25bc@linaro.org>
In-Reply-To: <cd76c1d0-9622-4a05-9e98-51824bec25bc@linaro.org>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 25 Mar 2024 09:20:48 -0600
Message-ID: <CAEUSe78F1Ab0ZWE+ZcE5=1HgZ+GFiDJKL=DmKUWwcdWOr4yFHA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 00:55, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
> Hello!
>
> On 13/03/24 10:45 a. m., Sasha Levin wrote:
> > This is the start of the stable review cycle for the 5.10.213 release.
> > There are 73 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git/patch/?id=3Dlinux-5.10.y&id2=3Dv5.10.212
> > or in the git tree and branch at:
> >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > Thanks,
> > Sasha
>
> We're seeing regressions while building PowerPC with GCC 8 and 12 with pp=
c6xx_defconfig:
>
> -----8<-----
>    /builds/linux/drivers/macintosh/via-pmu-backlight.c:22:20: error: 'FB_=
BACKLIGHT_LEVELS' undeclared here (not in a function)
>       22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
>          |                    ^~~~~~~~~~~~~~~~~~~
>    In file included from /builds/linux/include/linux/kernel.h:15,
>                     from /builds/linux/include/asm-generic/bug.h:20,
>                     from /builds/linux/arch/powerpc/include/asm/bug.h:109=
,
>                     from /builds/linux/include/linux/bug.h:5,
>                     from /builds/linux/include/linux/thread_info.h:12,
>                     from /builds/linux/arch/powerpc/include/asm/ptrace.h:=
264,
>                     from /builds/linux/drivers/macintosh/via-pmu-backligh=
t.c:11:
> ----->8-----
>
> Bisection points to:
>
>    commit ee550f669e91c4cb0c884f38aa915497bc201585
>    Author: Thomas Zimmermann <tzimmermann@suse.de>
>    Date:   Wed Mar 6 13:28:20 2024 +0100
>        arch/powerpc: Remove <linux/fb.h> from backlight code
>
>
> Reverting that commit made the build pass again.
>
> Reproducer:
>
>    tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12 --kc=
onfig ppc6xx_defconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>
> Greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org

Apologies for replying to the wrong email here -- it should have been
for 5.10.214-rc1. Naresh took care of relaying the information to the
right place.

--=20
ddiaz

