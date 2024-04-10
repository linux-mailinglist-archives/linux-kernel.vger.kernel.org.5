Return-Path: <linux-kernel+bounces-139275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB78A00D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1061A1F24DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913E181B96;
	Wed, 10 Apr 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG6NEfN8"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C1181337
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778542; cv=none; b=qGlhJMuuenRvMbjXAavVPqzm+MJ5NgC3seqZ+6scUqf5ZwLLCoiw3XYhEWSjMgdidNuUFb8tEWzJhr4eF0W6BeVC9opa4u6A9UCgqJB9+runNSFBJPsjElHOEamjXTrmOGcI1schREMfb+FWuefvELDrO+lXFKNwD7OfCzJydtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778542; c=relaxed/simple;
	bh=xEoGedRNiXJoGnqajnhf1BwPxOUbcpaoDU2aUMU/6xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkBNW3jisTX6vqLSP4Z7yD5vxhtT/8Jl5AqWfAWghqLI2fi0bPyqlGqjdMiMECQ/bl6bmoknKCcH6Xnq0rQ3fbb+9/8tY4bKEQKQ/Pvi3mwJ45uZH9SvpH8ckRc6lzQcPRVGVZ+FCB3nVeV3JKCln4GPtYExJAmFflONNbdOLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG6NEfN8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43477091797so2891cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712778539; x=1713383339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWCShh/bRGRzeO22yeBjtZLPhJ0/AGFCyE+KkcrS+ds=;
        b=pG6NEfN8H1FXyjhB6zgMz+V9P0x2RFFQyiTdsFO1L8VKpRZzyjbysiRD2ExCnRgOyP
         0jWXnJGQfToi03nmPxhOzvQ8GnFe5PYQ0eFRMbLuEO2dmusAPuDSUWSmQy4lRYpfQqn3
         D5g/7wYHgv2woKEaU8vyxaJA0v9b4Ck0ZrI83pGenx0LyuKCSGX+Wcd+3hXZ7zxJaBc8
         H4CMDij5YMRVFiHWUjfY91MVCf6HqD6Oo4llx3di1Ic8N0DMtoXfSng3m4FadtQU3GmD
         c+WWawmeJOMxjmCBk+zt62kiil76RJEDKkXGg6mfVbbsT8OAXlGYWUnrZ1X76kBP5kkz
         bE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712778539; x=1713383339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWCShh/bRGRzeO22yeBjtZLPhJ0/AGFCyE+KkcrS+ds=;
        b=o+qSA+0W4A/1ya0zPNM6Cjj042k8eOYXvF1S289Ef4RV+It4Jj1mE6xJwblzfkDrqF
         ubyX7Jzhp0BjCljNfCCkcwUElkYFhVwGwL+bQInFDICMOxOGl1BPMaeT8rC0JL+tmIEe
         91vRZFUxTaY9kgPRFX646gNg/lwVA9bd6JQ1BHclvFqDUyw03XI4SBciEfRcNrcBH2Dg
         PW7bVGPmPenL3xmrbYnqKfY1Qokd0vIrdm1txkuAwfwGF6B2gzOJviqaCO/fythapDWT
         DbuVfWKoACvgLJPug7/qA+xjUqqX2J/AHWfxswI5cQDA805YLykhnXTwrkQMIqsehI6q
         yi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0ANT6bfRxDEgINNGnwJdqNbnV3aIk4+MVMCyKqFeCj3wQ9cTZPiGTpjkIenYwleXrOBy07iYtr9RwoMZiZlO1Q9yraQz3dJgT8rc+
X-Gm-Message-State: AOJu0YwffHPzWsiIkbiVGnWO3mIN6QuBSKt5z5v8C3jbB+k/FGRvTVnd
	WzNNS6AQqweMEwKmOUfE/AagLtLXPBW7VFy8cbuHa3CUYtYGvj8RMadR2OL7Pb1Il4NNxdQwyjc
	EybH+nahjuBxEbADpHnMJbdHoAO4lpM6qa14u
X-Google-Smtp-Source: AGHT+IGa6MOnKjfghS1aRAZ4F4MxrT/E1DKiGKtukJn/QsQjBmlT/f6kggLbge9jt3UM+LRGc/z5WVALVplB0eqXhqc=
X-Received: by 2002:a05:622a:5c13:b0:434:61ad:8c1b with SMTP id
 gd19-20020a05622a5c1300b0043461ad8c1bmr55230qtb.28.1712778539135; Wed, 10 Apr
 2024 12:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410182618.169042-2-noah@noahloomans.com>
