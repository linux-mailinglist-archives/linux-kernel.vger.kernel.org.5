Return-Path: <linux-kernel+bounces-87191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12A86D0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416E31F21B21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1F70AE1;
	Thu, 29 Feb 2024 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Yr8AIOHA"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2116062E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228377; cv=none; b=Vpkm7+MaD+ynYOEm/RtTzo659nRJvnRJsbeMiWswRrJEQsK+IK2PBl4A+AG3YKSR7Hxt8kNDZT9YwjPyyK00LqDGwHJpa/IRzcZ59jUv3FsM4WTGBYlAZfnAmaEkrjTxIZZ2BAqyizO/3AigHiZd8yJ6fddUjk7XSv8zM64Q4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228377; c=relaxed/simple;
	bh=IAtiPDsmSz7hD3vhPLE/igLGTYY4MMGETCJKNgYaVuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENwwTubxbXNgY794kWLKBiW9tusd8v+GCjcD7hlujAJxDVMvGROC0ZsWgxj6idpkMSdvOIJm0G5Qrzngr98uvs8xxw5dsqa6KEzIbbh4YRlbWwYNXGaBLrkuJsFi78f3SZlUJKpFdZK2c0oVC9avWSnxQHYDUJFX1WphVyhlv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Yr8AIOHA; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4727ca88800so355977137.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709228374; x=1709833174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAtiPDsmSz7hD3vhPLE/igLGTYY4MMGETCJKNgYaVuM=;
        b=Yr8AIOHAyBNbzGWguva4lWdNncaEt96R8bL60P8X3DnCtuE5054AIquijNVFUR748m
         k/CJw+UVgl9dxnmsKXx+gbn2eeLI1NZYG438eQFFjvOtZFAV5UEuXFYEIznMm58DlXC/
         OlN5ePW/DltNEFyGphlyjQFyApnVnYKD5QBr945kB8NkTwRiAxY5ULGzn8tMl1bomSIz
         6YUo4dZNr1CYIsYwBC6ATdjZY8e9QpMt42re6D1B5ToUwjrH+F5eJFulyWUNlsG43Dfq
         4sdYlxNzRuxoBoo4FE6WA2IUeBW4J5MDsf2ZnYC4E9oCWVeRn8aoSQCYhCVHJ5Nzq87a
         ep8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228374; x=1709833174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAtiPDsmSz7hD3vhPLE/igLGTYY4MMGETCJKNgYaVuM=;
        b=g2cRhjMB0yrvX3wyj39sQq39EeadbxSB+pFsW07oK5iudHvcD9b/PXR1bjrSoesO4Y
         zMOvjb1z7IQokN/nQdEcYbVDjLBH045uWLdQYvBpYS/K4wwNo3+IWX3O3raGY6gV2Bt8
         dbItYXhQVFnfbEWxR5T2qyrOj5+TnPnzaTt1MpwzVZVmfuyV0s2a75U7PrKxxFUWCrVj
         eu0gnbzOQsU6YJ7/qDm2v9CbnFXzXbutDOMM8nZrFoj43L5NzVdd01/nga/jEC0yOwp/
         Vhemtc0+99Vzmn1iw0UCd4aQbxbHRHbRjoDz9R4KDafuMzsIQFSjwmk9MJA9R6zU0dih
         pEmw==
X-Forwarded-Encrypted: i=1; AJvYcCXzKWY+JNAww6TObNaKzlTh/W1CkX5MImmrJwEJz0b2+SlovaHURQFG5Fpp0/7NLBnbGVPURfLnMZrG5lBW5mSoKJQDKTHXNmt+Ru8Y
X-Gm-Message-State: AOJu0YyUgTflje0m1F7PUgWo9NbDoqVhGWHgnGCBYYLebaYcRbdGSO5f
	qIweQbpZvOONwu+P21VefP2YDE8CSvLkATf0YF5QMkulHZf2awr8KnxGYtVhbsaH/iSZWxGyzyE
	lEWzYR+58InWiNo/Bt0jwpHcFZhIceJIjy6YGZtrWd0TFnFSeE3E=
X-Google-Smtp-Source: AGHT+IF3+Ifh+McFCEvMTyUM4nycbbpEpZ12Cahi2H6RdLSrouVmOQ1v6+nsASB2/9f5BsKQYIiB22pbGJw45Rvkepk=
X-Received: by 2002:a1f:e642:0:b0:4d3:3974:657e with SMTP id
 d63-20020a1fe642000000b004d33974657emr2462155vkh.4.1709228374399; Thu, 29 Feb
 2024 09:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229084555.43701-2-arturas.moskvinas@gmail.com>
 <CAMRc=MfTo7MnfMhRQsjeFsLv3yjEtP0C3ytqACN+nuGw0Sr-Bg@mail.gmail.com>
 <15e6e45f-7398-4703-8154-35e769bac94a@gmail.com> <CAMRc=Mf__-sbAV0xuC2hsxm_-kQWqgxSLRYLKqt9-ce+8_Kf_w@mail.gmail.com>
 <f9e90eb2-60e5-4ae8-9f3f-92922294e981@gmail.com>
In-Reply-To: <f9e90eb2-60e5-4ae8-9f3f-92922294e981@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 29 Feb 2024 18:39:23 +0100
Message-ID: <CAMRc=MfSO_RbrU672WV8MnfRoPJbkJwa4q+7p++6sZf-x3LGOA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: 74x164: Enable output pins after registers are reset
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, 
	u.kleine-koenig@pengutronix.de, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:24=E2=80=AFPM Arturas Moskvinas
<arturas.moskvinas@gmail.com> wrote:
>
>
>
> On 2/29/24 15:25, Bartosz Golaszewski wrote:
>
> On Thu, Feb 29, 2024 at 1:23=E2=80=AFPM Arturas Moskvinas
> <arturas.moskvinas@gmail.com> wrote:
>
> Chip outputs are enabled[1] before actual reset is performed[2] which mig=
ht
> cause pin output value to flip flop if previous pin value was set to 1
> in chip.
> Fix that behavior by making sure chip is fully reset before all outputs a=
re
> enabled.
>
> Bartosz, does this look better?
>
> ... if previous pin value was set to 1 period
>
> Andriy, Bartosz, is commit message ok?
> =3D=3D=3D
> gpio: 74x164: Enable output pins after registers are reset
>
> Chip outputs are enabled[1] before actual reset is performed[2] which mig=
ht
> cause pin output value to flip flop if previous pin value was set to 1.
> Fix that behavior by making sure chip is fully reset before all outputs a=
re
> enabled.
>
> Flip-flop can be noticed when module is removed and inserted again and on=
e of
> the pins was changed to 1 before removal. 100 microsecond flipping is
> noticeable on oscilloscope (100khz SPI bus).
>
> For a properly reset chip - output is enabled around 100 microseconds (on=
 100khz
> SPI bus) later during probing process hence should be irrelevant behavior=
al
> change.
>
> Fixes: 7ebc194d0fd4 (gpio: 74x164: Introduce 'enable-gpios' property)
> Link: https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74=
x164.c#L130 [1]
> Link: https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74=
x164.c#L150 [2]
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
> =3D=3D=3D
>
> Arturas Moskvinas

Looks good to me.

Bart

