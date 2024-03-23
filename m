Return-Path: <linux-kernel+bounces-112395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68455887945
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B081C20D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A946521;
	Sat, 23 Mar 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/V7UzWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999B41C7F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208171; cv=none; b=lhWCaCvaO1fX89FYve11B1E+P2FxS3/tL9oIBQyRm9cXyAkVFIMH1XkC+Q07ud4pzzQpey0vH/VM4UdJ1yaKh4xTx1eu0xlmYmYPmRRNn2cRAxckUhVOqCFp+9faPf276JD/2cQloK1zE97SD0RnO3VCxVfjxSwP0d48C5CYBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208171; c=relaxed/simple;
	bh=SG/1XtC/pGMwmgY0NE0DCGtX2DJa4C4qd44oIXn2Ojg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOmguBnIxzGkLeAwXm3zgZXxq63cEnsG2mhGZ5A5xCtoGSRDmnm1Km7iWhVoGwY61GnHaBbjYNcPuUsgfMFuo8W7etKGxdF7+DaRE+KCfld7fFJ8xG5Dphp7N7Ra/gjNBrJpC79gCEp+K5KSH0hQJgJSjdt1OqtQAWF0byAEXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/V7UzWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB6C433C7;
	Sat, 23 Mar 2024 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711208171;
	bh=SG/1XtC/pGMwmgY0NE0DCGtX2DJa4C4qd44oIXn2Ojg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/V7UzWHU93gCYpTEKXbUyeNu/j1TaMxnShAuGw/RYq4x2IJ8tXx9ydsEWxH+FqgC
	 pjl/SrnHKgk15M6eTsxDRGHKMGZ3JkG9kcidj4Xix8G45a+VIxM+qX6RqkBamTOUae
	 zkVZtBFbN191E0w5Kibl3AXpaB13EkdfWWp5eUq8=
Date: Sat, 23 Mar 2024 16:36:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 1/3] uio_dmem_genirq: Fix build failure on 32 bit builds
 with 64 bit physaddr
Message-ID: <2024032353-taekwondo-gigolo-6427@gregkh>
References: <20240323144228.3924542-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323144228.3924542-1-linux@roeck-us.net>

On Sat, Mar 23, 2024 at 07:42:26AM -0700, Guenter Roeck wrote:
> Builds on 32-bit systems with 64 bit physical address fail with
> 
> drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
> drivers/uio/uio_dmem_genirq.c:63:39: error:
> 	cast from pointer to integer of different size
> 
> drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
> drivers/uio/uio_dmem_genirq.c:92:43: error:
> 	cast to pointer from integer of different size
> 
> The conversion itself is safe since sizeof(phys_addr_t) it in general equal
> to or larger than sizeof(void *). Solve the problem by double-casting the
> conversion.
> 
> Fixes: 019947805a8d ("uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion")
> Cc: Chris Leech <cleech@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/uio/uio_dmem_genirq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for these, Chris, any objection to me queueing them up?

greg k-h

