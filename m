Return-Path: <linux-kernel+bounces-73090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA485BD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31170285281
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8726A34E;
	Tue, 20 Feb 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vtGGFpgf"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDE67C49
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436519; cv=none; b=CaegtEdrf0QtaJy8XtTUEBWTEmnYVLwXkHt6Ruulm/t0mp+BYqmyQX+cEW6kOgyXN/AyFbHG6YCB/kFQ4KO2Q8lpX9QfcM/MsesuT4icDVE/r48Ru6o7rDq3JEVhwL77PqQJZZSFQa2S9qQWozcNsrKqwxRNrLkanwbuT6pFADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436519; c=relaxed/simple;
	bh=QQBscvCfbaDRlzqcyAKjfFFH/xl7hw7boMX/xj5Gdk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkyocNfHcbqHy6eFi37YsqNL6YsdsfEU5z+49tjN4Ro+LBQh+lZr3vWuxdIhTnmz9I1hVa7RZOJD5Md6WR0qyu96h437AIgJgewripqSEd/GSI1I8H6sC0XSxuHdE14NqDxGybUhqIvXCz5j+b1fmrfirGNF8xFgnZi7rsubGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vtGGFpgf; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so3437645241.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708436509; x=1709041309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP/TK90neT8X21AtRisPl7685j0CAZc0zErZJvKoQI4=;
        b=vtGGFpgfoQEbBi4YvkwAKlT3/xI0GglK0CG5yXQRrAmagwEdk7vW6JL7qnCJV4xGgK
         X4OxjISO+00dIkd9CcIh+K7UvoX89aaC/O1bL7rlLGuB7ORKAFJABKZbbRfScs+QoOFo
         M3K2RszlnSEEyYP+DSF6w4EvSN0zuR/+7go6mHi86NPbjOFOiU6IZ52O093dS7vgYd+J
         zm06VuYHOQZALEzWtW6ezEJblrci9ih12UYVAXM4WcBo+4d0dobWHt82T/kzlZn7ByQ1
         ft9eUHlK2fQ+MfNqivMKcAJ/ewigYgKA5yP4sVrZepnIZd92AhZnAmoLkDlL9S+gS0k8
         xbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708436509; x=1709041309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP/TK90neT8X21AtRisPl7685j0CAZc0zErZJvKoQI4=;
        b=Jue/41Y5k3PZnJBlB07cPT+ZX8fS/2xrl8quPZJxqOR6qxBLty8clYD6Qn55YBYwpA
         GGUU5Q3sBnEvB1HDekeuxntXVX/W/DDfFeydhEXPsMedaPcu1R653G0+7o2iAKBDafjN
         /TI2ai/wUKeTg3azSeJ1+S3ZKYXmU949rE53s8TWSYBry9iSsvnUXmUF/J0o+bRQD1Ud
         HEy4ZV9u2+iaQCz1R843AW8TMVisfaEbuXzftDREDCeDo4o0G7e5pJ3WQgXJsfQNyitm
         RvfnGUFSUETTGG2IHcZzcxI7n+pzqIJrkGx+3YDtfDiU854kLOBwSEEepuWW+E9n0kdX
         EJhg==
X-Forwarded-Encrypted: i=1; AJvYcCWh0xMzmbBIZeaSuwMAA73W8NpQplu6o2tUfAt68iSC9tQ8jpSxitifZOn5m6llotgUQi3q8puUjPp4A1RUQPy9JtxAA3jfu1Ee3bDI
X-Gm-Message-State: AOJu0YxeC1wIEA8h6ATxf+2lT5ftoRk+wQ4diDJ+Ykc1uqsW4vSKM02d
	k6OKeYG0azYrqlpL4EEL0wEYh00wx2NDoyCFcDUvv/FBHD44pyPGc/ks7LcqfO50R2CVVfJU9J9
	m16/ZO10ueGwbxumM39AqypwA3nHycHcw5dxpjz3ziWRmqrU0rFA=
X-Google-Smtp-Source: AGHT+IEBVqrGCcl71zhl8y7obE4covazgnsV45hChAyMiiWzAb7U3Rn+DCURtJ9DVwFtq4joCvmggniLbawJuIySIJw=
X-Received: by 2002:a67:ad19:0:b0:470:4aad:7aa4 with SMTP id
 t25-20020a67ad19000000b004704aad7aa4mr5837008vsl.8.1708436509617; Tue, 20 Feb
 2024 05:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111019.133697-1-herve.codina@bootlin.com>
In-Reply-To: <20240220111019.133697-1-herve.codina@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 14:41:38 +0100
Message-ID: <CAMRc=MfpudtuwMEexJdWwhJ3sdbTn4fhpwQvGKOHSPE6+6k4jQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio chip removal
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:10=E2=80=AFPM Herve Codina <herve.codina@bootlin=
com> wrote:
>
> Hi,
>
> When a gpio chip device is removed while some related gpio are used by
> the user-space (gpiomon for instance), the following warning can appear:
>   remove_proc_entry: removing non-empty directory 'irq/233', leaking at l=
east 'gpiomon'
>   WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x19=
0/0x19c
>   ...
>   Call trace:
>     remove_proc_entry+0x190/0x19c
>     unregister_irq_proc+0xd0/0x104
>     free_desc+0x4c/0xc4
>     irq_free_descs+0x6c/0x90
>     irq_dispose_mapping+0x104/0x14c
>     gpiochip_irqchip_remove+0xcc/0x1a4
>     gpiochip_remove+0x48/0x100
>   ...
>
> Indeed, even if the gpio removal is notified to the gpio-cdev, the
> IRQ used is not released when it should be.
>
> This series calls the gpio removal notifier sooner in the removal
> process in order to give a chance to a notifier function to release
> the IRQ before releasing the IRQ mapping and adds the needed
> operations to release the IRQ in the gpio cdev notifier function.
>
> Best regards,
> Herv=C3=A9 Codina
>
> Herve Codina (2):
>   gpiolib: call gcdev_unregister() sooner in the removal operations
>   gpiolib: cdev: release IRQs when the gpio chip device is removed
>
>  drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
>  drivers/gpio/gpiolib.c      |  8 +++++++-
>  2 files changed, 29 insertions(+), 12 deletions(-)
>
> --
> 2.43.0
>

Thanks for taking a stab at it. I saw this issue some time ago, tried
to fix it directly in interrupt procfs code[1], got yelled at by
Thomas Gleixner for 20 or so emails and eventually forgot about it.
Nice to see someone tackle it again.

Bart

[1] https://lore.kernel.org/lkml/20230814093621.23209-1-brgl@bgdev.pl/

