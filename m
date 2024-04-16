Return-Path: <linux-kernel+bounces-147211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DF18A710B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8621F226FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E61327F8;
	Tue, 16 Apr 2024 16:13:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D812BE9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284033; cv=none; b=V5y9JsndSZSqAt1w2OgcFlMsXtD3p3nbnrFP9mgsTLN9sDRgthWkF+RW5wA+moIMgujYbc/3PS5fL/kQQDJUXrphel85H+2fvbn6grkjoaNRVnK+LJ1HrxmUWs/X8fCpTfDLnMXVcLAQYZj2vZaoCPKWNqiy96hzI+l7+YDHMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284033; c=relaxed/simple;
	bh=EZiYXcYYhdRml4SnenIKMTRsThmm16vYt8B4S1m+SF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFTSwHzxuYqEjQN2Xs83o3bZ8teFfXHPCrks9Po6dGnDObQI7Af09nZ6OTr9pR9gP/Fazda+Ta89EGqDLf9KOwyOQYfthjzLaxpzp/Gsgy1637lMmPotbYS1RK6F7F6gLAlPxFotlVpzrBS1o/VNYrkZnkzZccqHnfT+FJTzHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E8F4339;
	Tue, 16 Apr 2024 09:14:18 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 980CE3F792;
	Tue, 16 Apr 2024 09:13:47 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:13:41 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, shameerali.kolothum.thodi@huawei.com,
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
Message-ID: <Zh6jtYS0mu9xdwgS@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <36bdfb3c-2828-4188-88b1-b9d01b2a114f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bdfb3c-2828-4188-88b1-b9d01b2a114f@amd.com>

On Mon, Apr 15, 2024 at 03:27:42PM -0500, Moger, Babu wrote:
> 
> 
> On 3/21/24 11:50, James Morse wrote:
> > commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> > searching closid_num_dirty_rmid") added a Kconfig option that causes
> 
> This is not true. The Kconfig option is never added. It is added later in
> the series. There is also comment
> on this https://lore.kernel.org/lkml/ZhecyLQsGZ9Iv8wU@gmail.com/
> 
> 
> Shouldn't the Kconfig option added first before doing this change?
> 
> > resctrl to search for the CLOSID with the fewest dirty cache lines when
> > creating a new control group. This depends on the values read from the
> > llc_occupancy counters.

See David's comments and previous discussion on this patch.

You're right to point out that the description of the original commit
does seem a bit garbled though: CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
not present in Kconfig here, but already referenced by other code.

We seem to have a consensus that it's OK to have a dangling IS_ENABLED()
so long as the option is added formally to Kconfig later, but it looks
like the commit message here should be reworded.

Does the following make sense?

--8<--

commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
searching closid_num_dirty_rmid") added logic that causes resctrl to
search for the CLOSID with the fewest dirty cache lines when creating a
new control group, if requested by the arch code. This depends on the
values read from the llc_occupancy counters. The logic is applicable to
architectures where the CLOSID effectively forms part of the monitoring
identifier and so do not allow complete freedom to choose an unused
monitoring identifier for a given CLOSID.

-->8--


Although it would probably have been better if the Kconfig option had
been added upstream, this patch does not create that that situation and
the series (taken as a whole) resolves it.

So I am not sure that anything would be solved or improved by changing
the body of this patch, but if people still have concerns then I guess
we can look at it.


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
> -- 
> Thanks
> Babu Moger
> 

[...]

Cheers
---Dave

