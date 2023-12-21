Return-Path: <linux-kernel+bounces-8241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BE81B450
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B898B25CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF36A34B;
	Thu, 21 Dec 2023 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mugoYsI8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D906EB4D;
	Thu, 21 Dec 2023 10:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74463C433C7;
	Thu, 21 Dec 2023 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703155778;
	bh=LhqCfCVPwytiqliSfMH3BV35/UgE/I1uDNJzZrI9ZPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mugoYsI8oZi1OCgLEy8hn7PjZyRMSHhJwsekUOz7yFXzPs/Jn21rgbS7Qp8KSVn5m
	 z8v+WQzVPqiHKrkMZFkpj4xCmQgzisjMrKpnBtadDrbTvo8KWUbYdsdZ6VufyJ3uch
	 TuLgie5gpDPMD5Tnt21OHTjo90W0vB7hoKes4hj0=
Date: Thu, 21 Dec 2023 11:49:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: ivan.orlov0322@gmail.com, surenb@google.com, 42.hyeyoo@gmail.com,
	Liam.Howlett@oracle.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
	BassCheck <bass@buaa.edu.cn>
Subject: Re: [PATCH] usb: mon: Fix atomicity violation in mon_bin_vma_fault
Message-ID: <2023122104-favoring-lavender-94a9@gregkh>
References: <20231221104034.4851-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221104034.4851-1-2045gemini@gmail.com>

On Thu, Dec 21, 2023 at 06:40:34PM +0800, Gui-Dong Han wrote:
> In mon_bin_vma_fault():
> 	offset = vmf->pgoff << PAGE_SHIFT;
> 	if (offset >= rp->b_size)
> 		return VM_FAULT_SIGBUS;
> 	chunk_idx = offset / CHUNK_SIZE;
> 	pageptr = rp->b_vec[chunk_idx].pg;
> The code is executed without holding any lock.
> 
> In mon_bin_vma_close():
> 	spin_lock_irqsave(&rp->b_lock, flags);
> 	rp->mmap_active--;
> 	spin_unlock_irqrestore(&rp->b_lock, flags);
> 
> In mon_bin_ioctl():
> 	spin_lock_irqsave(&rp->b_lock, flags);
> 	if (rp->mmap_active) {
> 		...
> 	} else {
> 		...
> 		kfree(rp->b_vec);
> 		rp->b_vec  = vec;
> 		rp->b_size = size;
> 		...
> 	}
> 	spin_unlock_irqrestore(&rp->b_lock, flags);
> 
> Concurrent execution of mon_bin_vma_fault() with mon_bin_vma_close() and
> mon_bin_ioctl() could lead to atomicity violations. mon_bin_vma_fault()
> accesses rp->b_size and rp->b_vec without locking, risking array
> out-of-bounds access or use-after-free bugs due to possible modifications
> in mon_bin_ioctl().
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency
> bugs including data races and atomicity violations. The above possible
> bug is reported, when our tool analyzes the source code of Linux 6.2.
> 
> To address this issue, it is proposed to add a spin lock pair in
> mon_bin_vma_fault() to ensure atomicity. With this patch applied, our tool
> never reports the possible bug, with the kernel configuration allyesconfig
> for x86_64. Due to the lack of associated hardware, we cannot test the
> patch in runtime testing, and just verify it according to the code logic.
> 
> Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/usb/mon/mon_bin.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index 9ca9305243fe..509cd1b8ff13 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1250,12 +1250,16 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
>  	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
>  	unsigned long offset, chunk_idx;
>  	struct page *pageptr;
> -
> +	unsigned long flags;
> +	spin_lock_irqsave(&rp->b_lock, flags);
>  	offset = vmf->pgoff << PAGE_SHIFT;
> -	if (offset >= rp->b_size)
> +	if (offset >= rp->b_size) {
> +		spin_unlock_irqrestore(&rp->b_lock, flags);
>  		return VM_FAULT_SIGBUS;
> +	}
>  	chunk_idx = offset / CHUNK_SIZE;
>  	pageptr = rp->b_vec[chunk_idx].pg;
> +	spin_unlock_irqrestore(&rp->b_lock, flags);
>  	get_page(pageptr);
>  	vmf->page = pageptr;
>  	return 0;
> -- 
> 2.34.1
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

