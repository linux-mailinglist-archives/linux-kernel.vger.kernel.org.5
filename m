Return-Path: <linux-kernel+bounces-51576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90919848CB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D701C21941
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EC1B7F7;
	Sun,  4 Feb 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQgOHvon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23C1B597;
	Sun,  4 Feb 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041949; cv=none; b=q9OsZIzFEHmnVd4AJf+Ug5PFOoZFgOmpEnpz4ySqOD5bnFccjqYc9VJcy2I4CLNVZadGbQTVFMxRQwmYh14Bhk08f6f4+cUY30JB59btjcYAPr4O5ELDTH/HubHuEdtPbIw0Not9Pmkxe8euNTg+C9hyvg4Por7vvvCerZ/jN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041949; c=relaxed/simple;
	bh=+QVKIMfXxRR3UDPdfEy7+LD2ngsSXV9PfGI90MZVdm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCy2DrvlBB/k//v+zOJSsJtJo+2+BWz2CDWoQYvnVYc2ysSeTdpKm+wu/GZ68UiyyAgO2nlmrkbukkWvNDd5PEbOgts7uvUwRcsYw3pTr6MKKwUrQn91K+2m72fmEJKr+qq96OdYhQ5JtPO17zYvgfbzWPsNv/CvaVQhCB9jbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQgOHvon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E70C433C7;
	Sun,  4 Feb 2024 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707041948;
	bh=+QVKIMfXxRR3UDPdfEy7+LD2ngsSXV9PfGI90MZVdm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQgOHvonjUYF7WDtiCyKLIICm5Mfzv7t0SLZaE33RF8ih3MVMA0wVWGYzU0OL4T3Z
	 U00S7WzSCew/WAguzKK/0kAc2l+C0DqVh3n5Luk9tz74lf2w0DtvYv1cXSlC7ZOcqR
	 IfhYR1euMdX+BMCFvhTDdn7wvrMUYrVZhBKPVVYlBQj05PnL+RetoBPjvwn+0dpJa3
	 XBrjfU3V75qj0e5lSyJ/3x44nwcKNlBvK7Z5RwUDlhRXMEQvx4LFgRWFz4UT3mozTi
	 YvGg5llPIFppn2YVXOvW6sUWQ01FOenuU7dfHxjojJUueMnEs32bsvxk1FxTsm1rLb
	 Vow3KggUPXKuA==
Date: Sun, 4 Feb 2024 10:19:03 +0000
From: Simon Horman <horms@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 4/4] uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
Message-ID: <20240204101903.GA916983@kernel.org>
References: <20240201233400.3394996-1-cleech@redhat.com>
 <20240201233400.3394996-5-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201233400.3394996-5-cleech@redhat.com>

On Thu, Feb 01, 2024 at 03:34:00PM -0800, Chris Leech wrote:
> Conversion of this driver to use UIO_MEM_DMA_COHERENT for
> dma_alloc_coherent memory instead of UIO_MEM_PHYS.
> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>  drivers/uio/uio_dmem_genirq.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c

..

> @@ -264,7 +257,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
>  					" dynamic and fixed memory regions.\n");
>  			break;
>  		}
> -		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->memtype = UIO_MEM_DMA_COHERENT;
> +		uiomem->dma_device = &pdev->dev,

Hi Chris,

a nit from my side.

Probably the ',' would be better written as a ';' here.
I don't think this is a bug, but using comma like this is
somewhat unexpected and confusing.

Flagged by clang-17 with -Wcomma


>  		uiomem->addr = DMEM_MAP_ERROR;
>  		uiomem->size = pdata->dynamic_region_sizes[i];
>  		++uiomem;
> -- 
> 2.43.0
> 
> 

