Return-Path: <linux-kernel+bounces-61274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E9851033
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF701C21908
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40C17C73;
	Mon, 12 Feb 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVlArfF9"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B728387
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732001; cv=none; b=d7prx3UMhd0bML6Rv49x+YshezseflD7rwm+qINfxJmyV6+mw6NCbk7Ffs15ausFFOGWCQvugtVg4gOunPYKVRZq7KuhBZE6VI71Tgjlg/LuWXe4b00RU7PBNXbQAbggquWYyL0cN9O3rq3r9JCxCdRwsHQRQphlos9dhG9FTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732001; c=relaxed/simple;
	bh=vDtolkGdaMWAyiegRfRrHs/H2BrHfAsixEXypYInEIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAtgcyQva0c/nJRwnglQwR85SLPIVgTWWNI3vMxPA0KuihbeMjN82tepasg8Q8PYQwehvBQsE58r4xN/zam9JtLi8vNHCN4n+T1G0T8ZAp3z+A1fOC2RqtntmOAvwbj2D8bht2PCgCYE91cyL1WFk5ATJTq81ZcTozbnkno+0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OVlArfF9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so2579538276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707731997; x=1708336797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EUAKADpIIShD8988Fj+XlVtzUoRcV54qiXkH80IZQA=;
        b=OVlArfF9CHwHv5SJHsClLdyDfcg0xLHzPqRo6PpFxUg1EiBi1DWuo19SPZwC/XSdhJ
         Ni9Cf94/iAZtTS24RvCGgBoFVITXySBO/g/rp1ttRMGkPzRzet7omX1oygYxcbQj0uUr
         vSVQRCcnmzHf81A6vpFRd5CQDEmqX7ry0fNJx7WTzPR2iN87nXthqBHGbBlo7R2/rzO2
         SHCBhemZ+FfAHUyiZyXmvKQqo3n1w9/hJ+AJaeDUcux5Km72DBERxFgjMNtVa2Lke1wl
         Uq4PsASbfEBakMxprpB0HoazNv5GNsQMu4P2SvbMf0IOZicTFkRgZ2ghhIGUH3/0U1LF
         9LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731997; x=1708336797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EUAKADpIIShD8988Fj+XlVtzUoRcV54qiXkH80IZQA=;
        b=TmPLq/vFD88NOx2IB5hAa/3hftenJ9YFUdDWjORNDmaaSBelX/0guQ2B4lFBnj3ZQ0
         gjtG+A427W7sxN5eU5muMLa42jEhI0tecga0qRtLe38+KjMwB+iI1gngKg4TrwUVDwkb
         fAq5UkJgdYHm5zc1+41a2Z0GKKx3CQ4gzNunAFjm9wntmFVO2VnXAEOxWUqCtqjYOwcf
         HKj+1zExNuEJTEtyv7cuLrkz5ebJ3/m7q0VdvnTucz+ncmejmpB6cW9pxnrDvGW/2KTL
         JUJ0B4ZERjbcnqNSTcuQWsDUHyK9BTJiiXmF8bqikd+fpVJ4znHBBBPsqieH/avPUQVe
         0+6A==
X-Forwarded-Encrypted: i=1; AJvYcCVewx6rF0lmUBogRalYmUeD8bI5FxUZG/R+q64fAsqh/X+Tw0JblWAaqt7V0H8NcmDj3GMbOVHYUNXfstNe9pEAtmBoX6a84hMZwh9U
X-Gm-Message-State: AOJu0Yzb2BMXKDN9cw5bJchVoW1FN9KittgDR0kB+Kkmdla03YC4E9S0
	8/2/1qZ91+paOliv+5CGxDJ7K1LRZuAbLM/roqt8bn/9DQrHepuhEy+9kBKRwFDp0OhQU6CZjQr
	A9BMqoLWl9Ea+C6Ebr0bEGu+r4CR+QziHbXhtNA==
X-Google-Smtp-Source: AGHT+IEkE9Hg5jeZfD1Tk+QDSD6mWDX7W383XCB8OM5NDOZ5+ZDEaDz5sVK+FINKgigTa1URH3madrlxVrJc3kmUHhc=
X-Received: by 2002:a25:2943:0:b0:dc6:d313:62dd with SMTP id
 p64-20020a252943000000b00dc6d31362ddmr5102056ybp.61.1707731997192; Mon, 12
 Feb 2024 01:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-24-brgl@bgdev.pl>
 <20240210053730.GA187163@rigel> <CAMRc=Mcq2Obf58=iLHpm5B2_KkHCqRevFWupbBuKmNs_BV6i2g@mail.gmail.com>
 <20240212095722.GB388487@rigel>
In-Reply-To: <20240212095722.GB388487@rigel>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 12 Feb 2024 10:59:46 +0100
Message-ID: <CACMJSesy79vtjcywfZU8=irZF9DR535BjTGXahE0xzyHhC5fDg@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] gpio: remove the RW semaphore from the GPIO device
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Feb 2024 at 10:57, Kent Gibson <warthog618@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 10:53:07AM +0100, Bartosz Golaszewski wrote:
> > On Sat, Feb 10, 2024 at 6:37=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Thu, Feb 08, 2024 at 10:59:19AM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > With all accesses to gdev->chip being protected with SRCU, we can n=
ow
> > > > remove the RW-semaphore specific to the character device which
> > > > fullfilled the same role up to this point.
> > > >
> > >
> > > fulfilled
> > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  drivers/gpio/gpiolib-cdev.c | 1 -
> > > >  drivers/gpio/gpiolib.c      | 4 ----
> > > >  drivers/gpio/gpiolib.h      | 5 -----
> > > >  3 files changed, 10 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cde=
v.c
> > > > index ccdeed013f6b..9323b357df43 100644
> > > > --- a/drivers/gpio/gpiolib-cdev.c
> > > > +++ b/drivers/gpio/gpiolib-cdev.c
> > > > @@ -24,7 +24,6 @@
> > > >  #include <linux/pinctrl/consumer.h>
> > > >  #include <linux/poll.h>
> > > >  #include <linux/rbtree.h>
> > > > -#include <linux/rwsem.h>
> > > >  #include <linux/seq_file.h>
> > > >  #include <linux/spinlock.h>
> > > >  #include <linux/timekeeping.h>
> > >
> > > Shouldn't this be part of the rwsem -> srcu switch in the previous
> > > patch?
> > >
> >
> > That other patch was already huge. I figured this should be separate.
> >
>
> To be clear, I mean just this header removal, not the whole patch.
>
> Cheers,
> Kent.

Ah, then it makes sense indeed. I'll fix it in tree.

Bart

