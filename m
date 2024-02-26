Return-Path: <linux-kernel+bounces-80698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B169866B68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0101F2269E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855191C295;
	Mon, 26 Feb 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UBqnKylB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7C1C686
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934017; cv=none; b=Gwdzztd9zFqW8GSK0ScuhAjuOnJdqfoZCn8B+DC47Ai713VorPi6nz8W79CEmRMsCph2ID5B0fDLQsByKDdtj734m/tf+iGWyCDzJPIngV4B+vVtZpuLkXThPiC/uM4w6z6E3+woyFa1LEIIT/uV5lqQrUaN93wQdScoB3TrBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934017; c=relaxed/simple;
	bh=H1/68T6vtEI19f2OwbzYGbUoeQTa60oidED9lAkt07k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWQ2HGIO+C7ZFPlbotBvyNKgdXK5U1YHr+0Bnzchx/Y9ui64BcYCTCqqakZrjpaqg3C1psIiQsz1bcNWwEUn5bAahVhCrbboLZ0xAsnnPYn4e4aTesBMjqqsd+MbsiKoPKADoorAXenI1MrWH/hVlek2NT/R/7HbBfBGaz2K1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=UBqnKylB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so399839166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1708934013; x=1709538813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DLWa7NcP4etKwAniB6QuHD07G5jSHGqKq2CbdXaCTc=;
        b=UBqnKylBLQ/njzmb6jfdu45pAv7Jq9vmv3/Xq6ftDeMrCSi/p4F6w4Lc2s+E9NOUtM
         dRCBi19q4rmcOlwi4j0hiDJfNipAj2tPx0acJ1incJN38HS0Z9CBcdkV3wdrrcsumMTI
         /7AQXK4oVhmg9Iq61eVDv+ZJ51GoAw1pk2yTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934013; x=1709538813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DLWa7NcP4etKwAniB6QuHD07G5jSHGqKq2CbdXaCTc=;
        b=ZpfQR96FabVpu06qdkSDQZMT0SIdRuLK+P2H7V81IOa8DKfpC8XCuJgLCqBNZ53a9v
         0xPuqR7fXUwNiS/AEarH6nzwpSUVaAkgI2uwTKOE33wd7gO3XB2+A1tb/njdbsqCa55d
         0tW1t5aRURQjB8DoRoF0GQgMPl9GRddPGllTQ9GXWyMtVbsDUbMxfVaSVJdJbYLEJFyh
         rrDh4XctsMZg9zxc2A7TyztThExDSvQNZ28RYiMr0FIOxLemxGiHy35BoXNC6b5tCoFi
         2WBpZLFe1udES9mKcCAvulc/w41/YS8vjxoAeYkXRfdWFkRnRcFA/7qXJX5b2BwXRJdt
         LIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDuyesPMkNlPtJ+fVWxfHHVqKyYYhAQ0/tg0hZAY6y4BQJBHOEeMAJTTiDmXGKGa+f1rBrdA85liyGwmkgRJnYK0zBril02+tVPnb5
X-Gm-Message-State: AOJu0YxOAxzaFzKCXimPDai9KxHYKfows9o370SN5NOm65dib/HpGe5c
	kzQkhO6LU2QcdKEdlQNnOqiogyDq42mHHWQER263BeP6pSnUpis8RFqJkXg1cUInQRtbr5k971G
	O6Gb8xXcR4m1GRS+KDyVMTnfvrfFX8e9eZkJFYw==
X-Google-Smtp-Source: AGHT+IEhOCKWXEBEZgQAKtk2f60JhvlK6LnyTrP3IE8mObADY6Ur4vqS9GaLdac9/qnxIORF2bcbkB4Pe4oF+dX3X4A=
X-Received: by 2002:a17:906:b798:b0:a41:3d8b:80d with SMTP id
 dt24-20020a170906b79800b00a413d8b080dmr4627327ejb.37.1708934012843; Sun, 25
 Feb 2024 23:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226070348.1703879-1-michael@amarulasolutions.com>
In-Reply-To: <20240226070348.1703879-1-michael@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Feb 2024 08:53:21 +0100
Message-ID: <CAOf5uw=P0UYXP8ujHpF+hnGR_cg90gqv9na7cVH1sQ-BtEgrTA@mail.gmail.com>
Subject: Re: [PATCH V2] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amarula@amarulasolutions.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all

Please don't review, I'm not happy with it and even it's broken. I
need to find better solution

