Return-Path: <linux-kernel+bounces-130637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C9897AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A5C1F21280
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140715667F;
	Wed,  3 Apr 2024 21:34:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589EA2BB02
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180095; cv=none; b=Ha4ARlE/SoyR+QlvbmOrVaWltTMuo1KV8j/Jtn9IV+ifBBkDoLg/ekVXPbRNBCnZYmysTI7AYfOMsM+qLThMFCLz+5DioyloPnME1s6BktmVDj97evXLp3+PyibZSZOphpbwOdrc8kdP/JI/FPE/eqOnT4IZXpPaPCthIY5M49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180095; c=relaxed/simple;
	bh=O/x3pR/Uq2m/RFQAAEF82MfnkT1toOKqKKJEqBr1+aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPRqKmXUYloYnBQaeF7FMpwKjvmvdZOYfnPxz0SERgPWI7H1m7Eb4s8tclqRowhu4zj0vzS5CvSZO/0IGcWAkm4Im9KII90BZVDnEu3fmvBN8RDv+6oemZSEGuUIYcfZnWrbUc74lYyufJeUqP+7t4pSBFs9lCLVagaGkqoUyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93FC21007;
	Wed,  3 Apr 2024 14:35:23 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD68B3F7B4;
	Wed,  3 Apr 2024 14:34:49 -0700 (PDT)
Date: Wed, 3 Apr 2024 23:34:49 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: Re: [PATCH v3 0/3] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <Zg3LeYvOefchf1N3@arm.com>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <5bdlm4kzni6x2bdy7kmmomf7cmyohjhr4nr7v2mb2pchuhkulj@moakmpptnbg5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdlm4kzni6x2bdy7kmmomf7cmyohjhr4nr7v2mb2pchuhkulj@moakmpptnbg5>

On Mon, Mar 25, 2024 at 09:10:26AM -0700, Vanshidhar Konda wrote:
> On Tue, Mar 12, 2024 at 08:34:28AM +0000, Beata Michalska wrote:
> > Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
> > existing implementation for FIE and AMUv1 support: the frequency scale
> > factor, updated on each sched tick, serves as a base for retrieving
> > the frequency for a given CPU, representing an average frequency
> > reported between the ticks - thus its accuracy is limited.
> > 
> > The changes have been rather lightly (due to some limitations) tested on
> > an FVP model.
> > 
> 
> I tested these changes on an Ampere system. The results from reading
> scaling_cur_freq look reasonable in the majority of cases I tested. I
> only saw some unexpected behavior with cores that were configured for
> no_hz full.
> 
> I observed the unexplained behavior when I tested as follows:
> 1. Run stress on all cores
>    stress-ng --cpu 186 --timeout 10m --metrics-brief
> 2. Observe scaling_cur_freq and cpuinfo_cur_freq for all cores
>    scaling_cur_freq values were within a few % of cpuinfo_cur_freq
> 3. Kill stress test
> 4. Observe scaling_cur_freq and cpuinfo_cur_freq for all cores
>    scaling_cur_freq values were within a few % of cpuinfo_cur_freq for
>    most cores except the ones configured with no_hz full.
> 
> no_hz full = 122-127
> core   scaling_cur_freq  cpuinfo_cur_freq
> [122]: 2997070           1000000
> [123]: 2997070           1000000
> [124]: 3000038           1000000
> [125]: 2997070           1000000
> [126]: 2997070           1000000
> [127]: 2997070           1000000
> 
> These values were reflected for multiple seconds. I suspect the cores
> entered WFI and there was no update to the scale while those cores were
> idle.
>
Right, so the problem is with updating the counters upon entering idle, which at
this point is being done for all CPUs, and it should exclude the full dynticks
ones - otherwise it leads to such bad readings. So for nohz_full cores cpufreq
driver will have to take care of getting the current frequency.

Will be sending a fix for that.

Thank you very much for testing - appreciate that!

---
BR
Beata
> Thanks,
> Vanshi

