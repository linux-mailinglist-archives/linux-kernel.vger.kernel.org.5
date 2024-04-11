Return-Path: <linux-kernel+bounces-140661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179198A176B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70571F243EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF410A12;
	Thu, 11 Apr 2024 14:38:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0CFBE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846320; cv=none; b=PM5nrB4uwa8/25G0Dq8UQ90AF7zy6TZ5BZxqnb58HCgAkbG0KXbM24iGvx1IXZHfBqrUAA2vMhtGwapLo4yNVHpcS5hjyRstEOotxIdS9fRAHI/xQutql88qIn5u5tDAE/3/koEsvNhLTCKTWquuU86IjM78g3quhSd3fut0pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846320; c=relaxed/simple;
	bh=ynssZhL2d6PMLpGtJdceKSnohdNZtVgxxF/5673hUD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5vSckhPx0VikJlMj1UCIXyP0cWuJDCVH6ychYIURy4CJp1sXKfPKPaIKBMRFQ5n8dKVEvCw6BEVxs8zQDqWA0DTD3VpNKCIY5H8yYjT18vkWKlULpBoYx4SZlsuczqxKj9/UJBVW9roE/9/sSPBFlfklfstdGb9RedeM6+43JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF586339;
	Thu, 11 Apr 2024 07:39:07 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93EB13F64C;
	Thu, 11 Apr 2024 07:38:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:38:33 +0100
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
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Zhf16Tg7VtCaplFq@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>

On Mon, Apr 08, 2024 at 08:13:19PM -0700, Reinette Chatre wrote:
> Hi James and x86 Maintainers,
> 
> Please consider the file movements as captured in the diffstat below:
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> >  MAINTAINERS                               |    2 +
> >  arch/Kconfig                              |    8 +
> >  arch/x86/Kconfig                          |    5 +-
> >  arch/x86/include/asm/resctrl.h            |   45 +-
> >  arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
> >  arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
> >  arch/x86/kernel/cpu/resctrl/internal.h    |  433 +--
> >  arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +----
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1126 +-----
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3929 +-------------------
> >  arch/x86/kernel/process_32.c              |    2 +-
> >  arch/x86/kernel/process_64.c              |    2 +-
> >  fs/Kconfig                                |    1 +
> >  fs/Makefile                               |    1 +
> >  fs/resctrl/Kconfig                        |   23 +
> >  fs/resctrl/Makefile                       |    3 +
> >  fs/resctrl/ctrlmondata.c                  |  527 +++
> >  fs/resctrl/internal.h                     |  340 ++
> >  fs/resctrl/monitor.c                      |  843 +++++
> >  fs/resctrl/psuedo_lock.c                  | 1122 ++++++
> 
> (sidenote: James, please note typo in psuedo_lock.c)

Noted.

(So that's what the Psuedo Lock key on the keyboard does...)

> 
> >  fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
> >  include/linux/resctrl.h                   |  153 +-
> >  include/linux/resctrl_types.h             |   98 +
> >  24 files changed, 7244 insertions(+), 6875 deletions(-)
> >  create mode 100644 fs/resctrl/Kconfig
> >  create mode 100644 fs/resctrl/Makefile
> >  create mode 100644 fs/resctrl/ctrlmondata.c
> >  create mode 100644 fs/resctrl/internal.h
> >  create mode 100644 fs/resctrl/monitor.c
> >  create mode 100644 fs/resctrl/psuedo_lock.c
> >  create mode 100644 fs/resctrl/rdtgroup.c
> >  create mode 100644 include/linux/resctrl_types.h
> 
> I would like to check in on the sentiments regarding maintaining the resctrl
> contributions after this work is merged. Considering that resctrl will 
> be split between fs/resctrl and arch/x86, would it still be acceptable for
> resctrl code to both areas (filesystem as well as arch) to flow via the tip tree with
> help from x86 maintainers?
> 
> How will Arm patches flow?
> 
> James, are you planning a separate MAINTAINERS entry for the Arm specific code?
> I would like to propose that you add yourself as a reviewer to the existing resctrl
> MAINTAINERS entry to learn when any changes are submitted that may impact Arm. 
> 
> Reinette

I'll leave this for James to respond.

Cheers
---Dave

