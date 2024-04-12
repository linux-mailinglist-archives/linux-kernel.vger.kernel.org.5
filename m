Return-Path: <linux-kernel+bounces-143069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74C8A33BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098EC1C21AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26C149C51;
	Fri, 12 Apr 2024 16:23:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2B14900C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938996; cv=none; b=dgffJG8sPajmAfXFAvPSZc3jQkVwU1voyK9T77G0ZLMLwXY7oFe5b/rPrBza7ut/XWyPVnzJ1b7DWfJ9PXWOvqBk7A1Xn2OIGNFNFg06riRtTTxRLOLOhgIfiHL8tG5ZHWsVQbKopnNCMj5pnOT8FJUz0xqq3oXL+aFEoNIDcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938996; c=relaxed/simple;
	bh=/3mQWjfURr0ul96Te/Rzx/s+gGbTlTdAjJvHzDW9C1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrQJBKTyUGi4ACiqhMhcTS+YfaXrL9GC3krhq6swhRJpY0TqakwXk/YowgXSeSSQEGx+GSrsBsg0HWtll9/7CN1+RY8dL6reIXhBvHlJHUcOFZwVvYDSZKl3zK4iEvkfFJIhFv+YRwSNJ7AbyryPAO1WNJs8AZhwipyaP1TH5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B565339;
	Fri, 12 Apr 2024 09:23:43 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38AFF3F64C;
	Fri, 12 Apr 2024 09:23:11 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:23:08 +0100
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
Subject: Re: [PATCH v1 29/31] fs/resctrl: Add boiler plate for external
 resctrl code
Message-ID: <Zhlf7BckYC3/SlaM@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-30-james.morse@arm.com>
 <fb4abe11-5859-4a53-a4db-bb4e59a571c6@intel.com>
 <ZhfzObobGI/p9ISP@e133380.arm.com>
 <23afb7ff-222f-40d0-a68e-3d7b0c3df55d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23afb7ff-222f-40d0-a68e-3d7b0c3df55d@intel.com>

On Thu, Apr 11, 2024 at 10:42:48AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/11/2024 7:27 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:41:04PM -0700, Reinette Chatre wrote:
> >> Hi James,
> >>
> >> On 3/21/2024 9:51 AM, James Morse wrote:
> >>> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> >>> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> >>> depend on this.
> >>>
> >>> Signed-off-by: James Morse <james.morse@arm.com>
> >>> ---
> >>>  MAINTAINERS              |  1 +
> >>>  arch/Kconfig             |  8 ++++++++
> >>>  arch/x86/Kconfig         | 10 +++-------
> >>>  fs/Kconfig               |  1 +
> >>>  fs/Makefile              |  1 +
> >>>  fs/resctrl/Kconfig       | 23 +++++++++++++++++++++++
> >>>  fs/resctrl/Makefile      |  3 +++
> >>>  fs/resctrl/ctrlmondata.c |  0
> >>>  fs/resctrl/internal.h    |  0
> >>>  fs/resctrl/monitor.c     |  0
> >>>  fs/resctrl/psuedo_lock.c |  0
> >>>  fs/resctrl/rdtgroup.c    |  0
> >>>  include/linux/resctrl.h  |  4 ++++
> >>>  13 files changed, 44 insertions(+), 7 deletions(-)
> >>>  create mode 100644 fs/resctrl/Kconfig
> >>>  create mode 100644 fs/resctrl/Makefile
> >>>  create mode 100644 fs/resctrl/ctrlmondata.c
> >>>  create mode 100644 fs/resctrl/internal.h
> >>>  create mode 100644 fs/resctrl/monitor.c
> >>>  create mode 100644 fs/resctrl/psuedo_lock.c
> >>>  create mode 100644 fs/resctrl/rdtgroup.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 5621dd823e79..c49090e9c777 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -18543,6 +18543,7 @@ S:	Supported
> >>>  F:	Documentation/arch/x86/resctrl*
> >>>  F:	arch/x86/include/asm/resctrl.h
> >>>  F:	arch/x86/kernel/cpu/resctrl/
> >>> +F:	fs/resctrl/
> >>>  F:	include/linux/resctrl*.h
> >>>  F:	tools/testing/selftests/resctrl/
> >>>  
> >>> diff --git a/arch/Kconfig b/arch/Kconfig
> >>> index fd18b7db2c77..131d874d6738 100644
> >>> --- a/arch/Kconfig
> >>> +++ b/arch/Kconfig
> >>> @@ -1406,6 +1406,14 @@ config STRICT_MODULE_RWX
> >>>  config ARCH_HAS_PHYS_TO_DMA
> >>>  	bool
> >>>  
> >>> +config ARCH_HAS_CPU_RESCTRL
> >>> +	bool
> >>> +	help
> >>> +	  The 'resctrl' filesystem allows CPU controls of shared resources
> >>> +	  such as caches and memory bandwidth to be configured. An architecture
> >>> +	  selects this if it provides the arch-specific hooks for the filesystem
> >>> +	  and needs the per-task CLOSID/RMID properties.
> >>
> >> Should it mention monitoring capabilities?
> > 
> > Probably, although I wonder whether it is better to describe this just
> > once, under RESCTRL_FS.  Does it makes sense to have something
> > like this here?
> > 
> > 	  An architecture selects this option to indicate that the necessary
> > 	  hooks are provided to support the common memory system usage
> > 	  monitoring and control interfaces provided by the 'resctrl'
> > 	  filesystem (see RESCTRL_FS).
> 
> This looks good to me.

