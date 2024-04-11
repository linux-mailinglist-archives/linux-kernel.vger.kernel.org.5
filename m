Return-Path: <linux-kernel+bounces-140607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1268A16DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4D1C22B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352814E2CD;
	Thu, 11 Apr 2024 14:13:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376EE22096
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844808; cv=none; b=Bj4ymErOpgDqGyvXh9cFmg87wwlgj1Z+2oAUGvRX9Rnb5HmT2qFKtaf6DYKCBsQJDPRytN9igfce5Sk0HPkbRGRgjvmx7/7SQEWPs1ck1anxLGtb+4NzUe7CpDrWGLR510GKvbzLSPEyEfJvV11dK50kvGbHEsJzfNkOIXW+xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844808; c=relaxed/simple;
	bh=9gYqdh3z0f1o0+aWVzfUE3fhoHPG24zQFuoqUDpyTXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMMq+VQtT+YN2IzH7FLapIzbAJIoeXpcvHqi5f/GwEZHFp+RZSFkArCzIRoZDefzqs6noHP4b3GFSDXY78i0JvhEXiqrxsw8Evoed2Z0qAW0NwpYwrmTngBicVQqxKewBoV3KlCKDAa1hDhTliKv0GK3Mi71MpZai/csT/SIy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12468339;
	Thu, 11 Apr 2024 07:13:55 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B710A3F64C;
	Thu, 11 Apr 2024 07:13:22 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:13:20 +0100
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
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
Message-ID: <ZhfwAASIZsjTu5b1@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <0cbc22c1-a35c-4ad8-8f3b-f7a7b034d944@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbc22c1-a35c-4ad8-8f3b-f7a7b034d944@intel.com>

On Mon, Apr 08, 2024 at 08:13:40PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> > searching closid_num_dirty_rmid") added a Kconfig option that causes
> 
> Please see section about "Fixes" tags in section "Ordering of commit tags"
> in Documentation/process/maintainer-tip.rst

Noted for James' attention.

> > resctrl to search for the CLOSID with the fewest dirty cache lines when
> > creating a new control group. This depends on the values read from the
> > llc_occupancy counters.
> > 
> > This support missed that some platforms may not have these counters.
> > This causes a NULL pointer dereference when creating a new control
> > group as the array was not allocated by dom_data_init().
> > 
> > As this feature isn't necessary on platforms that don't have cache
> > occupancy monitors, add this to the check that occurs when a new
> > control group is allocated.
> > 
> > The existing code is not selected by any upstream platform, it makes
> > no sense to backport this patch to stable.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 011e17efb1a6..1767c1affa60 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -149,7 +149,8 @@ static int closid_alloc(void)
> >  
> >  	lockdep_assert_held(&rdtgroup_mutex);
> >  
> > -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> > +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> > +	    is_llc_occupancy_enabled()) {
> >  		cleanest_closid = resctrl_find_cleanest_closid();
> >  		if (cleanest_closid < 0)
> >  			return cleanest_closid;
> 
> Patch looks good.
> 
> Thank you
> 
> Reinette
> 

Noted, thanks.

Cheers
---Dave

