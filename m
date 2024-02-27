Return-Path: <linux-kernel+bounces-83926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE3A86A029
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65162908C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5D51C50;
	Tue, 27 Feb 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fYp5rZ+f"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE951C39
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062039; cv=none; b=TfvHZU2i7it0aF8LRMyBmWcK/XQHNUkGvZWMUJCFar6eSKwlcN2ooeXbBUC6T7CqqPb1gZscmVZVnw10NBpSTmEAdvmgTjjROrYk/5lfzExKMplJwkV2xuXZnOvO71zcJFQnagRpg9wyVIbq/it007uNJfrq9xT3yQ6fFIHgW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062039; c=relaxed/simple;
	bh=HIKKzEVIfU4FOsnh3wR+y/aXx4vwP82xvrWjzqt/EUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7m7zSAAlyhUf2l5QaD7Z61jbjxCc8M1KX6i2/qoFxjSkSZZ0kzKt+DHSgMXFwlJroO24COtQeeSOLbpssTtF3fkSpE0ZTkt1CxdWYuMeW9ygfNg/q0QiTG4WT9EWMfDTt/Q02QyCeL/MNKay4VMUfstXCJ0TIv7xONmkxbDCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fYp5rZ+f; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4cb26623d0aso1169770e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709062037; x=1709666837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZo+bB1dk8cpOA97BbHSLAQyCTqe94gEN503/zLlktA=;
        b=fYp5rZ+fVw+uHT8xRt9OFYTFI6Vx5geo23hTpgTkzOcFMKxpm6g3pSyoCmwQlcsMID
         nCwIt9fOLikM676TCorWS/ubvRk2AnNpAkb85h0zxvPLtKD1Ww1uI541LG9gp42MIJw4
         ONCtzXnINAKgeUcLArp27wIyA3AZzU4Gb4/HZFRUnUAB/NHBK0lZZZ8ojROxyOZ9R6K8
         QQuOwsBImZxYPhT4miLymMwgvzInkRAZWns6Ic4b1eKe5Hf2VBL3biTvxsEzHqfjPucc
         0EFbDh02w59aBbFDkZpsYpQtrLhIfKAiamq360YlenGoPCorbEfJ6Iif32cq4pIrXMFl
         38Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062037; x=1709666837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZo+bB1dk8cpOA97BbHSLAQyCTqe94gEN503/zLlktA=;
        b=GTKymDNnE/+yKeZVSM7KcqmvZW20TClU7Sekb39VzciN1z9Gwdud5O+mpIOpUcZ1N1
         zK9JXVrZsE4HNBdcxsrb0CKRWYR7Lo1ivPnXSyOZM9QeYjMzshqIrcuIlntTNqNwBEE1
         Adqo3js9Dq+3p8tz1RdGKdkzS3dMIuxIyIcQKYnUh7VYlRobneBt8kZwZu3UdMohje4l
         uqzMG7LOgOUXnR9UWWFbm7UmQ2h9rohn9FVMX4sRjPTkDN8x1yVLPS2NgS/Bu4vF8Q/O
         BYigJIQMUvpNH6tvzlnk7WFGpP8XPWWqbG6QFbJzxecsUkm5AJvkdktC5DuhodbGABJ+
         SNXA==
X-Forwarded-Encrypted: i=1; AJvYcCXuF43m5OPsfGnJMk7fHTo4aAO0p/bH69x70Paz6bPGUkE6eWP3SrEhN4fy/9xC4/m+nLMNrr+KeK5Dgj1r3o++sCLrEC+Ug5Fi+hhO
X-Gm-Message-State: AOJu0Yzb/qGg96SkFT6eNBR3ipA6AP3HYoN+CAFi9pcHYVoVgXIRtDA6
	psriTCXzYPU4rdzewoMcMdb1NW0FlquDFVLs2j08YBUXnKYOnl0fKL3kpwZSm3GKslVkk0sczQQ
	B5cdQk72JWLedLJt5GXnTyYLj8DC0qG+1pNwJfg==
