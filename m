Return-Path: <linux-kernel+bounces-100004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C038587908D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7825D284EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C857A725;
	Tue, 12 Mar 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTEKdwgN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DA7A717
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235055; cv=none; b=ZuSUdE2KntyKjxTjL87Dl1TEXiAxCKz7Ps3L5niF9TymAeFlwaTio2zitonwoDdwoquMxfXjAHHNpKFhAqwhkI0Mr/BoTPqOK2pVV4+4bSBSPQF8BxzsWa3/XsnC0J30YTAGI5iewBhbkVdffJh9/YGdTQAJCQZ2HGBVGlslBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235055; c=relaxed/simple;
	bh=QMxcKhA+SHACk4dEgqI2TkWVEDXvIN+aSdu0THtt6tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcrZjNbu3AGx0t+4r4uXHAlCDpZI9ryQSZQY3XphYkwEUUALlqFgJYlwQzuzGqFuxp3XZ7coi4A4kCNq9ab9Hoi/zy8HHLoAD7mlh5+SXKcDUYnLnifnA9CVbnAXw83GAhJr6ZPEIZnslzwbFTb9tLv+qbeP8MyD4Ey/0el5mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTEKdwgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5574DC43390;
	Tue, 12 Mar 2024 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710235054;
	bh=QMxcKhA+SHACk4dEgqI2TkWVEDXvIN+aSdu0THtt6tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTEKdwgN3N16i+bUrWmfbz+NBgXWCcZvaXb8quYTXrAc4kQxke1E96Id/d3MFWbZ7
	 9ahuaXHy4A7XJxiGcdy6JAAHeV+SoticNJzLV56Xaf0ONzM5EQhsxBzhfQE8eyq4BC
	 oxJSeCi9OPLRRj8Gz7tCcbUB7WZbbhyA4TR+MQBRYJGY8aqDHwU/cFLBT3L0kcidCa
	 NaPO6550HOHhXAaqpyqxYfAJRRM/Zwpahc3XGq7G69avbC7qYOpS22bTdhB6E+wZ8t
	 4sFmeA1JUHuVb6QnXSVJnH5/p99rdfiAs+b1oWKjBCA6rDdn0MfwyIL1zmFaw8ADx8
	 NZt730lOg2Kgg==
Date: Tue, 12 Mar 2024 09:17:30 +0000
From: Lee Jones <lee@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <20240312091730.GU86322@google.com>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>

On Mon, 11 Mar 2024, Luis Chamberlain wrote:

> On Mon, Mar 11, 2024 at 09:11:27AM +0100, Michal Hocko wrote:
> > On Wed 06-03-24 06:45:54, Greg KH wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > sysctl: Fix out of bounds access for empty sysctl registers
> > > 
> > > When registering tables to the sysctl subsystem there is a check to see
> > > if header is a permanently empty directory (used for mounts). This check
> > > evaluates the first element of the ctl_table. This results in an out of
> > > bounds evaluation when registering empty directories.
> > > 
> > > The function register_sysctl_mount_point now passes a ctl_table of size
> > > 1 instead of size 0. It now relies solely on the type to identify
> > > a permanently empty register.
> > > 
> > > Make sure that the ctl_table has at least one element before testing for
> > > permanent emptiness.
> > 
> > While this makes the code more robust and more future proof I do not think
> > this is fixing any real issue not to mention anything with security
> > implications. AFAIU there is no actual code that can generate empty
> > sysctl directories unless the kernel is heavily misconfigured.
> > 
> > Luis, Joel, what do you think?
> 
> As per review with Joel:
> 
> The out-of-bounds issue cannot be triggered in older kernels unless
> you had external modules with empty sysctls. That is because although
> support for empty sysctls was added on v6.6 none of the sysctls that
> were trimmed for the superfluous entry over the different kernel
> releases so far has had the chance to be empty.
> 
> The 0-day reported crash was for a future out of tree patch which was
> never merged yet:
> 
> https://github.com/Joelgranados/linux/commit/423f75083acd947804c8d5c31ad1e1b5fcb3c020                                                                                                       
> 
> Let's examine this commit to see why it triggers a crash to understand
> how the out of bounds issue can be triggered.
> 
> Looking for suspects of sysctls which may end up empty in that patch we
> have a couple. kernel/sched/fair.c sched_fair_sysctls can end up empty when
> you don't have CONFIG_CFS_BANDWIDTH or CONFIG_NUMA_BALANCING. But the kernel
> config for the 0-day test was:                                                                                                                                                                         
> https://download.01.org/0day-ci/archive/20231120/202311201431.57aae8f3-oliver.sang@intel.com/config-6.6.0-rc2-00030-g423f75083acd                                                           
> 
> It has CONFIG_CFS_BANDWIDTH=y but CONFIG_NUMA_BALANCING is not set so
> this was not the culprit, but that configuration could have been a
> cause if it was possible.
> 
> In the same future-not-upstream commit kernel/sched/core.c sched_core_sysctls
> can be empty if you don't have the following:                                                                                                                     
> 
> CONFIG_SCHEDSTATS       --> not set on 0-day kernel
> CONFIG_UCLAMP_TASK      --> not set on 0-day kernel                                                                                                                                         
> CONFIG_NUMA_BALANCING   --> not set on 0-day kernel
> 
> So that was the cause, and an example real valid config which can trigger
> a crash. But that patch was never upstream.
> 
> Now, we can look for existing removal of sysctl sentinels with:
> 
> git log -p --grep "superfluous sentinel element"
> 
> And of these, at first glance, only locks_sysctls seems like it *could*
> possibly end up in a situation where random config would create an empty
> sysctl, but exanding on the code we see that's not possible because
> leases-enable sysctl entry is always built if you have sysctls enabled:
> 
> static struct ctl_table llocks_sysctlsocks_sysctls[] = {
>         {
>                 .procname       = "leases-enable",
>                 .data           = &leases_enable,
>                 .maxlen         = sizeof(int),                                   
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> #ifdef CONFIG_MMU
>         {
>                 .procname       = "lease-break-time",
>                 .data           = &lease_break_time,                             
>                 .maxlen         = sizeof(int),
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> #endif /* CONFIG_MMU */
> };
> 
> The out of bounds fix commit should have just had the tag:
> 
> Fixes 9edbfe92a0a13 ("sysctl: Add size to register_sysctl")
> 
> Backporting this is fine, but wouldn't fix an issue unless an external
> module had empty sysctls. And exploiting this is not possible unless
> you purposely build an external module which could end up with empty
> sysctls.

Thanks for the amazing explanation Luis.

If I'm reading this correctly, an issue does exist, but an attacker
would have to lay some foundations before it could be triggered.  Sounds
like loading of a malicious or naive module would be enough.

We know from conducting postmortems on previous exploits that successful
attacks often consist of leveraging a chain of smaller, seemingly
implausible or innocuous looking bugs rather than in isolation.

With that in mind, it is still my belief that this could be used by an
attacker in such a chain.  Unless I have this totally wrong or any of
the maintainers have strong feelings to the contrary, I would like to
keep the CVE number associated with this fix.

-- 
Lee Jones [李琼斯]

