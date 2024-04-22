Return-Path: <linux-kernel+bounces-154064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15C8AD6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62064284149
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A11CF9B;
	Mon, 22 Apr 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEhU+RcZ"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EFE1CD2E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822871; cv=none; b=f5yoc4x1NqD7YEkF98gNgCYwkMc2GD0wTUmzLBi4gshu21Kw9EXub5WEyc+3pCJL4Ibo6YuMWn/uoCCzF/rCFkOW3PZXjDCTVgZ7j//fPpWprqunvZIA5tqS5eYMH+u0LfmBkfnaeimX2tHBKM/aFgPht8KTHuS9YGIR5oePwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822871; c=relaxed/simple;
	bh=Cbt4igSSEOCM0YFndB3iSaxU9eb8wKebvbCilWGRQq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfzIDINOTHCEgTrt+PHV+yqpB8DoSmDwNCYjuFGBxzrh+oiPzaTAgZ6EI0kN74akaEjlhUYycu15VwkYk0IaO0ml2v8+kNGFoc1pNGsTxMFtQy6i/14CaOrVdcKzgFaz/BcdFUA+Yxq3rVe7VtKqZWUs/3HihnF3HQgUmYhfIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YEhU+RcZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a073f10e8eso8625826d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713822866; x=1714427666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4TkjiOmnf7EkU2uUP7WyZ/U9eWwbiO9i0mpJYmLC7M=;
        b=YEhU+RcZ9DG2o7bbTF66ZGEe048wtODeAHs9XyalWF2RbKwputMXN8iO6AKtloNE2h
         w91eHwIG6eQck4zCHy2TtyZIn1XkQ27G/BuAhLRzlXmz6x93m7BuHDy9ehA753o6M+7l
         uEFucKm4ECEWoun3DuBvQN9DpWAaINC+Z5wL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822866; x=1714427666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4TkjiOmnf7EkU2uUP7WyZ/U9eWwbiO9i0mpJYmLC7M=;
        b=iR5wBneM7uSU3qV8OQDVXS8sjbV6wlAGpTFSEYFXQi6kz0KzcNRBkJGx8F2soe7Y1g
         +20WfyAE7X4lT1fS8D4EIWFPZNZW2FDqStyo430BdEEEC4a+6V+tkfZuEx/WLsaPHEXT
         j4gA+WHjFhWdeZOWUGMUEC+Gv3pxkPc4AOFXSiMEXVzDK3vgMb8ta0cGnTRyMbERjOu4
         y5RvPSqPRAAiHVxkFDFmZTlZgOWvLuITMsuS1cl3VPcdBGY8EiQSvTWIbpj27+anc5ol
         M5Kvy2cORRcQC+uAyQCpnaZ7wSTZgYj5cA3jwXPqVOvHEQJK+XPGsPYnhfWFR/HU6Szp
         Tytw==
X-Forwarded-Encrypted: i=1; AJvYcCXqk2Pj1odMscRLxgEXGEDXuQ+RZc7niVY35wzYwf4YjS+eiHA1nE+W9Fg6p2aZ3Q7C7FiylUC1QQU6ZOGWumDF91CvLZAOt6RHfonh
X-Gm-Message-State: AOJu0YyQlnvEWupaG86hXEitJEMoFmTmRkqsDPEOBBbZSWSJWNb5jkP2
	HUkysGVTjafbiWO8AdC26SdZbnyrlVelV4HnQ0iG3tIXGVWAVAfo4cYv1za1RycjRDKpPbFWMpt
	JJLPd
X-Google-Smtp-Source: AGHT+IEgqQ6ViSmhoE/sl+2BcZD+/6WDEmS0o2IBIg92494i3STCWcb1l7tOhhv3WH14yt2wsy9erQ==
X-Received: by 2002:a05:6214:a93:b0:6a0:76b9:3e11 with SMTP id ev19-20020a0562140a9300b006a076b93e11mr7202908qvb.53.1713822866537;
        Mon, 22 Apr 2024 14:54:26 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id n12-20020a0c8c0c000000b006a050fa22cfsm2139503qvb.145.2024.04.22.14.54.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:54:25 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-439b1c72676so60291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIjrOkrkpDeMFSz9pJSkk6N7fxIRlVtNcp9sRplHVBM+Z9mMuTi/COUFFUr7QbOROXt08eTSNSAmX2xR5efAp+2qcPGy1DcitkHZ4P
X-Received: by 2002:ac8:550d:0:b0:439:9aa4:41ed with SMTP id
 j13-20020ac8550d000000b004399aa441edmr95963qtq.16.1713822864486; Mon, 22 Apr
 2024 14:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
In-Reply-To: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 14:54:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHt7Pm-qEBs7vtK0B0DCbu9YbU465OdpSKCYZVpNuOaA@mail.gmail.com>
Message-ID: <CAD=FV=UHt7Pm-qEBs7vtK0B0DCbu9YbU465OdpSKCYZVpNuOaA@mail.gmail.com>
Subject: Re: [PATCH] serial: kgdboc: Fix NMI-safety problems from keyboard
 reset code
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 19, 2024 at 3:30=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, when kdb is compiled with keyboard support, then we will use
> schedule_work() to provoke reset of the keyboard status.  Unfortunately
> schedule_work() gets called from the kgdboc post-debug-exception
> handler.  That risks deadlock since schedule_work() is not NMI-safe and,
> even on platforms where the NMI is not directly used for debugging, the
> debug trap can have NMI-like behaviour depending on where breakpoints
> are placed.
>
> Fix this by using the irq work system, which is NMI-safe, to defer the
> call to schedule_work() to a point when it is safe to call.
>
> Reported-by: Liuye <liu.yeC@h3c.com>
> Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.=
com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/tty/serial/kgdboc.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb1640054..adcea70fd7507 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -19,6 +19,7 @@
>  #include <linux/console.h>
>  #include <linux/vt_kern.h>
>  #include <linux/input.h>
> +#include <linux/irq_work.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> @@ -48,6 +49,25 @@ static struct kgdb_io                kgdboc_earlycon_i=
o_ops;
>  static int                      (*earlycon_orig_exit)(struct console *co=
n);
>  #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>
> +/*
> + * When we leave the debug trap handler we need to reset the keyboard st=
atus
> + * (since the original keyboard state gets partially clobbered by kdb us=
e of
> + * the keyboard).
> + *
> + * The path to deliver the reset is somewhat circuitous.
> + *
> + * To deliver the reset we register an input handler, reset the keyboard=
 and
> + * then deregister the input handler. However, to get this done right, w=
e do
> + * have to carefully manage the calling context because we can only regi=
ster
> + * input handlers from task context.
> + *
> + * In particular we need to trigger the action from the debug trap handl=
er with
> + * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap e=
xit code
> + * (the "post_exception" callback) uses irq_work_queue(), which is NMI-s=
afe, to
> + * schedule a callback from a hardirq context. From there we have to def=
er the
> + * work again, this time using schedule_Work(), to get a callback using =
the

nit: schedule_work() (no capital "W").

> + * system workqueue, which runs in task context.

Thank you for the comment. It makes the double-jump through IRQ work
and then normal work clearer.


Other than the nit in the comment, this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

