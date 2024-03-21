Return-Path: <linux-kernel+bounces-109746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B270D88552D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4EB1C20E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C97868C;
	Thu, 21 Mar 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OmGWHcvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDD5914C;
	Thu, 21 Mar 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007425; cv=none; b=uj39rPlIQMvBHXOor0SZ5FgK5zGzGCFtAaKycasUGEEoVYZEFJ60Vo3flC22iG8yCO2BT+VJwVi3rS4jWYMiyoZpnqKaOei2gaMBcyntaPddgIrZMn5VtOOJCu1ctO+SA0VzsT33+1kbb4+3+CcUFSGVuubyOYHlFYI9W2cdSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007425; c=relaxed/simple;
	bh=jz0FnzSzpqsMaLVsUsazaeeE2gPTKuo3vV3JKyGyhmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDBmcQpMIJ2iMPFJ0RwsXMRUYE3FWW3PebU0jta6Jd8LMh2DiWEbtEoxYY9GLyPMiJlIFVY4ugarUS1T1FC69PbFKROq82GMmt1anARgHqgYTqSsvncrnm0O1zldgAwDepWky8sCmB/Nudibpt474398/UI5L8i1WZrsE1DY71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OmGWHcvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D84C433F1;
	Thu, 21 Mar 2024 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711007424;
	bh=jz0FnzSzpqsMaLVsUsazaeeE2gPTKuo3vV3JKyGyhmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmGWHcvf2B5O4nBtgvkYXiC24XKm73vjYH7lJpZWzI+HqkLZZg8lHtqfxltjaWIC1
	 mhD7oZ9/d+73UluyADfIYRvecLPptfFXBG3eMj2/mp3L1ibZbhqLzvsRjoDjLK9tho
	 5GEmSFNeo9QGPkFnjyItNXLCEZIcq7eRUKOWI8SM=
Date: Thu, 21 Mar 2024 08:50:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Subject: Re: [PATCH usb] wifi: ath9k: fix oob in htc_issue_send
Message-ID: <2024032107-discover-sulfide-af1d@gregkh>
References: <0000000000004e41110614187d35@google.com>
 <tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7225DC0D859205DD8BDDAE191CCFBF0D8907@qq.com>

On Thu, Mar 21, 2024 at 03:31:33PM +0800, Edward Adam Davis wrote:
> [syzbot reported]
> usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> ath9k_htc 1-1:1.0: ath9k_htc: HTC initialized with 33 credits
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
> index 255 is out of range for type 'htc_endpoint [22]'
> CPU: 1 PID: 2494 Comm: kworker/1:2 Not tainted 6.8.0-rc6-syzkaller-00190-ga788e53c05ae #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Workqueue: events request_firmware_work_func
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:347
>  htc_issue_send.constprop.0+0x209/0x230 drivers/net/wireless/ath/ath9k/htc_hst.c:26
>  ath9k_wmi_cmd_issue drivers/net/wireless/ath/ath9k/wmi.c:305 [inline]
>  ath9k_wmi_cmd+0x424/0x630 drivers/net/wireless/ath/ath9k/wmi.c:342
>  ath9k_regread+0xdb/0x160 drivers/net/wireless/ath/ath9k/htc_drv_init.c:242
>  ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:287 [inline]
>  __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
>  ath9k_hw_init+0xf02/0x2b30 drivers/net/wireless/ath/ath9k/hw.c:700
>  ath9k_init_priv drivers/net/wireless/ath/ath9k/htc_drv_init.c:662 [inline]
>  ath9k_init_device drivers/net/wireless/ath/ath9k/htc_drv_init.c:839 [inline]
>  ath9k_htc_probe_device+0xb37/0x25f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:963
>  ath9k_htc_hw_init+0x33/0x70 drivers/net/wireless/ath/ath9k/htc_hst.c:529
>  ath9k_hif_usb_firmware_cb+0x272/0x620 drivers/net/wireless/ath/ath9k/hif_usb.c:1273
>  request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1163
>  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
>  </TASK>
> ---[ end trace ]---
> [Fix]
> If the target does not return a valid end point id during the device connection
> process, returns a failure.
> 
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Reported-and-tested-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
> index eb631fd3336d..0d1115d1cc29 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_hst.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
> @@ -295,6 +295,9 @@ int htc_connect_service(struct htc_target *target,
>  	}
>  
>  	*conn_rsp_epid = target->conn_rsp_epid;
> +	if (*conn_rsp_epid < 0 || *conn_rsp_epid > ENDPOINT_MAX)
> +		return -EINVAL;
> +
>  	return 0;
>  err:
>  	kfree_skb(skb);
> -- 
> 2.43.0
> 
> 

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

