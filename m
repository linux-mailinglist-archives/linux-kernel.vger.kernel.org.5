Return-Path: <linux-kernel+bounces-56294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6170884C865
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E6288615
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486C525561;
	Wed,  7 Feb 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Chcv9I7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A724B34;
	Wed,  7 Feb 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300984; cv=none; b=CxztSS2t/im/3Xw5zG42u3qVEMES95nVZ+wb5sdYtI4kpkUdCTke6YTMGfIAsm2Ttk5lPUf7FhMNYLiQpOulKkyi9bnJKOT4ONtiY3p9yDbxwCaibJIc6v3y9y1txoE9ZrlMQLjXVT2+v4NBgI/8woMRzOWW2MZOPbt6DaXL6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300984; c=relaxed/simple;
	bh=O04xBB7jnsZDHGbei3HBZ/qO2slZ2cFBfcRAGrgWMGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFx3b5Dv+1kXujWoVr5jHtQXyY+7ExTEILjcD+UHAL5mF4JuG2bC1Hq9Pz6AfqfDKsmFlAB7sjy4isRtNZa67Kss0gRzFfNz7RJdojNwVPnDu7nQpDf62trvezzmGl0MnEwbnvtgJVcAZpdkbOciNWUZCTRAefJ7NuS/3B4Uw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Chcv9I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0F2C433F1;
	Wed,  7 Feb 2024 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707300983;
	bh=O04xBB7jnsZDHGbei3HBZ/qO2slZ2cFBfcRAGrgWMGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Chcv9I76fqA58CzJhnC6834vmu/rCPhepxW1dU3gSIIb/UV9k2EQS2IH3igdQnqO
	 1ipgUgxeac8jMik4ta+EKdszqKqEtdARVUd61yMK50nMCLcMU7OqDV7cul2Kc5N2nR
	 ymWuEGKGVidQW8cicnKse6OqZONINuuL21hTKeMg=
Date: Wed, 7 Feb 2024 10:16:20 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Sujeev Dias <sdias@codeaurora.org>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] bus: mhi: host: free buffer on error in
 mhi_alloc_bhie_table
Message-ID: <2024020709-familiar-slapping-a96a@gregkh>
References: <20240207065136.18316-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207065136.18316-1-pchelkin@ispras.ru>

On Wed, Feb 07, 2024 at 09:51:36AM +0300, Fedor Pchelkin wrote:
> img_info->mhi_buf should be freed on error path in mhi_alloc_bhie_table().
> This error case is rare but still needs to be fixed.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/bus/mhi/host/boot.c | 1 +
>  1 file changed, 1 insertion(+)

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

