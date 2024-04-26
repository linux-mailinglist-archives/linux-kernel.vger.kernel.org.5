Return-Path: <linux-kernel+bounces-159890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4105E8B357E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAE11F2103B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CD143C5F;
	Fri, 26 Apr 2024 10:46:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DE29CEC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128361; cv=none; b=Yaj20GWZzInmJyxZ41GtUR0Fg/PFhEKGP0DmQlW3jwo53TEuxRY6FxCEraH9NqpbsEg4RhI2HnJ9dJsFNLi5QN7FdjUqJm/kykDeckyvBCGytv60vqgtLDsIfVWs6+l08q0KJtpP6kRFL6+WcfbZm1Q6iQvJIPUNvierNY3rp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128361; c=relaxed/simple;
	bh=eyOccf8Xy7flTGGh+YY5mmHvEDzf63ettllp3q8969g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jaw9fbxwGiHImI1wBPJvjpPy+XdCdYQb5e5hksqHG4W0a+Mfyf9IQb8LXyqg4biFnfzTtmb8pyqZ16s2DS8ZXD4sUzuxJpstFMj1HuPmSIx69sRm7vN1ULMwkw61eITkjkPJl/3s6XRTqPtmQMx16vMNwutOutsdg8gI0xCAgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3DE22F4;
	Fri, 26 Apr 2024 03:46:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4C243F64C;
	Fri, 26 Apr 2024 03:45:55 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:45:39 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: Re: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <ZiuF0zgqkMlmkEZz@arm.com>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
 <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
 <Zh6dSrUnckoa-thV@arm.com>
 <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>

On Wed, Apr 17, 2024 at 02:38:58PM -0700, Vanshidhar Konda wrote:
> On Tue, Apr 16, 2024 at 05:46:18PM +0200, Beata Michalska wrote:
> > On Mon, Apr 15, 2024 at 09:23:10PM -0700, Vanshidhar Konda wrote:
> > > On Fri, Apr 05, 2024 at 02:33:19PM +0100, Beata Michalska wrote:
> > > > Some architectures provide a way to determine an average frequency over
> > > > a certain period of time based on available performance monitors (AMU on
> > > > ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
> > > > into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
> > > > represent the current frequency of a given CPU, as obtained by the hardware.
> > > > This is the type of feedback that counters do provide.
> > > >
> > > 
> > > --- snip ---
> > > 
> > > While testing this patch series on AmpereOne system, I simulated CPU
> > > frequency throttling when the system is under power or thermal
> > > constraints.
> > > 
> > > In this scenario, based on the user guilde, I expect scaling_cur_freq
> > > is the frequency the kernel requests from the hardware; cpuinfo_cur_freq
> > > is the actual frequency that the hardware is able to run at during the
> > > power or thermal constraints.
> > There has been a discussion on scaling_cur_freq vs cpuinfo_cur_freq [1].
> > The guidelines you are referring here (assuming you mean [2]) are kinda
> > out-of-sync already as scaling_cur_freq has been wired earlier to use arch
> > specific feedback. As there was no Arm dedicated implementation of
> > arch_freq_get_on_cpu, this went kinda unnoticed.
> > The conclusion of the above mentioned discussion (though rather unstated
> > explicitly) was to keep the current behaviour of scaling_cur_freq and align
> > both across different archs: so with the patches, both attributes will provide
> > hw feedback on current frequency, when available.
> > Note that if we are to adhere to the docs cpuinfo_cur_freq is the place to use
> > the counters really.
> > 
> > That change was also requested through [3]
> > 
> > Adding @Viresh in case there was any shift in the tides ....
> > 
> 
> Thank you for the pointer to the discussion in [1]. It makes sense to
> bring arm64 behavior in line with x86. The question about whether
> modifying the behavior of scaling_cur_freq was a good idea did not get
> any response.
> 
> > > 
> > > The AmpereOne system I'm testing on has the following configuration:
> > > - Max frequency is 3000000
> > > - Support for AMU registers
> > > - ACPI CPPC feedback counters use PCC register space
> > > - Fedora 39 with 6.7.5 kernel
> > > - Fedora 39 with 6.9.0-rc3 + this patch series
> > > 
> > > With 6.7.5 kernel:
> > > Core        scaling_cur_freq        cpuinfo_cur_freq
> > > ----        ----------------        ----------------
> > > 0             3000000                 2593000
> > > 1             3000000                 2613000
> > > 2             3000000                 2625000
> > > 3             3000000                 2632000
> > > 
> > So if I got it right from the info you have provided the numbers above are
> > obtained without applying the patches. In that case, scaling_cur_freq will
> > use policy->cur (in your case) showing last frequency set, not necessarily
> > the actual freq, whereas cpuinfo_cur_freq uses __cpufreq_get and AMU counters.
> > 
> > 
> > > With 6.9.0-rc3 + this patch series:
> > > Core        scaling_cur_freq        cpuinfo_cur_freq
> > > ----        ----------------        ----------------
> > > 0             2671875                 2671875
> > > 1             2589632                 2589632
> > > 2             2648437                 2648437
> > > 3             2698242                 2698242
> > > 
> > With the patches applied both scaling_cur_freq and cpuinfo_cur_freq will use AMU
> > counters, or fie scale factor obtained based on AMU counters to be more precise:
> > both should now show similar/same frequency (as discussed in [1])
> > I'd say due to existing implementation for scaling_cur_freq (which we cannot
> > change at this point) this is unavoidable.
> > 
> > > In the second case we can't identify that the CPU frequency is
> > > being throttled by the hardware. I noticed this behavior with
> > > or without this patch.
> > > 
> > I am not entirely sure comparing the two should be a way to go about throttling
> > (whether w/ or w/o the changes).
> > It would probably be best to refer to thermal sysfs and get a hold of cur_state
> 
> Throttling could happen due to non-thermal reasons. Or a system may not
> even support thermal zones. So on those systems we wouldn't be able to
> identify/debug the behavior of the hardware providing less than maximum
> performance. The discussion around scaling_cur_freq should probably be
> re-visited in a targeted manner I think.
> 

