Return-Path: <linux-kernel+bounces-49531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD52846B86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F184E1F2A20F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECA76902;
	Fri,  2 Feb 2024 09:05:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991766087A;
	Fri,  2 Feb 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864751; cv=none; b=BO/lOa15XpwKGcuxUUOCrR4RJ34oOC7ZAcEUPvPNNlZR8zkmnwe3QtT4kQinKQZI2snAbiMESlhMukmL5bSFp2MsM4eBCqI+vhXYPD3KYqgwvajPoZZJWiAjegOyE966NAmmirEzpvVG73A7Yb6J4AvJFetI+8KFE9fwO0lMuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864751; c=relaxed/simple;
	bh=IKxvwNSUt3agfDzeeYKFG24bjgt9QnYU/2DpLutNLhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1MRGygqHam3URTJ0CqPtOrtnW7YYFH1CcL6LELr3jBc2zFgQ/3sNE3Q6SopyNuo6ppAa2tvfPWVMTNEnoUIhWQDO1mesJJgQJXr4Orai8tQ/VkqS2pJoiZdCWDPj2PAqsxlWs5hkz165lsWXkOUzIpoGv/d3RXhH9TN45va7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9EADA7;
	Fri,  2 Feb 2024 01:06:30 -0800 (PST)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658B93F5A1;
	Fri,  2 Feb 2024 01:05:42 -0800 (PST)
Date: Fri, 2 Feb 2024 10:05:05 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm,
	will@kernel.org, catalin.marinas@arm.com, viresh.kumar@linaro.org,
	ionela.voinescu@arm.com, yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Message-ID: <ZbywQfY7J5DbF1Ev@e129154.nice.arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com>
 <CAJZ5v0jh3mG3hyFS6war=0bk3PvsVtTwZ1_YwwWov36Bmz7q0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jh3mG3hyFS6war=0bk3PvsVtTwZ1_YwwWov36Bmz7q0w@mail.gmail.com>

Apologies for extremely late reply, juggling too many things at time ....

On Wed, Dec 06, 2023 at 09:41:05PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 27, 2023 at 5:09 PM Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > From: Sumit Gupta <sumitg@nvidia.com>
> >
> > When available, use arch_freq_get_on_cpu to obtain current frequency
> > (usually an average reported over given period of time)
> > to better align the cpufreq's view on the current state of affairs.
> 
> And why is this a good idea?
Apart from being problematic with an issue pointed at [1] (which will result
in dropping the change in cpufreq) this was to keep the cpufreq core aware of
potential frequency changes and take appropriate action (informing the governor)
case it got out of sync.
> 
> Any problem statement?
The problem has been raised here [2]
> 
> > This also automatically pulls in the update for cpuinfo_cur_freq sysfs
> > attribute, aligning it with the scaling_cur_freq one, and thus providing
> > consistent view on relevant platforms.
> 
> I have no idea what the above is supposed to mean, sorry.
Bad wording I guess. With this change both 'cpuinfo_cur_freq' and
'scaling_cur_freq' will use the arch_freq_get_on_cpu if available, and will use
the same source of information (one depending on a platform).

> 
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > [BM: Subject & commit msg]
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 8c4f9c2f9c44..109559438f45 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> >  {
> >         unsigned int new_freq;
> >
> > -       new_freq = cpufreq_driver->get(policy->cpu);
> > +       new_freq = arch_freq_get_on_cpu(policy->cpu);
> > +       new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
> 
> Please don't use ?: in general and it is not even useful here AFAICS.
> 
> What would be wrong with
> 
> new_freq = arch_freq_get_on_cpu(policy->cpu);
> if (!new_freq)
>         new_freq = cpufreq_driver->get(policy->cpu);
> 
> ?
Nothing wrong with that.

---
[1] https://lore.kernel.org/all/ZWXy0h%2FfFfQh+Rhy@arm.com/
[2] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
---
BR
Beata
> 
> >         if (!new_freq)
> >                 return 0;
> >
> > --

