Return-Path: <linux-kernel+bounces-22021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 735FE829807
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846821C21964
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BF4122B;
	Wed, 10 Jan 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WnaxW/x7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684B405C3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D70BC433F1;
	Wed, 10 Jan 2024 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704883949;
	bh=d/N3uSGa56h3NygWjcmOS8GWGLbmjtlxYmmoZF+2HMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnaxW/x7jsuUunYSqYAkc8ACl+bkUoH0WfeoQeH6O/prBx6VOjn74EGZ/2FV/vzDv
	 7E3CHdpCW4tmHEGz40ZnIpxglF/nih3urpS9lqLLva1P0DO8Sc8iyevTGTX6Qd0y9V
	 o+k3NMPpYfemnNot8LESasNwYvEYnOrJjVOUTf/A=
Date: Wed, 10 Jan 2024 11:52:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kovalev@altlinux.org
Cc: bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org
Subject: Re: [PATCH 1/1] misc/vmw_vmci: fix filling of the msg and
 msg_payload in dg_info struct
Message-ID: <2024011013-lucid-try-0119@gregkh>
References: <20240110104042.31865-1-kovalev@altlinux.org>
 <20240110104042.31865-2-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110104042.31865-2-kovalev@altlinux.org>

On Wed, Jan 10, 2024 at 01:40:42PM +0300, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> Fix "detected field-spanning write" of memcpy warning that is issued by
> the tracking mechanism __fortify_memcpy_chk, added 2021-04-20
> (f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time)
> 
> Fixes: a110b7ebb9c674 ("VMCI: datagram implementation.")
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  drivers/misc/vmw_vmci/vmci_datagram.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
> index f50d22882476f9..27853b31e288b1 100644
> --- a/drivers/misc/vmw_vmci/vmci_datagram.c
> +++ b/drivers/misc/vmw_vmci/vmci_datagram.c
> @@ -234,7 +234,10 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
>  
>  			dg_info->in_dg_host_queue = true;
>  			dg_info->entry = dst_entry;
> -			memcpy(&dg_info->msg, dg, dg_size);
> +			memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
> +			if (dg->payload_size) {
> +				memcpy(dg_info->msg_payload, VMCI_DG_PAYLOAD(dg), dg->payload_size);
> +			}
>  
>  			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
>  			schedule_work(&dg_info->work);
> @@ -377,7 +380,10 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
>  
>  		dg_info->in_dg_host_queue = false;
>  		dg_info->entry = dst_entry;
> -		memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
> +		memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
> +		if (dg->payload_size) {
> +			memcpy(dg_info->msg_payload, VMCI_DG_PAYLOAD(dg), dg->payload_size);
> +		}
>  
>  		INIT_WORK(&dg_info->work, dg_delayed_dispatch);
>  		schedule_work(&dg_info->work);
> -- 
> 2.33.8
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

