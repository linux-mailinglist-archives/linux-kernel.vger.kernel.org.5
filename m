Return-Path: <linux-kernel+bounces-61261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF166851010
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AAB213E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082F17BD3;
	Mon, 12 Feb 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nqQMA9iQ"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541A17BB2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731601; cv=none; b=VNoHRp4nlUrN36uYF1JN248sJ64nmy3LSdMmGEQqQ+F7PPJ1Tv4RMVRaEOfiaLpxzkMiG6qVTEZ2FjW8ubV5d7Y8i4dQru3L6rQ6IeINeBVsON7cC8PJTA9DS1La7PnPCJt68kwbm9fQoHAxY3nHqN0nh7nVLK0qd1zLzHO9FSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731601; c=relaxed/simple;
	bh=nus13uP2h13TaLzuZyHgqMURDq86XtXlluSv6CHhhHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuEniu0Om1+SYBvbRl7FQRdDQnVzLw956prc38LZTMZmy1KjjS+7/s1WRrO6Z9TayqiAKIYGAhQ+/eQ3uAAT5OGznFJTsuqZsYRssrBNBO88P7sSkZ32Ikx2O7EzjtRn3yz/XBNrrsomIARlfVNbg8raoGzHoQtr0nob/orWV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nqQMA9iQ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d130979108so1041129241.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707731598; x=1708336398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfkulGaUinwmqh3cPnf9KWHBA6cCTkzaIyl9HsKgL4Y=;
        b=nqQMA9iQbgpCuoPr2KTOY2v7mRsXYOrznYXAaYmvpb0p7VsHciDGqvUVNeBTfmChof
         1pfYtCwfhvsGNz89MRfR1Z8GE0YGjgtV8oa5m09Bp+cR04kCR/kXxxThPnhLDB7sSEqZ
         QoymQrIl9baTgF+sXt9axMdm3ypEpixbFI5deWo1/7QXoUFCKfBcCnYTDap5mAIrIXcI
         jn5PZ49EAMBAfMH11VpiFPH+RCShZ1XWUbFbZ2LCnZHoHDI6d+6B1kUy4LR0ItbSOtNO
         agAShNzipSP/54jDevDGvTxdpTKPCWHl2JDEsA1FRjQ41gVmZj5G5oqpTmOF4R/KMF8+
         NlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731598; x=1708336398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfkulGaUinwmqh3cPnf9KWHBA6cCTkzaIyl9HsKgL4Y=;
        b=b0uhjdKcXDzFP4jLKfS1YfqWyqZpjkS8HW8KglnQIW+KqtcLQndJWprWop16bGn/0T
         2xICMsjgjRu0uxJ8Zl84ekkRsyppQw54+ac5nq8KXz/+XtEu+wNM6Tl4scCBqF4gBRZD
         n8HLdDSlWVLH+mYLGa4vgg4hAXu+mzOCG4GFYr+aNQcoS+zYbe8Q+vWYK3XsXRbQYmLJ
         gq1bWp5zMmkKT/Q1JTiJH7nJnnnhmWGdkKywlwlF0VIGjTzVetJ8eSoH4j0wDHbzWq/w
         5GDsIDaSm48hzNghQO0j2vrsQ5+uzKGQpEzhOLHe5JFGGp23hjL5ftZKjeyAJenCqgTW
         KHQw==
X-Gm-Message-State: AOJu0YzBKn9gwKKf1DQxJGRIYZKYQPNPt2DDOwYCn20agdIf9O/oj6Cs
	QMAGK6RsN3+AI23TGOMnW8StffTRaq2kBrc8DJASXZRGVtgf8ilFziLuCKlIvkaXR4B9gPZoNXR
	x/5WtYF4JEVj/CZqF6L9hVO3sL6RfDj3mLkZdpw==
X-Google-Smtp-Source: AGHT+IG1PxIbzBo55spJqG87YjfeoT4Cwbz4KWAVswGzf6HdwI6mHeO65JSPby/65G2WRjVlweDFXZanwE6gae9WTvs=
X-Received: by 2002:a05:6102:3709:b0:46d:2500:b3f5 with SMTP id
 s9-20020a056102370900b0046d2500b3f5mr3314313vst.35.1707731598486; Mon, 12 Feb
 2024 01:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-24-brgl@bgdev.pl>
 <20240210053730.GA187163@rigel>
In-Reply-To: <20240210053730.GA187163@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 10:53:07 +0100
Message-ID: <CAMRc=Mcq2Obf58=iLHpm5B2_KkHCqRevFWupbBuKmNs_BV6i2g@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] gpio: remove the RW semaphore from the GPIO device
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 6:37=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Feb 08, 2024 at 10:59:19AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > With all accesses to gdev->chip being protected with SRCU, we can now
> > remove the RW-semaphore specific to the character device which
> > fullfilled the same role up to this point.
> >
>
> fulfilled
>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 1 -
> >  drivers/gpio/gpiolib.c      | 4 ----
> >  drivers/gpio/gpiolib.h      | 5 -----
> >  3 files changed, 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index ccdeed013f6b..9323b357df43 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -24,7 +24,6 @@
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/poll.h>
> >  #include <linux/rbtree.h>
> > -#include <linux/rwsem.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/timekeeping.h>
>
> Shouldn't this be part of the rwsem -> srcu switch in the previous
> patch?
>

That other patch was already huge. I figured this should be separate.

Bart

> Other than those nits, FWIW the series looks good to me.
>
> Cheers,
> Kent.

