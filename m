Return-Path: <linux-kernel+bounces-159805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8378B3454
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF6C1C2291B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D113F436;
	Fri, 26 Apr 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ4xEJFI"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD213F426;
	Fri, 26 Apr 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124466; cv=none; b=GS60ReTujb/JuzCu44FjplAm/QJa+ZJFyh5NqgpRYo7bDe2ga4Lns6HZVAx9TJJwFGjbQxJPrQhyOUss1o2TRatG1UC6Wce/JgeSCyLj1+Yi2L2A4RZmaW5OnrU88RAlKvcbP05WltxCT1ioX7lKe/em10cgYnOqOawWyEPXPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124466; c=relaxed/simple;
	bh=kzpjBbw7imQPtr1iEKrA+g23bA1zMo6sqYKAYgW5TGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/Ga7oin5aCL/dBTgWcfJZQKf9F21yLcaIz0tHrmghpSI7axdCsw289Zh7EjSOfImr0pif5syfhQidYyT1dD9DShY9FyQd8y29VfhFWX5MOKflffyVnlfysYijmEU7iT9LBw5I2knAkEagAXYCu67ilrzMsYt2zY4Ht0yr1k+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ4xEJFI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36b33fc543dso8252925ab.0;
        Fri, 26 Apr 2024 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714124464; x=1714729264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1BsiCXySDfC7jDGmTMKKwQaI3n7a2aIRe2EcYSparo=;
        b=gJ4xEJFIeGzrpjitKDnebqm3olBBfwhl5Crbh+wrcuXqrJP0+PwrZIxLpiaFtz0W5R
         LVtKV+mCzrbogQkpQz4UrnwnhJvUtdEG/+/nFnkdlfh+85WmT1eGI+V44Q01evMUMEqQ
         Og1dVJchkC7PUCG2YPf7/UemufKruJDuDEtzASVl0srqegMvNk4hOZThXG4c96KsyOxX
         VKXn2sUsV+7duVulT+bpr0vAgQ9/7njH/c08Ywf3Rbvc1gOwXWqiLj1dsa7eEA7PZ2fE
         GzvvHCQsFMHEVN5mzKMA8S3GKlQpPBqR1txPGP0Ir6kLg2L+FSYB8QW76+ftGqm9Ms+j
         Z+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124464; x=1714729264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1BsiCXySDfC7jDGmTMKKwQaI3n7a2aIRe2EcYSparo=;
        b=I5RUxe9SsxtBGatUvPfYIrCY2Ev2tSl8bcNunHRZhUrtZTsvBJudzUUkJfEN9wvB2X
         gZDeFjkqzRmBB7XZNpyLlgEb+GVYgVfP+xg8RLTu+N0vJF288YOTyOhB3aJQV6UktrbL
         39S5LfmKOfFVKw4OWDLKRM9wb7G9JC7ohXqE6wLegnpEfkZtdX0ZoWvxYfE5LqQlaI8q
         wtNtKqF+Jy2Yzvtw8VCG8csBfje4YbPu3GRXTdqfqjLCCT3FBfX+zTvPvET1K8pqyCkv
         WILrkwyDvlrjR52li7Evdp08A5GM1my3vYjxLs32TC81QA5tCZUw/ff1Rx98weR8nJcM
         GhUg==
X-Forwarded-Encrypted: i=1; AJvYcCWClyOPL9xcUYQidY3NC6C+VXzazdWacFNYX3V/MRkFF24/elSBsxMyYedbhc30/B9iujIrODip+VlqrrSvXAs1/ex8tgV2uRZSqOC6DnSfrrVA7r/ExBPzIE0JjtewRBMx0tDv5KAC
X-Gm-Message-State: AOJu0YxR1/mswbJGtPigL7cTVMJcmXuR4r1Ypm0uYgpJ0kmLqUc1rNLB
	DTd27URihCzTmRpbky0yapmmV5CavL5iuXyeNnGFz54mavPzJuouvSPEhKuK62rIHdKHvYPpWNT
	FxrBC05sk0/ExMOi6A8B5haaDlNQ=
X-Google-Smtp-Source: AGHT+IEGaZvPO5oDRi2nUcdkHLqGT35jCal6XIN3ooTOhGsIGR31vfLjrd1ZIar9sR1QKw8y2eHL6Ege8TqMTy0rULg=
X-Received: by 2002:a05:6e02:138d:b0:36c:ae5:c4da with SMTP id
 d13-20020a056e02138d00b0036c0ae5c4damr2836951ilo.17.1714124463813; Fri, 26
 Apr 2024 02:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com> <ZirB5sWBsOXucVsY@lizhi-Precision-Tower-5810>
