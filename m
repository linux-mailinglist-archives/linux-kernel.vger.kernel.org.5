Return-Path: <linux-kernel+bounces-140660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDBD8A1769
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8096A1C20F18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A93DDD8;
	Thu, 11 Apr 2024 14:38:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08224DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846306; cv=none; b=OsS/5YuJBSVIgKZweiIhxfX4ZjnXHoCt1zR6UYrkT2fkAivl+0HYJR6O6NjFmORQLEQRBn8pPCQoa05Se6FlvY2FJJmWJ3/aUt9uBmXfB2kTtsDsxVgE9YtEfVWRbWemXtj6vjnbvvoBF/7xg5DGkrvQHcg5aK+LPycYTo+39BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846306; c=relaxed/simple;
	bh=OK8+Son5Z8AEopqkXnz1w53B1Kw4C3yIEMVEHHRXc74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6rB/7yKgxHmOaatKLSptw8117UBU6AeLNcL/1Vpg2fnm+Xn5TlB3EKueqUIhA+Wh9xQ8F27FGA8gaQ9nwkAR+cf/wnVm5fLVSjLYxk8Y9xkk9EE4bWR7taaeo91YufJGDnNNIc1RojSO1bQ15oh7PbdnYGaxh/aM6epFlk/kTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC5D611FB;
	Thu, 11 Apr 2024 07:38:53 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F583F64C;
	Thu, 11 Apr 2024 07:38:21 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:38:19 +0100
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
Subject: Re: [PATCH v1 22/31] x86/resctrl: Make resctrl_arch_pseudo_lock_fn()
 take a plr
Message-ID: <Zhf1244gRHVueI2u@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-23-james.morse@arm.com>
 <6589ae7b-95bb-4490-83ac-95904da7649f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6589ae7b-95bb-4490-83ac-95904da7649f@intel.com>

On Mon, Apr 08, 2024 at 08:24:35PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
> > and takes a struct rdtgroup as an argument.
> > 
> > After the filesystem code moves to /fs/, the definition of struct
> > rdtgroup will not be available to the architecture code.
> > 
> > The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
> > for the CLOSID. Embed that in the pseudo_lock_region as a hw_closid,
> 
> Above creates expectation that the new member will be named hw_closid,
> but that is not what the code does.

I'll flag this for review, but I'd guess that this can probably just be
"closid".  I'll make a note to consider what needs to change to make
things consistent between the patch and commit message.

James might have had other ideas, connected with the remapping done for
CDP emulation causing the resctrl closid being different from the actual
value used by the hardware, at least for MPAM (see my response on
patch 24).  I don't fully understand how this works for x86 though.

So long as functionality is unaffected, and this patch is introducing no
new confusion that wasn't there beforehand, the exact name may not
matter too much(?)

Did you have other concerns here?

Cheers
---Dave

