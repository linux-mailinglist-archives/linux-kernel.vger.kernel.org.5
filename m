Return-Path: <linux-kernel+bounces-28927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769488304BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266AF288F01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76281DFE1;
	Wed, 17 Jan 2024 11:47:35 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554A1DFD1;
	Wed, 17 Jan 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492055; cv=none; b=UH7ghQo/AM56xjjwlhY16d1Bbeoib+Hgttnxx+xvNFbd70Gj/NphU8aTFcU5dtQwyIiTAh+2yU5cr0SpG43dEmM7yCu5BGI4CoxsBYi2/zLkmF+Syt5HeZS3OMsmOXXGsh/VdsJo+Xoha95JRY3UT7basoUce4OJN9lFCQKQpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492055; c=relaxed/simple;
	bh=kvkTR7iTyZVPJBT9Sqjw0z5+Ipc3TcSsE7D3hjrE/E4=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=q6ko/VZy9AJOh7bCGu0SMhxo9SYpV7mrpmrlwxU6nXKDs1xvUu55JJ+LH71Tisb3Sq2AiTMF4LtAxHu9bvShiGN98gRJvIHoRHS1vPp+VA0+4kWiZVgxyomw5R9qzjKiEUbcusCOaMTgrsVFdOwrEFciNbNJHawuPQEOh0omcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rQ4O1-00035J-2U; Wed, 17 Jan 2024 12:47:13 +0100
Date: Wed, 17 Jan 2024 12:47:13 +0100
From: Florian Westphal <fw@strlen.de>
To: wangkeqi <wangkeqi_chris@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangkeqi <wangkeqiwang@didiglobal.com>,
	kernel test robot <oliver.sang@intel.com>, fengwei.yin@intel.com
Subject: Re: [PATCH net v2] connector: Change the judgment conditions for
 clearing proc_event_num_listeners
Message-ID: <20240117114713.GA11468@breakpoint.cc>
References: <20240116015753.209781-1-wangkeqi_chris@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116015753.209781-1-wangkeqi_chris@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

wangkeqi <wangkeqi_chris@163.com> wrote:
> From: wangkeqi <wangkeqiwang@didiglobal.com>
> 
> It is inaccurate to judge whether proc_event_num_listeners is
> cleared by cn_netlink_send_mult returning -ESRCH.
> In the case of stress-ng netlink-proc, -ESRCH will always be returned,
> because netlink_broadcast_filtered will return -ESRCH,
> which may cause stress-ng netlink-proc performance degradation.
> Therefore, the judgment condition is modified to whether
> there is a listener.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com
> Fixes: c46bfba133 ("connector: Fix proc_event_num_listeners count not cleared")
> Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>
> Cc: fengwei.yin@intel.com
> ---
>  drivers/connector/cn_proc.c   | 6 ++++--
>  drivers/connector/connector.c | 6 ++++++
>  include/linux/connector.h     | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 3d5e6d705..b09f74ed3 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -108,8 +108,10 @@ static inline void send_msg(struct cn_msg *msg)
>  		filter_data[1] = 0;
>  	}
>  
> -	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> -			     cn_filter, (void *)filter_data) == -ESRCH)
> +	if (netlink_has_listeners(get_cdev_nls(), CN_IDX_PROC))
> +		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> +			     cn_filter, (void *)filter_data);
> +	else
>  		atomic_set(&proc_event_num_listeners, 0);

How is that serialized vs. cn_proc_mcast_ctl?

1. netlink_has_listeners() returns false
2.  other core handles PROC_CN_MCAST_LISTEN, atomic_inc called
3. This core (re)sets counter to 0, but there are listeners, so
    all functions that do

 if (atomic_read(&proc_event_num_listeners) < 1)
    return;

will not get enabled/remain disabled.

Probably better to add cn_netlink_has_listeners() function
and use that instead of the (inaccurate) counter?

