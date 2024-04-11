Return-Path: <linux-kernel+bounces-140608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B2F8A16DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A641F224E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474E14D45D;
	Thu, 11 Apr 2024 14:13:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701622096
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844824; cv=none; b=EGbYYEj/N2CT3YjqE7J34FNzvgCZAFqag8wWLvkYKcFZeXR9X9r+B2MVC1l7O/+NurNZw3+MvDJUtCAeZB3So6lL8M/lyaN4ZyPepXzxoh5qGglr3ji9TmO+zAsZiOkITcBwsXich9lEX903JPcljgdp+1IZIsjRhKoIaTiUHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844824; c=relaxed/simple;
	bh=qbLoWnPAg+jsjrOorXMatRQj/0BRkniRfTdxAUDR7s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5nAP5Lso2QqBqBiafNUXa1zHqRXdbyQdtE85xQnyEzGzQRAvMUj4tuCUoNEuMGls9co1wryM8Rq9lYZmyNtys7qhXrhVWZvG+yCJZOsQg2G+8sjwNR8ZE/ZNYqn/8cemEH0X7Pd+OFxT5Pnh/DNgeOR2hN4eFexG1f5kBRQA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 040F211FB;
	Thu, 11 Apr 2024 07:14:11 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB1EF3F64C;
	Thu, 11 Apr 2024 07:13:38 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:13:36 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
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
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
Message-ID: <ZhfwEF5EJiTM5Hjm@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>

On Tue, Apr 09, 2024 at 10:05:33AM +0200, David Hildenbrand wrote:
> On 21.03.24 17:50, James Morse wrote:
> > commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> > searching closid_num_dirty_rmid") added a Kconfig option that causes
> > resctrl to search for the CLOSID with the fewest dirty cache lines when
> > creating a new control group. This depends on the values read from the
> > llc_occupancy counters.

[...]

> It's weird to not see RESCTRL_RMID_DEPENDS_ON_CLOSID appear in any Kconfig file.
> I guess it will all make sense once the refactoring is done :)

Agreed; a stub Kconfig item could be added, but since the file layout
and naming conventions change after this patch, doing this would
probably just create noise in the series though.

Looking at <linux/kconfig.h> (yikes!), IS_ENABLED() is designed to do
the right thing for non-existing Kconfigs...

If nobody is too concerned about the temporarily dangling IS_ENABLED()s
in this series, I won't propose any change here.


> As Reinette comments, likely we want here:
> 
> Fixes: 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")

Noted for James' attention.

> 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 011e17efb1a6..1767c1affa60 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -149,7 +149,8 @@ static int closid_alloc(void)
> >   	lockdep_assert_held(&rdtgroup_mutex);
> > -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> > +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> > +	    is_llc_occupancy_enabled()) {
> >   		cleanest_closid = resctrl_find_cleanest_closid();
> >   		if (cleanest_closid < 0)
> >   			return cleanest_closid;
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb

Thanks; noted for James' attention.

Cheers
---Dave

