Return-Path: <linux-kernel+bounces-147216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432798A7113
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EC91C20DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92B130AC3;
	Tue, 16 Apr 2024 16:17:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4585644
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284233; cv=none; b=eNDbp11EgpB9Hbq/59k1AgftDW6N43xa7E9s+OJ9dgCAsCDhkwM7AN6QLJ3ij+eob0r1kDT8vPM63TBG08A+pc8HgB0p/4/7r//XtDJwAnz2I2N1H8O+1yUHY13+7V/S56tCkEXdRQZDfONXaoFrXIPXAW9n4PcihC5Z/rHoOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284233; c=relaxed/simple;
	bh=HrJiUGIsotWmaJtFYrXhbeTckCCT/Ww05vzENfwm8Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMRhxVTPrjsuMPncFpeb4u5mbbn+oqxPe2dvoRmsSjC34TYKaNzLGfoiMUrDe04w8hftIeXphc1QXrZVzYpBgGFzwq8oOE4X+2wjyUwcGRXPTL3EvIfwqi50wUejjTp28Id4QIen/GIpOwqK/XMvqNv/VvdzAeZ5VThnePGM2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA5C1339;
	Tue, 16 Apr 2024 09:17:39 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E45C3F792;
	Tue, 16 Apr 2024 09:17:08 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:17:06 +0100
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
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
Message-ID: <Zh6kgs1/bji1P1Hl@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
 <c61711b5-e2b8-42dc-9ca2-a9b9454770f9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61711b5-e2b8-42dc-9ca2-a9b9454770f9@amd.com>

On Mon, Apr 15, 2024 at 03:40:46PM -0500, Moger, Babu wrote:
> Hi James/Dave,
> 
> On 3/21/24 11:50, James Morse wrote:
> > update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> > it uses to update the local CPUs default pqr values. This is a problem
> > once the resctrl parts move out to /fs/, as the arch code cannot
> > poke around inside struct rdtgroup.
> > 
> > Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> > to be used as the target of an IPI, and pass the effective CLOSID
> > and RMID in a new struct.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++----
> >  include/linux/resctrl.h                | 11 +++++++++++
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 5d2c1ce5b6b1..18f097fce51e 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -341,13 +341,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
> >   * from update_closid_rmid() is protected against __switch_to() because
> >   * preemption is disabled.
> >   */
> > -static void update_cpu_closid_rmid(void *info)
> > +void resctrl_arch_sync_cpu_defaults(void *info)
> 
> How about keeping the name similar to the old name?
> 
> resctrl_arch_update_cpu_defaults

Ack (Reinette made a similar comment.)

> 
> >  {
> > -	struct rdtgroup *r = info;
> > +	struct resctrl_cpu_sync *r = info;
> >  
> >  	if (r) {
> >  		this_cpu_write(pqr_state.default_closid, r->closid);
> > -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> > +		this_cpu_write(pqr_state.default_rmid, r->rmid);
> >  	}
> >  
> >  	/*

[...]

> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 6e87bc95f5ea..2b79e4159507 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -220,6 +220,17 @@ struct resctrl_schema {
> >  	u32				num_closid;
> >  };
> >  
> > +struct resctrl_cpu_sync {
> 
> How about changing it to  resctrl_cpu_defaults?
> 
> > +	u32 closid;
> > +	u32 rmid;
> > +};

[...]

> -- 
> Thanks
> Babu Moger
> 

Yes, your name describes what the struct means, so renaming it as per
your suggestion does make sense.

I'll make a note.

Cheers
---Dave

