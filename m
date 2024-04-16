Return-Path: <linux-kernel+bounces-147027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F28A6E82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E798B28CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F412F365;
	Tue, 16 Apr 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+DyPwlG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4912FF9E;
	Tue, 16 Apr 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278014; cv=none; b=Zr9bbXLeotnbOZfwsMUvPJtrfa0HWjlNrYsA8DD81FMMbKVbfCKLqCtB5xdlALCt1RUN3LGv/fiacbhxPJ/Jpm7MdmsIyLPhrGMziOh5IjhEZj7NwdXP44qcj9NxCC5q+Ie8WftD2DalCSBn1WppzEhV36uzAWa9pfNeBB0Ivmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278014; c=relaxed/simple;
	bh=S3+lG+Q4zz1vpzcDH9owuemE4fYStoaS86UMxk5U1J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny1QRV7hEUp66NA5ZGl9rLzwEnAz6GDsiZ5UjDc55nL63gv8TDhqY/o9pESgX1nzCJnM2f93MofwTlJ/DsTlcM7eR7XRu5XQP1jOunXOQ2lp62leAkaMeQSnH87JEe6To1gaiBR9vFGPrhcMvTKkXJzI5LJBMYt5cwDCFixWPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+DyPwlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BAFC32783;
	Tue, 16 Apr 2024 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713278013;
	bh=S3+lG+Q4zz1vpzcDH9owuemE4fYStoaS86UMxk5U1J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0+DyPwlGsaCyAcl74aQcZEoKNlafqD253vXe+at408/lTtSZFqY732I6veMUNTJiD
	 kAw1rB3SW31dZCwayjZu08nsfjNu+yXxE400hAYlx+zyCxkrjHcdVRP11C3A4k+021
	 S9nMv/SR9Flg66ICCPZTkKKhhNi+j2aukCNTEIlk=
Date: Tue, 16 Apr 2024 16:33:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, ewagner12@gmail.com,
	suravee.suthikulpanit@amd.com, vashegde@amd.com, jgg@ziepe.ca,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <2024041620-brick-stack-6736@gregkh>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>

On Tue, Apr 16, 2024 at 02:00:43PM +0100, Robin Murphy wrote:
> Previously, an untrusted device forcing IOMMU_DOMAIN_DMA always took
> precedence over whatever a driver's def_domain_type may have wanted to
> say. This was intentionally handled in core code since 3 years prior,
> to avoid drivers poking at the details of what is essentially a policy
> between the PCI core and the IOMMU core. Now, though, we go to the
> length of evaluating both constraints to check for any conflict, and if
> so throw our toys out of the pram and refuse to handle the device at
> all. Regardless of any intent, in practice this leaves the device, and
> potentially the rest of its group or even the whole IOMMU, in a largely
> undetermined state, which at worst may render the whole system unusable.
> Unfortunately it turns out that this is a realistic situation to run
> into by connecting a PASID-capable device (e.g. a GPU) to an AMD-based
> laptop via a Thunderbolt expansion box, since the AMD IOMMU driver needs
> an identity default domain for PASIDs to be usable, and thus sets a
> def_domain_type override based on PASID capability.
> 
> In general, restoring the old behaviour of forcing translation will not
> make that device's operation any more broken than leaving it potentially
> blocked or subject to the rest of a group's translations would, nor will
> it be any less safe than leaving it potentially bypassed or subject to
> the rest of a group's translations would, so do that, and let eGPUs work
> again.
> 
> Reported-by: Eric Wagner <ewagner12@gmail.com>
> Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
> Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to respect def_domain_type()")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 996e79dc582d..90dbea14d4d6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1772,9 +1772,8 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>  		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
>  			dev_err_ratelimited(
>  				untrusted,
> -				"Device is not trusted, but driver is overriding group %u to %s, refusing to probe.\n",
> +				"IOMMU_DOMAIN_DMA for untrusted device overrides driver request of %s for group %u, expect issues...\n",
>  				group->id, iommu_domain_type_str(driver_type));
> -			return -1;
>  		}
>  		driver_type = IOMMU_DOMAIN_DMA;
>  	}
> -- 
> 2.39.2.101.g768bb238c484.dirty
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

