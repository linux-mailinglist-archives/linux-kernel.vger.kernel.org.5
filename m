Return-Path: <linux-kernel+bounces-102653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8987B55E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9ECF1C20F07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9245D74E;
	Wed, 13 Mar 2024 23:50:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E25336D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373840; cv=none; b=GG/qTN82VW+Vsn7XwQFRtiJKy4+U55tJ1N5qrdGa7naekFkB21C7ZGgnVJYCMwJtUlBEB26hO8ByvbBgweqFfWUg8gnKiA+2HwaNJwxGeOJ/LYufvdN2+aZ2c/pv7/mUdmMGf0YXXjS0eTWQDxlHbH63elphNbJgztOz8S2X2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373840; c=relaxed/simple;
	bh=ByyhjiMnk2+hZUiI7OFtRvQm1bF5Rd89kOoggsgFmp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaibxuKc509wJiqng5A5CnuJfgZe93UzSZf1YswVKoCv1X/QG4803jOtdCdR7Aa0stscHbv0YIdJ19yl8paMxrhKmbk388yvZsCkJbOwgDsqveYEHRG718P2CNgL04tmRih3njH4t+ON5FPnkz9TLkHeAnRRLmTvEbcR2YsnClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A142C1007;
	Wed, 13 Mar 2024 16:51:14 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ACF03F73F;
	Wed, 13 Mar 2024 16:50:34 -0700 (PDT)
Date: Thu, 14 Mar 2024 00:49:57 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	vanshikonda@os.amperecomputing.com, sudeep.holla@arm.com,
	will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com
Subject: Re: [PATCH v3 0/3] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <ZfI7pQtXgXAG7RBH@arm.com>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <ZfGbyfBl35cyACAc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfGbyfBl35cyACAc@arm.com>

On Wed, Mar 13, 2024 at 12:27:53PM +0000, Ionela Voinescu wrote:
> Hey,
> 
> On Tuesday 12 Mar 2024 at 08:34:28 (+0000), Beata Michalska wrote:
> > Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
> > existing implementation for FIE and AMUv1 support: the frequency scale
> > factor, updated on each sched tick, serves as a base for retrieving
> > the frequency for a given CPU, representing an average frequency
> > reported between the ticks - thus its accuracy is limited.
> > 
> > The changes have been rather lightly (due to some limitations) tested on
> > an FVP model.
> > 
> > Relevant discussions:
> > [1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
> > [2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
> > [3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
> > [4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c
> > 
> > v3:
> > - dropping changes to cpufreq_verify_current_freq
> > - pulling in changes from Ionela initializing capacity_freq_ref to 0
> >   (thanks for that!)  and applying suggestions made by her during last review:
> > 	- switching to arch_scale_freq_capacity and arch_scale_freq_ref when
> > 	  reversing freq scale factor computation
> > 	- swapping shift with multiplication
> > - adding time limit for considering last scale update as valid
> > - updating frequency scale factor upon entering idle
> > 
> > v2:
> > - Splitting the patches
> > - Adding comment for full dyntick mode
> > - Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
> >   of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
> >   with potential freq changes
> > 
> > Beata Michalska (2):
> >   arm64: Provide an AMU-based version of arch_freq_get_on_cpu
> >   arm64: Update AMU-based frequency scale factor on entering idle
> > 
> > Ionela Voinescu (1):
> >   arch_topology: init capacity_freq_ref to 0
> > 
> 
> Should there have been a patch that adds a call to
> arch_freq_get_on_cpu() from show_cpuinfo_cur_freq() as well?
> 
> My understanding from this [1] thread and others referenced there is
> that was something we wanted.
>
Right, so I must have missunderstood that, as the way I did read it was that
it is acceptable to keep things as they are wrt cpufreq sysfs entries.

---
BR
Beata
> [1] https://lore.kernel.org/lkml/2cfbc633-1e94-d741-2337-e1b0cf48b81b@nvidia.com/
> 
> Thanks,
> Ionela.
> 
> 
> >  arch/arm64/kernel/topology.c | 116 +++++++++++++++++++++++++++++++----
> >  drivers/base/arch_topology.c |   8 ++-
> >  2 files changed, 110 insertions(+), 14 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 