On Mon, Feb 26, 2024 at 8:03=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> This patch restore the logic but protects the variable using a spinlock
> without moving the code
>
> [   45.597274] dwc3 31000000.usb: wait for SETUP phase timed out
> [   45.599140] dwc3 31000000.usb: failed to set STALL on ep0out
> [   45.601069] ------------[ cut here ]------------
> [   45.601073] WARNING: CPU: 0 PID: 150 at drivers/usb/dwc3/ep0.c:289 dwc=
3_ep0_out_start+0xcc/0xd4
> [   45.601102] Modules linked in: cfg80211 rfkill ipv6 rpmsg_ctrl rpmsg_c=
har crct10dif_ce rti_wdt k3_j72xx_bandgap rtc_ti_k3 omap_mailbox sa2ul auth=
enc [last unloaded: ti_k3_r5_remoteproc]
> [   45.601151] CPU: 0 PID: 150 Comm: sh Not tainted 6.8.0-rc5 #1
> [   45.601159] Hardware name: BSH - CCM-M3 (DT)
> [   45.601164] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   45.601172] pc : dwc3_ep0_out_start+0xcc/0xd4
> [   45.601179] lr : dwc3_ep0_out_start+0x50/0xd4
> [   45.601186] sp : ffff8000832739e0
> [   45.601189] x29: ffff8000832739e0 x28: ffff800082a21000 x27: ffff80008=
08dc630
> [   45.601200] x26: 0000000000000002 x25: ffff800082530a44 x24: 000000000=
0000000
> [   45.601210] x23: ffff000000e079a0 x22: ffff000000e07a68 x21: 000000000=
0000001
> [   45.601219] x20: ffff000000e07880 x19: ffff000000e07880 x18: 000000000=
0000040
> [   45.601229] x17: ffff7fff8e1ce000 x16: ffff800080000000 x15: fffffffff=
ffe5260
> [   45.601239] x14: 0000000000000000 x13: 206e6f204c4c4154 x12: 532074657=
3206f74
> [   45.601249] x11: 0000000000000001 x10: 000000000000000a x9 : ffff80008=
3273930
> [   45.601259] x8 : 000000000000000a x7 : ffffffffffff3f0c x6 : fffffffff=
fff3f00
> [   45.601268] x5 : ffffffffffff3f0c x4 : 0000000000000000 x3 : 000000000=
0000000
> [   45.601278] x2 : 0000000000000000 x1 : ffff000004e7e600 x0 : 00000000f=
fffff92
> [   45.601289] Call trace:
> [   45.601293]  dwc3_ep0_out_start+0xcc/0xd4
> [   45.601301]  dwc3_ep0_stall_and_restart+0x98/0xbc
> [   45.601309]  dwc3_ep0_reset_state+0x5c/0x88
> [   45.601315]  dwc3_gadget_soft_disconnect+0x144/0x160
> [   45.601323]  dwc3_gadget_suspend+0x18/0xb0
> [   45.601329]  dwc3_suspend_common+0x5c/0x18c
> [   45.601341]  dwc3_suspend+0x20/0x44
> [   45.601350]  platform_pm_suspend+0x2c/0x6c
> [   45.601360]  __device_suspend+0x10c/0x34c
> [   45.601372]  dpm_suspend+0x1a8/0x240
> [   45.601382]  dpm_suspend_start+0x80/0x9c
> [   45.601391]  suspend_devices_and_enter+0x1c4/0x584
> [   45.601402]  pm_suspend+0x1b0/0x264
> [   45.601408]  state_store+0x80/0xec
> [   45.601415]  kobj_attr_store+0x18/0x2c
> [   45.601426]  sysfs_kf_write+0x44/0x54
> [   45.601434]  kernfs_fop_write_iter+0x120/0x1ec
> [   45.601445]  vfs_write+0x23c/0x358
> [   45.601458]  ksys_write+0x70/0x104
> [   45.601467]  __arm64_sys_write+0x1c/0x28
> [   45.601477]  invoke_syscall+0x48/0x114
> [   45.601488]  el0_svc_common.constprop.0+0x40/0xe0
> [   45.601498]  do_el0_svc+0x1c/0x28
> [   45.601506]  el0_svc+0x34/0xb8
> [   45.601516]  el0t_64_sync_handler+0x100/0x12c
> [   45.601522]  el0t_64_sync+0x190/0x194
> [   45.601531] ---[ end trace 0000000000000000 ]---
> [   45.608794] Disabling non-boot CPUs ...
> [   45.611029] psci: CPU1 killed (polled 0 ms)
> [   45.611837] Enabling non-boot CPUs ...
> [   45.612247] Detected VIPT I-cache on CPU1
>
> Tested on a am62x board
>
> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in =
dwc3_gadget_suspend)
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> V1->V2:
>         Add cc to stable
> ---
>  drivers/usb/dwc3/gadget.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4c8dd6724678..4c88e44127b5 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4703,13 +4703,19 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>         unsigned long flags;
>         int ret;
>
> +       spin_lock_irqsave(&dwc->lock, flags);
> +       if (!dwc->gadget_driver) {
> +               spin_unlock_irqrestore(&dwc->lock, flags);
> +               return 0;
> +       }
> +       spin_unlock_irqrestore(&dwc->lock, flags);
> +
>         ret =3D dwc3_gadget_soft_disconnect(dwc);
>         if (ret)
>                 goto err;
>
>         spin_lock_irqsave(&dwc->lock, flags);
> -       if (dwc->gadget_driver)
> -               dwc3_disconnect_gadget(dwc);
> +       dwc3_disconnect_gadget(dwc);
>         spin_unlock_irqrestore(&dwc->lock, flags);
>
>         return 0;
> --
> 2.40.1
>


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

