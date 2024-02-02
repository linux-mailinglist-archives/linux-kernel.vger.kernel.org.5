Return-Path: <linux-kernel+bounces-49541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C19846BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181361C271A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF107763B;
	Fri,  2 Feb 2024 09:15:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0CF50D;
	Fri,  2 Feb 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865333; cv=none; b=OhiT/jWZRszckjY/DgIgbhPdk6AJgBlK/SuhOcw7eXx/Z7VMl2DcnMOr7106m/uLsyKsjUCMiwkfxI20ZBO8V2fzbgLQ17QJfBO8RhYVoBhGrs4ukOYHip4PutubXN/uixB2imEi+ZJLZQuDqKgTpSijJ5h4RqV7KUXjusdeKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865333; c=relaxed/simple;
	bh=nOB2zNCHmxLdT4OymTGgdgqRYFwfwOcpl02fc6ZMVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq/kqRvOHzGUxM+hmuCPp9lzwemkdhE++jYvASkQIJ+5CiQVd/1y8Zovn22LEZKmP7l2WhbW/jF/VtOM05dAJM7JLlYwfcKUACiXIT1XDKDB4lWUVyVUSkg7C4z6OOYEjZbaJi2jS3LufJ9egRNscaXxoSpjp/JZbz+tE0IEUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9170FDA7;
	Fri,  2 Feb 2024 01:16:11 -0800 (PST)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF38F3F5A1;
	Fri,  2 Feb 2024 01:15:24 -0800 (PST)
Date: Fri, 2 Feb 2024 10:14:47 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm,
	will@kernel.org, catalin.marinas@arm.com, viresh.kumar@linaro.org,
	rafael@kernel.org, yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Message-ID: <ZbyyhxYACe07vocu@e129154.nice.arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com>
 <ZWXy0h/fFfQh+Rhy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWXy0h/fFfQh+Rhy@arm.com>

Hi Ionela,

So sorry for relpying so late, lost if from my rader for a while ...
On Tue, Nov 28, 2023 at 02:01:54PM +0000, Ionela Voinescu wrote:
> Hi Beata, Sumit,
> 
> On Monday 27 Nov 2023 at 16:08:38 (+0000), Beata Michalska wrote:
> > From: Sumit Gupta <sumitg@nvidia.com>
> > 
> > When available, use arch_freq_get_on_cpu to obtain current frequency
> > (usually an average reported over given period of time)
> > to better align the cpufreq's view on the current state of affairs.
> > This also automatically pulls in the update for cpuinfo_cur_freq sysfs
> > attribute, aligning it with the scaling_cur_freq one, and thus providing
> > consistent view on relevant platforms.
> > 
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
> >  	unsigned int new_freq;
> >  
> > -	new_freq = cpufreq_driver->get(policy->cpu);
> > +	new_freq = arch_freq_get_on_cpu(policy->cpu);
> > +	new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
> 
> Given that arch_freq_get_on_cpu() is an average frequency, it does not
> seem right to me to trigger the sync & update process of
> cpufreq_verify_current_freq() based on it.
> 
> cpufreq_verify_current_freq() will at least modify the internal state of
> the policy and send PRE and POST notifications, if not do a full frequency
> update, based on this average frequency, which is likely different from
> the current frequency, even beyond the 1MHz threshold.
> 
Noted, will drop this change.

---
BR
Beata
> While I believe it's okay to return this average frequency in
> cpuinfo_cur_freq, I don't think it should be used as an indication of
> an accurate current frequency, which is what
> cpufreq_verify_current_freq() expects.
> 

> Sumit, can you give more details on the issue at [1] and why this change
> fixes it?
> 
> [1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
> 
> Thank you,
> Ionela.
	> 
> >  	if (!new_freq)
> >  		return 0;
> >  
> > -- 
> > 2.25.1
> > 

