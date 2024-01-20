Return-Path: <linux-kernel+bounces-31713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26738332E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43351C21436
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BF1879;
	Sat, 20 Jan 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9DLcIbY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F517D4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705731476; cv=none; b=n6OujAoVG20Yz5vQ1QlRWDm3DdN+0oc2BHfVkYj6W3bxlMskYud0i5V+cONgSKz7fGZjypwRE/r43wZ2INIupmJzXIm+8dCI6BT96r8HlALk1AVewowRuEy0XyaOC1rmKlJM/F4k17qB1X8n1Pz6mE39AI+vW+4LI/weFT/FZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705731476; c=relaxed/simple;
	bh=2TIFv5bWl4QoJ8YY6nQXuOBcbB39LBIAHax5xsKVXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ44PTvaHXAHlOYd2lOOlkZj+ad5y/SGcnDkBC2xVSVXfiODb4KmF6bctpGNwEoOw3rmrhAGVPorr1pW9EC1iamjID7atFJffvDXEccEGvYS9CeDmU+zl5K6vq9f8mLAEdcTc5JttLHFSwcA9oy9JyUCz2TqsdIvhxYi/5/KaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9DLcIbY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705731473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KPagYGDCgd4YbmRF67JJPRGuQwCB9qdncajSxilqw6s=;
	b=M9DLcIbY1PDwXvA5f+Hh+SOWkhWMet76xQH5P8QuZT38yZPNa00AVCkwkayS5Raxg5N7t7
	N5hvB/rNyi6MHcvnTWYXxUEWlHfIZ1W5T59dbpePiu/8CvYGV11GZomM5OZ/NQkVCr83e9
	L0MuZrxStWzQUJC4EUQ7WBiEw286egc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-I_WqePedOoSQHcCvLPXnfg-1; Sat,
 20 Jan 2024 01:17:48 -0500
X-MC-Unique: I_WqePedOoSQHcCvLPXnfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD9422825BA5;
	Sat, 20 Jan 2024 06:17:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BCA58C0FDCA;
	Sat, 20 Jan 2024 06:17:42 +0000 (UTC)
Date: Sat, 20 Jan 2024 14:17:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>, ming.lei@redhat.com
Subject: Re: [PATCH 4/9] lib/group_cpus: optimize outer loop in
 grp_spread_init_one()
Message-ID: <ZatlggW/8SH6od9O@fedora>
References: <20240120025053.684838-1-yury.norov@gmail.com>
 <20240120025053.684838-5-yury.norov@gmail.com>
 <ZatDXvhvt0mLTi2m@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZatDXvhvt0mLTi2m@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Sat, Jan 20, 2024 at 11:51:58AM +0800, Ming Lei wrote:
> On Fri, Jan 19, 2024 at 06:50:48PM -0800, Yury Norov wrote:
> > Similarly to the inner loop, in the outer loop we can use for_each_cpu()
> > macro, and skip CPUs that have been moved.
> > 
> > With this patch, the function becomes O(1), despite that it's a
> > double-loop.
> > 
> > While here, add a comment why we can't merge outer logic into the inner
> > loop.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/group_cpus.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> > index 0a8ac7cb1a5d..952aac9eaa81 100644
> > --- a/lib/group_cpus.c
> > +++ b/lib/group_cpus.c
> > @@ -17,16 +17,17 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  	const struct cpumask *siblmsk;
> >  	int cpu, sibl;
> >  
> > -	for ( ; cpus_per_grp > 0; ) {
> > -		cpu = cpumask_first(nmsk);
> > -
> > -		/* Should not happen, but I'm too lazy to think about it */
> > -		if (cpu >= nr_cpu_ids)
> > +	for_each_cpu(cpu, nmsk) {
> > +		if (cpus_per_grp-- == 0)
> >  			return;
> >  
> > +		/*
> > +		 * If a caller wants to spread IRQa on offline CPUs, we need to
> > +		 * take care of it explicitly because those offline CPUS are not
> > +		 * included in siblings cpumask.
> > +		 */
> >  		__cpumask_clear_cpu(cpu, nmsk);
> >  		__cpumask_set_cpu(cpu, irqmsk);
> > -		cpus_per_grp--;
> >  
> >  		/* If the cpu has siblings, use them first */
> >  		siblmsk = topology_sibling_cpumask(cpu);
> > @@ -38,6 +39,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> >  
> >  			__cpumask_clear_cpu(sibl, nmsk);
> >  			__cpumask_set_cpu(sibl, irqmsk);
> > +			cpu = sibl + 1;
> 
> It has been tricky enough to update condition variable of for_each_cpu()
> (such kind of pattern can't build in Rust at all), and the above line could
> be more tricky actually.

Not only the above line is tricky, but also it is wrong, because 'cpu'
local variable should always point to the 1st bit in 'nmsk'. However, if
you set it to 'sibl + 1', some bits in 'nmsk' are skipped in the loop,
aren't they?


Thanks,
Ming


