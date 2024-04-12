Return-Path: <linux-kernel+bounces-143045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED628A338A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01DF1C20F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B4149C64;
	Fri, 12 Apr 2024 16:17:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6D148850
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938670; cv=none; b=nmxWJVhcSnNhyLAtTwx4S1/MOfTqZZPASP4YDQqxZOyDxm+6Jim/UOiEDWx3rXfn03Ki7DQ8p1vgDBFnUVLm22uXRDK2cQ9wKJYjsQ/aQNocJix8umPYLNOr+W6WZ/QuNe9kEZHgnnmXFfXeyyJ/PkkKVO7YP8UHX0ndRQM/0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938670; c=relaxed/simple;
	bh=23qXPzccGbJUkVqJ029wkcVrlAyJmFHp8rYgdXlCJPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGvCzPvZaUVc1yf6qxVVt/G1HrlVvsV1trlASMAMqp8DYKOpI6u9j9I+iVSpHgWDaPwNdDir7zahhHW3I/9wgAsqWn4wnOGmVWCJe/Mt/x0fPypVG2Ahm5YLKO0izE+VtC7xfPp2nHkiu5vM+bAxNtkYMHE2dxtvRrYx/UnyqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19217339;
	Fri, 12 Apr 2024 09:18:17 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170173F64C;
	Fri, 12 Apr 2024 09:17:44 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:17:42 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Cc: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>,
	"amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 09/31] x86/resctrl: Add a resctrl helper to reset all
 the resources
Message-ID: <ZhlepqX41cBsQh/m@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-10-james.morse@arm.com>
 <TYAPR01MB63303577D268E2175A61D0968B3D2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB63303577D268E2175A61D0968B3D2@TYAPR01MB6330.jpnprd01.prod.outlook.com>

On Wed, Apr 03, 2024 at 07:52:42AM +0000, Shaopeng Tan (Fujitsu) wrote:
> Hello James,
> 
> > On umount(), resctrl resets each resource back to its default configuration. It
> > only ever does this for all resources in one go.
> > 
> > reset_all_ctrls() is architecture specific as it works with struct
> > rdt_hw_resource.
> > 
> > Add an architecture helper to reset all resources.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/include/asm/resctrl.h         |  2 ++
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> > index f61382258743..5f6a5375bb4a 100644
> > --- a/arch/x86/include/asm/resctrl.h
> > +++ b/arch/x86/include/asm/resctrl.h
> > @@ -15,6 +15,8 @@
> >   */
> >  #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
> > 
> > +void resctrl_arch_reset_resources(void);
> > +
> >  /**
> >   * struct resctrl_pqr_state - State cache for the PQR MSR
> >   * @cur_rmid:		The cached Resource Monitoring ID
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 1a49c9918f8d..13c24cb18d76 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -2859,6 +2859,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
> >  	return 0;
> >  }
> > 
> > +void resctrl_arch_reset_resources(void)
> > +{
> > +	struct rdt_resource *r;
> > +
> > +	for_each_capable_rdt_resource(r)
> Could you explain why not "for_each_alloc_capable_rdt_resource(r)"?
> 
> > +		reset_all_ctrls(r);
> > +}
> > +
> >  /*
> >   * Move tasks from one to the other group. If @from is NULL, then all tasks
> >   * in the systems are moved unconditionally (used for teardown).
> > @@ -2968,16 +2976,14 @@ static void rmdir_all_sub(void)
> > 
> >  static void rdt_kill_sb(struct super_block *sb)  {
> > -	struct rdt_resource *r;
> > -
> >  	cpus_read_lock();
> >  	mutex_lock(&rdtgroup_mutex);
> > 
> >  	rdt_disable_ctx();
> > 
> > -	/*Put everything back to default values. */
> > -	for_each_alloc_capable_rdt_resource(r)
> This was "for_each_alloc_capable_rdt_resource(r)".
> 
> Best regards, 
> Shaopeng TAN

Noted for James to take a look at, thanks.

If this was intentional, it probably needs more explanation -- it looks
quite likely to have been unintentional, though.

Cheers
---Dave

