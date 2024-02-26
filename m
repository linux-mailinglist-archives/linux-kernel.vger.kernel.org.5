Return-Path: <linux-kernel+bounces-80441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC58866874
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E41C215F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0313ADC;
	Mon, 26 Feb 2024 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QieB6N03"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DCF9C3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916554; cv=none; b=cVliZgePCr6pZhZPmxhXtiPyPjyaw9LXy1ctQXbWbSacF+8LMeWGltn8FiQh+8+E7A5GQ1IgyFDqKSCAARVnG67AbiGEiIRJLrtYNIK5VIS80lLr8qTRW2yNBx7wsxLLPT8aTqfML/QYdXOOYNFMlmaSDrHLpLVzz+Eepf+PQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916554; c=relaxed/simple;
	bh=RCEU+SPzcUGA1zcpyZgBCLYlfuElCOrCdvbtQNZwiSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBthx9sQNjcbU5+pS3j1s51/Yct1BeVL6f4flTmxbEFLWg3nZQPpU35fOwG6+J1M3P8gklfWDPloy1VcnU3jUlwoGHxI8sq7QrnpFYXES2kxjM6zOhaRUaP+SMjAKpMagTTIx8F3bGHEm2VPGp20VffIbUdtwxE3VKEnpO0gpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QieB6N03; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7f00fbe-a676-4d47-b1bb-cc69cc391172@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708916549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLnUgfVyZPSEL5gUBH6XVmm8mzZPojhGbh54ahAhp+E=;
	b=QieB6N03fX4o3UrEdw0KLjmTi+KZ/hp42DYy4cBVJUwDrvOyptjc6N7j9fdtYWU8fOsGKk
	9OJdwdWWtmhPe7yGQSi4CKIVc2o2eMfAM+ON4FxQqfypQzKhPNVFGHz/qJKwBS9QJRKuhx
	HeuY47+h63rcxxL/JcvmuvBh+9N29Z0=
Date: Mon, 26 Feb 2024 11:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] usb: isp1760: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: rui.silva@linaro.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
References: <20240224135256.830413-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224135256.830413-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:52, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  drivers/usb/isp1760/isp1760-hcd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
> index 76862ba40f35..0e5e4cb74c87 100644
> --- a/drivers/usb/isp1760/isp1760-hcd.c
> +++ b/drivers/usb/isp1760/isp1760-hcd.c
> @@ -2521,21 +2521,19 @@ static const struct hc_driver isp1760_hc_driver = {
>  int __init isp1760_init_kmem_once(void)
>  {
>  	urb_listitem_cachep = kmem_cache_create("isp1760_urb_listitem",
> -			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY |
> -			SLAB_MEM_SPREAD, NULL);
> +			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY, NULL);
>  
>  	if (!urb_listitem_cachep)
>  		return -ENOMEM;
>  
>  	qtd_cachep = kmem_cache_create("isp1760_qtd",
> -			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY |
> -			SLAB_MEM_SPREAD, NULL);
> +			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY, NULL);
>  
>  	if (!qtd_cachep)
>  		goto destroy_urb_listitem;
>  
>  	qh_cachep = kmem_cache_create("isp1760_qh", sizeof(struct isp1760_qh),
> -			0, SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
> +			0, SLAB_TEMPORARY, NULL);
>  
>  	if (!qh_cachep)
>  		goto destroy_qtd;

