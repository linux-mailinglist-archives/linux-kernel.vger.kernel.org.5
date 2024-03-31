Return-Path: <linux-kernel+bounces-126026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471589311E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1420EB2185A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6176036;
	Sun, 31 Mar 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKMhz6eg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CE74BF4;
	Sun, 31 Mar 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711877566; cv=none; b=PDELnuOyk1aGrWuDrKaUBZSNkkt15Oot7rdTedEhkqDdAw41WoZ3X4lKF/VfJEDBkGh7os550N49MaciZgFudAlDiEddnM9lSBDtK7hcc8EfWE0YP12UyVxdvnGryNL+ddxya9CUJ7lgfBAK36gy0xrxlzmUpCOzy5SBC9x78Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711877566; c=relaxed/simple;
	bh=2enq6wAu/O4AeWARd094N9k1k7dNI3QZzRGN2sj1ta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMBqUpSPL2c+ocO5Q1uU3DDGRCXRw0H7M8/bLQLf69J4O02PvlThpDikIyk/7Zk6xSJaCdgac5T6/NG4e/4f83h3eQRquEcJzQvwCH0Hdz2jWdpqsk24w5CWJrfOg257mUq8qYSR02KYz8qpVDWh2gnDLcXZX6QsnJlED/R2iSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKMhz6eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96306C433F1;
	Sun, 31 Mar 2024 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711877565;
	bh=2enq6wAu/O4AeWARd094N9k1k7dNI3QZzRGN2sj1ta0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKMhz6egBE+acFXIafQ3P8FTGcVhCEiKujymKP5WRIQ/QVNQdarAqzCq3QyhN9CDI
	 pUvnjDtj7IvbTg0LkSWDOjZJXFfDLmQS8uFLurOZBAu9Vv1LnGMSDMIENbw+BD2P3z
	 7n9S/VxH5Dr+ELusP98pq1MLLX8cWo0r625SMZ/rMRlqaN4ZHBwE83rVkttIW34oMz
	 6rYjyS0cq+R76PXJwHYi/VrALQJfojUR8K3OCE9LXgrR1Fb49PriNAYETy+FfJ9VjC
	 pK12pYKT6BvZy3YuyTU0/+V9jhxDyJmlZQKrAzrz3Eph+rdEw2ClNN1Cy7Wii/vtST
	 f1y/oZDtaeC3g==
Date: Sun, 31 Mar 2024 10:32:41 +0100
From: Simon Horman <horms@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net v2] ax25: fix use-after-free bugs caused by
 ax25_ds_del_timer
Message-ID: <20240331093241.GB26556@kernel.org>
References: <20240329015023.9223-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329015023.9223-1-duoming@zju.edu.cn>

On Fri, Mar 29, 2024 at 09:50:23AM +0800, Duoming Zhou wrote:
> When the ax25 device is detaching, the ax25_dev_device_down()
> calls ax25_ds_del_timer() to cleanup the slave_timer. When
> the timer handler is running, the ax25_ds_del_timer() that
> calls del_timer() in it will return directly. As a result,
> the use-after-free bugs could happen, one of the scenarios
> is shown below:
> 
>       (Thread 1)          |      (Thread 2)
>                           | ax25_ds_timeout()
> ax25_dev_device_down()    |
>   ax25_ds_del_timer()     |
>     del_timer()           |
>   ax25_dev_put() //FREE   |
>                           |  ax25_dev-> //USE
> 
> In order to mitigate bugs, when the device is detaching, use
> timer_shutdown_sync() to stop the timer.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Call timer_shutdown_sync() in ax25_dev_device_down().

Thanks,

as per my review of v1, I do think this is a correct approach to addressing
a valid concern.  But I would also value another set of eyes on the problem.

Reviewed-by: Simon Horman <horms@kernel.org>

>  net/ax25/ax25_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
> index c5462486dbc..282ec581c07 100644
> --- a/net/ax25/ax25_dev.c
> +++ b/net/ax25/ax25_dev.c
> @@ -105,7 +105,7 @@ void ax25_dev_device_down(struct net_device *dev)
>  	spin_lock_bh(&ax25_dev_lock);
>  
>  #ifdef CONFIG_AX25_DAMA_SLAVE
> -	ax25_ds_del_timer(ax25_dev);
> +	timer_shutdown_sync(&ax25_dev->dama.slave_timer);
>  #endif
>  
>  	/*
> -- 
> 2.17.1
> 

