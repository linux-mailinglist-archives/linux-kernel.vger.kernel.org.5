Return-Path: <linux-kernel+bounces-121883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25088EEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B01C342C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2815253D;
	Wed, 27 Mar 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Q1iO77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EE1514D8;
	Wed, 27 Mar 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566630; cv=none; b=LXXx+7W+MQWfJ5hR0BJGoFED3RMWG8zPlQsqaD29GSjRVeUx10SEUHEO3oLegEvr51rk3BpAYaNsOaFdzbhI77I93JTXx8isPS3dUlPtQ6TSUAcxl6wDSdbve8RS0DX0u1pcuGqawZMpIAnnSuXzPWweU1NqGg3kHpArcOALV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566630; c=relaxed/simple;
	bh=ceAJBDJsMQ5sDuySRq7ldhrporPZTG7ZT1EpQXcXN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUuu6kmhDEGaFrv1j7M/uNnetq0P7KqBD9lXaB60xim4dnDcr0RJt5WCV1TKZAtM+wOmfGTq05/aLBFG1PvtDEearaGIUbbdl9FKyuVeftAeqN9wOvZQPcQYGyqVL61+C5iX2aoHdf7wgrYfTKDrdn7SQbCeCmgwEky7Rbcqpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Q1iO77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E7C433F1;
	Wed, 27 Mar 2024 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711566629;
	bh=ceAJBDJsMQ5sDuySRq7ldhrporPZTG7ZT1EpQXcXN1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1Q1iO770PoO1j4FciX9Y5BU9kmYJujFc52pzkyG+BLJxx/CLBKAAVYC8Lt9REJDJ
	 HpckABPRRQMoSyMxYM0p1Dv4Qi8flAq+1UXQhAVh5rKC0QHADZxp9GwXbp8IWoXTQA
	 5f4/qnMydLfKJ3dMCIj2cgBUYE+CCuyNkB6AAhB8jv9Xd+ZdjqaK7hpormBBPSP+In
	 wFrgpYsxVFyY48Va7RwjLqmZ/hgQOQEg+gLxCgg6+PtJ4mTvxXMXP214XILZM0HdyS
	 sZy3JhkjTuROHpTWwwtLu11nXHKCWNHvX73CzzQyec4rdFXxAlZY4Jj2ea28lIrr+a
	 l4JTADtsvGHyw==
Date: Wed, 27 Mar 2024 19:10:25 +0000
From: Simon Horman <horms@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: fix use-after-free bugs caused by
 ax25_ds_del_timer
Message-ID: <20240327191025.GU403975@kernel.org>
References: <20240326142542.118058-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326142542.118058-1-duoming@zju.edu.cn>

On Tue, Mar 26, 2024 at 10:25:42PM +0800, Duoming Zhou wrote:
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

FWIIW, in my reading of things there is another failure mode whereby
ax25_ds_timeout may rearm the timer after the call to del_timer() but
before the call to ax25_dev_put().

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  net/ax25/ax25_ds_timer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> index c4f8adbf814..5624c0d174c 100644
> --- a/net/ax25/ax25_ds_timer.c
> +++ b/net/ax25/ax25_ds_timer.c
> @@ -43,7 +43,12 @@ void ax25_ds_setup_timer(ax25_dev *ax25_dev)
>  
>  void ax25_ds_del_timer(ax25_dev *ax25_dev)
>  {
> -	if (ax25_dev)
> +	if (!ax25_dev)
> +		return;
> +
> +	if (!ax25_dev->device_up)
> +		timer_shutdown_sync(&ax25_dev->dama.slave_timer);
> +	else
>  		del_timer(&ax25_dev->dama.slave_timer);
>  }

I think that a) it is always correct to call timer_shutdown_sync,
and b) ax25_dev->device_up is always true. So a call to
timer_shutdown_sync can simply replace the call to del_timer.

Also, not strictly related, I think ax25_dev cannot be NULL,
so that check could be dropped. But perhaps that is better left alone.


Zooming out a bit, has removal of ax25 been considered.
I didn't check the logs thoroughly, but I'm not convinced it's been
maintained - other than clean-ups and by-inspection bug fixes - since git
history began.

