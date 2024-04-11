Return-Path: <linux-kernel+bounces-140643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC678A171F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05E0281154
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9E14EC4A;
	Thu, 11 Apr 2024 14:27:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECA14E2F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845633; cv=none; b=KV1v198HJtXalpurMd8CxBM7qZrBLYI6JAk7x/vC3W3q0yF1S0TdTORQE0mB223fDedk/93wASw07uqlySOE66gl2eDjxtmVJZje7wFhApbDVJE8Iq9gfCfNoe7FLRVZ2J/URWIetzaXX5fNQGYUAcnf0ppU2LHbdEROwT2DtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845633; c=relaxed/simple;
	bh=IDhvXdY96MsYpZX2SANCCDVSaXfvjQDM3K/TIAwdMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrO5zBC91WKVzXFwIy0vXI+6ueMWkN20hVLPlPXxQvpKvpqNszrWyskNSDNdxAG5GB4EGaqGVPpF17M09F/lxXZbEy4CLlLnUeCEbMV3F6HkAPWhunbPvhyPai+JMIQY40g+58TfCbCuTOnN/PDrC/qum+9RAQXUok60rvW8vjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E4B339;
	Thu, 11 Apr 2024 07:27:40 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277BF3F64C;
	Thu, 11 Apr 2024 07:27:08 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:27:05 +0100
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
Message-ID: <ZhfzObobGI/p9ISP@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-30-james.morse@arm.com>
 <fb4abe11-5859-4a53-a4db-bb4e59a571c6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4abe11-5859-4a53-a4db-bb4e59a571c6@intel.com>

On Mon, Apr 08, 2024 at 08:41:04PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:51 AM, James Morse wrote:
> > Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> > for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> > depend on this.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  MAINTAINERS              |  1 +
> >  arch/Kconfig             |  8 ++++++++
> >  arch/x86/Kconfig         | 10 +++-------
> >  fs/Kconfig               |  1 +
> >  fs/Makefile              |  1 +
> >  fs/resctrl/Kconfig       | 23 +++++++++++++++++++++++
> >  fs/resctrl/Makefile      |  3 +++
> >  fs/resctrl/ctrlmondata.c |  0
> >  fs/resctrl/internal.h    |  0
> >  fs/resctrl/monitor.c     |  0
> >  fs/resctrl/psuedo_lock.c |  0
> >  fs/resctrl/rdtgroup.c    |  0
> >  include/linux/resctrl.h  |  4 ++++
> >  13 files changed, 44 insertions(+), 7 deletions(-)
> >  create mode 100644 fs/resctrl/Kconfig
> >  create mode 100644 fs/resctrl/Makefile
> >  create mode 100644 fs/resctrl/ctrlmondata.c
> >  create mode 100644 fs/resctrl/internal.h
> >  create mode 100644 fs/resctrl/monitor.c
> >  create mode 100644 fs/resctrl/psuedo_lock.c
> >  create mode 100644 fs/resctrl/rdtgroup.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5621dd823e79..c49090e9c777 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18543,6 +18543,7 @@ S:	Supported
> >  F:	Documentation/arch/x86/resctrl*
> >  F:	arch/x86/include/asm/resctrl.h
> >  F:	arch/x86/kernel/cpu/resctrl/
> > +F:	fs/resctrl/
> >  F:	include/linux/resctrl*.h
> >  F:	tools/testing/selftests/resctrl/
> >  
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index fd18b7db2c77..131d874d6738 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1406,6 +1406,14 @@ config STRICT_MODULE_RWX
> >  config ARCH_HAS_PHYS_TO_DMA
> >  	bool
> >  
> > +config ARCH_HAS_CPU_RESCTRL
> > +	bool
> > +	help
> > +	  The 'resctrl' filesystem allows CPU controls of shared resources
> > +	  such as caches and memory bandwidth to be configured. An architecture
> > +	  selects this if it provides the arch-specific hooks for the filesystem
> > +	  and needs the per-task CLOSID/RMID properties.
> 
> Should it mention monitoring capabilities?

Probably, although I wonder whether it is better to describe this just
once, under RESCTRL_FS.  Does it makes sense to have something
like this here?

	  An architecture selects this option to indicate that the necessary
	  hooks are provided to support the common memory system usage
	  monitoring and control interfaces provided by the 'resctrl'
	  filesystem (see RESCTRL_FS).

