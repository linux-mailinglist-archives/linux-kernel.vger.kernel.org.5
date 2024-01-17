Return-Path: <linux-kernel+bounces-28729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3164E83024E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430541C24C89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08314016;
	Wed, 17 Jan 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceF6A+5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308665CB0;
	Wed, 17 Jan 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483774; cv=none; b=tNVv7CFNdoBBH4lIp1AluejhdBVDVkAbsJqdcXq2bLmIzWHjmbmT9HIuIb/idVIKMbgkNDlP0svoPs7SaHwlmT7uUWFjnBMhW8wwbErdKuN6ly6F9vj1/ZKsX9cteQihDqteXFvXgsHAXV73O+D5R/mL3hxq0oOLL6j77CGjttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483774; c=relaxed/simple;
	bh=ezgzhxmzgqDVyuNbjOenp2QEaN5lS6ynx4hz58XBGfs=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=jfVnvPGlc6CjxTVnDeU1yzHVSAvF6D/ToyQR2XYL6g6W/sfK4zUmpWH/X9B8zRfzj6pblcjOyh7sA/UwoStJ/i7OSh/RgdrP3R9onIGQkaEGapkb6pnWO2asRl/+ND3wZLVrRHQMGmi2NFOiYJlORg3Hopvn8hUiXf8+zhLQCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceF6A+5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA534C433F1;
	Wed, 17 Jan 2024 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705483773;
	bh=ezgzhxmzgqDVyuNbjOenp2QEaN5lS6ynx4hz58XBGfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceF6A+5xa/2LS66d38fu+hdQrLWrlFhrsrTUfv7JPzA1muRn1y1ItHXhWYTvCZzRN
	 Diqs+zXxaATOjf430AhTAt3vnV9tR7FCAm6y19tCNedNomwjNkNHIv7mUbd7kBvJ8l
	 QNAV6LQFwX4L9XyoJ2DnuSh3sD04rg0xWSz8/sMs0VKohXULpBMDOMwaUM2ci5HMV1
	 P40IwKIgsR6vTp3dNKYcs6F9iVF36HmWCg74CXvmaRav3NoYNROadaaE4rkQl76Iri
	 CMxMM9UxaU2VbM8VFkJcAKuv4xyoXLApo5eQcFkMDWhVOnair8fxjMpd7a/y+WseqV
	 BhbqoFFUsOReQ==
Date: Wed, 17 Jan 2024 09:29:28 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipvs: Simplify the allocation of ip_vs_conn slab
 caches
Message-ID: <20240117092928.GA618956@kernel.org>
References: <20240117072045.142215-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117072045.142215-1-chentao@kylinos.cn>

On Wed, Jan 17, 2024 at 03:20:45PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Hi Kunwu Chan,

I think this is more of a cleanup than a fix,
so it should probably be targeted at 'nf-next' rather than 'net'.

If it is a fix, then I would suggest targeting it at 'nf'
and providing a Fixes tag.

The above notwithstanding, this looks good to me.

Acked-by: Simon Horman <horms@kernel.org>

> ---
>  net/netfilter/ipvs/ip_vs_conn.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index a743db073887..98d7dbe3d787 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1511,9 +1511,7 @@ int __init ip_vs_conn_init(void)
>  		return -ENOMEM;
>  
>  	/* Allocate ip_vs_conn slab cache */
> -	ip_vs_conn_cachep = kmem_cache_create("ip_vs_conn",
> -					      sizeof(struct ip_vs_conn), 0,
> -					      SLAB_HWCACHE_ALIGN, NULL);
> +	ip_vs_conn_cachep = KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
>  	if (!ip_vs_conn_cachep) {
>  		kvfree(ip_vs_conn_tab);
>  		return -ENOMEM;

