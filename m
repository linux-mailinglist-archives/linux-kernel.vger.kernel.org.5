Return-Path: <linux-kernel+bounces-156535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A28B043E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD92840F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6015887D;
	Wed, 24 Apr 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D99h+jPI"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC85158867
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947029; cv=none; b=SA4F3o31LMYR3b56iNESwAAu1YF+IsrfkH63RJ2V2Y7dUiAJ51hbSmTXLGMFpHhiIgTzph7mP5gLd64HI0XM55nzx5145PdGNBjbppT8Owb+FIhe+o0+U56grAIgqLYTn2eRLGX+enNwGHgELQvuKxIhBHOVRXdiYj2BHWUZauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947029; c=relaxed/simple;
	bh=Zp3ox78TP6hxWDah/Xpqv+ArZs5jq62G8JwODJB4R/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCUfaepNzGxL46k6RYnAWT6D9126OUMLk8XWJR2pUlat/5txEeA0ztL90o6KyjZ7CFicWRMC+qV4o2ppVJJ/6+1i/TBHCr7FlG55EJKRwSxHmo35HONP47CmVi54pgB6LGe9xbra0OZb+D5a2U//SnhXYXBTdg/LEozbXyc+a1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D99h+jPI; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4dcd4cb27beso1671992e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713947027; x=1714551827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPFo+IxgUQ2kIlqLDAB9FNtWLgx3YKcW7YRqfGcT4is=;
        b=D99h+jPI02n6GqC0nTUgIBoOB/rxNVXaq+kV/nJeyIEeK9HKDBCFa35QkEhKnSrYSb
         fSChGitjJDJuJORQ6mqbBpP5jjUy14U8DUJF25Xl1e+lkn80UzRJX93D1BU01eBY5GgG
         T3bQ2c5PgSJ03ZWXGKDxrzkUd2DUPAoyANAOyL6kT20v6r01BnS9/6RyvwYfnxsMQqTt
         bS0NNUoXToSapKYv02Cnsc0GkNtKrDhjL6X7WDSkRNbVBT3P0Og7sFHVomxUx55UuToQ
         D2gtLw7CrXAo+63p52KAeMMDLKWgv8BM2WqJn5FMge0NkffY9VhFLDjpBPRAS+Gw1Rcv
         wawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947027; x=1714551827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPFo+IxgUQ2kIlqLDAB9FNtWLgx3YKcW7YRqfGcT4is=;
        b=Kkf6almMdhQSejewd8XRGSBed1WI1NjwqyfmZfGLYFdr0evWjHkkllTi8fardbjbo+
         JsJ9IuzzLZH68ZOt1vQE55Wgs0mn4uicPpjOmNQXYQfUPRDsdinY6HHxgtL2+AzSlUXZ
         /Wt7F36k/8nZKWbGSNjfd8S/hmjEEJ2Yqeo/CIRRQy9+3rxl04IQmor3xxeIzWB9Czyl
         mJzpw1rVla6JlCP8qtU26QlZwWZGVwR2+NyJhPP0Dx1TGM+Ab9AqHC0nyGd4YY8XLo2J
         uo7UgyYYatfLnUjP+XUsc+/kQrkjSL/g4pAd7R1l5V3mwrOLl+8TvRHK1GGkzwkbRwPZ
         4D5g==
X-Forwarded-Encrypted: i=1; AJvYcCUK8gUCaiNXeD+NNb9frkgm4JD8qUbQu+V364a9DVeYgdeUB+v2h54mRRQlyVuLPtHUc8f3IK7giCyY5lYSLyz+wBh6tkYjSUEb985/
X-Gm-Message-State: AOJu0Yy7rFPjWAthpUeHWXz9dbARBvSquddHwBLKnncgVUaZA4Y+DPxt
	kSQNuOAnIQdv17ZxOb0yTwyvBkBeXpLD3a8VMhMvruFm3zKGXdyyXQVYdM9lc+pUEcmd8PRMsf6
	d1gGzGMsugdXPm3/J3lSdZgyEGDZLpvBnibc+Aw==
