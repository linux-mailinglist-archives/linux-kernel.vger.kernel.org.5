Return-Path: <linux-kernel+bounces-147214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4C8A710F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D5A285634
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAF131746;
	Tue, 16 Apr 2024 16:16:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77412EBCB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284192; cv=none; b=SzqD4vrV1/q5fLBU+Fok1r0gPbmaZ9t9iQbkrUVXsuB2VzDn61eipHhUzmN72mnuSfAbTK2ncGj2fgSje0i5bx20PZR8MBVYLBNrSIwxDh+6WqOLhcWZjRbKdoosZo/r2JDpd0Bs64ReIr8alKJvhb791J6xIucxIJzsJrJIDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284192; c=relaxed/simple;
	bh=S5K7SFmE4dfMjysbYJ5MwR3t5QxHLkujkgTHIM9Uyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+oY9OMYWJ7nKLjImHhlIyV+zoqqBZisew0LQ9DMpuFiunus/xz9zEntT30e7KRvSU/o1hOKCrXBMUGmvXjWI5Psj7lJsAZfWnQQPAz3rOk7irG59YgRbjKtVGPHqMJq8qAMglsHlVSRIpWn9CjN464Az+YvHhxjYJk1gZdcLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F47A339;
	Tue, 16 Apr 2024 09:16:57 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1783F792;
	Tue, 16 Apr 2024 09:16:26 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:16:23 +0100
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
Subject: Re: [PATCH v1 04/31] x86/resctrl: Add helper for setting CPU default
 properties
Message-ID: <Zh6kV5CuYLAIGlyc@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-5-james.morse@arm.com>
 <c8d1f4ec-eb38-4846-a6ae-722e39ab75f9@intel.com>
 <Zhldk3XV/g/ZZfO5@e133380.arm.com>
 <6469d1c9-f535-45e8-91b7-992175cf4697@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6469d1c9-f535-45e8-91b7-992175cf4697@intel.com>

On Mon, Apr 15, 2024 at 10:45:07AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/12/2024 9:13 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:15:03PM -0700, Reinette Chatre wrote:
> >> Hi James,
> >>
> >> On 3/21/2024 9:50 AM, James Morse wrote:
> >>
> >>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >>> @@ -3623,14 +3623,18 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
> >>>  static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> >>>  {
> >>>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> >>> +	u32 closid, rmid;
> >>>  	int cpu;
> >>>  
> >>>  	/* Give any tasks back to the parent group */
> >>>  	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
> >>>  
> >>>  	/* Update per cpu rmid of the moved CPUs first */
> >>> +	closid = rdtgrp->closid;
> >>> +	rmid = prdtgrp->mon.rmid;
> >>>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> >>> -		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
> >>> +		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
> >>> +
> >>
> >> While I understand that the CLOSIDs are the same, I do think it looks unexpected
> >> for the CLOSID to be set to the CLOSID of the group being removed. Could this
> >> be set to CLOSID of parent group instead?
> >>
> >> Reinette
> > 
> > That seems reasonable.  How about something like this?
> > 
> > -	closid = rdtgrp->closid;
> > +	closid = prdtgrp->closid; /* no change, but the arch code needs it */
> 
> Looks good. If the comment stays, please do replace the tail comment with a
> freestanding comment (for reference you can search for "No tail comments"
> in Documentation/process/maintainer-tip.rst). 

Ack, noted.

Cheers
---Dave

