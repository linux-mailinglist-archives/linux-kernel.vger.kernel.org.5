Return-Path: <linux-kernel+bounces-136852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342E89D904
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD881C21444
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC412C531;
	Tue,  9 Apr 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u902tTqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B880043;
	Tue,  9 Apr 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664877; cv=none; b=MrNwF+ZXKV1ecYaBDNKY9C4pSzdBcy7EwNBh4ldRQsl6V1fi/cZcff2H8nCQOZWrShxE9vvmsJ+ihJ+/uJHQu2o72RUXQXd0x7iTmb7FSfwc+IMcWkziQ7gVoX07/QLGv/TQmZo4YcIukgyXzYFM91Nt6wvr5QngPfmQ5KMIhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664877; c=relaxed/simple;
	bh=b6JwoQx9iqUWXaUmbAB3ya+MdSagj6m7QwNqt/Lxn+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y03JYXo46y0M8bPpxJLBA2J0lcByBD2ilaBQPD4PGMd3dxJlOuKB1nbui8jg42Le4qNwgg0HTm7XPzUlZc6HLr7GBvyb/YNYY/2Iblu9IfRVT337H3iOo1TL84QpLRGhiBQ1cL5UJt2A5hJq9YcyDFH5jW2ybIPL0R3HSGQ2j38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u902tTqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDB2C43390;
	Tue,  9 Apr 2024 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712664877;
	bh=b6JwoQx9iqUWXaUmbAB3ya+MdSagj6m7QwNqt/Lxn+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u902tTqa9EOdqFofkXIH03QWbKFlfzdl79ctoI6PXU2cx/k7Vw+be+EmYpYeTUrUt
	 ccjnEo8OLYsrdcWQCASKWCOdiddtPXPYptPTRTmYncwtUObdct1DS/WtYd7v7utmQa
	 anctvW8YG0B3/n3nD5YB/4lWA+In/P+Rtb/85p0k=
Date: Tue, 9 Apr 2024 14:14:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal FONTAIN <Pascal.FONTAIN@bachmann.info>
Cc: linux-kernel@vger.kernel.org, Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	afd@ti.com, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 2/2] misc: sram: Add DMA-BUF Heap exporting of SRAM
 areas
Message-ID: <2024040944-flashcard-tribune-6a8e@gregkh>
References: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
 <20240409120605.4138472-3-Pascal.FONTAIN@bachmann.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409120605.4138472-3-Pascal.FONTAIN@bachmann.info>

On Tue, Apr 09, 2024 at 02:06:05PM +0200, Pascal FONTAIN wrote:
> From: Andrew Davis <afd@ti.com>
> 
> This new export type exposes to userspace the SRAM area as a DMA-BUF
> Heap,
> this allows for allocations of DMA-BUFs that can be consumed by various
> DMA-BUF supporting devices.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Tested-by: Pascal Fontain <pascal.fontain@bachmann.info>

When sending on a patch from someone else, you too must sign off on it
as per our documenation.  Please read it and understand what you are
agreeing to when you do that for a new version please.

> ---
>  drivers/misc/Kconfig         |   7 +
>  drivers/misc/Makefile        |   1 +
>  drivers/misc/sram-dma-heap.c | 246 +++++++++++++++++++++++++++++++++++
>  drivers/misc/sram.c          |   6 +
>  drivers/misc/sram.h          |  16 +++
>  5 files changed, 276 insertions(+)
>  create mode 100644 drivers/misc/sram-dma-heap.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9e4ad4d61f06..e6674e913168 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -448,6 +448,13 @@ config SRAM
>  config SRAM_EXEC
>  	bool
>  
> +config SRAM_DMA_HEAP
> +	bool "Export on-chip SRAM pools using DMA-Heaps"
> +	depends on DMABUF_HEAPS && SRAM
> +	help
> +	  This driver allows the export of on-chip SRAM marked as both pool
> +	  and exportable to userspace using the DMA-Heaps interface.

What will use this in userspace?

thanks,

greg k-h

