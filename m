Return-Path: <linux-kernel+bounces-31305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519AA832C37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8441E1C2397B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB754BC7;
	Fri, 19 Jan 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlRVPNUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E15467F;
	Fri, 19 Jan 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677646; cv=none; b=lVb4bSiYQWjr/OIoex9zOdsw8rfIhyMX/4VWg3RWTLUQPIBg1rVRZXT6NaKs3eQ1NU4n2Bjc0eyM7/EPb4h9246S0PLpDEkYyGyMGB5xeSHxbAHMVbLJLvQis4nJ58907z3igQL2W1l3oGd1YzjgFWAZf92xZilYBB7SBScuQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677646; c=relaxed/simple;
	bh=re6v2gZ3PsRR4/YOQTnhxuBDuntEkGevLBRe7TtKQsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzogPlAYgHnvd4T3XQS4EwFD8uI9RI3HC82hIw3aeGAwRHPpaZ5rZIn/CCbXgqQjQ22ONf3pzREndT2Y3P5WzUkT5yC7VFIUbmFtsrvSe2SGNJ6qdS2mnGO5eKDw/7ZaWrxTv7/QUZtPJFyh4xh1jUk5w/xpkIlbge1FmEToQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlRVPNUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29169C433C7;
	Fri, 19 Jan 2024 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705677646;
	bh=re6v2gZ3PsRR4/YOQTnhxuBDuntEkGevLBRe7TtKQsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlRVPNUuRshsLP0Y0r9ERCdEm3tonAsL+BoS6ecOTwBwHaZbO2sDgx0A/QLwuzo7i
	 FFoSa8EruAEaSCEu56ZB8NVFpNQ3sqJzslf96K4f38Me453dBGo3mOZ/ci2kQ11Ydj
	 kBo5ru4LCHYCu9RZXeuPTniOpDIQsYSJbDAReL+lXVG7CYMqMtyCgAwXa0juCWj8nL
	 k7uNBzPw/tcWsEH3sHEuLE2/qkHN+5CvAhkufZnM+m7vS30xkO++zcT5J1Bat0eSnp
	 MJNxBJrEr+Tyl2hmNt3dAt7ABo8jdTjdSqPZTOxsca56lVmy7LTRIlWbHRJI8MhGrF
	 lMllTjMkS+Icw==
Date: Fri, 19 Jan 2024 15:20:39 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipvs: Simplify the allocation of ip_vs_conn slab
 caches
Message-ID: <20240119152039.GC89683@kernel.org>
References: <20240117072045.142215-1-chentao@kylinos.cn>
 <20240117092928.GA618956@kernel.org>
 <ba5b4e70-365f-476a-9969-6f9a891221a7@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5b4e70-365f-476a-9969-6f9a891221a7@kylinos.cn>

On Thu, Jan 18, 2024 at 10:22:05AM +0800, Kunwu Chan wrote:
> Hi Simon,
> 
> Thanks for your reply.
> 
> On 2024/1/17 17:29, Simon Horman wrote:
> > On Wed, Jan 17, 2024 at 03:20:45PM +0800, Kunwu Chan wrote:
> > > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> > > to simplify the creation of SLAB caches.
> > > 
> > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > 
> > Hi Kunwu Chan,
> > 
> > I think this is more of a cleanup than a fix,
> > so it should probably be targeted at 'nf-next' rather than 'net'.
> Thanks, I'm confused about when to use "nf-next" or "net" or "net-next".
> "nf-next" means fixing errors for linux-next.git and linux-stable.git, while
> "nf" or "next" just means linux-next.git?

Hi Kunwu,

nf is for fixes for Netfilter (which includes IPVS). The target tree is nf.git
nf-next is for non-fixes for Netfilter. The target tree if nf-next.git

net is for fixes for Networking code, which does not have a more specific
tree (as is the case for Netfilter). The target tree is net.git.
Liikewise, net-next is for non-fixes for Networking code.
The target tree is net-next.git

The MAINTAINERS file, and get_maintainers.pl script are useful here.

nf is merged into net on request from the Netfilter maintainers,
this is it's path to released kernels.
Likewise, nf-next is merged into net-next.

> 
> > 
> > If it is a fix, then I would suggest targeting it at 'nf'
> > and providing a Fixes tag.
> I'll keep it in mind in the future.
> > 
> > The above notwithstanding, this looks good to me.
> > 
> > Acked-by: Simon Horman <horms@kernel.org>
> > 
> > > ---
> > >   net/netfilter/ipvs/ip_vs_conn.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> > > index a743db073887..98d7dbe3d787 100644
> > > --- a/net/netfilter/ipvs/ip_vs_conn.c
> > > +++ b/net/netfilter/ipvs/ip_vs_conn.c
> > > @@ -1511,9 +1511,7 @@ int __init ip_vs_conn_init(void)
> > >   		return -ENOMEM;
> > >   	/* Allocate ip_vs_conn slab cache */
> > > -	ip_vs_conn_cachep = kmem_cache_create("ip_vs_conn",
> > > -					      sizeof(struct ip_vs_conn), 0,
> > > -					      SLAB_HWCACHE_ALIGN, NULL);
> > > +	ip_vs_conn_cachep = KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
> > >   	if (!ip_vs_conn_cachep) {
> > >   		kvfree(ip_vs_conn_tab);
> > >   		return -ENOMEM;
> -- 
> Thanks,
>   Kunwu
> 

