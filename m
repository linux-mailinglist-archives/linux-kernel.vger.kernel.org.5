Return-Path: <linux-kernel+bounces-16758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98A82436B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A76AB24187
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378F224FA;
	Thu,  4 Jan 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J9pVgrnm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81374224C0;
	Thu,  4 Jan 2024 14:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969C4C433C8;
	Thu,  4 Jan 2024 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704377811;
	bh=j8bX2+yD9pfzU69Q1L1Kz7U0xyaFH5dtvaYGpvTRB90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9pVgrnmZvFXzF34hpwglQZLfOqYuAtiHcYi1U6ZP/CV0/tAORQsyvfAahy2QVESe
	 gU59buvTYaVYTH5pQZcvz7xPIIKec4/Zf1F9IRbCA5P6EXf4Loj1GJU04eSNRamuO2
	 DpAWUomZ0OHZxiR+Cy9CdFrajGbiajj5TwWZ8qT8=
Date: Thu, 4 Jan 2024 15:16:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: surenb@google.com, 42.hyeyoo@gmail.com, benjamin.tissoires@redhat.com,
	mhocko@suse.com, ivan.orlov0322@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com, stable@vger.kernel.org,
	BassCheck <bass@buaa.edu.cn>
Subject: Re: [PATCH v2] usb: mon: Fix atomicity violation in mon_bin_vma_fault
Message-ID: <2024010409-poppy-rumor-bff5@gregkh>
References: <20231222060450.5449-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222060450.5449-1-2045gemini@gmail.com>

On Fri, Dec 22, 2023 at 02:04:50PM +0800, Gui-Dong Han wrote:
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
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 6.2.
> 
> To address this issue, it is proposed to add a spin lock pair in
> mon_bin_vma_fault() to ensure atomicity. With this patch applied, our tool
> never reports the possible bug, with the kernel configuration allyesconfig
> for x86_64. Due to the lack of associated hardware, we cannot test the
> patch in runtime testing, and just verify it according to the code logic.
> 
> [1] https://sites.google.com/view/basscheck/
> 
> Fixes: 19e6317d24c25 ("usb: mon: Fix a deadlock in usbmon between ...")
> Cc: stable@vger.kernel.org
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
> v2:
> * In this patch v2, we've added some information of the static analysis
> tool used, as per the researcher guidelines. Also, we've added a cc in the
> signed-off-by area, according to the stable-kernel-rules.
>   Thank Greg KH for helpful advice.
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

Nit, you still need the blank line before spin_lock_irqsave() here,
right?

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

Shouldn't the unlock go here, not 2 lines above as you are still
modifying things touched by rp.

thanks,

greg k-h

