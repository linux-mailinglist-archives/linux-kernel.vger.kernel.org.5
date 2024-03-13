Return-Path: <linux-kernel+bounces-101621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E60887A991
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8231F22DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3EA26AFA;
	Wed, 13 Mar 2024 14:35:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA19A2905;
	Wed, 13 Mar 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340525; cv=none; b=cpApWzwBf74KoAczTqRkMI7VjQkXVMnYau+cqDSOxyv2XampTwjl5MYPGxSDDPNGlPOh8GKNEyJwl8ieef97u5l0+qn9HzY2sHqWHQJJphuQk//pXwmlhjPag1nWzb5kSC+IGznp/REcxPMnkaIVhLRD4jnJtQYz1TBGzTo0tSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340525; c=relaxed/simple;
	bh=yOQGShewM716dS+uPb9Z8lLXlUwt34drgeAVECPi7Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqqjfTBuOt/H42BwIS7cDhCnAYn6m1MKGVyByGuAiBFkWtjUS1AonnHwXmIs2asPYb1Prkx563E0ONULLQ7upI5UhXkvTyWwi+s8nUi53+QjIsLy4qHgHNMQfp3q+LHXDS8IA95gVqwzVhLgkgtd51c2BZN9ex3BHYLoM1VHef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37BEB1007;
	Wed, 13 Mar 2024 07:35:58 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8CDC3F762;
	Wed, 13 Mar 2024 07:35:17 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:35:15 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux@armlinux.org.uk, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfG5oyrgGOkpHYD6@bogus>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
 <ZfCXJRJSMK4tt_Cm@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfCXJRJSMK4tt_Cm@arm.com>

On Tue, Mar 12, 2024 at 05:55:49PM +0000, Catalin Marinas wrote:
> On Tue, Mar 12, 2024 at 10:06:06AM -0700, Christoph Lameter (Ampere) wrote:
> > On Mon, 11 Mar 2024, Christoph Lameter (Ampere) wrote:
> >
> > > This could be an issue in the ARM64 arch code itself where there maybe
> > > an assumption elsewhere that a cpumask can always store up to NR_CPU
> > > cpus and not only nr_cpu_ids as OFFSTACK does.
> > >
> > > How can I exercise the opp driver in order to recreate the problem?
> > >
> > > I assume the opp driver is ARM specific? x86 defaults to OFFSTACK so if
> > > there is an issue with OFFSTACK in opp then it should fail with kernel
> > > default configuration on that platform.
> >
> > I checked the ARM64 arch sources use of NR_CPUS and its all fine.
> >
> > Also verified in my testing logs that CONFIG_PM_OPP was set in all tests.
> >
> > No warnings in the kernel log during those tests.
> >
> > How to reproduce this?
>
> I guess you need a platform with a dts that has an "operating-points-v2"
> property. I don't have any around.
>
> Sudeep was trying to trigger this code path earlier, not sure where he
> got to.

I did try to trigger this on FVP by adding OPPs + some hacks to add dummy
clock provider to successfully probe this driver. I couldn't hit the issue
reported 🙁. It could be that with the hardware clock/regulator drivers, it
take a different path in OPP core.

--
Regards,
Sudeep