If so, I can propose this.

(Details on what gets added to task_struct is maybe unnecessarily low-
level to bother with here...)

> > +
> >  config HAVE_ARCH_COMPILER_H
> >  	bool
> >  	help
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index e071e564452e..cb043543f088 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -479,8 +479,10 @@ config GOLDFISH
> >  config X86_CPU_RESCTRL
> >  	bool "x86 CPU resource control support"
> >  	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> > +	depends on MISC_FILESYSTEMS
> >  	select KERNFS
> 
> Do both X86_CPU_RESCTRL and RESCTRL_FS need to select KERNFS?

Hmmm, hopefully the arch backend doesn't need to re-depend on KERNFS.
I'll note that for review.

(If not, we can probably drop filesystem-related #includes from the
remaining x86 arch code too...)

[...]

> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index a46b0cbc4d8f..d8a36383b6dc 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
> >  source "fs/hpfs/Kconfig"
> >  source "fs/qnx4/Kconfig"
> >  source "fs/qnx6/Kconfig"
> > +source "fs/resctrl/Kconfig"
> >  source "fs/romfs/Kconfig"
> >  source "fs/pstore/Kconfig"
> >  source "fs/sysv/Kconfig"
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 6ecc9b0a53f2..da6e2d028722 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
> >  obj-$(CONFIG_EROFS_FS)		+= erofs/
> >  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
> >  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> > +obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
> > diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
> > new file mode 100644
> > index 000000000000..36a1ddbe6c21
> > --- /dev/null
> > +++ b/fs/resctrl/Kconfig
> 
> Could you please review the contents of this file for
> appropriate line length and consistent tab usage?

Noted.

> > @@ -0,0 +1,23 @@
> > +config RESCTRL_FS
> > +	bool "CPU Resource Control Filesystem (resctrl)"
> > +	depends on ARCH_HAS_CPU_RESCTRL
> > +	select KERNFS
> > +	select PROC_CPU_RESCTRL               if PROC_FS
> > +	help
> > +	  Resctrl is a filesystem interface
> > +	  to control allocation and
> > +	  monitoring of system resources
> > +	  used by the CPUs.

(Not quite a haiku, but I don't know how many syllables "resctrl"
counts as...)

Since this is the Kconfig user's primary knob for enabling resctrl,
maybe flesh this out and make it a bit more generic and newbie-friendly?
Something like:

	  Some architectures provide hardware facilities to group tasks and
	  monitor and control their usage of memory system resources such as
	  caches and memory bandwidth.  Examples of such facilities include
	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
	  Platform Quality of Service (AMD QoS).

	  If your system has the necessary support and you want to be able to
	  assign tasks to groups and manipulate the associated resource
	  monitors and controls from userspace, say Y here to get a mountable
	  'resctrl' filesystem that lets you do just that.

	  If nothing mounts or prods the 'resctrl' filesystem, resource
	  controls and monitors are left in a quiescent, permissive state.

	  If unsure, it is safe to say Y.

	  See <file:Documentation/arch/x86/resctrl.rst> for more information.

I'm assuming that just enabling this option doesn't introduce
significant overheads.  For MPAM I'm pretty sure it doesn't,
but if this is a concern that we could go for "If unsure, say N."

If this looks OK, I can propose it to James.

> > +
> > +config RESCTRL_FS_PSEUDO_LOCK
> > +	bool
> > +	help
> > +          Software mechanism to pin data in a cache portion using
> > +          micro-architecture specific knowledge.
> > +
> > +config RESCTRL_RMID_DEPENDS_ON_CLOSID
> > +	bool
> > +	help
> > +	  Enable by the architecture when the RMID values depend on the CLOSID.
> > +	  This causes the closid allocator to search for CLOSID with clean
> > +	  RMID.
> > diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
> > new file mode 100644
> > index 000000000000..10fcfb0fdb10
> > --- /dev/null
> > +++ b/fs/resctrl/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
> > +obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= psuedo_lock.o
> > diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/fs/resctrl/psuedo_lock.c b/fs/resctrl/psuedo_lock.c
> 
> pseudo_lock.c

[...]

> Reinette

Noted here, and in the Makefile snippet above.

Cheers
---Dave

