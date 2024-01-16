Return-Path: <linux-kernel+bounces-28320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB182FCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB691F2ABBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C6604A3;
	Tue, 16 Jan 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LOb3vEPF"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555835291
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441288; cv=none; b=Iq/tXRZVTN1q0OovC5yV3sXuMwnBSCN6vCPmxWwGAQLGh2SloXJxsih55qW0HIbg3GSV/CPZNHiqZmU8R/9WiEvUNYg78Nwmk79du5/vUpsNjkJkC6qYfbh07oXSF1hbTV3RpnN73h/CH/x/rE20myQ3BfgHMcHESUiqyZoDCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441288; c=relaxed/simple;
	bh=/LJidhTBr1TIpVkob74VQJvRJ4hEMWmnye+c9nRvJu4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jl3vMiUIqRcYslkpEW4A/5P0R8hQmipclLKiva80R7HNhz6+96KZ+b4+myPR4C/BqUoO8eS4Qo5y5iMUq4H6R4Llae3i4dAGmTK24zM1Jy5/dADBAL6UF/dzJh+paZ4/QitGstJzj1AGFa3gfcdj1sXe6vQmmWyl9XlVRsm+yAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LOb3vEPF; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-467010c1c72so5801506137.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705441284; x=1706046084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef0uuGFlu4TkR3S/PSmAQYeICoa3SoldbUHXTDWaWbk=;
        b=LOb3vEPFzLM6fz1hE+kguHNcSWiSjFTFiWi7wZcOHdBo/Qw/DCMS3c1CjAt4uWFNKW
         DRdeBbDxiPLN+f9WpqoA8UQs3i77Z9UnC9+zmzyVqS2tlkD60ErYYEal6BWxfwK/gI71
         gV7guM8xaZLnYBi7426dsmnf8H2xlN2jARPoOq98Xn5174ziyrubMAjRIt9G/liYS21d
         5aAiKs3M4QFWrlWbJ/pXa/uJTbWmabh2QAwU9/L48YlJTQ0AliOQ4/wDCBG+wOVpnW7b
         J7T7OEuK1mhcDT6qalT/fcsddxqri2uzlud/B8ZIU9Y4g5dEz+kY9aHmGTl+DcPMwhdM
         zQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441284; x=1706046084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ef0uuGFlu4TkR3S/PSmAQYeICoa3SoldbUHXTDWaWbk=;
        b=Hr780749aMt6Ci6JR19bEISUpIBq7RF8k/wBIM+RwMNpAx5ic4594kT7Jdz78oSuvv
         eQ7YO1jkvi5/d76LHTJqDjIZrCkc3dv50fpDZ3Yh1CsjsaDS4XdJvpRKxroM5D5BwZsd
         qH0z85LPMUVURe32oxtAOCigWRRE7M964Fmum5X2uu4a3NAm3cwH4Ut9ViqhHbVtVu9I
         xd4ZJgK364P7MNYEVIleaXmvt7PaNzZ7GdXlh3J3r0RYUbTNBkek2syPNgCUYrsd1k6G
         fHSvccuHmOyzW+YzDOLJVpUOmRo6xoqQ8qiXHGx+XRJkBO6KB/uCiyu1DAHr0v0gl5EN
         xzqw==
X-Gm-Message-State: AOJu0YwMkLSuhGRX1fbwX5EVb+iOu0nLCt2/8aMXYf97er4xvX1oRZiV
	RUAe3uQg/fXDdOWPXkNwxR55ZGVkpHqRwi+sYEcNG0j5NbXfBA==
X-Google-Smtp-Source: AGHT+IFmCZALerJPM8J0+yd5E6NTsF8sIZkFEH/Cm99GpS2xyCSz9bGTxCqGMHQSSQWncMPJb0wifoW6pfWzXgU7Iro=
X-Received: by 2002:a05:6102:3641:b0:467:fb20:6a44 with SMTP id
 s1-20020a056102364100b00467fb206a44mr4737690vsu.26.1705441283716; Tue, 16 Jan
 2024 13:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl> <19dca2a9-36e1-4a6b-9b65-db4c0a163d56@roeck-us.net>
In-Reply-To: <19dca2a9-36e1-4a6b-9b65-db4c0a163d56@roeck-us.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jan 2024 22:41:12 +0100
Message-ID: <CAMRc=McueRLdFJ_p-QPKPwFJatVXOG8hyeZKniAPGDBrNo2xFg@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:23=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > extra_checks is only used in a few places. It also depends on
> > a non-standard DEBUG define one needs to add to the source file. The
> > overhead of removing it should be minimal (we already use pure
> > might_sleep() in the code anyway) so drop it.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This patch triggers (exposes) the following backtrace.
>
> BUG: sleeping function called from invalid context at drivers/gpio/gpioli=
b.c:3738
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 7, name: kworker=
/0:0
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by kworker/0:0/7:
>  #0: c181b3a4 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_=
scheduled_works+0x23c/0x644
>  #1: c883df28 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at=
: process_scheduled_works+0x23c/0x644
>  #2: c24e1720 (&host->lock){-...}-{2:2}, at: sdhci_check_ro+0x14/0xd4
> irq event stamp: 2916
> hardirqs last  enabled at (2915): [<c0b18838>] _raw_spin_unlock_irqrestor=
e+0x70/0x84
> hardirqs last disabled at (2916): [<c0b1853c>] _raw_spin_lock_irqsave+0x7=
4/0x78
> softirqs last  enabled at (2360): [<c00098a4>] __do_softirq+0x28c/0x4b0
> softirqs last disabled at (2347): [<c0022774>] __irq_exit_rcu+0x15c/0x1a4
> CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G                 N 6.7.0-09928-=
g052d534373b7 #1
> Hardware name: Freescale i.MX25 (Device Tree Support)
> Workqueue: events_freezable mmc_rescan
>  unwind_backtrace from show_stack+0x10/0x18
>  show_stack from dump_stack_lvl+0x34/0x54
>  dump_stack_lvl from __might_resched+0x188/0x274
>  __might_resched from gpiod_get_value_cansleep+0x14/0x60
>  gpiod_get_value_cansleep from mmc_gpio_get_ro+0x20/0x30