X-Google-Smtp-Source: AGHT+IHZ7X76KDkGnfGA3Bl/vGPMhc2BLowSx3pIZsvhaqPdCqZCneOazFLgOUQklJc7AYOw6nVgw9sTtiQodVWHsnE=
X-Received: by 2002:a05:6122:3284:b0:4dc:fbc5:d47 with SMTP id
 cj4-20020a056122328400b004dcfbc50d47mr1633005vkb.16.1713947026616; Wed, 24
 Apr 2024 01:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213853.356988651@linuxfoundation.org>
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Apr 2024 13:53:35 +0530
Message-ID: <CA+G9fYuv0nH3K9BJTmJyxLXxvKQjh91KdUi4yjJ0ewncW5cSjw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 03:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As Pavel reported,

LKFT also found these regressions on 6.1.

The arm build failed with gcc-13 and clang-17 on the Linux stable-rc
linux.6.1.y branch.

arm:
 * omap2plus_defconfig - failed
 * defconfig  - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Suspecting commit :
-------
  ASoC: ti: Convert Pandora ASoC to GPIO descriptors
    [ Upstream commit 319e6ac143b9e9048e527ab9dd2aabb8fdf3d60f ]

Build log:
---
arch/arm/mach-omap2/pdata-quirks.c:259:15: error: variable
'pandora_soc_audio_gpios' has initializer but incomplete type
  259 | static struct gpiod_lookup_table pandora_soc_audio_gpios = {
      |               ^~~~~~~~~~~~~~~~~~
arch/arm/mach-omap2/pdata-quirks.c:260:10: error: 'struct
gpiod_lookup_table' has no member named 'dev_id'
  260 |         .dev_id = "soc-audio",
      |          ^~~~~~
arch/arm/mach-omap2/pdata-quirks.c:260:19: warning: excess elements in
struct initializer
  260 |         .dev_id = "soc-audio",
      |                   ^~~~~~~~~~~
arch/arm/mach-omap2/pdata-quirks.c:260:19: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c:261:10: error: 'struct
gpiod_lookup_table' has no member named 'table'
  261 |         .table = {
      |          ^~~~~
arch/arm/mach-omap2/pdata-quirks.c:261:18: error: extra brace group at
end of initializer
  261 |         .table = {
      |                  ^
arch/arm/mach-omap2/pdata-quirks.c:261:18: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c:262:17: error: implicit declaration
of function 'GPIO_LOOKUP'; did you mean 'IOP_LOOKUP'?
[-Werror=implicit-function-declaration]
  262 |                 GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
      |                 ^~~~~~~~~~~
      |                 IOP_LOOKUP
arch/arm/mach-omap2/pdata-quirks.c:262:55: error: 'GPIO_ACTIVE_HIGH'
undeclared here (not in a function); did you mean 'ACPI_ACTIVE_HIGH'?
  262 |                 GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
      |                                                       ^~~~~~~~~~~~~~~~
      |                                                       ACPI_ACTIVE_HIGH
arch/arm/mach-omap2/pdata-quirks.c:264:17: error: extra brace group at
end of initializer
  264 |                 { }
      |                 ^
arch/arm/mach-omap2/pdata-quirks.c:264:17: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c:261:18: warning: excess elements in
struct initializer
  261 |         .table = {
      |                  ^
arch/arm/mach-omap2/pdata-quirks.c:261:18: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c: In function 'omap3_pandora_legacy_init':
arch/arm/mach-omap2/pdata-quirks.c:271:9: error: implicit declaration
of function 'gpiod_add_lookup_table'
[-Werror=implicit-function-declaration]
  271 |         gpiod_add_lookup_table(&pandora_soc_audio_gpios);
      |         ^~~~~~~~~~~~~~~~~~~~~~
arch/arm/mach-omap2/pdata-quirks.c: At top level:
arch/arm/mach-omap2/pdata-quirks.c:259:34: error: storage size of
'pandora_soc_audio_gpios' isn't known
  259 | static struct gpiod_lookup_table pandora_soc_audio_gpios = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:250:
arch/arm/mach-omap2/pdata-quirks.o] Error 1


steps to reproduce:
---
# tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig omap2plus_defconfig


Links
---
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWG4dRZzA7WgJqyLQ8Rm05WTUo/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.87-142-gcde450ef0f2f/testrun/23640116/suite/build/test/gcc-13-omap2plus_defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

