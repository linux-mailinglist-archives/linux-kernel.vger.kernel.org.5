Return-Path: <linux-kernel+bounces-140626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4228A16F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2391F210BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF714EC49;
	Thu, 11 Apr 2024 14:17:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43514D45D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845061; cv=none; b=o/9FC4+qCOldUQXxfymYq4wp8OMQJwv8FVnEPvrPvnJ3ikwcyhehDy8OFfsUlZqwgt2YoGBVVPEFnUGAixDFBlWmnqAngwt0rG4ZmBrlDhu9ZBQv31bdAdhga0tnn0PVUkRyB4OAc0v3Aq7kjorYZR8+cyemb7zopar2onmH7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845061; c=relaxed/simple;
	bh=xuNCmJ693hUGjHHj4/JkD+xhls4nmb8lLaS8Z6bnGN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUm9NeCYhGzrEcMWazq1o2iu9d8sVdrUL91P01XKVy1wRfGr+JV/N+ZP42pb40ObBVSvRGigBheaHywEpT0vygW06oUDFVigL+X+jcUIcSSAHWXZAtyQIwRGLXrl0j+4KgLaImPf6QaRkd2wmeMTG/cCTYGO6klhFusEEilAgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29055339;
	Thu, 11 Apr 2024 07:18:09 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D403F64C;
	Thu, 11 Apr 2024 07:17:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:17:34 +0100
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
Subject: Re: [PATCH v1 20/31] x86/resctrl: Allow an architecture to disable
 pseudo lock
Message-ID: <Zhfw/uEZaYk9492j@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-21-james.morse@arm.com>
 <6d563361-87c0-474d-812c-b33e79eacf3a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d563361-87c0-474d-812c-b33e79eacf3a@intel.com>

On Mon, Apr 08, 2024 at 08:24:12PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > Pseudo-lock relies on knowledge of the micro-architecture to disable
> > prefetchers etc.
> > 
> > On arm64 these controls are typically secure only, meaning linux can't
> > access them. Arm's cache-lockdown feature works in a very different
> > way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.
> > 
> > Add a Kconfig symbol that can be selected by the architecture. This
> > enables or disables building of the psuedo_lock.c file, and replaces
> 
> pseudo_lock.c

Noted.

> > the functions with stubs. An additional IS_ENABLED() check is needed
> > in rdtgroup_mode_write() so that attempting to enable pseudo-lock
> > reports an "Unknown or unsupported mode" to user-space.
> > 
> 
> I am missing something here. It is not obvious to me why the IS_ENABLED()
> check is needed. Wouldn't rdtgroup_locksetup_enter()
> return -EOPNOTSUPP if CONFIG_RESCTRL_FS_PSEUDO_LOCK is not enabled?
> 
> Reinette
> 

Hmm, if I've understood all this correctly, then it looks like the
existing code in rdtgroup_mode_write() relies on the dispatched
function (rdtgroup_locksetup_enter() etc.) to do an appropriate
rdt_last_cmd_puts() on failure.  If no function is called at all and
the requested mode change is not a no-op or otherwise trivially
successful, then it looks like we're supposed to fall into the else
clause.

I'd guess James' intent here was to use the fallback else {} to write
a suitable status string, while keeping the stub functions as trivial
as possible.

Just taking the IS_ENABLED() away would result in error return from the
write(), but no suitable last_cmd_status string.

For consistency with the existing x86 implementation, I wonder whether
we should put a suitable rdt_last_cmd_puts() in the stub for
rdtgroup_locksetup_enter().

There might be other ways to refactor or simplify this, though.

Thoughts?

Cheers
---Dave

