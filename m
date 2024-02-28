Return-Path: <linux-kernel+bounces-85733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0586BA13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE281F294BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF87004E;
	Wed, 28 Feb 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dCCV8CGF"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93D7003F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156258; cv=none; b=Nr9fKV77vGhpXoAjgfQiJ4Hm2Gs7U/nbmsJIV7XV93M/oD4d7+y89Rv644nJlaW64B0sLFcc8bbSWPJEtwlMvVxOOpxDU7RZ3xd+2lF1IdnhJkjaQKmOYmmb0nNO6iPDPcRr5VAAPKvGV3hN/ZQcJegruHd/G+FaFotkHHNZTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156258; c=relaxed/simple;
	bh=7MtaPH4mmZq/nGRB+yz9PCBbXAr4P3Ky9sNTUu/ul50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzZwlwX/vdT6j9R9DoMHr5P3nC1m5fSOsbgaNwOFk1i03ds8XVA3SiseqzEW3aFeQNMRvnU0KFk6Nqpm3waW5y2qTvxrUuwr09nJ5pyVl4wqsdTDYcVW+ohDrANDB4kN9v9ut76bGzeJZrGjrxnF/g8f+07kyyLXqsqZV/LadX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dCCV8CGF; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7da6e0fc90eso767841241.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709156255; x=1709761055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4qG/E7ig3urgZzazatHSTWk740qedvnHhyssGrklwE=;
        b=dCCV8CGFkXtb6F7nr1PUFaMS1R3clHImGe1jfTsDCX1g5NPRTGDnTzEeyNgdzuqJs2
         /6XwhhPaX4JjmXEildJ9wqojm+0AUOgbbMDK7Qvj9jO3ICw1vQfN2n81JKjzX+OepjRK
         F0dGO2zd2zl4wo0iBu7iZ16tETy90AI6rtoNoHPfhQ17vKzC1a/lhS1iH7tZz23HJ5xP
         XVbVCUQGxYnGDUWIS2u6AGRQepw51CiIsCgxWlZDk922U6jcV6b0jn5LOUjwbO7DrSWV
         +pURVYNeDhEP/OOAgy0ckTFpzFuGaI0nU35vlhVS/zAyEqWWLCW9NiZzaT7rneAqWcLK
         mYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156255; x=1709761055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4qG/E7ig3urgZzazatHSTWk740qedvnHhyssGrklwE=;
        b=LiuaKMK16EPBFChXqLvt1wcb7WD765yEfJ9Zw/hx9HAB0PVZBAs25nQ4lO853QeotF
         A2M3qc6bVnsALT7bpp9qTcqqFIzSS1oC5NNHQJ7s6opF9bnVcx7zNorcfnXqNML3pfJj
         Qe4jNGTSlFeW4Rh2ZX+Ijde5N6m3VYglu0U5iIALfBjVE1LPhj/T15MkVlsagOIwJFTU
         yr0gzNNCSqh5+5W9A04nyqidDwGBgXRrjt4y5rLs/mDUxNrCZCQBLNTtfoVxm2kETY7M
         422e2sqwQiYVmsDziGFfV1vYwnlLdZxFpAPwyKMqckI+MaqxamXhSAdO03SsZRw6zMwS
         KDqg==
X-Forwarded-Encrypted: i=1; AJvYcCXnA/BJ2G61wPJpc1K1TewQmjgQMxtIwzdMNlFkWCpIKoVEhkH/rWatS1/rNyl3ml562wj1X76lYIYijCIDj2mgGoIh4xcDyDxGuQk3
X-Gm-Message-State: AOJu0Yx0TiDW6yirw7XCOByrFHJM9LQlzpAIw1KhK2b+bK2qs07ERaBU
	pCkSgBRg9Jf+cdDrp1PWnfOd4Y2FVJkrZ1atzCjz9T+VLRoAGOtNqOahYWa8cxn+t5DXKVHAtkO
	3bQYOIvpG8oZ2KHfcHy6ZrHUTGU5/9MqBb1XYJA==
X-Google-Smtp-Source: AGHT+IGq+lHEgVzWoso5P1DGLN7doXiaFOo7RFZl+mOvfNuP7w1nVXfOoqkOmZ008ts9c9Z306x1EbAyL3+iorZ4ops=
X-Received: by 2002:a05:6102:21c6:b0:470:4088:fdc0 with SMTP id
 r6-20020a05610221c600b004704088fdc0mr329127vsg.2.1709156255343; Wed, 28 Feb
 2024 13:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223065254.3795204-1-swboyd@chromium.org> <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
 <CAMRc=Mdapd2jTACGqm-ujZrAunRmNeJ8_3+bpsN4ieCre52yrg@mail.gmail.com> <Zd-nI9XoYW3hrPXx@smile.fi.intel.com>
In-Reply-To: <Zd-nI9XoYW3hrPXx@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 28 Feb 2024 22:37:24 +0100
Message-ID: <CAMRc=Meh4LCqdfuVhp89Xb=QVWt13a-Ynp+8PPvNEyykvUsnug@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in devm_fwnode_gpiod_get_index()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Feb 28, 2024 at 10:28:07PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Feb 28, 2024 at 7:57=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Feb 22, 2024 at 10:52:53PM -0800, Stephen Boyd wrote:
> > > > This devm API takes a consumer device as an argument to setup the d=
evm
> > > > action, but throws it away when calling further into gpiolib. This =
leads
> > > > to odd debug messages like this:
> > > >
> > > >  (NULL device *): using DT '/gpio-keys/switch-pen-insert' for '(nul=
l)' GPIO lookup
> > > >
> > > > Let's pass the consumer device down, by directly calling what
> > > > fwnode_gpiod_get_index() calls but pass the device used for devm. T=
his
> > > > changes the message to look like this instead:
> > > >
> > > >  gpio-keys gpio-keys: using DT '/gpio-keys/switch-pen-insert' for '=
(null)' GPIO lookup
> > > >
> > > > Note that callers of fwnode_gpiod_get_index() will still see the NU=
LL
> > > > device pointer debug message, but there's not much we can do about =
that
> > > > because the API doesn't take a struct device.
> > >
> > > Have you seen this?
> > > https://lore.kernel.org/r/20231019173457.2445119-1-andriy.shevchenko@=
linux.intel.com
> >
> > Clearly yes as I queued the first one in that series. The rest did not
> > make its way upstream for whatever reason. What is your point? You
> > want to respin it?
>
> It was a reply to Stephen. :-)
>

Ah, fair enough.

Bart