Noted, thanks.

> 
> > 
> > If so, I can propose this.
> > 
> > (Details on what gets added to task_struct is maybe unnecessarily low-
> > level to bother with here...)
> > 
> >>> +
> >>>  config HAVE_ARCH_COMPILER_H
> >>>  	bool
> >>>  	help
> >>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>> index e071e564452e..cb043543f088 100644
> >>> --- a/arch/x86/Kconfig
> >>> +++ b/arch/x86/Kconfig
> >>> @@ -479,8 +479,10 @@ config GOLDFISH
> >>>  config X86_CPU_RESCTRL
> >>>  	bool "x86 CPU resource control support"
> >>>  	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> >>> +	depends on MISC_FILESYSTEMS
> >>>  	select KERNFS
> >>
> >> Do both X86_CPU_RESCTRL and RESCTRL_FS need to select KERNFS?
> > 
> > Hmmm, hopefully the arch backend doesn't need to re-depend on KERNFS.
> > I'll note that for review.
> > 
> > (If not, we can probably drop filesystem-related #includes from the
> > remaining x86 arch code too...)
> > 
> > [...]

(I still need to look at this.)

> > 
> >>> diff --git a/fs/Kconfig b/fs/Kconfig
> >>> index a46b0cbc4d8f..d8a36383b6dc 100644
> >>> --- a/fs/Kconfig
> >>> +++ b/fs/Kconfig
> >>> @@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
> >>>  source "fs/hpfs/Kconfig"
> >>>  source "fs/qnx4/Kconfig"
> >>>  source "fs/qnx6/Kconfig"
> >>> +source "fs/resctrl/Kconfig"
> >>>  source "fs/romfs/Kconfig"
> >>>  source "fs/pstore/Kconfig"
> >>>  source "fs/sysv/Kconfig"
> >>> diff --git a/fs/Makefile b/fs/Makefile
> >>> index 6ecc9b0a53f2..da6e2d028722 100644
> >>> --- a/fs/Makefile
> >>> +++ b/fs/Makefile
> >>> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
> >>>  obj-$(CONFIG_EROFS_FS)		+= erofs/
> >>>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
> >>>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> >>> +obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
> >>> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
> >>> new file mode 100644
> >>> index 000000000000..36a1ddbe6c21
> >>> --- /dev/null
> >>> +++ b/fs/resctrl/Kconfig
> >>
> >> Could you please review the contents of this file for
> >> appropriate line length and consistent tab usage?
> > 
> > Noted.
> > 
> >>> @@ -0,0 +1,23 @@
> >>> +config RESCTRL_FS
> >>> +	bool "CPU Resource Control Filesystem (resctrl)"
> >>> +	depends on ARCH_HAS_CPU_RESCTRL
> >>> +	select KERNFS
> >>> +	select PROC_CPU_RESCTRL               if PROC_FS
> >>> +	help
> >>> +	  Resctrl is a filesystem interface
> >>> +	  to control allocation and
> >>> +	  monitoring of system resources
> >>> +	  used by the CPUs.
> > 
> > (Not quite a haiku, but I don't know how many syllables "resctrl"
> > counts as...)
> > 
> > Since this is the Kconfig user's primary knob for enabling resctrl,
> > maybe flesh this out and make it a bit more generic and newbie-friendly?
> > Something like:
> > 
> > 	  Some architectures provide hardware facilities to group tasks and
> > 	  monitor and control their usage of memory system resources such as
> > 	  caches and memory bandwidth.  Examples of such facilities include
> > 	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
> > 	  Platform Quality of Service (AMD QoS).
> 
> Nit: We should double check with AMD how they want to refer to their
> feature. Their contribution to the resctrl docs used the term you provide
> but their spec uses PQOS.
> 
> Do you expect this snippet to be updated when MPAM full support lands or
> does resctrl have enough support at this point to include a mention of MPAM?

Probably yes, even if only to make the point that this is generic and
relevant for more than one architecture.

For this series, MPAM is not known to the kernel, so I didn't want to
give the impression that there was any support for it (yet).

> > 
> > 	  If your system has the necessary support and you want to be able to
> > 	  assign tasks to groups and manipulate the associated resource
> > 	  monitors and controls from userspace, say Y here to get a mountable
> > 	  'resctrl' filesystem that lets you do just that.
> > 
> > 	  If nothing mounts or prods the 'resctrl' filesystem, resource
> > 	  controls and monitors are left in a quiescent, permissive state.
> 
> Well written, thank you.

Thanks for the once-over; I'll propose this to James for inclusion.

> 
> > 
> > 	  If unsure, it is safe to say Y.
> > 
> > 	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
> > 
> > I'm assuming that just enabling this option doesn't introduce
> > significant overheads.  For MPAM I'm pretty sure it doesn't,
> > but if this is a concern that we could go for "If unsure, say N."
> 
> I would vote for N for when folks are not sure.

OK, fair enough.  Noted.

Cheers
---Dave

