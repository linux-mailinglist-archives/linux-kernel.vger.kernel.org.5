Return-Path: <linux-kernel+bounces-99442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA250878869
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71BF286A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86656745;
	Mon, 11 Mar 2024 18:55:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9E56443;
	Mon, 11 Mar 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183352; cv=none; b=JBAQTi8cVcT6ueQz56Cq875Qoswax5fl7cqDEPiJXJd4GPAaTFRvefTi1eIYEVLZAPz4UFDYmnpcYwDrXNl4BFZlUvFmJQRso3ojf6Tx3SFLJrmCC9ogQWIj7r+sZf69Er5/iSGdbLPhOly7vvFSGHhQWVFW9nfFlUZ899x2OX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183352; c=relaxed/simple;
	bh=u+mjpEFo6fNKY8iblRcstxYCBK04l2AO6isKa5Cqn+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/89ogHqGFDY7/04yczTlnqXnl02SMaH1aLdD9BT//CDyFfPUYDnJXFrsillamgOdjH9tIskMJDCfGR3FmXi5JffcPsmm/6H0zOhega7izQE4O9kzGAtVVjBdhIyq6Z0vYVVSZNv6nBBiWbZ615Xb3kuuropqtYTH0JrrPYcko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6058C433F1;
	Mon, 11 Mar 2024 18:55:47 +0000 (UTC)
Date: Mon, 11 Mar 2024 18:55:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
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
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <Ze9TsQ-qVCZMazfI@arm.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>

On Fri, Mar 08, 2024 at 03:01:28PM +0100, Marek Szyprowski wrote:
> On 07.03.2024 02:45, Christoph Lameter (Ampere) wrote:
> > Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
> > Computing) are planning to ship systems with 512 CPUs. So that all CPUs on
> > these systems can be used with defconfig, we'd like to bump NR_CPUS to 512.
> > Therefore this patch increases the default NR_CPUS from 256 to 512.
> >
> > As increasing NR_CPUS will increase the size of cpumasks, there's a fear that
> > this might have a significant impact on stack usage due to code which places
> > cpumasks on the stack. To mitigate that concern, we can select
> > CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
> > NR_CPUS=256, we only select this when NR_CPUS > 256.
> >
> > CPUMASK_OFFSTACK configures the cpumasks in the kernel to be
> > dynamically allocated. This was used in the X86 architecture in the
> > past to enable support for larger CPU configurations up to 8k cpus.
[...]
> This patch landed in today's linux-next as commit 0499a78369ad ("ARM64: 
> Dynamically allocate cpumasks and increase supported CPUs to 512"). 
> Unfortunately it triggers the following warning during boot on most of 
> my ARM64-based test boards. Here is an example from Odroid-N2 board:

I spent a big part of this afternoon going through the code paths but
there's nothing obvious that triggered this problem. My suspicion is
some memory corruption, algorithmically I can't see anything that could
go wrong with CPUMASK_OFFSTACK. Unfortunately I could not reproduce it
yet to be able to add some debug info.

So I decided to revert this patch. If we get to the bottom of it during
the merging window, I can still revive it. Otherwise we'll add it to
linux-next post -rc1.

Thanks for reporting it and subsequent debugging.

-- 
Catalin

