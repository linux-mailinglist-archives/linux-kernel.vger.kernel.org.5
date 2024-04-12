Return-Path: <linux-kernel+bounces-143062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D368A33AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57008B28296
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD701494D7;
	Fri, 12 Apr 2024 16:21:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C984149C4D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938864; cv=none; b=AF+Se0+K3xgFHP0cv2dtizM6YHKlZCHewX0+Z20D2SKRA6TpKwypzMwcfY2fLSUJ9wYxCGasE4vvbJ2zLYNV7kzRB9cxK3RY5XmjSwwhsZ4/hiVdwt/Ki361pST6YIQsu7c3BmKEsdKliH8P7TuMT+V/kqzp/FV7UatN/4H5vsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938864; c=relaxed/simple;
	bh=ThIUTkskTJ3StO15VmG5tI0v0yhSfi9cYlLfVt0C3no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWdM0kHROOSseTqbl3DeCst8rxQU3XTR3cbZLROKn+KH/JIvDHuR7HkWTfbGjdZmUfBfyVkOtDhZDfU278GVmY7FBQ0Q1+GpgaPz5cZ6QTcfQl00NgE2iPDToljj1YOEwArtIaBlYvdxBIh6zi89Cew9CifU+GnWfVz37M5M9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5018339;
	Fri, 12 Apr 2024 09:21:30 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E39D43F64C;
	Fri, 12 Apr 2024 09:20:58 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:20:56 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <ZhlfaHhIXe9ZLXmK@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
 <0aaae9ce-00ae-cd0b-ed25-4d52d1620ab5@intel.com>
 <Zhfz7KHJeXYNCw9/@e133380.arm.com>
 <be03a7e9-fb0b-4edb-b22e-4452255992ad@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be03a7e9-fb0b-4edb-b22e-4452255992ad@intel.com>

On Thu, Apr 11, 2024 at 10:45:01AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/11/2024 7:30 AM, Dave Martin wrote:
> > On Tue, Mar 26, 2024 at 12:44:26PM -0700, Fenghua Yu wrote:
> >> Hi, James,
> >>
> >> On 3/21/24 09:51, James Morse wrote:
> >>> resctrl is linux's defacto interface for managing cache and bandwidth
> >>> policies for groups of tasks.
> >>>
> >>> To allow other architectures to make use of this pseudo filesystem,
> >>> move it live in /fs/resctrl instead of /arch/x86.
> >>>
> >>> This move leaves behind the parts of resctrl that form the architecture
> >>> interface for x86.
> >>>
> >>> Signed-off-by: James Morse <james.morse@arm.com>
> >>> ---
> >>> Discussion needed on how/when to merge this, as it would conflict with
> >>> all outstanding series. It's probably worth deferring to some opportune
> >>> time, but is included here for illustration.
> >>> ---
> >>>   arch/x86/kernel/cpu/resctrl/core.c        |   15 -
> >>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  505 ---
> >>>   arch/x86/kernel/cpu/resctrl/internal.h    |  310 --
> >>>   arch/x86/kernel/cpu/resctrl/monitor.c     |  821 -----
> >>>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1093 ------
> >>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3994 --------------------
> >>>   fs/resctrl/ctrlmondata.c                  |  527 +++
> >>>   fs/resctrl/internal.h                     |  340 ++
> >>>   fs/resctrl/monitor.c                      |  843 +++++
> >>>   fs/resctrl/psuedo_lock.c                  | 1122 ++++++
> >>>   fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
> >>>   11 files changed, 6845 insertions(+), 6738 deletions(-)
> >>>
> >>
> >> checkpatch reports warnings and checks on this patch. Please fix them. e.g.
> >>
> >> CHECK: Blank lines aren't necessary before a close brace '}'
> >> #13340: FILE: fs/resctrl/rdtgroup.c:3184:
> >> +
> >> +	}
> > 
> > Thanks for spotting these...
> > 
> > However, this is a "move code around with no functional change" patch,
> > so I think that it should paste the original code across verbatim
> > without trying to address style violations.  (Otherwise, there is no
> > hope of checking whether this patch is correct or not...)
> 
> I agree that this patch is too big for it to do more than just move
> code (please see next comments though).
> 
> > 
> > For the above example, see:
> > 47820e73f5b3 ("x86/resctrl: Initialize a new resource group with default MBA values")
> > 
> > Other than code that is moved or cloned from previously existing code,
> > do you see any new style problems actually introduced by this patch?
> > 
> > 
> > Notwithstanding the above, this series will conflict with a lot of the
> > in-flight changes pending for resctrl, so it could be a good opportunity
> > to fix some legacy style nits.
> > 
> > Reinette, do you have a view on this?  If legacy style problems get
> > addressed in the moved code, are they essential for this series or could
> > that be done in a follow-up?
> 
> On its path upstream this series will be scrutinized by various checkers and 
> to ensure a smooth merge I would like to recommend that this series aim to
> get as clean slate as possible from the basic checkers.
> 
> Could a patch addressing these legacy issues precede this patch instead?
> 
> I do not think all need to be addressed though. Some of the spelling warnings
> are false positives and the camel case appears to be the custom for filesystem
> parameter code.
> 
> It is not obvious to me that all are legacy issues though ... could you
> take a second look at the "WARNING: Use #include <linux/resctrl.h>
> instead of <asm/resctrl.h>" ones?
> 
> Reinette

Ack, that does make sense, and it's probably better than letting the dust
settle on this series before applying further cleanups.

I'll make a note to review.

Some of the #include <asm/*> look to have been inherited from the
previous x86 arch code where they would have been more appropriate, but
perhaps some can change to <linux/*> now that more of the definitions
are in the common headers.

Cheers
---Dave

