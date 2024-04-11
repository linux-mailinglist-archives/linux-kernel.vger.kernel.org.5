Return-Path: <linux-kernel+bounces-140625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01178A16F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6ED289DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9214EC6E;
	Thu, 11 Apr 2024 14:17:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6914E2DE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845028; cv=none; b=VkZQZyemuehClQXX4k4uTa6ry7Cq6eKV0ZZlzEoQKZ+/T5sQpfoATB9tVMhErYjbC+/EMcTHTtLiHxHxDPrqC59FbyqNxTcwjeb9vH95B7EbPRnL7HxzIr3jhNhvxnkwRkDpkSm/VM6RtFErd4q/gp3c81WVWRfEu1B0dsZY1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845028; c=relaxed/simple;
	bh=hFpPbCUdGEDxZtHZpIbjnwRnJOUcczaR3P0MhRNYSRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg9nNH42zzAumwvOxtUc13GtngiT4aKemCGnFd7FpKcb0T4vMasJMTLn8KsKkL9BhCEO7AmjHQ2jXE3OVDeoEHqq9NARxI1bTnTetJG+GOr1qAGtTb9S8G4etYwaHC9ePySEW3goJp3qAuxMJ5/Y/SQdS0nlqHCyka8SGdaUiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 443A4339;
	Thu, 11 Apr 2024 07:17:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1C953F64C;
	Thu, 11 Apr 2024 07:17:03 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:17:01 +0100
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
Subject: Re: [PATCH v1 18/31] x86/resctrl: Allow
 resctrl_arch_mon_event_config_write() to return an error
Message-ID: <Zhfw3d3YCKu7PD3G@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-19-james.morse@arm.com>
 <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>

On Mon, Apr 08, 2024 at 08:23:36PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > resctrl_arch_mon_event_config_write() writes a bitmap of events provided
> > by user-space into the configuration register for the monitors.
> > 
> > This assumes that all architectures support all the features each bit
> > corresponds to.
> > 
> > MPAM can filter monitors based on read, write, or both, but there are
> > many more options in the existing bitmap. To allow this interface to
> > work for machines with MPAM, allow the architecture helper to return
> > an error if an incompatible bitmap is set.
> > 
> > When valid values are provided, there is no change in behaviour. If
> > an invalid value is provided, currently it is silently ignored, but
> > last_cmd_status is updated. After this change, the parser will stop
> > at the first invalid value and return an error to user-space. This
> > matches the way changes to the schemata file are made.
> > 
> 
> Is this needed? With move of mbm_cfg_mask to rdt_resource I expect
> MPAM would use it to set what the valid values are. With that done,
> when user space provides a value, mon_config_write() compares user
> provided value against mbm_cfg_mask and will already return early
> (before attempting to write to hardware) with error
> if value is not supported. This seems to accomplish the goal of this
> patch?

This sounds plausible.

In a recent snapshot of James' MPAM code, it looks like we could be
initialising rdt_resource::mbm_cfg_mask when setting up the rdt_resource
struct for resctrl, though in fact this information is captured
differently right now.  I'm sure why (though James may have a
reason). [1]

I don't see an obvious reason though why we couldn't set mbm_cfg_mask
and detect bad config values globally in mon_config_write(), the same as
for the existing AMD BMEC case.

Nothing in the MPAM architecture stops hardware vendors from randomly
implementing different capabilities in different components of the
system, but provided that we only expose the globally supported subset
of event filtering capabilities to resctrl this approach looks workable.
This consistent with the James' MPAM code deals with other feature
mismatches across the system today.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2#n730

> 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> 
> ..
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 8a7367d1ce45..6705d7960dfd 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -200,6 +200,7 @@ struct resctrl_mon_config_info {
> >  	struct rdt_domain   *d;
> >  	u32                  evtid;
> >  	u32                  mon_config;
> > +	int                  err;
> >  };
> 
> Please take care to use consistent spacing.
> 
> Reinette

Noted FWIW (though I guess this code might change or go away).

Cheers
---Dave