In-Reply-To: <20240410182618.169042-2-noah@noahloomans.com>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 10 Apr 2024 12:48:46 -0700
Message-ID: <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race condition
To: Noah Loomans <noah@noahloomans.com>
Cc: Bhanu Prakash Maiya <bhanumaiya@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	Robert Zieba <robertzieba@google.com>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:29=E2=80=AFAM Noah Loomans <noah@noahloomans.com=
> wrote:
>
> The cros_ec_uart_probe() function calls devm_serdev_device_open() before
> it calls serdev_device_set_client_ops(). This can trigger a NULL pointer
> dereference:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ...
>     CPU: 5 PID: 103 Comm: kworker/u16:3 Not tainted 6.8.4-zen1-1-zen #1 4=
a88f2661038c2a3bb69aa70fb41a5735338823c
>     Hardware name: Google Morphius/Morphius, BIOS MrChromebox-4.22.2-1-g2=
a93624aebf 01/22/2024
>     Workqueue: events_unbound flush_to_ldisc
>     RIP: 0010:ttyport_receive_buf+0x3f/0xf0
>     ...
>     Call Trace:
>      <TASK>
>      ? __die+0x10f/0x120
>      ? page_fault_oops+0x171/0x4e0
>      ? srso_return_thunk+0x5/0x5f
>      ? exc_page_fault+0x7f/0x180
>      ? asm_exc_page_fault+0x26/0x30
>      ? ttyport_receive_buf+0x3f/0xf0
>      flush_to_ldisc+0x9b/0x1c0
>      process_one_work+0x17b/0x340
>      worker_thread+0x301/0x490
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xe8/0x120
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x34/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1b/0x30
>      </TASK>
>
> A simplified version of crashing code is as follows:
>
>     static inline size_t serdev_controller_receive_buf(struct serdev_cont=
roller *ctrl,
>                                                       const u8 *data,
>                                                       size_t count)
>     {
>             struct serdev_device *serdev =3D ctrl->serdev;
>
>             if (!serdev || !serdev->ops->receive_buf) // CRASH!
>                 return 0;
>
>             return serdev->ops->receive_buf(serdev, data, count);
>     }
>
>     static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp=
,
>                                       const u8 *fp, size_t count)
>     {
>             struct serdev_controller *ctrl =3D port->client_data;
>             [...]
>
>             if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>                     return 0;
>
>             ret =3D serdev_controller_receive_buf(ctrl, cp, count);
>
>             [...]
>             return ret;
>     }
>
> It assumes that if SERPORT_ACTIVE is set and serdev exists, serdev->ops
> will also exist. This conflicts with the existing cros_ec_uart_probe()
> logic, as it first calls devm_serdev_device_open() (which sets
> SERPORT_ACTIVE), and only later sets serdev->ops via
> serdev_device_set_client_ops().
>
> Commit 01f95d42b8f4 ("platform/chrome: cros_ec_uart: fix race
> condition") attempted to fix a similar race condition, but while doing
> so, made the window of error for this race condition to happen much
> wider.
>
> Attempt to fix the race condition again, making sure we fully setup
> before calling devm_serdev_device_open().
>
> Fixes: 01f95d42b8f4 ("platform/chrome: cros_ec_uart: fix race condition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Noah Loomans <noah@noahloomans.com>
> ---
>
> This is my first time contributing to Linux, I hope this is a good
> patch. Feedback on how to improve is welcome!
>

The commit message is a bit long, but the patch itself looks good to me.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

Guenter

>  drivers/platform/chrome/cros_ec_uart.c | 28 +++++++++++++-------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/ch=
rome/cros_ec_uart.c
> index 8ea867c2a01a..62bc24f6dcc7 100644
> --- a/drivers/platform/chrome/cros_ec_uart.c
> +++ b/drivers/platform/chrome/cros_ec_uart.c
> @@ -263,12 +263,6 @@ static int cros_ec_uart_probe(struct serdev_device *=
serdev)
>         if (!ec_dev)
>                 return -ENOMEM;
>
> -       ret =3D devm_serdev_device_open(dev, serdev);
> -       if (ret) {
> -               dev_err(dev, "Unable to open UART device");
> -               return ret;
> -       }
> -
>         serdev_device_set_drvdata(serdev, ec_dev);
>         init_waitqueue_head(&ec_uart->response.wait_queue);
>
> @@ -280,14 +274,6 @@ static int cros_ec_uart_probe(struct serdev_device *=
serdev)
>                 return ret;
>         }
>
> -       ret =3D serdev_device_set_baudrate(serdev, ec_uart->baudrate);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set up host baud rate (%d)", ret)=
;
> -               return ret;
> -       }
> -
> -       serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
> -
>         /* Initialize ec_dev for cros_ec  */
>         ec_dev->phys_name =3D dev_name(dev);
>         ec_dev->dev =3D dev;
> @@ -301,6 +287,20 @@ static int cros_ec_uart_probe(struct serdev_device *=
serdev)
>
>         serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
>
> +       ret =3D devm_serdev_device_open(dev, serdev);
> +       if (ret) {
> +               dev_err(dev, "Unable to open UART device");
> +               return ret;
> +       }
> +
> +       ret =3D serdev_device_set_baudrate(serdev, ec_uart->baudrate);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to set up host baud rate (%d)", ret)=
;
> +               return ret;
> +       }
> +
> +       serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
> +
>         return cros_ec_register(ec_dev);
>  }
>
> --
> 2.44.0
>