When getting GPIO value with a spinlock taken the driver *must* use
the non-sleeping variant of this function: gpiod_get_value(). If the
underlying driver can sleep then the developer seriously borked. The
API contract has always been this way so I wouldn't treat it as a
regression.

I'd start with checking if replacing this with gpiod_get_value()
helps. Possibly even do:

if (in_atomic())
    gpiod_get_value();
else
    gpiod_get_value_cansleep();

Bartosz

>  mmc_gpio_get_ro from esdhc_pltfm_get_ro+0x20/0x48
>  esdhc_pltfm_get_ro from sdhci_check_ro+0x44/0xd4
>  sdhci_check_ro from mmc_sd_setup_card+0x2a8/0x47c
>  mmc_sd_setup_card from mmc_sd_init_card+0xfc/0x93c
>  mmc_sd_init_card from mmc_attach_sd+0xd8/0x180
>  mmc_attach_sd from mmc_rescan+0x2ac/0x30c
>  mmc_rescan from process_scheduled_works+0x2e4/0x644
>  process_scheduled_works from worker_thread+0x188/0x418
>  worker_thread from kthread+0x11c/0x144
>  kthread from ret_from_fork+0x14/0x38
>
> This is with the imx25-pdk qemu emulation when booting from mmc/sd card.
> It isn't really surprising since sdhci_check_ro() calls the gpio code und=
er
> spin_lock_irqsave(). No idea how to fix that, so I won't even try.
>
> Bisect log attached for reference.
>
> Guenter
>
> ---
> # bad: [052d534373b7ed33712a63d5e17b2b6cdbce84fd] Merge tag 'exfat-for-6.=
8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> # good: [70d201a40823acba23899342d62bc2644051ad2e] Merge tag 'f2fs-for-6.=
8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
> git bisect start 'HEAD' '70d201a40823'
> # good: [b6e1b708176846248c87318786d22465ac96dd2c] drm/xe: Remove uniniti=
alized variable from warning
> git bisect good b6e1b708176846248c87318786d22465ac96dd2c
> # good: [7912a6391f3ee7eb9f9a69227a209d502679bc0c] Merge tag 'sound-6.8-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good 7912a6391f3ee7eb9f9a69227a209d502679bc0c
> # bad: [a3cc31e75185f9b1ad8dc45eac77f8de788dc410] Merge tag 'libnvdimm-fo=
r-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> git bisect bad a3cc31e75185f9b1ad8dc45eac77f8de788dc410
> # bad: [576db73424305036a6aa9e40daf7109742fbb1df] Merge tag 'gpio-updates=
-for-v6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> git bisect bad 576db73424305036a6aa9e40daf7109742fbb1df
> # good: [61f4c3e6711477b8a347ca5fe89e5e6613e0a147] Merge tag 'linux-watch=
dog-6.8-rc1' of git://www.linux-watchdog.org/linux-watchdog
> git bisect good 61f4c3e6711477b8a347ca5fe89e5e6613e0a147
> # good: [12b7f4ddfcb66dafed432cf4a987f5b40179c0f1] Merge tag 'device_is_b=
ig_endian-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/=
driver-core into gpio/for-next
> git bisect good 12b7f4ddfcb66dafed432cf4a987f5b40179c0f1
> # good: [ede7511e7c22c9542a699ddff9f32de74e0bb972] gpiolib: cdev: include=
 overflow.h
> git bisect good ede7511e7c22c9542a699ddff9f32de74e0bb972
> # bad: [f34fd6ee1be84c6e64574e9eb58f89d32c7f98a4] gpio: dwapb: Use generi=
c request, free and set_config
> git bisect bad f34fd6ee1be84c6e64574e9eb58f89d32c7f98a4
> # good: [7dd1871e5049bbd40ee78ac94b1678ba5caf2486] gpio: tps65219: don't =
use CONFIG_DEBUG_GPIO
> git bisect good 7dd1871e5049bbd40ee78ac94b1678ba5caf2486
> # bad: [0338f6a6fb659f083eca7dd5967bb668d14707f8] gpiolib: drop tabs from=
 local variable declarations
> git bisect bad 0338f6a6fb659f083eca7dd5967bb668d14707f8
> # bad: [5d5dfc50e5689d5b09de4a323f84c28a6700d156] gpiolib: remove extra_c=
hecks
> git bisect bad 5d5dfc50e5689d5b09de4a323f84c28a6700d156
> # first bad commit: [5d5dfc50e5689d5b09de4a323f84c28a6700d156] gpiolib: r=
emove extra_checks

