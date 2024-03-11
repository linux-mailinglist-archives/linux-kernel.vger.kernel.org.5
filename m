Return-Path: <linux-kernel+bounces-99582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD0878A54
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2543B1F21B84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117256B98;
	Mon, 11 Mar 2024 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2HyfHV1P"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A652D607
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194272; cv=none; b=YA0yn1KrNkN7qR6GFIpxpVio5zIcBc4NMJT7AJzCTRm5/usnhkpLFpn++AtdTipRposQSZRFqz2GLz/QqhR9+QiG1gLM95lQz2x8zMuOypYq7kJkzOYcArO0/Zk6Dz8ERVoKEG2jwYuk09248vFMKAVoDr3rtiy8/LbBLV8r324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194272; c=relaxed/simple;
	bh=Rv9Xl1j2Gcr0kIXmY7aliGGWXvDwx4DEY45xBD8KKf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl45Z/Rl4VdoamPzwTYL9kwcmTOBc1p4Wsa1AASnXr6FP23qhWXo9osG6oAHEatcE3K4xzEF5O2CHV2Vogi3SU1qrpVm2i5GkTKotG0FQXx7awh07Styi0wZTYC6m3eDI5cABwQ+kKZR4bfFoyAGSiMMYBlUoM021n1elTt9/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2HyfHV1P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4fs5qTi08rtdMj6m38ky2WmttIn+ysNDMJCt2/7f4s=; b=2HyfHV1PVL/NE2cDbDJHeiy1by
	N0982YfxyXx0vvt33qIV5IcyEqdldIU+58/pjRNmZmRbqbZqkIVnREgwn5AdWkAbN0F8yzk23UQMU
	VDIE/X66mnWEDgJzflhNU2C4yBYNdt4sO1zuV2nLaKvQ09BpjW+Gf5ZMzklVtMZQPAhgs4Q1vW6sK
	zP3iUU3UxZ7FVAHD3VTO7zf0VTqk0HhK4rAOFPiaEXPU1RTcen76X99EbIR61N2Cpu+TUvPuiYPhJ
	UexPz2ovc4pR9iQMrGK2y3tQ0twwnqKMdFNKZqzIl8q6JuzKqwFSpaS6LMFwYIaH+fGVIEoH3+VTq
	9KU5n9Rw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjneY-00000003K68-0jvY;
	Mon, 11 Mar 2024 21:57:50 +0000
Date: Mon, 11 Mar 2024 14:57:50 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze68r7_aTn6Vjbpj@tiehlicka>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Mar 11, 2024 at 09:11:27AM +0100, Michal Hocko wrote:
> On Wed 06-03-24 06:45:54, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > sysctl: Fix out of bounds access for empty sysctl registers
> > 
> > When registering tables to the sysctl subsystem there is a check to see
> > if header is a permanently empty directory (used for mounts). This check
> > evaluates the first element of the ctl_table. This results in an out of
> > bounds evaluation when registering empty directories.
> > 
> > The function register_sysctl_mount_point now passes a ctl_table of size
> > 1 instead of size 0. It now relies solely on the type to identify
> > a permanently empty register.
> > 
> > Make sure that the ctl_table has at least one element before testing for
> > permanent emptiness.
> 
> While this makes the code more robust and more future proof I do not think
> this is fixing any real issue not to mention anything with security
> implications. AFAIU there is no actual code that can generate empty
> sysctl directories unless the kernel is heavily misconfigured.
> 
> Luis, Joel, what do you think?

As per review with Joel:

The out-of-bounds issue cannot be triggered in older kernels unless
you had external modules with empty sysctls. That is because although
support for empty sysctls was added on v6.6 none of the sysctls that
were trimmed for the superfluous entry over the different kernel
releases so far has had the chance to be empty.

The 0-day reported crash was for a future out of tree patch which was
never merged yet:

https://github.com/Joelgranados/linux/commit/423f75083acd947804c8d5c31ad1e1b5fcb3c020                                                                                                       

Let's examine this commit to see why it triggers a crash to understand
how the out of bounds issue can be triggered.

Looking for suspects of sysctls which may end up empty in that patch we
have a couple. kernel/sched/fair.c sched_fair_sysctls can end up empty when
you don't have CONFIG_CFS_BANDWIDTH or CONFIG_NUMA_BALANCING. But the kernel
config for the 0-day test was:                                                                                                                                                                         
https://download.01.org/0day-ci/archive/20231120/202311201431.57aae8f3-oliver.sang@intel.com/config-6.6.0-rc2-00030-g423f75083acd                                                           

It has CONFIG_CFS_BANDWIDTH=y but CONFIG_NUMA_BALANCING is not set so
this was not the culprit, but that configuration could have been a
cause if it was possible.

In the same future-not-upstream commit kernel/sched/core.c sched_core_sysctls
can be empty if you don't have the following:                                                                                                                     

CONFIG_SCHEDSTATS       --> not set on 0-day kernel
CONFIG_UCLAMP_TASK      --> not set on 0-day kernel                                                                                                                                         
CONFIG_NUMA_BALANCING   --> not set on 0-day kernel

So that was the cause, and an example real valid config which can trigger
a crash. But that patch was never upstream.

Now, we can look for existing removal of sysctl sentinels with:

git log -p --grep "superfluous sentinel element"

And of these, at first glance, only locks_sysctls seems like it *could*
possibly end up in a situation where random config would create an empty
sysctl, but exanding on the code we see that's not possible because
leases-enable sysctl entry is always built if you have sysctls enabled:

static struct ctl_table llocks_sysctlsocks_sysctls[] = {
        {
                .procname       = "leases-enable",
                .data           = &leases_enable,
                .maxlen         = sizeof(int),                                   
                .mode           = 0644,
                .proc_handler   = proc_dointvec,
        },
#ifdef CONFIG_MMU
        {
                .procname       = "lease-break-time",
                .data           = &lease_break_time,                             
                .maxlen         = sizeof(int),
                .mode           = 0644,
                .proc_handler   = proc_dointvec,
        },
#endif /* CONFIG_MMU */
};

The out of bounds fix commit should have just had the tag:

Fixes 9edbfe92a0a13 ("sysctl: Add size to register_sysctl")

Backporting this is fine, but wouldn't fix an issue unless an external
module had empty sysctls. And exploiting this is not possible unless
you purposely build an external module which could end up with empty
sysctls.

HTH,

  Luis

