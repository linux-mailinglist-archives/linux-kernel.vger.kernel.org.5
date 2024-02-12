Return-Path: <linux-kernel+bounces-62538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E03852288
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B4FB24A89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E950248;
	Mon, 12 Feb 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUhjCLey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BB4F888
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780544; cv=none; b=R1wqbhz1CWjAcoQ3uC9foBlymWizQ4aHruqk12V00sQQTahIRdKXDljzTB3NZLJvSyD86Lnwwwrqbg+G6yko9N40+At9N5LMrY0yIe5/IG//CB/RzqtvfxJ3xSUkLOovTjpFkeVNDE0ivGtZ0VLfC31Igsu0otOywrvbzD1+lPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780544; c=relaxed/simple;
	bh=OZmWRyAZ96aIiqGUnApBj9/GzU1LECVikVIx9OJtviQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jx4yQGxpVFP4zYg7t8HH3Lwk7bqwlFJhN2VxqI27Abt3z4mrwzcHUU/oUia1l/BTBRU9dM53G2WWwLxS20plvCCQYvHSwUd/okGWHk7xaMukCjrhG02TYPVgDH90O1MrgJbC1LKNncyembqq1xAJm0P146a90xs48rJwqGx0NVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUhjCLey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FCC433F1;
	Mon, 12 Feb 2024 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780543;
	bh=OZmWRyAZ96aIiqGUnApBj9/GzU1LECVikVIx9OJtviQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sUhjCLeyJQSC+hYpQL8kqbT2BVhPqwCcgcfsMisIAG+uQqimRkMNRF9PL9cfIRKWh
	 yRUbEFI3XOWQKFB1UR0dJ93ghozW/fXhgrK30ChKeAve0qshx7Wc1y+sXH7Ay3TZnO
	 wkgJg07KcZaPhuYqRXw7wJrwi4jp95t7xecibBbo8B8ZPlhcnJ68jwo9iuOql/9IrY
	 EopbupN+xxGkeFL29wrjUI15kTwGaCaygI4nAdrKVLMaTQVfdOsNmov+B3+ehDu+Im
	 iQIqRFZP5eT+ZBuUJjvfoMHuqhyiGdZ78Uza/0kXjFxS7X1f6EzKp7sLoDlhMyjDst
	 ncPa8BgzLi+mQ==
Date: Mon, 12 Feb 2024 15:29:00 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Daniil Dulov <d.dulov@aladdin.ru>
cc: Juergen Gross <jgross@suse.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, 
    xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org, 
    linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] swiotlb-xen: remove redundant NULL check
In-Reply-To: <20240211150958.4112-1-d.dulov@aladdin.ru>
Message-ID: <alpine.DEB.2.22.394.2402121528340.1925432@ubuntu-linux-20-04-desktop>
References: <20240211150958.4112-1-d.dulov@aladdin.ru>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Daniil,

Against which Linux branch was this patch generated?

Cheers,

Stefano


On Sun, 11 Feb 2024, Daniil Dulov wrote:
> In this case hwdev cannot be NULL, so remove redundant NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b097186fd29d ("swiotlb-xen: SWIOTLB library for Xen PV guest with PCI passthrough.")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/xen/swiotlb-xen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2b385c1b4a99..b166f6efea26 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -305,7 +305,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  	if (!ret)
>  		return ret;
>  
> -	if (hwdev && hwdev->coherent_dma_mask)
> +	if (hwdev->coherent_dma_mask)
>  		dma_mask = hwdev->coherent_dma_mask;
>  
>  	/* At this point dma_handle is the dma address, next we are
> -- 
> 2.25.1
> 