@Viresh:

It seems that we might need to revisit the discussion we've had around
scaling_cur_freq and cpuinfo_cur_freq and the use of arch_freq_get_on_cpu.
As Vanshi has raised, having both utilizing arch specific feedback for
getting current frequency is bit problematic and might be confusing at best.
As arch_freq_get_on_cpu is already used by show_scaling_cur_freq there are not
many options we are left with, if we want to kee all archs aligned:
we can either try to rework show_scaling_cur_freq and it's use of
arch_freq_get_on_cpu, and move it to cpuinfo_cur_freq, which would align with
relevant docs, though that will not work for x86, or we keep it only there and
skip updating cpuinfo_cur_freq, going against the guidelines. Other options,
purely theoretical, would involve making arch_freq_get_on_cpu aware of type of
the info requested (hw vs sw) or adding yet another arch-specific implementation,
and those are not really appealing alternatives to say at least.
What's your opinion on this one ?

---
BR
Beata


> I'll test v5 of the series on AmpereOne and report back on that thread.
> 
> Thanks,
> Vanshi
> 
> > which should indicate current throttle state:
> > 
> > /sys/class/thermal/thermal_zone[0-*]/cdev[0-*]/cur_state
> > 
> > with values above '0' implying ongoing throttling.
> > 
> > The appropriate thermal_zone can be identified through 'type' attribute.
> > 
> > 
> > Thank you for giving those patches a spin.
> > 
> > ---
> > BR
> > Beata
> > ---
> > [1] https://lore.kernel.org/all/20230609043922.eyyqutbwlofqaddz@vireshk-i7/
> > [2] https://elixir.bootlin.com/linux/latest/source/Documentation/admin-guide/pm/cpufreq.rst#L197
> > [3] https://lore.kernel.org/lkml/2cfbc633-1e94-d741-2337-e1b0cf48b81b@nvidia.com/
> > ---
> > 
> > 
> > > Thanks,
> > > Vanshi

