Return-Path: <linux-kernel+bounces-140621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768BD8A16F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157FC1F21642
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC914F9D1;
	Thu, 11 Apr 2024 14:16:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475CA14EC7D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844968; cv=none; b=ddhQuZ7Klcv9+O4Oe670lGMVUrFqFRYNkWBskRxRPIFoXQki6DXgNfvP57axc3OT45P9Ikmn6F0/GzDAIFa3Bx96Jb2St/gH3mx6dUWm4rymlS+pmEi5UnWQMzUdeIQcHA6nIjMS36hRGpo6OIpDd5NPkecFhpCfTaBnH2Omun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844968; c=relaxed/simple;
	bh=VURZfbujbR/cSK3LncKJi7+/qsd91o8bKnsDkv60Vew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGogGcZ/ShXDyHnvYYBiK+bcaalIwDYGARLifXKFqVdTEXteAAGwiJjSv8oeDcM4CHkUQjQpkhj4NrZ+Vi08rE/MCSrlabSukdCYH3hcUd9CBiHgImmNnZQI6CmQfxjAGXHwMURON8ArT09HAp2dwdAqp5P/sIrF0rAHxiWfkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65397339;
	Thu, 11 Apr 2024 07:16:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17B9D3F64C;
	Thu, 11 Apr 2024 07:16:03 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:16:01 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 13/31] x86/resctrl: Stop using the
 for_each_*_rdt_resource() walkers
Message-ID: <ZhfwoXOlenwwH++O@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-14-james.morse@arm.com>
 <9d339257-97c3-4d9f-aa02-c43713fd33df@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d339257-97c3-4d9f-aa02-c43713fd33df@intel.com>

On Mon, Apr 08, 2024 at 08:19:40PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > The for_each_*_rdt_resource() helpers walk the architectures array
> 
> architecture's ?

Noted.

> > of structures, using the resctrl visible part as an iterator. These
> > became over-complex when the structures were split into a
> > filesystem and architecture-specific struct. This approach avoided
> > the need to touch every call site.
> > 
> > Once the filesystem parts of resctrl are moved to /fs/, both the
> > architecture's resource array, and the definition of those structures
> > is no longer accessible. To support resctrl, each architecture would
> > have to provide equally complex macros.
> > 
> > Change the resctrl code that uses these to walk through the resource_level
> > enum and check the mon/alloc capable flags instead. Instances in core.c,
> > and resctrl_arch_reset_resources() remain part of x86's architecture
> > specific code.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  7 +++++-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 30 +++++++++++++++++++----
> >  2 files changed, 31 insertions(+), 6 deletions(-)

[...]

> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index e736e4d20f63..3f16e7854411 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

[...]

> > @@ -2205,8 +2211,12 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
> >  			goto out_destroy;
> >  	}
> >  
> > -	for_each_mon_capable_rdt_resource(r) {
> > -		fflags = r->fflags | RFTYPE_MON_INFO;
> > +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> > +		r = resctrl_arch_get_resource(i);
> > +		if (!r->mon_capable)
> > +			continue;
> > +
> > +		fflags =  r->fflags | RFTYPE_MON_INFO;
> 
> Please check spacing.

[...]

> Reinette

Noted, thanks.


Cheers
---Dave

