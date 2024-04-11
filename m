Return-Path: <linux-kernel+bounces-140614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF528A16E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E32B29040
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B514F12E;
	Thu, 11 Apr 2024 14:14:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55314F104
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844887; cv=none; b=d3jSY60cAsQDEx3Dty1poYu1pRawpxD/Sz6JNUHrgeaoJvx0EuEDu3oSnO1intF5L83LIWZ6ApBeWxGFyj3SDNzAETM10ElCzun/hzSRAS+aTjfa6LnzSWasPCmAWf/PCeRTZGiE2tCJO7tdmhGHC8Dm/payQvp2yIafPaa/yvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844887; c=relaxed/simple;
	bh=pAXfynRvZVXBc8XFJ+iZWkP/Zd7LC+cDV5LxxtMhLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUo0+TeFowX3hbllPn0Cmv/4z6JO7Fw8hN0g1UedKEJ5OylzDg+iDXfUg0u7XyeAs63XuMhZUpUnzjpLK9L+FvCSr04ZsGCZ4Kb5hUuSw8ye83nJgBxKObJpTqSBeYC+E/QkyfeOxxE6OJV+QyLBqIp0DVN4MERC7cdIy1+YbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6DE339;
	Thu, 11 Apr 2024 07:15:14 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 766D13F64C;
	Thu, 11 Apr 2024 07:14:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:14:40 +0100
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
Subject: Re: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
Message-ID: <ZhfwUHHmOtXZqX1S@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-7-james.morse@arm.com>
 <TYAPR01MB63300666A8517A5A141F9B5C8B3D2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB63300666A8517A5A141F9B5C8B3D2@TYAPR01MB6330.jpnprd01.prod.outlook.com>

On Wed, Apr 03, 2024 at 07:51:54AM +0000, Shaopeng Tan (Fujitsu) wrote:
> Hello James,
> 
> > rdtgroup_init() needs exporting so that arch code can call it once it lives in core
> > code. As this is one of the few functions we export, rename it to have the resctrl
> > in the name. The same goes for the exit call.
> > 
> > x86's arch code init functions for RDT are renamed to have an arch prefix to
> > make it clear these are part of the architecture code.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
> >  arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
> > arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
> >  include/linux/resctrl.h                |  3 +++
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> /fs/resctrl/monitor.c
> 746          * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
> 747          * are always allocated. These are used for the rdtgroup_default
> 748          * control group, which will be setup later in rdtgroup_init(). 
> "rdtgroup_init()" is still in the comments.
> 
> 
> Best regards,
> Shaopeng TAN
> 

[...]

Noted for James' attention, thanks.

Cheers
---Dave

