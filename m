Return-Path: <linux-kernel+bounces-140622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0B8A16F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D41F21317
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28EE14E2F4;
	Thu, 11 Apr 2024 14:16:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDD014D458
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844986; cv=none; b=p2UNFE+5L6fcS7zWtLUvfOCmVF9+oeL6OmkIE7/tp/fGUjIDSTStUC9kJaPMsmlDbogK+ZGKtyI1ywBLpLp2H1MYG5nGVFiJRcghUsNI/rvg670pLm/H6htTgjmzlGrprUqQjfluFUOlyDUXmBK+x4fD5IZv2K0WKNcn6TudTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844986; c=relaxed/simple;
	bh=9eDUfFpsnSByPAqcPCwyufcI3DhKvyJo1MAFTfMH4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaMumol/fE5D6mMQSqjfWkBVQvz+bmoBSAxZbUlEXzwtG5eTetOSnNmJCs15qI//TmDdAVB8GeQ2PT3v6Rtn5HdG0CVoLWKDgFjNvnqUnRvaspDYaJjBi/ZfG9tPXJX7aSxpaDHye7NQGT0b0Jl7rVyEHuY5wmJez2UJS+HSOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FBC7339;
	Thu, 11 Apr 2024 07:16:54 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0AB43F64C;
	Thu, 11 Apr 2024 07:16:21 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:16:19 +0100
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
Subject: Re: [PATCH v1 14/31] x86/resctrl: Export the is_mbm_*_enabled()
 helpers to asm/resctrl.h
Message-ID: <Zhfws5KVuCPXy9V8@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-15-james.morse@arm.com>
 <67021f34-65fd-4ea8-b696-b5d797ae9dbc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67021f34-65fd-4ea8-b696-b5d797ae9dbc@intel.com>

On Mon, Apr 08, 2024 at 08:20:12PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > The architecture specific parts of resctrl have helpers to hide accesses
> > to the rdt_mon_features bitmap.
> > 
> > Once the filesystem parts of resctrl are moved, these can no longer live
> > in internal.h. Once these are exposed to the wider kernel, they should
> > have a 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
> > 
> > Move and rename the helpers that touch rdt_mon_features directly.
> > is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
> > so can be moved into that file.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/include/asm/resctrl.h         | 17 +++++++++++
> >  arch/x86/kernel/cpu/resctrl/core.c     |  4 +--
> >  arch/x86/kernel/cpu/resctrl/internal.h | 27 -----------------
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 18 ++++++------
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++---------
> >  5 files changed, 54 insertions(+), 52 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> > index 5f6a5375bb4a..50407e83d0ca 100644
> > --- a/arch/x86/include/asm/resctrl.h
> > +++ b/arch/x86/include/asm/resctrl.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/jump_label.h>
> >  #include <linux/percpu.h>
> >  #include <linux/sched.h>
> > +#include <linux/resctrl_types.h>
> >  
> 
> Can this be alphabetical?

I'd guess so, looking at it.

Noted.

Cheers
---Dave