In-Reply-To: <ZirB5sWBsOXucVsY@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 26 Apr 2024 17:40:52 +0800
Message-ID: <CAA+D8AO4Hzg3ydc1CkidZ0T18bJ3M3d79WPSxAcWZ2xdT4=rMA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx8mp: Add delay after power up
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:49=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Apr 25, 2024 at 06:19:24PM +0800, Shengjiu Wang wrote:
> > According to comments in drivers/pmdomain/imx/gpcv2.c:
> >
> >       /* request the ADB400 to power up */
> >       if (domain->bits.hskreq) {
> >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> >                                  domain->bits.hskreq, domain->bits.hskr=
eq);
> >
> >               /*
> >                * ret =3D regmap_read_poll_timeout(domain->regmap, domai=
n->regs->hsk, reg_val,
> >                *                                (reg_val & domain->bits=
hskack), 0,
> >                *                                USEC_PER_MSEC);
> >                * Technically we need the commented code to wait handsha=
ke. But that needs
> >                * the BLK-CTL module BUS clk-en bit being set.
> >                *
> >                * There is a separate BLK-CTL module and we will have su=
ch a driver for it,
> >                * that driver will set the BUS clk-en bit and handshake =
will be triggered
> >                * automatically there. Just add a delay and suppose the =
handshake finish
> >                * after that.
> >                */
> >       }
> >
> > The BLK-CTL module needs to add delay to wait for a handshake request f=
inished
> > before accessing registers, which is just after the enabling of power d=
omain.
> >
> > Otherwise there is error:
> >
> > [    2.180834] SError Interrupt on CPU1, code 0x00000000bf000002 -- SEr=
ror
> > [    2.180849] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5=
-next-20240424-00003-g21cec88845c6 #171
> > [    2.180856] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > [    2.180861] Workqueue: events_unbound deferred_probe_work_func
> > [    2.180878] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    2.180885] pc : clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > [    2.180900] lr : pm_generic_runtime_resume+0x2c/0x44
> > [    2.180910] sp : ffff800083423a20
> > [    2.180913] x29: ffff800083423a20 x28: 0000000000000000 x27: 0000000=
000000000
> > [    2.180922] x26: ffff0000c0e4e410 x25: 0000000000000000 x24: 0000000=
000000000
> > [    2.180935] x23: 0000000000000000 x22: ffff0000c02afd20 x21: 0000000=
000000000
> > [    2.180945] x20: ffff0000c162a000 x19: ffff0000c0e52810 x18: fffffff=
fffffffff
> > [    2.180959] x17: 0000000000000000 x16: 0000000000000100 x15: ffff800=
0834239f0
> > [    2.180970] x14: ffff0000c03d0a1c x13: ffff0000c0a03440 x12: 0000000=
0000003c7
> > [    2.180982] x11: 0000000000000000 x10: ffff8000825010ba x9 : 0000000=
000000008
> > [    2.180993] x8 : 0000000000000008 x7 : 0000000000000000 x6 : 0000000=
000000000
> > [    2.181005] x5 : ffff8000838b0000 x4 : ffff0000c0e66088 x3 : ffff800=
0813852c0
> > [    2.181018] x2 : 0000000000000000 x1 : 0000000000000004 x0 : ffff800=
0838b0300
> > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrup=
t
> > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5=
-next-20240424-00003-g21cec88845c6 #171
> > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > [    2.181064] Call trace:
> > [    2.181066]  dump_backtrace+0x90/0xe8
> > [    2.181080]  show_stack+0x18/0x24
> > [    2.181091]  dump_stack_lvl+0x34/0x8c
> > [    2.181104]  dump_stack+0x18/0x24
> > [    2.181117]  panic+0x39c/0x3d0
> > [    2.181129]  nmi_panic+0x48/0x94
> > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > [    2.181149]  do_serror+0x3c/0x70
> > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > [    2.181164]  el1h_64_error+0x64/0x68
> > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > [    2.181205]  __rpm_callback+0x48/0x1d8
> > [    2.181213]  rpm_callback+0x68/0x74
> > [    2.181224]  rpm_resume+0x468/0x6c0
> > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > [    2.181258]  __driver_probe_device+0x48/0x12c
> > [    2.181268]  driver_probe_device+0xd8/0x15c
> > [    2.181278]  __device_attach_driver+0xb8/0x134
> > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > [    2.181302]  __device_attach+0x9c/0x188
> > [    2.181312]  device_initial_probe+0x14/0x20
> > [    2.181323]  bus_probe_device+0xac/0xb0
> > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > [    2.181344]  process_one_work+0x150/0x290
> > [    2.181357]  worker_thread+0x2f8/0x408
> > [    2.181370]  kthread+0x110/0x114
> > [    2.181381]  ret_from_fork+0x10/0x20
> > [    2.181391] SMP: stopping secondary CPUs
> > [    2.181400] Kernel Offset: disabled
> > [    2.181403] CPU features: 0x0,00000040,00100000,4200421b
> > [    2.181407] Memory Limit: none
> > [    2.463040] ---[ end Kernel panic - not syncing: Asynchronous SError=
 Interrupt ]---
> >
> > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for powe=
r saving")
> > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/cl=
k-imx8mp-audiomix.c
> > index e4231e9c8f05..cb44c460548e 100644
> > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> >  #include <linux/mod_devicetable.h>
> > @@ -362,6 +363,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(str=
uct device *dev)
> >
> >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> >  {
> > +     /*
> > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > +      * need to wait for handshake request to propagate
> > +      */
> > +     udelay(5);
> > +
>
> https://lore.kernel.org/imx/20230727152503.2199550-1-shenwei.wang@nxp.com=
/T/#m2dc5111e9628235f031c0bad2a137222b0205a61
>
> supposed clk_imx8mp_audiomix_save_restore() is that write save data into
> some registers.
>
> See above link for detail, it may not delay 5us before write to register.
> You need
>         readl();
>         udelay(5);
>         writel();

Here we need to wait for the handshake to be ready,  we have nothing
to be read.

but I don't really understand why the code is commented.

               /*
                * ret =3D regmap_read_poll_timeout(domain->regmap,
domain->regs->hsk, reg_val,
                *                                (reg_val &
domain->bits.hskack), 0,
                *                                USEC_PER_MSEC);

If we uncomment the code,  it can also fix the issue.

best regards
Shengjiu Wang

>
> >       clk_imx8mp_audiomix_save_restore(dev, false);
> >
> >       return 0;
> > --
> > 2.34.1
> >

