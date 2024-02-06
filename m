Return-Path: <linux-kernel+bounces-54591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96A84B14A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38EC3B240FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327C12D777;
	Tue,  6 Feb 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JP2eRrv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE412D165;
	Tue,  6 Feb 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211825; cv=none; b=hYGioQt/Mq9SsfupfkkogH2p0pHQSmDuEbKTiYOOuoyWrIMHPs7IKNgPLMmwLkiHtwzPdmY9uv+YBRQiIIeEOGGx91taByhyiyTrNbnIZHZQEKjhujQonpAA+dcuhsqNG3huasQH37bKdCZSoSL0uy8ugo/caEiROS2jygHm8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211825; c=relaxed/simple;
	bh=qWfeTTeoBr9rdFyPV0/HnKFKUfJuboySmGfliyMAN5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwFGd52tDLy74zLl1GDkOBJgFGIyhWV/iD+yIcA4ydDBpqry66/T+xc8+kvQiNR71cWh12rC4XCYOEo0GPQhu8sq2DHBXlTsHjlZbwr+AaX+bLGbCNRBzvpGVdfNAG8wegtNcgjZpfP6udRqQ5oe2Y1fqUaG8zQHlcWgERU/pTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JP2eRrv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34263C43399;
	Tue,  6 Feb 2024 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707211824;
	bh=qWfeTTeoBr9rdFyPV0/HnKFKUfJuboySmGfliyMAN5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JP2eRrv27P+yVwGdvNeOV136R0Nxxg5THl2E57UM0HnyihU+2ZJHbf00shnK8sp00
	 LKLy8sFh3kuhSFkm1n3NTG+HaIX6MpyjjryeWVroXZVvr9i4nWqbjiGn0SiH5brmSX
	 ryeOz++PE86+bqiZnN9a79M8HB2frumgS6vuUZeI=
Date: Tue, 6 Feb 2024 09:30:21 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Message-ID: <2024020647-submarine-lucid-ea7b@gregkh>
References: <20240206042408.224138-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206042408.224138-1-joychakr@google.com>

On Tue, Feb 06, 2024 at 04:24:08AM +0000, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects an integer error
> as a return value but rmem_read() returns the number of bytes read, as a
> result error checks in nvmem core fail even when they shouldn't.
> 
> Return 0 on success where number of bytes read match the number of bytes
> requested and a negative error -EINVAL on all other cases.
> 
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/nvmem/rmem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> index 752d0bf4445e..a74dfa279ff4 100644
> --- a/drivers/nvmem/rmem.c
> +++ b/drivers/nvmem/rmem.c
> @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
>  
>  	memunmap(addr);
>  
> -	return count;
> +	if (count != bytes) {
> +		dev_err(priv->dev, "Failed read memory (%d)\n", count);
> +		return -EINVAL;

Why is a "short read" somehow illegal here?  What internal changes need
to be made now that this has changed?

And what will userspace do with this error message in the kernel log?

thanks,

greg k-h

