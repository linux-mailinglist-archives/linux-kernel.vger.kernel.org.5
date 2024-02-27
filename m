Return-Path: <linux-kernel+bounces-83936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86D86A042
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5073D284BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57301420DC;
	Tue, 27 Feb 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="h0pFhshc"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398A524CC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062308; cv=none; b=Mgvkpub4fKVJzReyC//1d045xHfm6AvdKbGIBVTjdox1TmbObRMDu7RJXrNMP7Z7D5VY22oRTF2L8qOIfJ770J8tg30DMC7sEzY/ku+vgzNz5/ruj5b4pT1R0pdcCsGDCNb/UBktbpt0846MDboNtr3SqVkx2QKYlaJcKDl5HWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062308; c=relaxed/simple;
	bh=P8n53itoisgvJX5fY9vQdEzs7mU+bJ7TA8FH2xx0oZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo+EybWfWbrgmsdfwbeZmzkvbFDnV8Fb2oXTaQB/qIhOey3R9GcTKrZTXexD7/gaY1tMV02zF9CEpErkAYxaPXTAAkf0I5rIPNI8IAJWZjst795r90yAnOlBbWaMZNbakJFodR2CafzATl6psggMivI84a/udKyfVBg2MCBIRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=h0pFhshc; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4cb26623dc1so879786e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709062305; x=1709667105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkUGI/OjSyRrcII58LGuIBmZGZ6Bi4UA80M+PogBoGE=;
        b=h0pFhshcWkQPEPEFKpcGh55+eWw7obWC+/6T95QUUtD4yvSVhNMYQMeZDJm+dGtHp9
         VRyKjINaRFfZPceBlHsM6YMcBhUAR+3ugKSSaSd2POMZWYuW7yBWPGk0tjUJPVwAdEuF
         WcbNrqCw2Ez3aQUFj69pC9oTG2w8liMekQaN8hHWcWo7yPgtf9hmjypGJVP8/YLhxrMb
         rZNZnLC1ynu3ZzTzNidOxIBaSG4reLY0znlbY9HMLbShPvw8FD90uErh2Pz63DzM8iUe
         mxlgMiBJGqsv90f7pPppkEnnbnGB5JD/o4s1u6iwmTLF6LBDfmC9dIaky92d9AtW6pB2
         wbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062305; x=1709667105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkUGI/OjSyRrcII58LGuIBmZGZ6Bi4UA80M+PogBoGE=;
        b=crG/V6nSIMc3RJPSFNtN881aqjNyRzT7hTYI4nOVXHvofL50WmNrE3/rNRIK6OuTx0
         tYv6FJzwYeQ2p876kw9t/tesvitmdUGi1tLeNNMaRlbeSUVIuVC+GoEcxrdVWgYVfH9n
         fZsc04RIRRT1SvsuBCBa0ugME2mV+vPHIZgwBJe/DC1Y71E9JlbTyDvY6crn67VUFlfI
         id5Roq7kPABXdHKy0n1zZAGW7xR9q1/AqHG3PC/yEBWkE6G5ph4YppWflYm+yYAAVvrh
         m07+lRaipvm/s7x7QJVVN6ZnOeLexM3q66E22AfHfUvzeVEHYjUPma5Fl5gOMhgvUq2U
         P8FA==
X-Forwarded-Encrypted: i=1; AJvYcCW66T/8HSi3iU2GbcyUMKvNcF2XroUP7YSd84Eo6bfelcUgWrRGFKVC9uuRNH2SJzdU4PO2TbWHcb7jDp5lmuFTrGAKMjNV80jpzeYl
X-Gm-Message-State: AOJu0Yz7P04+F7Qwdw/5dAgdTvrWAwuRvhfKPL5wZ5Pwrw94x12FoB51
	ecBmDZu9ugJZD4TT6gtoZsPcuuX+wnELbDha2j/TkqxW+TQSsFhr4MQg48DrmK93z1ZRIZrF+Vu
	4YtDHz72SG0IwnttjUluvgkEEqST+qBkI1osJ2w==
X-Google-Smtp-Source: AGHT+IE+hinBR9yrZq4DUl/9CZfrFnny4RogLgxjhnSvZNb0Ore3YufiBI2IwIDXSL7+MvKyu59PcAR8zbTrmCgRU1Y=
X-Received: by 2002:a1f:dac2:0:b0:4c8:f076:cb0 with SMTP id
 r185-20020a1fdac2000000b004c8f0760cb0mr8464145vkg.4.1709062303829; Tue, 27
 Feb 2024 11:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227113426.253232-1-herve.codina@bootlin.com>
In-Reply-To: <20240227113426.253232-1-herve.codina@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Feb 2024 20:31:33 +0100
Message-ID: <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:34=E2=80=AFPM Herve Codina <herve.codina@bootlin=
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
> Compared to the previous iteration:
>   https://lore.kernel.org/linux-kernel/20240220111019.133697-1-herve.codi=
na@bootlin.com/
> this v2 series set gdev->chip to NULL before calling gcdev_unregister().
>
> Also, this v2 series was rebased on top of for-next branch of the GPIO
> tree.
>
> Best regards,
> Herv=C3=A9 Codina
>
> Changes v1 -> v2:
>   - Patch 1
>     Set gdev->chip to NULL before calling gcdev_unregister()
>
>   - Patch 2
>     No changes
>
> Herve Codina (2):
>   gpiolib: call gcdev_unregister() sooner in the removal operations
>   gpiolib: cdev: release IRQs when the gpio chip device is removed
>
>  drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
>  drivers/gpio/gpiolib.c      |  6 +++++-
>  2 files changed, 27 insertions(+), 12 deletions(-)
>
> --
> 2.43.0
>

Sorry but this is just papering over the real issue. I'd say NAK for
now as I'd really prefer to get to the root of the problem and fix it
for all GPIO interrupt users.

Kent, Linus: what do you think?

Bart

