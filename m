Return-Path: <linux-kernel+bounces-148703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540848A866B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8264B2378B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E0146A78;
	Wed, 17 Apr 2024 14:41:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9A14263B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364912; cv=none; b=U1tWy2ydq8KkKEvfh+KV8qMbS+5rMJdUYIGPf6Mr0UgW28Uo0Hit5aAosCVtREWIxJeR/0pJEvlLo7R4qxItIRTsYupJpGjLdcjpN93DFdDxSU3EB4Z+/I5a+3w236+eBTYTYcoIFB9w5od2xx+/TBgX6sKCrCbJNOiEBpZ/QfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364912; c=relaxed/simple;
	bh=qjC+xTCHfDtidcanQVL+BiMGEOTpfihi17X1cLx5J4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+lGfLRdcTtzw95hgsliQiUfiTnWkXqYpvXBlrn2QXIw20ymCUukt22fhJAHl7QlZkBu9kv4TdAW3SNYa1zyYrVRXKRpa3oNfaJLfBLHHXFXZp/oqAYWyo++5b/DrjvWhU5av1H2/GbUaFHsTw5nbHzN/tX/cteebGHIMOcCtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64986339;
	Wed, 17 Apr 2024 07:42:18 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4562E3F738;
	Wed, 17 Apr 2024 07:41:47 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:41:44 +0100
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
Subject: Re: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
Message-ID: <Zh/fqIFJDjsb1jYT@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-18-james.morse@arm.com>
 <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>
 <Zhfwzh4sHvTYyTJ1@e133380.arm.com>
 <c96cdf6a-02a8-4ee2-91f5-e4329015e276@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96cdf6a-02a8-4ee2-91f5-e4329015e276@intel.com>

On Thu, Apr 11, 2024 at 10:39:06AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/11/2024 7:16 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:21:24PM -0700, Reinette Chatre wrote:
> >> Hi James,
> >>
> >> On 3/21/2024 9:50 AM, James Morse wrote:
> >>> The mbm_cfg_mask field lists the bits that user-space can set when
> >>> configuring an event. This value is output via the last_cmd_status
> >>> file.
> >>>
> >>> Once the filesystem parts of resctrl are moved to live in /fs/, the
> >>> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> >>> this value is output to user-space, it has to be accessible to the
> >>> filesystem code.
> >>>
> >>> Move it to struct rdt_resource.
> >>>
> >>> Signed-off-by: James Morse <james.morse@arm.com>
> >>
> >> ..
> >>
> >>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> >>> index 975b80102fbe..8a7367d1ce45 100644
> >>> --- a/include/linux/resctrl.h
> >>> +++ b/include/linux/resctrl.h
> >>> @@ -140,6 +140,8 @@ struct resctrl_membw {
> >>>   * @format_str:		Per resource format string to show domain value
> >>>   * @evt_list:		List of monitoring events
> >>>   * @fflags:		flags to choose base and info files
> >>> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
> >>> + *			Monitoring Event Configuration (BMEC) is supported.
> > 
> > [...]
> > 
> >> Reinette
> >>
> >> BMEC is an AMD term. If MPAM is planning to use this member then this comment
> >> should be made generic.
> > 
> > MPAM can (at least) filter reads and/or writes, and it looks like James
> > is expecting to support this.
> > 
> > However, it probably does make sense to keep the comments neutral in a
> > common header.
> > 
> > Would the following work?
> > 
> > 	* @ mbm_cfg_mask:	Arch-specific event configuration flags
> > 
> > 
> > 
> > I think that's broad enough to cover all bases, but I'll wait for your
> > response.
> 
> Since this is exposed to user space, ideally all architectures would use
> the same bits to mean the same thing. I assumed that is what James intended
> by placing the existing (AMD BMEC) bits in the global resctrl_types.h.
> 
> Reinette

Maybe, but the bits as defined by AMD BMEC look rather architecture and
bus specific, and I am suspicious that there is no guaranteed clean
mapping between MPAM's config and BMEC's config.

MPAM currently just has "reads" and "writes" (or both), though as for
BMEC, the meanings of these are not fully defined.  I suppose finer
filtering granularity might be supported in future (at least, it is not
explicitly ruled out).

James' current approach seems to be to pick a single BMEC flag that's
in the right sort of area for each MPAM bit (though not equivalent) and
translate that bit across to drive a corresponding the MPAM bit.  But
I'd say that this is arch-specific configuration masquerading as
generic configuration IMHO and not really generic at all.

See "untested: arm_mpam: resctrl: Allow monitors to be configured"
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.7-rc2&id=db0ac51f60675b6c4a54ccd24fa7198ec321c56d

I guess this needs discussion with James, since there will have been
additional thought process behind all this that is not captured; either
way, I guess it could be resolved after this series, but it will need a
decision before the MPAM support is merged (or at least, before MPAM
exposes userspace support for event configuration upstream).

(If this has already been discussed and James' current approach has
already been agreed as the least worst option, then I guess I can live
with it; I just find it icky, and it looks odd to have AMD specifics in
a common header.)

Cheers
---Dave