X-Google-Smtp-Source: AGHT+IEFGbWoEN34BxbHYqCqI7hjM/e4fBTxXm7fwvkcvPpFoesBxi9UGIlnKHbze7e/t3KXzySdRKQfPqIwzXwj+fA=
X-Received: by 2002:a1f:eb81:0:b0:4c9:44a0:84e6 with SMTP id
 j123-20020a1feb81000000b004c944a084e6mr7210453vkh.6.1709062036773; Tue, 27
 Feb 2024 11:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com> <20240220142959.GA244726@rigel>
 <20240222005744.GA3603@rigel> <20240222010530.GA11949@rigel>
 <CAMRc=MdCm4UXMkzvG17Vd=6ajE+feihgYc66qUNTTKXhN0--dA@mail.gmail.com>
 <20240222123615.2cbada98@bootlin.com> <CAMRc=McTkVPD-1_5vvPcM2Q15=w+ocki2xTmvQzU-o395A930w@mail.gmail.com>
 <CAGETcx_j4613QjHgX5AJ96Ux6MJSxxhT7DL36yzNv1JCsoxTAA@mail.gmail.com>
In-Reply-To: <CAGETcx_j4613QjHgX5AJ96Ux6MJSxxhT7DL36yzNv1JCsoxTAA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Feb 2024 20:27:05 +0100
Message-ID: <CAMRc=Mf5fRWoOMsJ41vzvE=-vp3wi-Obw=j5fBk3DuQaZNQP2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip device
 is removed
To: Saravana Kannan <saravanak@google.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:51=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>

[snip]

> > > >
> > > > If you unbind the "gpio0" device after the consumer requested the i=
nterrupt,
> > > > you'll get the same splat. And device links will not help you here =
(on that
> > > > note: Saravana: is there anything we could do about it? Have you ev=
en
> > > > considered making the irqchip subsystem use the driver model in any=
 way? Is it
> > > > even feasible?).
>
> I did add support to irqchip to use the driver model. See
> IRQCHIP_PLATFORM_DRIVER_BEGIN() and uses of it.  So this makes sure
> the probe ordering is correct.
>
> But when I added that support, there was some pushback on making the
> modules removable[1]. But that's why you'll see that the
> IRQCHIP_PLATFORM_DRIVER_BEGIN() macro set .suppress_bind_attrs =3D true.
>
> Do you have a way to unregister an interrupt controller in your
> example? If so, how do you unregister it? It shouldn't be too hard to
> extend those macros to add removal support. We could add a
> IRQCHIP_MATCH2() that also takes in an exit() function op that gets
> called on device unbind.
>

The provider in my example is a GPIO chip that registers its own IRQ
domain. The domain is destroyed when the GPIO controller is
unregistered but interrupts can be requested orthogonally to the GPIO
subsystem and we don't have the knowledge about any interrupt users as
the .to_irq() callback is never called. Let me know if anything can be
done in this case.

I used the gpio-sim testing module for it (instantiated over DT) but
any such GPIO chip that is also an interrupt-controller would behave
the same.

> [1] - https://lore.kernel.org/lkml/86sghas7so.wl-maz@kernel.org/#t
>
> > > >
> > > > I would prefer this to be fixed at a lower lever than the GPIOLIB c=
haracter
> > > > device.
> > >
> > > I think this use case is covered.
> > > When the consumer device related to the consumer DT node is added, a
> > > consumer/supplier relationship is created:
> > > parse_interrupts() parses the 'interrups-extended' property
> > >   https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/propert=
y.c#L1316
> > > and so, of_link_to_phandle() creates the consumer/supplier link.
> > >   https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/propert=
y.c#L1316
> > >
> > > We that link present, if the supplier is removed, the consumer is rem=
oved
> > > before.
> > > The consumer should release the interrupt during its remove process (=
i.e
> > > explicit in its .remove() or explicit because of a devm_*() call).
> > >
> > > At least, it is my understanding.
> >
> > Well, then it doesn't work, because I literally just tried it before
> > sending my previous email.
>
> For your gpio0 device, can you see why __device_release_driver()
> doesn't end up calling device_links_unbind_consumers()?
>

It never gets into the while (device_links_busy(dev)) loop.

> Also, can you look at
> /sys/class/devlink/<bus:gpio0-devicename>--<consumer device name>
> folders and see what the status file says before you try to unbind the
> gpio0 device? It should say "active".
>

It says "available".

If you have some board supported upstream you could use for testing, I
think I could prepare you a DT snippet for testing.

Bart

[snip]

