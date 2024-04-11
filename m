Return-Path: <linux-kernel+bounces-140654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD888A1751
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8179B270B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168FF9C3;
	Thu, 11 Apr 2024 14:30:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B0114EC5A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845812; cv=none; b=G0TFA1xtRBjK4Y/3IS+W1hyTzPhSNuqHPJDLfG7+oDreP0Ge4A/HFT0gD4QCag6Q74NB9AGcwRplx11fs1WPDFVu8py4ub98mFnxbQhIx4If1AuC9GCLZGtUpQhIZ10G2gWeAZwEoW+ZZQWGsq5EY+IPg7CX5fJb9jazzqAOagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845812; c=relaxed/simple;
	bh=65CEUD63qTkkGzDCfMobVMuVZ++In3x+++Aghm1pBr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM4Y3YvKefA0uTbbIWukF51z2rdnEqxxeKI7+17Sb/y6+W3IkqyDZ7Kj9HiNFRfF9OrpyB8A95JixNf/4izz8bh5t5lNYBnX+UOfckBQlr/VArldFTaQf4MO5fQrEf7I9PEzjX7wR+9dawanu/wNTLMik8H0HM9+bRJGFEk50nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84656339;
	Thu, 11 Apr 2024 07:30:39 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384883F64C;
	Thu, 11 Apr 2024 07:30:07 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:30:04 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
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
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Zhfz7KHJeXYNCw9/@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
 <0aaae9ce-00ae-cd0b-ed25-4d52d1620ab5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aaae9ce-00ae-cd0b-ed25-4d52d1620ab5@intel.com>

On Tue, Mar 26, 2024 at 12:44:26PM -0700, Fenghua Yu wrote:
> Hi, James,
> 
> On 3/21/24 09:51, James Morse wrote:
> > resctrl is linux's defacto interface for managing cache and bandwidth
> > policies for groups of tasks.
> > 
> > To allow other architectures to make use of this pseudo filesystem,
> > move it live in /fs/resctrl instead of /arch/x86.
> > 
> > This move leaves behind the parts of resctrl that form the architecture
> > interface for x86.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> > Discussion needed on how/when to merge this, as it would conflict with
> > all outstanding series. It's probably worth deferring to some opportune
> > time, but is included here for illustration.
> > ---
> >   arch/x86/kernel/cpu/resctrl/core.c        |   15 -
> >   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  505 ---
> >   arch/x86/kernel/cpu/resctrl/internal.h    |  310 --
> >   arch/x86/kernel/cpu/resctrl/monitor.c     |  821 -----
> >   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1093 ------
> >   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3994 --------------------
> >   fs/resctrl/ctrlmondata.c                  |  527 +++
> >   fs/resctrl/internal.h                     |  340 ++
> >   fs/resctrl/monitor.c                      |  843 +++++
> >   fs/resctrl/psuedo_lock.c                  | 1122 ++++++
> >   fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
> >   11 files changed, 6845 insertions(+), 6738 deletions(-)
> > 
> 
> checkpatch reports warnings and checks on this patch. Please fix them. e.g.
> 
> CHECK: Blank lines aren't necessary before a close brace '}'
> #13340: FILE: fs/resctrl/rdtgroup.c:3184:
> +
> +	}

Thanks for spotting these...

However, this is a "move code around with no functional change" patch,
so I think that it should paste the original code across verbatim
without trying to address style violations.  (Otherwise, there is no
hope of checking whether this patch is correct or not...)

For the above example, see:
47820e73f5b3 ("x86/resctrl: Initialize a new resource group with default MBA values")

Other than code that is moved or cloned from previously existing code,
do you see any new style problems actually introduced by this patch?


Notwithstanding the above, this series will conflict with a lot of the
in-flight changes pending for resctrl, so it could be a good opportunity
to fix some legacy style nits.

Reinette, do you have a view on this?  If legacy style problems get
addressed in the moved code, are they essential for this series or could
that be done in a follow-up?

Cheers
---Dave

