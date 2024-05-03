Return-Path: <linux-kernel+bounces-167660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954818BACE3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE062B2166E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A0153830;
	Fri,  3 May 2024 12:55:37 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA178495;
	Fri,  3 May 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740936; cv=none; b=SSCntnjlohLsjxTDPvW9TBsMjaRI8XZAzKpE5enygbMg0IVsKIsZWIh4/tX+VkD14k+UyUVNg8nUx9kjtN3toK4jUM6H1terFMjeI7CFsTq4Zky8n1aLavVACpHcvw+bjZmSZf3WTVcslx5DmCTfwZeC+o0kGyJxkYDaYyu0I0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740936; c=relaxed/simple;
	bh=wG/BogTJ+ZimBl+hudVlgHFBVb7YDPHljUyi3g3Cv8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN7CNSKMoQeHpLIAVhQzksBdb6BiFkylzD7YiWeZIYvM70lYq1ZbZHJelWQE+A9pC+0qikIGOmCA3mlFaGewLh6CvbeBvR1+FdjTVmemr9iT7ujVZKlGd6kijhoubuqgXXMOCQHuc/D95ZadF284Try/AlyOYQjYrbHuMoY3ATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1s2sRd-000316-00; Fri, 03 May 2024 14:55:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 09974C0135; Fri,  3 May 2024 14:50:27 +0200 (CEST)
Date: Fri, 3 May 2024 14:50:27 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Message-ID: <ZjTdk9wLGLI5iiDV@alpha.franken.de>
References: <20240416173711.613750-1-yury.norov@gmail.com>
 <20240416173711.613750-2-yury.norov@gmail.com>
 <Zh+uPB0druail4XC@alpha.franken.de>
 <Zibs96v+uK/2uFT8@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zibs96v+uK/2uFT8@yury-ThinkPad>

On Mon, Apr 22, 2024 at 04:04:23PM -0700, Yury Norov wrote:
> On Wed, Apr 17, 2024 at 01:10:52PM +0200, Thomas Bogendoerfer wrote:
> > On Tue, Apr 16, 2024 at 10:37:10AM -0700, Yury Norov wrote:
> > > The function sets adjusted groups of bits in hub_irq_map by using
> > > for-loops. There's a bitmap_set() function dedicated to do this.
> > > 
> > > Because [0, CPU_CALL_B_IRQ] and [NI_BRDCAST_ERR_A, MSC_PANIC_INTR]
> > > ranges belong to the same machine word, bitmap_set() would boil down
> > > to an inline wrapper in both cases, avoiding generating a loop, with
> > > the associate overhead. Effectively, it would be a compile-time:
> > > 
> > > 	*hub_irq_map = GENMASK() | GENMASK();
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  arch/mips/sgi-ip27/ip27-irq.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> > > index 8f5299b269e7..d8acdf0439d2 100644
> > > --- a/arch/mips/sgi-ip27/ip27-irq.c
> > > +++ b/arch/mips/sgi-ip27/ip27-irq.c
> > > @@ -277,7 +277,6 @@ void __init arch_init_irq(void)
> > >  {
> > >  	struct irq_domain *domain;
> > >  	struct fwnode_handle *fn;
> > > -	int i;
> > 
> > I've already applied your first version, so I need an incremental
> > patch, which just removes the unused variable.
> 
> Sure, please find below.
> 
> >From ce447fe69092c48bb59a6c4cb08ee5f9080f0ad6 Mon Sep 17 00:00:00 2001
> From: Yury Norov <yury.norov@gmail.com>
> Date: Mon, 22 Apr 2024 15:52:12 -0700
> Subject: [PATCH] MIPS: SGI-IP27: fix -Wunused-variable in arch_init_irq()
> 
> Commit 40e20fbccfb722f21 (MIPS: SGI-IP27: micro-optimize arch_init_irq())
> replaced a for-loop iteration with bitmap_set() calls, but didn't remove
> an iteration variable.
> 
> Fixes: 40e20fbccfb722f21 (MIPS: SGI-IP27: micro-optimize arch_init_irq())
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404161933.izfqZ32k-lkp@intel.com/
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/sgi-ip27/ip27-irq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> index dcb14a234b1c..d8acdf0439d2 100644
> --- a/arch/mips/sgi-ip27/ip27-irq.c
> +++ b/arch/mips/sgi-ip27/ip27-irq.c
> @@ -277,7 +277,6 @@ void __init arch_init_irq(void)
>  {
>  	struct irq_domain *domain;
>  	struct fwnode_handle *fn;
> -	int i;
>  
>  	mips_cpu_irq_init();
>  
> -- 
> 2.40.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

