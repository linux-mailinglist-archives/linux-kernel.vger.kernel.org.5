Return-Path: <linux-kernel+bounces-17143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FC8248DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F8C1C22700
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC962C1A8;
	Thu,  4 Jan 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfYUazh+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2D2C18C;
	Thu,  4 Jan 2024 19:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF7AC433C7;
	Thu,  4 Jan 2024 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704395807;
	bh=9IYhiNNFGexpUZr6GXQKp38uLjqBlUuJ5KSb1AaVyDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfYUazh+5zgvF8w0BFNCESTr7TercBq61Bw7MIK1/0/8TFsMqp8ZW01IwFI7JcSSU
	 fQQzsWi6ZMw5g/SzaZkI0W+OkLYAf8+SxCm2JQFMDcFGPZerKzCp1tpoJO9ajCHJm/
	 +aeSLCW5oS5/aYCRjpvyqEW/O4SvJA18SBP248uz3o8jyTAXKgfZEEe4hXUetmiTAo
	 BD92ABC04wS0w7HFAyzvsS0p7DQK3NdHu98sirisk9YbASvy2WIs1YQ+s1LpWKeKd9
	 F/RA+T7UIULgDIg98DP+eeRe/YRCcm7iCg9oOe7s+/DKswCaenBCRClGCa7hNd8Bxg
	 rmnob6mFT6NHA==
Date: Thu, 4 Jan 2024 19:16:43 +0000
From: Simon Horman <horms@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shannon.nelson@amd.com
Subject: Re: [PATCH net-next 4/8] pds_core: Prevent race issues involving the
 adminq
Message-ID: <20240104191643.GL31813@kernel.org>
References: <20240104171221.31399-1-brett.creeley@amd.com>
 <20240104171221.31399-5-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104171221.31399-5-brett.creeley@amd.com>

On Thu, Jan 04, 2024 at 09:12:17AM -0800, Brett Creeley wrote:
> There are multiple paths that can result in using the pdsc's
> adminq.
> 
> [1] pdsc_adminq_isr and the resulting work from queue_work(),
>     i.e. pdsc_work_thread()->pdsc_process_adminq()
> 
> [2] pdsc_adminq_post()
> 
> When the device goes through reset via PCIe reset and/or
> a fw_down/fw_up cycle due to bad PCIe state or bad device
> state the adminq is destroyed and recreated.
> 
> A NULL pointer dereference can happen if [1] or [2] happens
> after the adminq is already destroyed.
> 
> In order to fix this, add some further state checks and
> implement reference counting for adminq uses. Reference
> counting was used because multiple threads can attempt to
> access the adminq at the same time via [1] or [2]. Additionally,
> multiple clients (i.e. pds-vfio-pci) can be using [2]
> at the same time.
> 
> The adminq_refcnt is initialized to 1 when the adminq has been
> allocated and is ready to use. Users/clients of the adminq
> (i.e. [1] and [2]) will increment the refcnt when they are using
> the adminq. When the driver goes into a fw_down cycle it will
> set the PDSC_S_FW_DEAD bit and then wait for the adminq_refcnt
> to hit 1. Setting the PDSC_S_FW_DEAD before waiting will prevent
> any further adminq_refcnt increments. Waiting for the
> adminq_refcnt to hit 1 allows for any current users of the adminq
> to finish before the driver frees the adminq. Once the
> adminq_refcnt hits 1 the driver clears the refcnt to signify that
> the adminq is deleted and cannot be used. On the fw_up cycle the
> driver will once again initialize the adminq_refcnt to 1 allowing
> the adminq to be used again.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

...

> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 0356e56a6e99..3b3e1541dd1c 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -450,6 +450,7 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
>  		pdsc_debugfs_add_viftype(pdsc);
>  	}
>  
> +	refcount_set(&pdsc->adminq_refcnt, 1);
>  	clear_bit(PDSC_S_FW_DEAD, &pdsc->state);
>  	return 0;
>  
> @@ -514,6 +515,24 @@ void pdsc_stop(struct pdsc *pdsc)
>  					   PDS_CORE_INTR_MASK_SET);
>  }
>  
> +void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)

Hi Brett,

a minor nit from my side: pdsc_adminq_wait_and_dec_once_unused is only used
in this file so perhaps it should be static?

> +{
> +	/* The driver initializes the adminq_refcnt to 1 when the adminq is
> +	 * allocated and ready for use. Other users/requesters will increment
> +	 * the refcnt while in use. If the refcnt is down to 1 then the adminq
> +	 * is not in use and the refcnt can be cleared and adminq freed. Before
> +	 * calling this function the driver will set PDSC_S_FW_DEAD, which
> +	 * prevent subsequent attempts to use the adminq and increment the
> +	 * refcnt to fail. This guarantees that this function will eventually
> +	 * exit.
> +	 */
> +	while (!refcount_dec_if_one(&pdsc->adminq_refcnt)) {
> +		dev_dbg_ratelimited(pdsc->dev, "%s: adminq in use\n",
> +				    __func__);
> +		cpu_relax();
> +	}
> +}
> +
>  void pdsc_fw_down(struct pdsc *pdsc)
>  {
>  	union pds_core_notifyq_comp reset_event = {
> @@ -529,6 +548,8 @@ void pdsc_fw_down(struct pdsc *pdsc)
>  	if (pdsc->pdev->is_virtfn)
>  		return;
>  
> +	pdsc_adminq_wait_and_dec_once_unused(pdsc);
> +
>  	/* Notify clients of fw_down */
>  	if (pdsc->fw_reporter)
>  		devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);

...

