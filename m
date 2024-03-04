Return-Path: <linux-kernel+bounces-90374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7386FE53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20D51F22A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F67A364CC;
	Mon,  4 Mar 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6n5/S8J"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8825565;
	Mon,  4 Mar 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546768; cv=none; b=I1zQjUGqF8KZYIpz4gaTyLvHDOYCdydmwFAlZeYj+P8ePrEwP/DphhJ3zSEhxzt8RqKXyh80X7sL0rAoZs+ryXKLjYP3F+XAZyVXp7g/WNOZH5gorImC5Kg9WuK8titb+X8ttEN1pxtoSQ/BDB2YT3v0vX4qgN19YnBIzKu1xoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546768; c=relaxed/simple;
	bh=hlRpzVqnSHmRzJJVlGFLHLMImdZQbWe5afwYf33LiCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrDlGdt3Bwj1x7CbbHLQLdUNErPo9aNHPx1E/nl5JeHC9pz8SrJHV8SjIEqvFbmybl4LZ5PkrDI95/eVzLSElFfasOHdtK42iOG05JRUQEpAEzTuDeZyuoY9M1y+2M/j6djiY26gAk5TrLjnqAKxWKj++PEUvYKe7KYwZWC7XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6n5/S8J; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso2940406eaf.3;
        Mon, 04 Mar 2024 02:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709546766; x=1710151566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npaHNykme7ADeourxyueSS27DGXv3jicYDGqKQjI2rM=;
        b=K6n5/S8JkWJaDPidXAtiny+9pye7BXV66/yTmoVoCiQF8GUo+pa+3as1f/bKEKN3R2
         c/5T/SoZqiXnk/xrWP04QbjqqD1wkRGoqT3fkogxBKT61cL+6oU26ijiJAq4Q6mGJ9/H
         MJ613R5u6wWh01Uj62tkfTi2qUeF9pvfsSxGJVRzmpGotJnW9ZZHZgpV6KOLGYbphLgE
         unT/LE5UFQKBNc4jPy2Cg35HSi0lMnRDVmtr26SzdXur//BImOmRXFnIdYbO0V3A+FUh
         7P02ADkVTpnduvk49iJi4/cdQxgoaHH72xvfxgs/8lo6bat0oQbuA5+FObvtcL8lusy7
         hUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546766; x=1710151566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npaHNykme7ADeourxyueSS27DGXv3jicYDGqKQjI2rM=;
        b=dufuejh8vuGo1LYfIeq8BeU9PAjCMc/GEaY2YLhW+3LZKGGS3LB63Kzy6JpLHLXKlA
         onX3srbTeb3+xNpCO/Y6lLLwkj6qNuoCfd0CJd4nH6g/s8ZIREKyPk6s0NCEUW5IK73R
         FbPF+CSLXftRusKzq9Y9BWJha2GMHltK3xS0mMglq+KBX7zFU/LwGaw7RgVR5AGxpceN
         b0QH33nWtu2bx+LPiF5sla9kAiGxvPjOS5rDi4jXd7VEwRRJsbssGfMdsBPkRYfVQYf0
         599yvHLkgK9NSB14p+0EynYChSdf0Aooy60bOYrlmoaK3oIkPaUlHHbfxuGWNV7aaQng
         2gaA==
X-Forwarded-Encrypted: i=1; AJvYcCWcYUYTFeu5+4yOVkknyRY1b4Snk0u7pJbAtf365uUm7mQF2zjBSqkyFmc0FNQ6Lu1SlTHaCzy86VknN8NjOhTXQ3Zh78b57GYQ1KjhyfBQR0fC1ztkyODgV0vP6O1+UfrZrUiLV9tkmgyE5W3Q8GucRqyFyQ23FRUwed53o2orMR1cUx9qEFCwwV8=
X-Gm-Message-State: AOJu0YxEW+yOQkAfzdB5aHNTf5S2AfGIvLRgvWeUJ8u/k0DMx9RQm4TL
	QOcPGttvDrGGMisHp+qo6xxQJL/J7XtD2FHY/Wc0/Zcg0hfEILQZMo3CbURlrVfBFjPGQ9QyTtw
	M/0BrQONDBX99PCpHRX2ORpy5xQk=
