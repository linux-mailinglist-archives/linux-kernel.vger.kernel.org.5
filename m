Return-Path: <linux-kernel+bounces-143046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7698A338B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD51B232D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43791487FF;
	Fri, 12 Apr 2024 16:18:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE86446BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938685; cv=none; b=kmt3YkTjtNqODHjq2/aQ4g74pRks5+CWXxRdf+/Xar/x/g4grUm3ojSadQDirpIDpsBFawJS5U4+s/SlaOwCiSen1HZ8BFBzuTaiAspo5olYzmrGQF8TW8GWIl9FOOpVM7BZi3GB8JN6aaao70JB7cdE89MMEGssrrJ85YnLeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938685; c=relaxed/simple;
	bh=uszwOdJLkaMVkV6UAk2fH9FDshpx6WSiAMT2XMXso/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXnp6QLdzIcJp/uJK1kBYn8Y1JHBAhQoiqpkOaRdF1wY9CSFqnoj47KFe7HaS9aSIIleV609PEjdTf3UHb1hgD6E+eZR2TlJLrt+Knx9wUW5QlAmfghkP1nJJhl5E9nEUWDLrywleJp+NRPeUcWuqNetKCleHQ6SAG0XCdtwEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C784339;
	Fri, 12 Apr 2024 09:18:32 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A559D3F64C;
	Fri, 12 Apr 2024 09:18:00 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:17:58 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: David Hildenbrand <david@redhat.com>, James Morse <james.morse@arm.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
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
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
Message-ID: <ZhletgrBN8tN2fCB@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
 <ZhfwEF5EJiTM5Hjm@e133380.arm.com>
 <4bc84ef2-6db4-4d3b-9b48-42396e78356c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc84ef2-6db4-4d3b-9b48-42396e78356c@intel.com>

On Thu, Apr 11, 2024 at 10:35:56AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/11/2024 7:13 AM, Dave Martin wrote:
> > On Tue, Apr 09, 2024 at 10:05:33AM +0200, David Hildenbrand wrote:
> >> On 21.03.24 17:50, James Morse wrote:
> >>> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> >>> searching closid_num_dirty_rmid") added a Kconfig option that causes
> >>> resctrl to search for the CLOSID with the fewest dirty cache lines when
> >>> creating a new control group. This depends on the values read from the
> >>> llc_occupancy counters.
> > 
> > [...]
> > 
> >> It's weird to not see RESCTRL_RMID_DEPENDS_ON_CLOSID appear in any Kconfig file.
> >> I guess it will all make sense once the refactoring is done :)
> > 
> > Agreed; a stub Kconfig item could be added, but since the file layout
> > and naming conventions change after this patch, doing this would
> > probably just create noise in the series though.
> > 
> > Looking at <linux/kconfig.h> (yikes!), IS_ENABLED() is designed to do
> > the right thing for non-existing Kconfigs...
> > 
> > If nobody is too concerned about the temporarily dangling IS_ENABLED()s
> > in this series, I won't propose any change here.
> 
> I am not concerned about this. Please note that these IS_ENABLED() checks
> are not introduced in this series, they were introduced in the previous
> portion of this MPAM work that can be found in upstream resctrl.
> 
> Reinette
> 

Ah, right.  Thanks for the explanation.

Cheers
---Dave

