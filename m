Return-Path: <linux-kernel+bounces-27404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D382EF77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9061F24529
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD21BDCA;
	Tue, 16 Jan 2024 13:08:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC861BDDA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386F12F4;
	Tue, 16 Jan 2024 05:09:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138893F6C4;
	Tue, 16 Jan 2024 05:08:29 -0800 (PST)
Date: Tue, 16 Jan 2024 13:08:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Valentin.Schneider@arm.com,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Matteo Carlini <Matteo.Carlini@arm.com>, akpm@linux-foundation.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZaZ_xK5QHVPSD7N6@FVFF77S0Q05N>
References: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
 <ZaVRlHpAOoNIiRiY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaVRlHpAOoNIiRiY@shell.armlinux.org.uk>

On Mon, Jan 15, 2024 at 03:39:00PM +0000, Russell King (Oracle) wrote:
> On Thu, Dec 14, 2023 at 04:05:56PM -0800, Christoph Lameter (Ampere) wrote:
> > +# Determines the placement of cpumasks.
> > +#
> > +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> > +# Useful for machines with lots of core because it avoids increasing
> > +# the size of many of the data structures in the kernel.
> > +#
> > +# If this is off then the cpumasks have a static sizes and are
> > +# embedded within data structures.
> > +#
> > +config CPUMASK_OFFSTACK
> > +	def_bool y
> > +	depends on NR_CPUS > 256
> 
> Should that be ">= 256" ?

I don't think that ">= 256" makes sense. Note that since the cpumasks are
arrays of unsigned long, they're chunked into groups of 64 bits:

    2 to  64 cpus:  1 x unsigned long =>  8 bytes
   65 to 128 cpus:  2 x unsigned long => 16 bytes
  129 to 192 cpus:  3 x unsigned long => 24 bytes
  193 to 256 cpus:  4 x unsigned long => 32 bytes
  257 to 320 cpus:  5 x unsigned long => 40 bytes

.. and so if a mask for 256 CPUs is too big to go in the stack, so is any mask
for 193+ CPUs, and so ">= 256" should be clamped down to ">= 193" or "> 192".
The boundary should be just after a multiple of 64.

How did we choose 256 specifically? I note that x86-64 allows 512 CPUs before
requiring CPUMASK_OFFSTACK, and I see that powerpc selects CPUMASK_OFFSTACK
when NR_CPUS >= 8192.

Mark.