X-Google-Smtp-Source: AGHT+IEZCHLXnTjPx8aXz5NWBb1J57G7Hm5GUiiKo1CYbLbZ4GqC25r3JSe+FSDjDau8uTsckG85pWvjqTt33klT3TQ=
X-Received: by 2002:a4a:928c:0:b0:5a0:daf5:a5d0 with SMTP id
 i12-20020a4a928c000000b005a0daf5a5d0mr6754352ooh.9.1709546765783; Mon, 04 Mar
 2024 02:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-2-linux.amoon@gmail.com>
 <3d1c7682-d163-4bcf-bd41-d7db0c8f61d1@wanadoo.fr> <CANAwSgR0aQ7nt1y5xknvVjHSnfvTaC8JZMLWurb8z2D0Oxg6Rw@mail.gmail.com>
 <ZeWR2VByrV1xWmYN@hovoldconsulting.com>
In-Reply-To: <ZeWR2VByrV1xWmYN@hovoldconsulting.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 4 Mar 2024 15:35:53 +0530
Message-ID: <CANAwSgTecdij9+eT7nY9C_xAxqbX8C9T_fL9TtGA=kZWLhfKnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
To: Johan Hovold <johan@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johon, Christophe,

On Mon, 4 Mar 2024 at 14:48, Johan Hovold <johan@kernel.org> wrote:
>
> On Sat, Mar 02, 2024 at 10:05:46PM +0530, Anand Moon wrote:
> > On Sat, 2 Mar 2024 at 21:19, Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > > Le 01/03/2024 =C3=A0 20:38, Anand Moon a =C3=A9crit :
>
> > > > The devm_clk_get_enabled() helpers:
> > > >      - call devm_clk_get()
> > > >      - call clk_prepare_enable() and register what is needed in ord=
er to
> > > >       call clk_disable_unprepare() when needed, as a managed resour=
ce.
> > > >
> > > > This simplifies the code and avoids the calls to clk_disable_unprep=
are().
> > > >
> > > > While at it, use dev_err_probe consistently, and use its return val=
ue
> > > > to return the error code.
>
> > > > @@ -260,25 +248,17 @@ static int exynos_ehci_suspend(struct device =
*dev)
> > > >
> > > >       exynos_ehci_phy_disable(dev);
> > > >
> > > > -     clk_disable_unprepare(exynos_ehci->clk);
>
> > > I don't think that removing clk_[en|dis]abble from the suspend and
> > > resume function is correct.
> > >
> > > The goal is to stop some hardware when the system is suspended, in or=
der
> > > to save some power.
> > Yes correct,
> > >
> > > Why did you removed it?
>
> > devm_clk_get_enabled  function register callback for clk_prepare_enable
> > and clk_disable_unprepare, so when the clock resource is not used it sh=
ould get
> > disabled.
> >
> > [0] https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk-devr=
es.c#L75
> >
> > I have also tested with rtc suspend & resume and did not find any issue=
.
>
> You seem to be totally confused about how devres works, and arguing back
> after Christophe points this out to you instead of going back and doing
> the homework you should have done before posting these patches is really
> not OK (e.g. as you're wasting other people's time).
>
Ok, It seems to have fallen short in my understanding..

> And you clearly did not test these patches enough to confirm that you
> didn't break the driver.

Ok I missed the failure of the ehci driver. while testing.

