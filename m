Return-Path: <linux-kernel+bounces-72914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666985BAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52544283A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7519C66B5A;
	Tue, 20 Feb 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxLgIDWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823B664CB;
	Tue, 20 Feb 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428912; cv=none; b=awkZpBRFBAqX2VOhHuB3JfsXGZ6NM9qb8UNV/p4HX5DSc7ShGdDebfYpKC+zQZ+CmXmFO9sqqK1VFwLs5xAKW9EfjhpI/qBOpAcgey3U+9S4ybD53cqgDEFmz3W3M/0Rb/qplRH0mhrQ6fmPov/EuNyJLmTlV7z3JficAg9iP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428912; c=relaxed/simple;
	bh=g+BwWIsDALTdEILafk/ZJXkguL1Tffup+cePcQBqNpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhp/sug/qE5bY+1r0zOj7l7VLXY3muIFeimdkQiKU781Y5n5udvddJ/i4XytvAZw4WSIktO2sVCpHvVQ5q1bKjB308OWPgv7ytmCGJlGQfqSdnZofSsCxEPIGmVvVbITZ8N/vxQmF4sd0LBrC+/TUiCKnqieu4HSJaRI0wXXud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxLgIDWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF98AC433F1;
	Tue, 20 Feb 2024 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428912;
	bh=g+BwWIsDALTdEILafk/ZJXkguL1Tffup+cePcQBqNpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BxLgIDWp33lBMiv/zh/ilTuRxvoZuYbroWyEeRjxfS1bOUxaHuEQ+hUACmhb14O5E
	 hgxLlGc2sZxkaS103n/PajbOL/y9uXATGSSyWGP4/FTgG7zKczm5PuMsdruaewGqfm
	 R21lEnZgg/lHPeyLc0yNHh7gNQPwCfsJAvNGU8yCDyog+UA77Ljnq7KyLg5i1QA2KR
	 SI0Z96QWKrqu/ONZrgaNOqqykz+hkyR43Z4X0JUpMkux5xsPV633N0Y7HXjeal6E91
	 2u2GGgxQoXVfZYVmYHBlm+hhxY8flDSrJP5oItmIwdal1uu1q/PPgVcOyQvVpHX7Pv
	 oioFLHh6Hg5bg==
Message-ID: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
Date: Tue, 20 Feb 2024 13:35:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect:Replace mutex with rt_mutex for icc_bw_lock
Content-Language: en-US
To: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 fengqi@xiaomi.com, xuyingfeng@xiaomi.com
References: <20240220074300.10805-1-wangrumeng@xiaomi.corp-partner.google.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240220074300.10805-1-wangrumeng@xiaomi.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 20.02.24 9:43, Rumeng Wang wrote:
> From: wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>
> 
> Replace existing mutex with rt_mutex to prevent priority inversion
> between clients, which can cause unacceptable delays in some cases.
> 
> Signed-off-by: wangrumeng <wangrumeng@xiaomi.corp-partner.google.com>

A similar patch [1] has been posted some time ago. Please check the review
comments.

Thanks,
Georgi

[1] https://lore.kernel.org/all/20220906191423.30109-1-quic_mdtipton@quicinc.com/

> ---
>   drivers/interconnect/core.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 50bac2d79d9b..467d42cc7e49 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -14,6 +14,7 @@
>   #include <linux/interconnect-provider.h>
>   #include <linux/list.h>
>   #include <linux/mutex.h>
> +#include <linux/rtmutex.h>
>   #include <linux/slab.h>
>   #include <linux/of.h>
>   #include <linux/overflow.h>
> @@ -28,7 +29,7 @@ static LIST_HEAD(icc_providers);
>   static int providers_count;
>   static bool synced_state;
>   static DEFINE_MUTEX(icc_lock);
> -static DEFINE_MUTEX(icc_bw_lock);
> +static DEFINE_RT_MUTEX(icc_bw_lock);
>   static struct dentry *icc_debugfs_dir;
>   
>   static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
> @@ -698,7 +699,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>   	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   
>   	old_avg = path->reqs[0].avg_bw;
>   	old_peak = path->reqs[0].peak_bw;
> @@ -730,7 +731,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>   		apply_constraints(path);
>   	}
>   
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   
>   	trace_icc_set_bw_end(path, ret);
>   
> @@ -939,7 +940,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   		return;
>   
>   	mutex_lock(&icc_lock);
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   
>   	node->provider = provider;
>   	list_add_tail(&node->node_list, &provider->nodes);
> @@ -968,7 +969,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	node->avg_bw = 0;
>   	node->peak_bw = 0;
>   
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   	mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_node_add);
> @@ -1094,7 +1095,7 @@ void icc_sync_state(struct device *dev)
>   		return;
>   
>   	mutex_lock(&icc_lock);
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   	synced_state = true;
>   	list_for_each_entry(p, &icc_providers, provider_list) {
>   		dev_dbg(p->dev, "interconnect provider is in synced state\n");
> @@ -1107,7 +1108,7 @@ void icc_sync_state(struct device *dev)
>   			}
>   		}
>   	}
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   	mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_sync_state);


