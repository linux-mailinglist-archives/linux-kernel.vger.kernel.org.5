Return-Path: <linux-kernel+bounces-93382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A60872EE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC67289F58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06BF55769;
	Wed,  6 Mar 2024 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XixnWcKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3171CD1E;
	Wed,  6 Mar 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709706344; cv=none; b=C0JfyYf5uYs09R+sqd+JmQ4m6ZyzE+7iM1Lo7UJG58FMubq/Q7Uwwe6d8oYef0STUM+7x4ItEBKoSsPKFGMQJoN/YSevTq4U9AZAlwzfLZjeqwZ95jSt/Zc13Bry2L0IfY5l00QyjR0hJ/iZrArYtxOagNRms8QDai+LBvLckXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709706344; c=relaxed/simple;
	bh=TIhUAXUWGTWxPL7sy0ENqPp+evBxdbJZkIMi9yVqRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoVEYKx4rNM7kA6/J3957jSbP7Fqcie1Fa/DIR3nO2mqqqPIhmkaQbmiNnAqaGlWe/NP7gzEplWhTjZKbc4SKwBORZVkJrO6vSEqiDkKH0tN8rbSSRxJIFK3otg5qNU18hYEE4Swv1p/cSFUa/seseiP/QTf+NY12YOoHDtOjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XixnWcKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5090C433F1;
	Wed,  6 Mar 2024 06:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709706344;
	bh=TIhUAXUWGTWxPL7sy0ENqPp+evBxdbJZkIMi9yVqRzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XixnWcKPPV5Jca5a2pQcERHC9afGtkQt9UpLdPP33UlYJfYZRfvNNH0g7HQg3IPuO
	 DVMCg+3MAoNl/mHLxsWuvAtp2UVgfF4NYUEY5G2lBPHxgKGMVNu+c80TiD32nlqgOT
	 +jesr0T9dNWnGeeIxph0YA9gy4K7VdC+lI/RP/Ck=
Date: Wed, 6 Mar 2024 06:25:41 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: djakov@kernel.org, robdclark@chromium.org, quic_rlaggysh@quicinc.com,
	quic_okukatla@quicinc.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Don't access req_list while it's being
 manipulated
Message-ID: <2024030623-smoking-marry-f4c5@gregkh>
References: <20240305225652.22872-1-quic_mdtipton@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305225652.22872-1-quic_mdtipton@quicinc.com>

On Tue, Mar 05, 2024 at 02:56:52PM -0800, Mike Tipton wrote:
> The icc_lock mutex was split into separate icc_lock and icc_bw_lock
> mutexes in [1] to avoid lockdep splats. However, this didn't adequately
> protect access to icc_node::req_list.
> 
> The icc_set_bw() function will eventually iterate over req_list while
> only holding icc_bw_lock, but req_list can be modified while only
> holding icc_lock. This causes races between icc_set_bw(), of_icc_get(),
> and icc_put().
> 
> Example A:
> 
>   CPU0                               CPU1
>   ----                               ----
>   icc_set_bw(path_a)
>     mutex_lock(&icc_bw_lock);
>                                      icc_put(path_b)
>                                        mutex_lock(&icc_lock);
>     aggregate_requests()
>       hlist_for_each_entry(r, ...
>                                        hlist_del(...
>         <r = invalid pointer>
> 
> Example B:
> 
>   CPU0                               CPU1
>   ----                               ----
>   icc_set_bw(path_a)
>     mutex_lock(&icc_bw_lock);
>                                      path_b = of_icc_get()
>                                        of_icc_get_by_index()
>                                          mutex_lock(&icc_lock);
>                                          path_find()
>                                            path_init()
>     aggregate_requests()
>       hlist_for_each_entry(r, ...
>                                              hlist_add_head(...
>         <r = invalid pointer>
> 
> Fix this by ensuring icc_bw_lock is always held before manipulating
> icc_node::req_list. The additional places icc_bw_lock is held don't
> perform any memory allocations, so we should still be safe from the
> original lockdep splats that motivated the separate locks.
> 
> [1] commit af42269c3523 ("interconnect: Fix locking for runpm vs reclaim")
> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Fixes: af42269c3523 ("interconnect: Fix locking for runpm vs reclaim")
> ---
>  drivers/interconnect/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
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

