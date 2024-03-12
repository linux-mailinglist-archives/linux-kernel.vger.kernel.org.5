Return-Path: <linux-kernel+bounces-100622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D95879AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7E283D55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD481386CB;
	Tue, 12 Mar 2024 17:55:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A91386B8;
	Tue, 12 Mar 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266156; cv=none; b=oke380hTZhN1FEaOmBvewmHiowtXbdWTU+PMXpk4w18qjwP6+ylEbK+M7RAX8uyOmZgcFQC7Onx0gxUYHWyIbqZqcpcxEi2sKbsCtSh8NEPt+uHu5wJ3VUqCt8rVkWJ2SD1j9heT5a2qgjMA+3MDwY8GPDt57mcrxUrP0Fz9fJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266156; c=relaxed/simple;
	bh=ZBXVU0PrKC6XLj6yDIOu46BarU+EV86MRbcnrms4X3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx/Wg/2jwPizwCzSt3rQHBJwvxN7Q3vPPRM7r2PwaoudsUa9RrbD08mPMmbIEtnRE4EozO1BnxIM9N+cZq4Az0weNG9s4lCldVTMPobHYtCh7+ASCA6BYovLFplyaXmpPi2Q26RqNgLdKChXyDQzjEdHs3GvD6PItPmVXHs1hJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132D2C433F1;
	Tue, 12 Mar 2024 17:55:51 +0000 (UTC)
Date: Tue, 12 Mar 2024 17:55:49 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfCXJRJSMK4tt_Cm@arm.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>

On Tue, Mar 12, 2024 at 10:06:06AM -0700, Christoph Lameter (Ampere) wrote:
> On Mon, 11 Mar 2024, Christoph Lameter (Ampere) wrote:
> 
> > This could be an issue in the ARM64 arch code itself where there maybe
> > an assumption elsewhere that a cpumask can always store up to NR_CPU
> > cpus and not only nr_cpu_ids as OFFSTACK does.
> > 
> > How can I exercise the opp driver in order to recreate the problem?
> > 
> > I assume the opp driver is ARM specific? x86 defaults to OFFSTACK so if
> > there is an issue with OFFSTACK in opp then it should fail with kernel
> > default configuration on that platform.
> 
> I checked the ARM64 arch sources use of NR_CPUS and its all fine.
> 
> Also verified in my testing logs that CONFIG_PM_OPP was set in all tests.
> 
> No warnings in the kernel log during those tests.
> 
> How to reproduce this?

I guess you need a platform with a dts that has an "operating-points-v2"
property. I don't have any around.

Sudeep was trying to trigger this code path earlier, not sure where he
got to.

-- 
Catalin

