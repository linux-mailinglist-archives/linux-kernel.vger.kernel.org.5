Return-Path: <linux-kernel+bounces-77154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB838601BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36E61F248A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4B548F3;
	Thu, 22 Feb 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOrdrx5y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1514B826
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627169; cv=none; b=vCMrd4IXzaUPVaw8pGkdrz/c404+7KtoUYaqlcMWc04TBRN5Mxjaf0aVJsCpyZGqM9q3czpXEuG8fCpGcLdc0zSZJV9tHVNjzQ52Ow+BSFerwIJrSQLzp+h7GO9DhmhnxOocvxmwKGrAeRLcsFU2qAnDBjAIOu3ocjMJcMwInak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627169; c=relaxed/simple;
	bh=ngJA9wPfkmM6Lvm9Tf7sAD8tyb/EoHcgny8Y03g0LKs=;
	h=Subject:To:Cc:From:Date:Message-Id; b=mDNAdMJxzLhbSt9ARrF3or5dNQhSkijBQt/XlzhP03NSh8CgfYclMrVGzHxwKrxeJvvA11U0Vv/cI8yf10+j0oRXHHTVKm7qpjIOwgfrm5gl/OxBhIgsi9XCoJ4WFOFQTBWFYE328DVJ0/DrKpZqmr6YLRFWcK4YgNZ5cRbAdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOrdrx5y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627168; x=1740163168;
  h=subject:to:cc:from:date:message-id;
  bh=ngJA9wPfkmM6Lvm9Tf7sAD8tyb/EoHcgny8Y03g0LKs=;
  b=VOrdrx5yBQ4ovUFDBEPeo5RlmcsLtmcYbGuuAwgUOK5ZHTdYzlWCdh1z
   Vs6Wu3i7TffhgljO421jHiNFHH2r4X+WkwLua6X5VnLJxkqUQzmVPsNll
   KA9IB7wxHXRz85guK8kdXKdII2aG/7Yf8c+Yz0az+DhYdMn7ytb1w3jFW
   L2TGbwDOWATfLLWdhJ97RGrhushBluSAdg/TQKABv2rVxpsHUBGbXy+4S
   IXndY+rn9m9oGYw0w2fKop60MRDRQaGFcKJHjdljqRP7vIZQ0fQeHy8HX
   YVyC7mZ9bN5VQG4/b4EhCXI8FxIqZqHe7XiQaEBULcCLurNM3YDeU72MR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14300035"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14300035"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5775805"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2024 10:39:26 -0800
Subject: [RFC][PATCH 00/34] [RFC] x86: Rework system-wide configuration masquerading as per-cpu data
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,rafael@kernel.org,lenb@kernel.org,mpatocka@redhat.com,snitzer@redhat.com,daniel@ffwll.ch,jgross@suse.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:26 -0800
Message-Id: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tl;dr: This tries to be more regimented in how system-wide x86 processor
configuration data is initialized.  It does that by moving fields out of
the per-cpu 'struct cpuinfo_x86' and into a new structure.  It also
requires that the boot CPU set these data up *once* and then be left
alone.

This is a more comprehensive approach to avoid the random tinkering
in patches like these:

	https://lore.kernel.org/all/20240131230902.1867092-1-pbonzini@redhat.com/

--

'struct cpuinfo_x86' is a mess.  At a high level, it can be thought
of as a CPU enumeration cache that (among other things) avoids using
CPUID constantly.  There's a copy of it for each CPU, but often the
'boot_cpu_data' version is the only one that counts.  Its fields are
written in basically random order, including a memcpy() into the
secondary processor copies from 'boot_cpu_data'.

This series focuses on a subset of the 'cpuinfo_x86' fields that must
be consistent across all CPUs:
 * The virtual and physical sizes supported by the CPU
 * The number of those physical bits that the caches comprehend
 * The size of a cacheline that CLFLUSH works on
 * The actual alignment that matters to the caches (can be different
   from that CLFLUSH size)

There are a few random folks cc'd here because their subsystem reads
one or more of these things in an x86 #ifdef of some kind.

There's a mishmash of ways to obtain these from CPUID, plus fixups
for erratum and general processor wonkiness.  There are also defaults
for these for processors that, for instance, don't even _have_ CPUID
support.  I think virt/phys_bits can be set and overwritten no fewer
than five times!

Let's bring some order to the chaos.

First, create some abstractions so that there are no longer direct
explicit accesses to some 'boot_cpu_data' fields.  This also provides
a way to do sanity checking so nothing consumes garbage.

Second, separate out the address configuration inputs from the
resulting values.  The inputs are provided in early boot by the boot
processor and stashed in x86_addr_config.

Third, remove global, shared configuration from 'struct cpuinfo_x86'.
Put it in a new structure: 'struct x86_sys_config'.

This creates a simple set of rules:
 1. The boot CPU populates 'bsp_addr_config' and nothing ever writes
    to it again
 2. get_cpu_address_sizes() reads 'bsp_addr_config' and writes
    'x86_config'
 3. 'bsp_addr_config' is never read again
 4. 'x86_config' is never written again

The centralized helpers also now provide a chance of enforcing those
rules.  Finish up the series by enforcing those rules and spitting out
a warning when they are violated.  This warning mechanism works in
*very* early boot and is a little unusual.  It could use some more
eyeballs (Subject: Enforce read-only x86_config state).

=== FAQ ===

== Why are both 'bsp_addr_config' and 'x86_config' needed? ==

Having defined, separate lifetimes helps enforce the new rules.

Once everything is in place 'bsp_addr_config' is only used at boot and
can be marked __init.  Mostpost can help find users of it that leak to
after boot.  Secondary CPU startup code can't be __init (because of
CPU hotplug) this helps ensure that 'bsp_addr_config' can only be
referenced from boot CPU code.

'x86_config' can also be __ro_after_init, which helps mitigate the
chance of it becoming tweaked after boot and growing into a little
mini version of 'boot_cpu_data' with all the same problems.

--

Ideas for future work (probably in another series):

 * Consolidate defaults in x86_config accessors and
   get_cpu_address_sizes() down to one copy
 * Can we do something more aggressive with x86_clflush_size()?  Is
   it ever anything other than 64 bytes on 64-bit?

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Juergen Gross <jgross@suse.com>

