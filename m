Return-Path: <linux-kernel+bounces-95445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6C874DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794C6B233A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB312BF1F;
	Thu,  7 Mar 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y/EKx0x5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E15129A61
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811585; cv=none; b=aOL3YFju03f6DvvMgbPBvAVdRicHTfvhwc4QyDdt1EokHCTgIBLOov/KmMCt6iLrXhduBTOSPM8ONIoU11BMV/zw+zFGQPBUDuAQzBkmyBfbCkYqvYyvazgNoUO1KonMK/+ZhQ/HZGPy7aYPdbl8QjWoFFH94SEgLYc3csKZbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811585; c=relaxed/simple;
	bh=kUtRXFv03Af2myonOW7iJH+7QC6OB41YDaO4QoZ6erc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAm5jHerBupaAp7lWDA6QWEggZGSxleQ4L2SQLQUOcwDtALXCjjaqrBWG5mg0Ku60E+56YGN3Ar8mC3omW14putyyanHXEageTjg5WxKz1+m/U2F3t1WFzKA5IMq/EyYQEIpmmtfYEemy4Eat6CcCpoY3DTrJmYZHMHIwcAXiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Y/EKx0x5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a450bedffdfso106790766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1709811581; x=1710416381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmyofjGAATtNfbRkux5Tn72b+cMR3JWBDg4s/dxWhdo=;
        b=Y/EKx0x5FXWSK4MlpeFFvF/bYC5iptrL7fmE9E2CucLtax9Pc++SOtueQjtpRBd6Qe
         IVd10xEupxQeXchwYjwfxiNeoJObcSR+hIGuUdWAB6QhL4iqZ5RF7ux8KIga9Fu3AWzR
         laGbJj0ikVnzSUnGPOvwof/O4w2oGiVHEYdLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811581; x=1710416381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmyofjGAATtNfbRkux5Tn72b+cMR3JWBDg4s/dxWhdo=;
        b=VKJHJNA2L+N67CkHjNcFfzEUqdTZLgGnqxaGZyMXee8hsItMgSdiwTT+st/feW6yfp
         DiInimXD95M3WgN19N73Mg2IapUxn1Mkb9MJ/4Lx2y0f74Z+XD8ur14mh5D4v7cQ4R27
         FVcJwF+Y9Qd03Ye0r4OZQ1p99Z4usmdYWGAx8Q2Wmv/xqaAGZP1lvBq6nRlwibM0xCvH
         9X4SuGJYItqOXEoq6OT7p8zmlKKxXH69bTjRxJjFoS8ylRUZPog+Vkru5m48Y2XJmRWh
         ZtOB4mYXfxzC67K9iu8v9/UAiKWR/zB4o1yPsEJzcUoxSLvOPLxgo1PVflubZxdWMlEB
         0G5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkbMLRi7780POvAKekhPhh651mhkOpe4/EodkJkdsVPDpcRosvqbJB1Uy5yh+yE88CJk6/q935ftc3GBJ6Aviji3DB3hORdPWySDHP
X-Gm-Message-State: AOJu0YxYhyZWf6JyvHOXbONTkJrR3BhOpKkdWf/hCs6Xu0FpaZH+M7jV
	nAMHZsyIcjpESmbKl9dY+da+ZZ38XdbdimtFKH4AUD/UryXTOD6f+zqTwiMJdVEU+7Yin8026e3
	6Xj5qQOR/gYGRfd76lskUE6ROHL9tzaJsnvqeKQ==
X-Google-Smtp-Source: AGHT+IEq4uXLnuvDMQxDLscG2Nl653AwCF7NrOD6IMSI06nfTPmzUcMJtV8xTGceFascG/93JVOwtTXBnv4kJciRtnM=
X-Received: by 2002:a17:906:6049:b0:a45:c8cb:f5c1 with SMTP id
 p9-20020a170906604900b00a45c8cbf5c1mr1697588ejj.63.1709811580611; Thu, 07 Mar
 2024 03:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226100502.1845284-1-michael@amarulasolutions.com>
 <20240226223643.pay4tb66j3q44cuk@synopsys.com> <CAOf5uwkcFuSRZy3F44pSZFpHk5Hah-r8m01JLt3Gd1ngvg-CPQ@mail.gmail.com>
 <20240307012847.2tkn7nu3juf2x6w2@synopsys.com>