[root@archl-xu4 alarm]# echo no > /sys/module/printk/parameters/console_sus=
pend
[root@archl-xu4 alarm]#
echo no > /sys/module/printk/parameters/console_suspend
[root@archl-xu4 alarm]# echo no > /sys/module/printk/parameters/console_sus=
pend
[root@archl-xu4 alarm]# time rtcwake -s 30 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Mon Mar  4 09:44:25 2024
[11969.792928] PM: suspend entry (deep)
[11969.798423] Filesystems sync: 0.003 seconds
[11969.819722] Freezing user space processes
[11969.825818] Freezing user space processes completed (elapsed 0.003 secon=
ds)
[11969.831585] OOM killer disabled.
[11969.834586] Freezing remaining freezable tasks
[11969.841553] Freezing remaining freezable tasks completed (elapsed
0.002 seconds)
[11969.919178] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[11970.091681] wake enabled for irq 129 (gpx0-4)
[11970.135766] wake enabled for irq 149 (gpx0-3)
[11970.157943] samsung-pinctrl 13400000.pinctrl: Setting external
wakeup interrupt mask: 0xffffffe7
[11970.179304] Disabling non-boot CPUs ...
[11970.276394] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[11970.281961] wake disabled for irq 149 (gpx0-3)
[11970.288997] phy phy-12130000.phy.6: phy_power_on was called before phy_i=
nit
[11970.358899] exynos-ohci 12120000.usb: init err (00000000 0000)
[11970.363298] exynos-ohci 12120000.usb: can't restart, -75
[11970.368581] usb usb2: root hub lost power or was reset
[11970.373819] wake disabled for irq 129 (gpx0-4)
[11970.382641] xhci-hcd xhci-hcd.8.auto: xHC error in resume, USBSTS
0x411, Reinit
[11970.383237] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[11970.383355] xhci-hcd xhci-hcd.9.auto: xHC error in resume, USBSTS
0x401, Reinit
[11970.383376] usb usb5: root hub lost power or was reset
[11970.383396] usb usb6: root hub lost power or was reset
[11970.388471] usb usb3: root hub lost power or was reset
[11970.416740] usb usb4: root hub lost power or was reset
[11970.770122] usb 3-1: reset high-speed USB device number 2 using xhci-hcd
[11971.100601] usb 4-1: reset SuperSpeed USB device number 3 using xhci-hcd
[11971.569524] usb 3-1.2: reset high-speed USB device number 3 using xhci-h=
cd
[11974.575262] OOM killer enabled.
[11974.576964] Restarting tasks ... done.
[11974.580608] r8152-cfgselector 6-1: USB disconnect, device number 4
[11974.589302] random: crng reseeded on system resumption
[11974.596363] PM: suspend exit

real    0m34.951s
user    0m0.012s
sys     0m0.259s
[root@archl-xu4 alarm]# [11974.640778] mmc_host mmc0: Bus speed (slot
0) =3D 50000000Hz (slot req 400000Hz, actual 396825HZ div =3D 63)
[11975.180552] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot
req 52000000Hz, actual 50000000HZ div =3D 0)
[11975.192142] mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot
req 200000000Hz, actual 200000000HZ div =3D 0)
[11975.282474] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot
req 52000000Hz, actual 50000000HZ div =3D 0)
[11975.296174] mmc_host mmc0: Bus speed (slot 0) =3D 400000000Hz (slot
req 200000000Hz, actual 200000000HZ div =3D 1)
[11975.569457] usb 6-1: new SuperSpeed USB device number 5 using xhci-hcd
[11975.614390] usb 6-1: New USB device found, idVendor=3D0bda,
idProduct=3D8153, bcdDevice=3D30.00
[11975.622196] usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D6
[11975.629284] usb 6-1: Product: USB 10/100/1000 LAN
[11975.633352] usb 6-1: Manufacturer: Realtek
[11975.637458] usb 6-1: SerialNumber: 000001000000
[11975.871080] r8152-cfgselector 6-1: reset SuperSpeed USB device
number 5 using xhci-hcd
[11975.955112] r8152 6-1:1.0: load rtl8153a-3 v2 02/07/20 successfully
[11976.032484] r8152 6-1:1.0 eth0: v1.12.13
[11976.134078] r8152 6-1:1.0 enu1: renamed from eth0

[root@archl-xu4 alarm]# [11981.522603] r8152 6-1:1.0 enu1: carrier on

[root@archl-xu4 alarm]#
>

Ok, I will restore the clk changes in the suspend / resume functions
in the next version and do thought testing.

> Johan

Thanks

-Anand

