Return-Path: <linux-kernel+bounces-77188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A18601E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD6A288E15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8514F975;
	Thu, 22 Feb 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbJzUVpr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82314EFFF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627216; cv=none; b=S1r6khniYM1SOcyJbKsyQ/r8aJNIoXhG7UWr2IQX13alUPcl9KKKnFDj2SZMyJWl7JHhYnoJFQzObYkfNNFNghzdJdyhsodeNkA4VeokrvEKH/nB5+k40LB0MBUOOnqewRdH0AnTX4XeLmKxb1FKpDniR1Y5CFCzZ2YL+7GVj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627216; c=relaxed/simple;
	bh=fXLqFFG0AjuZrNznR9RhW13fpkiv+9dzopyFF9ZKnd8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=EFRdR6niaVWXJ41qfgFGnRZutbjvTZbpulnZQr28Kr5c7FdqjzichCOkeFGKY2EcKeg+j4/C1oIx6ig0DKGJYergS8KUmxggXmWgIxLbDe0VZn9iG1JVAjH/oYx0O1I1l5sriZ5Cum7TjZ8vxyRtEK/t0A/w4z2unMaa1g0vkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbJzUVpr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627212; x=1740163212;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=fXLqFFG0AjuZrNznR9RhW13fpkiv+9dzopyFF9ZKnd8=;
  b=PbJzUVpr/JqnOoEKivrbAsqqXjDMAEMSsHe40XLy6eXIuaYAsTqMVOC8
   YzSvumvh+ZuVm6pQLD9GboRJQbLdTtNHd40mMwZqli3LKE8cUIROO9wkc
   4cBudFY/ayMa3xK669AOJsruGyfB2aXHV6cl0IMPxX9k20fzoXUxXsZcA
   UAAPoxkn76ZXF9iXZL9SwQNuVg56zEjFn8CLwzHnj6yHlmE/8LOIjpVxk
   xhm1vm33mFUQKoQ2bDGuxCOvg3KFVNh6E5pheDEaNYrVtj6z6hHlsZegY
   5iRitYgCrB+e7nb7VN3+Usd3aHlN6FcVxcy7UC9nhyAQvlKcwsKv2eKRc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584610"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584610"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265320"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:12 -0800
Subject: [RFC][PATCH 34/34] x86/cpu: Mark new boot CPU and config structures appropriately
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:11 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184011.9FCCBCBD@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Just to recap the rules:

 1. 'bsp_addr_config' is only used in early boot by the BSP.
 2. 'x86_config' is only written once by the BSP and can be
    used read-only during normal system operation

Mark 'bsp_addr_config' so it goes away after boot *and* non-init
references to it can be detected and warned about.

Mark 'x86_config' as __ro_after_init so it does not turn into the same
mess that 'boot_cpu_data' is.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86/kernel/setup.c~mark-new-structs arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~mark-new-structs	2024-02-22 10:09:05.173109438 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:09:05.177109595 -0800
@@ -131,8 +131,8 @@ struct ist_info ist_info;
 struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
 
-struct x86_addr_config bsp_addr_config;
-struct x86_sys_config x86_config __read_mostly;
+struct x86_addr_config bsp_addr_config __initdata;
+struct x86_sys_config x86_config __ro_after_init;
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
_