In-Reply-To: <20240307012847.2tkn7nu3juf2x6w2@synopsys.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Mar 2024 12:39:29 +0100
Message-ID: <CAOf5uwnx+VYXZnNHAHK9_6dLh5XsNJaQPSwbfUuER1uWwe4_gw@mail.gmail.com>
Subject: Re: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Mar 7, 2024 at 2:30=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> Hi,
>
> On Mon, Feb 26, 2024, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Mon, Feb 26, 2024 at 11:36=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@syn=
opsys.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Feb 26, 2024, Michael Trimarchi wrote:
> > > > This patch avoid to disconnect an already gadget in not connected s=
tate
> > > >
> > > > [   45.597274] dwc3 31000000.usb: wait for SETUP phase timed out
> > > > [   45.599140] dwc3 31000000.usb: failed to set STALL on ep0out
> > > > [   45.601069] ------------[ cut here ]------------
> > > > [   45.601073] WARNING: CPU: 0 PID: 150 at drivers/usb/dwc3/ep0.c:2=
89 dwc3_ep0_out_start+0xcc/0xd4
> > > > [   45.601102] Modules linked in: cfg80211 rfkill ipv6 rpmsg_ctrl r=
pmsg_char crct10dif_ce rti_wdt k3_j72xx_bandgap rtc_ti_k3 omap_mailbox sa2u=
l authenc [last unloaded: ti_k3_r5_remoteproc]
> > > > [   45.601151] CPU: 0 PID: 150 Comm: sh Not tainted 6.8.0-rc5 #1
> > > > [   45.601159] Hardware name: BSH - CCM-M3 (DT)
> > > > [   45.601164] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> > > > [   45.601172] pc : dwc3_ep0_out_start+0xcc/0xd4
> > > > [   45.601179] lr : dwc3_ep0_out_start+0x50/0xd4
> > > > [   45.601186] sp : ffff8000832739e0
> > > > [   45.601189] x29: ffff8000832739e0 x28: ffff800082a21000 x27: fff=
f8000808dc630
> > > > [   45.601200] x26: 0000000000000002 x25: ffff800082530a44 x24: 000=
0000000000000
> > > > [   45.601210] x23: ffff000000e079a0 x22: ffff000000e07a68 x21: 000=
0000000000001
> > > > [   45.601219] x20: ffff000000e07880 x19: ffff000000e07880 x18: 000=
0000000000040
> > > > [   45.601229] x17: ffff7fff8e1ce000 x16: ffff800080000000 x15: fff=
ffffffffe5260
> > > > [   45.601239] x14: 0000000000000000 x13: 206e6f204c4c4154 x12: 532=
0746573206f74
> > > > [   45.601249] x11: 0000000000000001 x10: 000000000000000a x9 : fff=
f800083273930
> > > > [   45.601259] x8 : 000000000000000a x7 : ffffffffffff3f0c x6 : fff=
fffffffff3f00
> > > > [   45.601268] x5 : ffffffffffff3f0c x4 : 0000000000000000 x3 : 000=
0000000000000
> > > > [   45.601278] x2 : 0000000000000000 x1 : ffff000004e7e600 x0 : 000=
00000ffffff92
> > > > [   45.601289] Call trace:
> > > > [   45.601293]  dwc3_ep0_out_start+0xcc/0xd4
> > > > [   45.601301]  dwc3_ep0_stall_and_restart+0x98/0xbc
> > > > [   45.601309]  dwc3_ep0_reset_state+0x5c/0x88
> > > > [   45.601315]  dwc3_gadget_soft_disconnect+0x144/0x160
> > > > [   45.601323]  dwc3_gadget_suspend+0x18/0xb0
> > > > [   45.601329]  dwc3_suspend_common+0x5c/0x18c
> > > > [   45.601341]  dwc3_suspend+0x20/0x44
> > > > [   45.601350]  platform_pm_suspend+0x2c/0x6c
> > > > [   45.601360]  __device_suspend+0x10c/0x34c
> > > > [   45.601372]  dpm_suspend+0x1a8/0x240
> > > > [   45.601382]  dpm_suspend_start+0x80/0x9c
> > > > [   45.601391]  suspend_devices_and_enter+0x1c4/0x584
> > > > [   45.601402]  pm_suspend+0x1b0/0x264
> > > > [   45.601408]  state_store+0x80/0xec
> > > > [   45.601415]  kobj_attr_store+0x18/0x2c
> > > > [   45.601426]  sysfs_kf_write+0x44/0x54
> > > > [   45.601434]  kernfs_fop_write_iter+0x120/0x1ec
> > > > [   45.601445]  vfs_write+0x23c/0x358
> > > > [   45.601458]  ksys_write+0x70/0x104
> > > > [   45.601467]  __arm64_sys_write+0x1c/0x28
> > > > [   45.601477]  invoke_syscall+0x48/0x114
> > > > [   45.601488]  el0_svc_common.constprop.0+0x40/0xe0
> > > > [   45.601498]  do_el0_svc+0x1c/0x28
> > > > [   45.601506]  el0_svc+0x34/0xb8
> > > > [   45.601516]  el0t_64_sync_handler+0x100/0x12c
> > > > [   45.601522]  el0t_64_sync+0x190/0x194
> > > > [   45.601531] ---[ end trace 0000000000000000 ]---
> > > > [   45.608794] Disabling non-boot CPUs ...
> > > > [   45.611029] psci: CPU1 killed (polled 0 ms)
> > > > [   45.611837] Enabling non-boot CPUs ...
> > > > [   45.612247] Detected VIPT I-cache on CPU1
> > > >
> > > > Tested on a am62x board with a usbnet gadget
> > > >
> > > > Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereferen=
ce in dwc3_gadget_suspend)
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > ---
> > > > V2->V3:
> > > >       - Change the logic of the patch using the gadget connected st=
ate
> > > >       - Change of the commit message
> > > > V1->V2:
> > > >       - Add stable in CC
> > > > ---
> > > >  drivers/usb/dwc3/gadget.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > > > index 4c8dd6724678..a7316a1703ad 100644
> > > > --- a/drivers/usb/dwc3/gadget.c
> > > > +++ b/drivers/usb/dwc3/gadget.c
> > > > @@ -2650,6 +2650,15 @@ static int dwc3_gadget_soft_disconnect(struc=
t dwc3 *dwc)
> > > >       int ret;
> > > >
> > > >       spin_lock_irqsave(&dwc->lock, flags);
> > > > +     /*
> > > > +      * Attempt to disconnect a no connected gadget
> > > > +      */
> > > > +     if (!dwc->connected) {
> > > > +             dev_warn(dwc->dev, "No connected device\n");
> > > > +             spin_unlock_irqrestore(&dwc->lock, flags);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > >       dwc->connected =3D false;
> > > >
> > > >       /*
> > > > --
> > > > 2.40.1
> > > >
> > >
> > > There's already a fix for this, and it's already in mainline. Let me
> > > know if this works for you:
> > >
> > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/commit/?id=3Db191a18cb5c47109ca696370a74a5062a70a=
dfd0__;!!A4F2R9G_pg!dqF-dGSHGR41Bep_7ZG2mWfPNYWfC4T-_FpOf_pFIvqa9L1n1e6l6D3=
oP9bOlRRFobW4Uvh0VAP8qBkLMfNkUlfaeTc$
> > >
> >
> > Can you explain to me the logic here? I mean pullsup_connected seems
> > never protected by spin lock and so I can not figure
> > out it easily and the commit message does not explain so much
> >
>
> Sorry for the delay response.
>
> Ah.. you're right, the spin_lock isn't useful there. My intention was to
> avoid soft disconnect flow to occur during system suspend along with
> pullup(off). I somehow forgot that it isn't protected with spin_lock.
>

You reduce the window of failure but we need to rework anyway

> It's a very unlikely scenario. Even if it did happen, it should be
> harmless. But to solve that perhaps we can:
> 1) Keep the code simple and enforce no sleep and hold spin_lock during
>    the entirety of run_stop() sequence


If the run_stop is executing I can imagine that you only need to mark it as
ongoing and protect with a spin_lock, returning -EINVAL on the suspend
hook. I will keep
it simple

Michael

> 2) Enforce a must-lock check to run_stop() and unlock during sleep. This
>    requires more code changes and reviews.
>
> If you have some ideas, please share. (Note that using dwc->connected
> isn't sufficient)
>
> Thanks,
> Thinh



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

