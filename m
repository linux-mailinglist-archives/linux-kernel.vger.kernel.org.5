Return-Path: <linux-kernel+bounces-80575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39A8669DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65821F222A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882981BC31;
	Mon, 26 Feb 2024 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q6diPE+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A11BF24;
	Mon, 26 Feb 2024 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927400; cv=none; b=NrM2OPTDegjVQC4TBuHSU+ZQJtpPYbF1NYG66ikpV0yFCCKTWQ2PNXgThIpwhzcpaa5CRBt3IJqa9e3tr09Zroz3i59uZah9Rf9LnkNxVjMCaAp9RkXSizbtYKGsygz1a+bGaJgOmNd55OFVKxKPHVAnQWzVkmBq1KUT9TNDc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927400; c=relaxed/simple;
	bh=rQ1turlgsXFMqRMIQFeoxObihk2n1XNDtxJd21pN6NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buz498FLI/vIkcq260cRUQfGkd8gLhl7rQlbbcTIZM5JXvlWtq5ImLXgbF+L/TZOeKOr0sjmj1fM4PUV0aPjudKpkSTKQPhP3PzQ1afb2dlkvPRm73WKN6Kk7ZrbHrH1xzCvpzCNzxvQqmRWk2EkEdz9vZNj9OWa9TAl2I7ZTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q6diPE+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD3C433F1;
	Mon, 26 Feb 2024 06:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708927400;
	bh=rQ1turlgsXFMqRMIQFeoxObihk2n1XNDtxJd21pN6NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6diPE+PpN5xVxki1jdKL05t/czhdUZjwrK3wpbFsw2ZbFdA7hJShitFl8CohBKea
	 izzRef5GkObR5ytJMXrVt0+vWnQqmpCz9fDP4lfQp+4pd8xgeMgrd0FPN5Nyl6hdF0
	 OFyH2UDBTcC7vK7BtokNW7R5fDc5ylR6G+4naxSE=
Date: Mon, 26 Feb 2024 07:03:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
Message-ID: <2024022604-shelve-uranium-4a58@gregkh>
References: <20240225181309.1697245-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225181309.1697245-1-michael@amarulasolutions.com>

On Sun, Feb 25, 2024 at 07:13:09PM +0100, Michael Trimarchi wrote:
> This patch restore the logic but protects the variable using a spinlock
> without moving the code
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
> Tested on a am62x board
> 
> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend)
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/usb/dwc3/gadget.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

