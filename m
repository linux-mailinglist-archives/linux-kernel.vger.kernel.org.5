Return-Path: <linux-kernel+bounces-99123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045F8783B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424881C21C21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817141C8B;
	Mon, 11 Mar 2024 15:22:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3A42073;
	Mon, 11 Mar 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170528; cv=none; b=NVMKcUrZA2Q67G316731xgwsEVgFWlk53DD80Xs35+InBM4YCHt7b1ugybpp451YbXkFyErYiOUt8QZ4FDw1bC6avOWNdB5hvLG8ypr4BR2BVS+bHiaN6znAlrEjSjBo4dOsRqbsQKGu4B8L9xGodLGpV5u/wT2Ju56Q1N0YVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170528; c=relaxed/simple;
	bh=IEbrELXNPCnsnk0tlcdplu6+a2MvOyBflK48xsJAEOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDE1uMKTt5ZK8L/fgppgA/ir5zJGp4CO0DTS/Hx1HVUI4ECa4L7C2+p4aCAJizCBtzZ/qslovbC4s8SUhyPUC46o3ZdFICpa9yNQQnAqsoaesAorT4tUrIMA151zHcbpLG/i/NPMrLZHQCaEYAybbI1Ocd9dVG0y8Bndo/aPw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399F3C433C7;
	Mon, 11 Mar 2024 15:22:03 +0000 (UTC)
Date: Mon, 11 Mar 2024 15:22:00 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>,
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
Message-ID: <Ze8hmCbN7_GDRMVS@arm.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <ZesmAO1jJfEjTwxd@arm.com>
 <f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
 <e3952dc0-ec28-e7c7-e858-c47f146c93de@linux.com>
 <Ze71H4AdY786nSvn@FVFF77S0Q05N>
 <8abb1a69-6cbd-4a36-ab1d-d269cdafa391@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8abb1a69-6cbd-4a36-ab1d-d269cdafa391@samsung.com>

On Mon, Mar 11, 2024 at 03:56:37PM +0100, Marek Szyprowski wrote:
> On 11.03.2024 13:12, Mark Rutland wrote:
> > On Fri, Mar 08, 2024 at 09:08:59AM -0800, Christoph Lameter (Ampere) wrote:
> >> On Fri, 8 Mar 2024, Marek Szyprowski wrote:
> >>>>> It looks that cpufreq-dt and/or opp drivers needs some adjustments
> >>>>> related with this change.
> >>>> That's strange. Is this with defconfig? I wonder whether NR_CPUS being
> >>>> larger caused the issue with this specific code. Otherwise
> >>>> CPUMASK_OFFSTACK may not work that well on arm64.
> >> cpumask handling must use the accessor functions provided in
> >> include/linux/cpumask.h for declaring and accessing cpumasks. It is likely
> >> related to the driver opencoding one of the accessors.
> > I took a look at both the OPP code and the cpufreq-dt code and it looks like
> > those are doign the right thing w.r.t. cpumask manipulation (i.e. they only use
> > the cpumask accessors, and use the cpumask_var_*() functions to dynamically
> > allocate/free cpumasks). Maybe I've missed something, but superficially those
> > look right.
> >
> > Marek, can you try reverting this commit and trying defconfig + NR_CPUS=512?
> 
> Yes, with $subject reverted and CONFIG_NR_CPUS=512 everything works 
> fine, so it must be something else broken.

Thanks for confirming. Would you mind testing the problematic commit
with CONFIG_DEBUG_PER_CPU_MAPS enabled? If it doesn't show anything
obvious that can be fixed quickly, I'll revert the commit and queue it
again after -rc1 for 6.10 (I haven't sent 6.9 the pull request yet).

-- 
Catalin

