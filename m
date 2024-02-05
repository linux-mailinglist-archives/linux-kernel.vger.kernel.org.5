Return-Path: <linux-kernel+bounces-53819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C086984A6F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E79B1F29886
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA05C60A;
	Mon,  5 Feb 2024 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QIDXPnXJ"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007765C5F4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161576; cv=none; b=kfuqLw2xA0UDjfYRUPRA7S5uwOmIeniDTQWlUIiYNLTwpHVAQ6gGVf07MgZb7MXcdMwXdlfTL/1FMvn5IH7EwsrnbjtFZ5clcODfFZkRDdoUki22Okd080tN48wSBsICWp+LXtGfFVfKhqaLfhBWr6c6oFwDe9taU9EvnMEcwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161576; c=relaxed/simple;
	bh=hO63VuEPXJUY9hUIA7K7fRg3qwjtnbS+xLs8dPIgUPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqytyzaEnwq2K/kmrkPEmQV8uOxiVdulX50Qy/ButpVJQ/jiaiR/6ckAH1nz3ZP2Sfk8wj8HuWLfENYq155b0QlgVt81l9lVPTBVQ6Kwy+4W0h57ufiVxfnXkJmy8nPG5rVSiVa45K4SzEWIxxnJj0qEWXM0r9deAudVc8PeakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QIDXPnXJ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so10452241.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707161574; x=1707766374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpJ2KDFjypNCJA/M9vBCBkVGGyjLvFlc5UOprwF/PLc=;
        b=QIDXPnXJ9Cfbam2BeLztIMEAW7J8m/ok9AkPkDk+FEYIYywJwpGsn3cPblYCjJ79wm
         8ztnCTVMDdix1IMT8CI+HirNGVyHrGQqa307orXNHtJJfLcx1HFhkoYWY3BzNJDOAjWP
         2H3JezcJfm0c4DVIXDEkhgLGiHuK7cL0D8XBQ498GaFoPLr2Spf4qDRBvZDSlnpklRtV
         suvDZE4/z+x7NqWT6iEYNBV4dnD455fqn6Ai8pZ20mSpjAbbO/COEjUhcbtLhw/KN8ng
         NnYn26PZjk/0VsEavogscDRfxaXJGpQgpdGCZ80rukRmGWrjFtdYzRoMTf2CnDCMzizt
         tcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161574; x=1707766374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpJ2KDFjypNCJA/M9vBCBkVGGyjLvFlc5UOprwF/PLc=;
        b=kSDgdUreqHXJ5RD2oJ8goyEjsZ/JAgL07nJh9uOYCLNNL+KGgIL5x80tBM30jpGhgo
         Gac3G+86QsJfuqAys+P4gYf6ocmvuMub+hmVJkjB8rQmLDR4P622+JsGiXozyLannHYt
         vl3XLkIh8OCl/mxXR2O+EJ3K4KC7pMhIAIRzCZBTCAKHHvIAE/Y3zqkT2hjeyeTRTC2T
         K/g+jVWAUdwKPekNWFTI90QxfduYNyMOeE0H8Uyxfqf404Ud6v2bN6z90Ca7ITtLJ51A
         IPuLH4crJYaYfHUuBqjhKhqG4qCUgdIWTE7ehi18okWIiURT3Wnsz+m1YImgddbT42ZD
         2ixw==
X-Gm-Message-State: AOJu0YxC/8XlADgXzxrWcuE1o9mkSqKCYBq64eUoUATMxCPKO0NkxDnu
	geJGU+ZuJHNFVc0/sa1fvUoyXBsZZrpohg8ERDZC9TrCFRdZMPhKw13DX2+mhlIYUOfEkE0YEnc
	zv9Bnl5RNK2mzIg9ZckOZ4cHqxgMQvZILwwDa6Q==
X-Google-Smtp-Source: AGHT+IGRj4nXNEOxA0AWu3Js+UzaMaCNnffXbyCuNiwCnejBiZnqQGgFyQD10my/FkTY9R7SNeFBm/zW+a4AHcwEcaQ=
X-Received: by 2002:a05:6102:c88:b0:46d:2558:9490 with SMTP id
 f8-20020a0561020c8800b0046d25589490mr1013540vst.15.1707161573804; Mon, 05 Feb
 2024 11:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
In-Reply-To: <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 20:32:42 +0100
Message-ID: <CAMRc=MeXeKwX3RH602+CnXf_t6BvBMoRYzGYhYXkpN0XTprQsQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

>
> > +     /* FIXME Cannot use gpio_chip_guard due to const desc. */
>
> gpio_chip_guard()
>

Nope, it's the name of the class type, not a function.

Bart

