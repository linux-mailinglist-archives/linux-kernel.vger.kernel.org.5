Return-Path: <linux-kernel+bounces-81140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133786710E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C656E1F24FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52665FDC0;
	Mon, 26 Feb 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDDsLru1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907B5FBBB;
	Mon, 26 Feb 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942497; cv=none; b=fbYiQkcPWTqywOBChyHrDvMRQKGkral1fCaMODXrr4OgSpDenmSDCT8ZoAmbPo1zcwAXe9jh+X1E2y9n+6iOCFYY3v7Nf8M+qNoq8j/cCw5OjjnsOvadYHxaLBdPRVec/Dkx+QK9YI6ZNKGmCi4ppjdElJBQHEcYOWePcWejYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942497; c=relaxed/simple;
	bh=o1mzMmaRz7hkDIp0oO5LoIQ5H4DKqBaGoNGkSEClgjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS6kJrdjclxVN7EbQxVS2r6yCeYr5AwznjO9zTzYNxtRGQh0nTwFBjADp+2QyoPZeo5XaBML1pTbMZTdFIXEq25JRK74WB3fO72dUFpdtB422VuQGPYHl4HUBdzQWOPKG0LmpS/bECZ1rJKrG4BujUsTDjVoncz29WmHoewRdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDDsLru1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3009C433F1;
	Mon, 26 Feb 2024 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708942496;
	bh=o1mzMmaRz7hkDIp0oO5LoIQ5H4DKqBaGoNGkSEClgjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDDsLru1S68QPgW5gk3zuGZmU5CX7Xp7yLIPvc/KLzDRYm2AlB6OBCLtGqh+9sgKn
	 cOlxDO90ffQsdxZN9jHwFImmtrnECQyIpazszCVjUUIaXZ2GCd0TMuvHYnw643Dqdl
	 LvAtJrhkKpagD5J733vnDGhDYJzI1nZIqhAZHStU=
Date: Mon, 26 Feb 2024 11:14:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
Message-ID: <2024022609-groom-passably-909c@gregkh>
References: <20240226100502.1845284-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226100502.1845284-1-michael@amarulasolutions.com>

On Mon, Feb 26, 2024 at 11:05:02AM +0100, Michael Trimarchi wrote:
> This patch avoid to disconnect an already gadget in not connected state
> 
> [   45.597274] dwc3 31000000.usb: wait for SETUP phase timed out
> [   45.599140] dwc3 31000000.usb: failed to set STALL on ep0out
> [   45.601069] ------------[ cut here ]------------
> [   45.601073] WARNING: CPU: 0 PID: 150 at drivers/usb/dwc3/ep0.c:289 dwc3_ep0_out_start+0xcc/0xd4
> [   45.601102] Modules linked in: cfg80211 rfkill ipv6 rpmsg_ctrl rpmsg_char crct10dif_ce rti_wdt k3_j72xx_bandgap rtc_ti_k3 omap_mailbox sa2ul authenc [last unloaded: ti_k3_r5_remoteproc]
> [   45.601151] CPU: 0 PID: 150 Comm: sh Not tainted 6.8.0-rc5 #1
> [   45.601159] Hardware name: BSH - CCM-M3 (DT)
> [   45.601164] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   45.601172] pc : dwc3_ep0_out_start+0xcc/0xd4
> [   45.601179] lr : dwc3_ep0_out_start+0x50/0xd4
> [   45.601186] sp : ffff8000832739e0
> [   45.601189] x29: ffff8000832739e0 x28: ffff800082a21000 x27: ffff8000808dc630
> [   45.601200] x26: 0000000000000002 x25: ffff800082530a44 x24: 0000000000000000
> [   45.601210] x23: ffff000000e079a0 x22: ffff000000e07a68 x21: 0000000000000001
> [   45.601219] x20: ffff000000e07880 x19: ffff000000e07880 x18: 0000000000000040
> [   45.601229] x17: ffff7fff8e1ce000 x16: ffff800080000000 x15: fffffffffffe5260
> [   45.601239] x14: 0000000000000000 x13: 206e6f204c4c4154 x12: 5320746573206f74
> [   45.601249] x11: 0000000000000001 x10: 000000000000000a x9 : ffff800083273930
> [   45.601259] x8 : 000000000000000a x7 : ffffffffffff3f0c x6 : ffffffffffff3f00
> [   45.601268] x5 : ffffffffffff3f0c x4 : 0000000000000000 x3 : 0000000000000000
> [   45.601278] x2 : 0000000000000000 x1 : ffff000004e7e600 x0 : 00000000ffffff92
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
> Tested on a am62x board with a usbnet gadget
> 
> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend)
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> V2->V3:
> 	- Change the logic of the patch using the gadget connected state
> 	- Change of the commit message
> V1->V2:
> 	- Add stable in CC
> ---
>  drivers/usb/dwc3/gadget.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4c8dd6724678..a7316a1703ad 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2650,6 +2650,15 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>  	int ret;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
> +	/*
> +	 * Attempt to disconnect a no connected gadget

What does this mean?  And why a 3 line comment?

> +	 */
> +	if (!dwc->connected) {
> +		dev_warn(dwc->dev, "No connected device\n");

You are printing while a spinlock is held?  What can userspace do with
this message?

> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +		return 0;

No error handling?  Why not?

thanks,

greg k-h

