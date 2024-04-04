Return-Path: <linux-kernel+bounces-131515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECED8988EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582E5289FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3306212883C;
	Thu,  4 Apr 2024 13:37:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD65128362;
	Thu,  4 Apr 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237860; cv=none; b=kBiOSWJlKv4UFBttlHMvuPyzvIIHXY75IgigWIG/sihzCQjD1SVQKlsXV6REc4BXHYDebYCljJqN9NURa543A+CBFQFP1IUor/KpgZElWKmL7G8wgVDnTMgMCTojmYif46YHJiNncwdb8qrCZGfUhw9Imu2YEsFOOpZW9H7ZYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237860; c=relaxed/simple;
	bh=Mq8V4G+8NbZSQZrJJKuG0zWVsG03i73wOl1e9e2mO3Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQ8KKzGzpPNM7AHbP7r2alPD3jEcqwaPSSYHq2+nUkjzgJfsKaOLaubnXEXhH5p7c+NGC9VSfNJcdO4MtHCgYXbDgwlHrokb08aLtyyvnEOxp5aQMCGAJaagbQ5bqeW+izIx6r2RJUZbZ2QyV3RmE31VqjpbJ6V1fOVc718wwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Mxg3Zsyz6J7DR;
	Thu,  4 Apr 2024 21:32:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AFE8F1400DC;
	Thu,  4 Apr 2024 21:37:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:37:33 +0100
Date: Thu, 4 Apr 2024 14:37:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linux Memory
 Management List" <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang"
	<horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	<qemu-devel@nongnu.org>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v10 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Message-ID: <20240404143733.00004594@Huawei.com>
In-Reply-To: <CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com>
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
	<20240402001739.2521623-3-horenchuang@bytedance.com>
	<20240403180425.00003be0@Huawei.com>
	<CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

<snip>

> > > @@ -858,7 +910,8 @@ static int __init memory_tier_init(void)
> > >        * For now we can have 4 faster memory tiers with smaller adistance
> > >        * than default DRAM tier.
> > >        */
> > > -     default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > > +     default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
> > > +                                                                     &default_memory_types);  
> >
> > Unusual indenting.  Align with just after (
> >  
> 
> Aligning with "(" will exceed 100 columns. Would that be acceptable?
I think we are talking cross purposes.

	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
						      &default_memory_types);  

Is what I was suggesting.

> 
> > >       if (IS_ERR(default_dram_type))
> > >               panic("%s() failed to allocate default DRAM tier\n", __func__);
> > >
> > > @@ -868,6 +921,14 @@ static int __init memory_tier_init(void)
> > >        * types assigned.
> > >        */
> > >       for_each_node_state(node, N_MEMORY) {
> > > +             if (!node_state(node, N_CPU))
> > > +                     /*
> > > +                      * Defer memory tier initialization on CPUless numa nodes.
> > > +                      * These will be initialized after firmware and devices are  
> >
> > I think this wraps at just over 80 chars.  Seems silly to wrap so tightly and not
> > quite fit under 80. (this is about 83 chars.
> >  
> 
> I can fix this.
> I have a question. From my patch, this is <80 chars. However,
> in an email, this is >80 chars. Does that mean we need to
> count the number of chars in an email, not in a patch? Or if I
> missed something? like vim configuration or?

3 tabs + 1 space + the text from * (58)
= 24 + 1 + 58 = 83

Advantage of using claws email for kernel stuff is it has a nice per character
ruler at the top of the window.

I wonder if you have a different tab indent size?  The kernel uses 8
characters.  It might explain the few other odd indents if perhaps
you have it at 4 in your editor?

https://www.kernel.org/doc/html/v4.10/process/coding-style.html

Jonathan

> 
> > > +                      * initialized.
> > > +                      */
> > > +                     continue;
> > > +
> > >               memtier = set_node_memory_tier(node);
> > >               if (IS_ERR(memtier))
> > >                       /*  
> >  
> 
> 


