Return-Path: <linux-kernel+bounces-98810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722B877FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9782EB21A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7C3C484;
	Mon, 11 Mar 2024 12:12:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B63EA98;
	Mon, 11 Mar 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159163; cv=none; b=QDXaUmqeQTQMZ7zrgtNjbO6OQPrzbAlTCyVCG973PBOaxQiKMfzhBuVTK8ngz53sFmNCW7yc+f7/6V4R2S25pBNs/x+UdyzRbO/OcMo7tNKcE76jYoWNYn9in8/1q8DT8TxFJqT9ONO6S3ukP2gSQ+7PMUhma2R+Gj/dLmJLCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159163; c=relaxed/simple;
	bh=uxZErM0jgyMEjgSg8ZtooXrgoEQobZPFoR0f71UenBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMTz5wnoVicRjPJaz87jPt7jw97v5Z0FfOVhF+qsFmIYA1x28jMhAKhgWU0JBFIQSrlW2/ckAzIA5PpWTzypt24pwdi9ip7MOLVH13YPRRpZBkE5yMKvKqX5AOo7yPIfVVamYDAPvSYxXH4LF94YSzYo/axzcKx/QRIqtVoUqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C647FFEC;
	Mon, 11 Mar 2024 05:13:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3EF3F64C;
	Mon, 11 Mar 2024 05:12:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:12:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <Ze71H4AdY786nSvn@FVFF77S0Q05N>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <ZesmAO1jJfEjTwxd@arm.com>
 <f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
 <e3952dc0-ec28-e7c7-e858-c47f146c93de@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3952dc0-ec28-e7c7-e858-c47f146c93de@linux.com>

On Fri, Mar 08, 2024 at 09:08:59AM -0800, Christoph Lameter (Ampere) wrote:
> On Fri, 8 Mar 2024, Marek Szyprowski wrote:
> 
> > > > 
> > > > It looks that cpufreq-dt and/or opp drivers needs some adjustments
> > > > related with this change.
> > > That's strange. Is this with defconfig? I wonder whether NR_CPUS being
> > > larger caused the issue with this specific code. Otherwise
> > > CPUMASK_OFFSTACK may not work that well on arm64.
> 
> cpumask handling must use the accessor functions provided in
> include/linux/cpumask.h for declaring and accessing cpumasks. It is likely
> related to the driver opencoding one of the accessors.

I took a look at both the OPP code and the cpufreq-dt code and it looks like
those are doign the right thing w.r.t. cpumask manipulation (i.e. they only use
the cpumask accessors, and use the cpumask_var_*() functions to dynamically
allocate/free cpumasks). Maybe I've missed something, but superficially those
look right.

Marek, can you try reverting this commit and trying defconfig + NR_CPUS=512?
That'll have CPUMASK_OFFSTACK=n, and:

* If that blows up, we know the problem is independent of CPUMASK_OFFSTACK, and
  has something to do with large cpumasks (either a driver bug, or elsewhere).

* If that doesn't blow up, it suggests the problem is related to
  CPUMASK_OFFSTACK rather than with large cpumasks specifically.

Either way, we probably need to revert this patch for now, as this won't have
enough time to soak in linux-next in time for v6.9.

Mark.

