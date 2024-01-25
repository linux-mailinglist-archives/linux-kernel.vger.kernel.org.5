Return-Path: <linux-kernel+bounces-38344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA283BE18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13831C21566
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3C1CAA7;
	Thu, 25 Jan 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JC97NJBj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6571C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176572; cv=none; b=uX726LkWYJWf1V2z199Xki5WK2u7Ef4tfzmvauhPX0Vt/NuOSUBqeduBU10JlMFSWRfvLpcxnk8Mf2fVSKR3AyVx/eP7Bv0e5myx2Nk3NgdtXvpMR/9IIEm8AES7kNeqBxUjXWrIRHugMmG93ocMzEqlHjRFCdftmhmCRHgfZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176572; c=relaxed/simple;
	bh=0FglvjcoV5T/4Go2FaGM3w5PY2/YxleqKSSdfl2SFkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh49AXZEotDRbXXXD1xe0XiOGzAWh+/siAOxX0NwGNNVX1yGWSPaLt/3C70h6lgyg5dMRF/dHy68VMjMJN29CAiJC+KM+wUPERwGrUdikFTqp1ecp7Foy+q5Z+KObccPOO9C5P+A5Zndlg8pYwHLwo6W9HiCPUkvXz6WSjBaXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JC97NJBj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706176571; x=1737712571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0FglvjcoV5T/4Go2FaGM3w5PY2/YxleqKSSdfl2SFkk=;
  b=JC97NJBjVLhiHPRCLa5OEt+Sh9ZTmUZAHXFvlDnnItl9JqM3DNYvWtGQ
   bhfhoWhete0xSPGmp3QKj5Syt6fblUbcbao7jS95dSVIERCddGaOfl2lh
   ZEKVG75PWrBVR49rZOVWv0o1Gc0MTFG97UZ5T2vata45yXxa2T4LB8Knd
   UuQloHrqbkgTh5+HmyLrmnBMIfnnFEjpmwkTveVa/K6ABcoO5U94ZPrQN
   9Uwk6WxRucJYIUbVoVNu+si5dPbVOOnMziRiwiYvoXo4QKgJqvm03qeEN
   HFOq6Oxa2tNSGURndMUsX32qs0xTnzuYfHiPBbgcQMhZEPlEUD+SFb2Qj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1991541"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1991541"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:56:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="857016534"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857016534"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:56:08 -0800
Date: Thu, 25 Jan 2024 01:53:14 -0800
From: Ashok Raj <ashok_raj@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Wei Liu <wei.liu@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 01/22] x86/cpu/topology: Make the APIC mismatch
 warnings complete
Message-ID: <ZbIvis3zHeQLZerL@araj-dh-work.jf.intel.com>
References: <20240117124704.044462658@linutronix.de>
 <20240117124902.403342409@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117124902.403342409@linutronix.de>

On Tue, Jan 23, 2024 at 02:10:04PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Detect all possible combinations of mismatch right in the CPUID evaluation
> code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/include/asm/apic.h           |    5 ++---
>  arch/x86/kernel/cpu/common.c          |   15 ++-------------
>  arch/x86/kernel/cpu/topology_common.c |   12 ++++++++++++
>  3 files changed, 16 insertions(+), 16 deletions(-)

[snip]

> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -177,6 +177,18 @@ void cpu_parse_topology(struct cpuinfo_x
>  
>  	parse_topology(&tscan, false);
>  
> +	if (IS_ENABLED(CONFIG_X86_LOCAL_APIC)) {
> +		if (c->topo.initial_apicid != c->topo.apicid) {
> +			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
> +			       cpu, c->topo.initial_apicid, c->topo.apicid);
> +		}
> +
> +		if (c->topo.apicid != cpuid_to_apicid[cpu]) {
> +			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
> +			       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
> +		}

Should we consider tainting the kernel when there is any mismatch?

