Return-Path: <linux-kernel+bounces-36205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E6839D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453001F26D08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4365F;
	Wed, 24 Jan 2024 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaSArcDB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17E160
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054817; cv=none; b=JbAcdtjsRMMEs7Covcgg1b3py82P+Ask49WciFkyFoSbg5q74pZhl2Itbcv1dOTLeihTxYq+THysyluOu0JenI2/c5/7jOvREpH1MllQ4PyK515EkXbdIIBEvXARkMA/q5XAq7PT1012AvQhiIFfWSzUUcYYgitCFdYoFJPUkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054817; c=relaxed/simple;
	bh=Zttr/KeuzYSYZY0cBuuTJAS8nIvuPSG9mXTCnDc+F2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozVOg6n17MBr5FEcum97FAw8anbXXqqzBERlZwkv2NZa7VHqJv9x6PfsDeJuWX26Bh08SpNZsH+Rj+6VcYuxIHGNAJWF1BZU1bh6n6vc1Bo3out26yoQ8OLJ5OvM9kd1NqFtc4pDOcPjsylty/x9T8S81P4MtP0X2e2t6e/38mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaSArcDB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706054816; x=1737590816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zttr/KeuzYSYZY0cBuuTJAS8nIvuPSG9mXTCnDc+F2c=;
  b=RaSArcDB/VbIAZ8iH2PQWWdMoMEb+Cj9MOjZOgwNVsrYZ2UywX9FOfsi
   pbuZHB3BDHe+t05ok2oazyJaEFM1QztP/Lq1tGJwTQik7j49ZvheWQv6x
   61nWCRTsSOIrINQbFAM618nEHAY9oKQi5eI3I7S/QqMD2jN4sAXvP/yBM
   V0VbDpNa1ZQGoWnLMxZkqFUZELhoiVo5pDZgbZHoxGv2Usq3IpIFiw2UY
   ntZhPUNAJX4f1cfsNCknDwwOf/I5j6buQa9cktvLn2FOlnxWRkMX93amX
   w7GUzp46iuwsM/2gNCfQAIbHBpFunWhWLQURLG/Zhnpw+WIn4SA7641Pm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1536041"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1536041"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 16:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1724612"
Received: from guptapa-mobl1.amr.corp.intel.com (HELO windy) ([10.125.112.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 16:06:45 -0800
Date: Tue, 23 Jan 2024 16:06:37 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <20240124000637.jtb6djjzqvdfi4rg@windy>
References: <20240118173213.2008115-1-leitao@debian.org>
 <20240118173213.2008115-3-leitao@debian.org>
 <20240122205821.m5dsyi4sc2ghoavd@desk>
 <Za/Vy2l1VwyI4DKH@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za/Vy2l1VwyI4DKH@gmail.com>

On Tue, Jan 23, 2024 at 07:05:47AM -0800, Breno Leitao wrote:
> On Mon, Jan 22, 2024 at 12:58:21PM -0800, Pawan Gupta wrote:
> > On Thu, Jan 18, 2024 at 09:32:12AM -0800, Breno Leitao wrote:
> > > +config MITIGATION_RETBLEED
> > > +	bool "Mitigate RETBleed hardware bug"
> > > +	depends on CPU_SUP_INTEL || (CPU_SUP_AMD && MITIGATION_UNRET_ENTRY)
> > 
> > Atleast on Intel CPUs, Retbleed mitigation is meaningless without
> > spectre-v2 being mitigated, shouldn't this depend on MITIGATION_SPECTRE_V2?
> 
> I suppose it is the same for AMD, right?

AMD's retbleed problem and mitigation is a bit different, it has to do
with Branch Type Confusion(BTC). I am not sure if it is possible to
mitigate it without spectre-v2 mitigation. Someone from AMD should be
able to clarify. Looking at the code it appears the dependency is on
CONFIG_CPU_UNRET_ENTRY or CONFIG_CPU_IBPB_ENTRY being set:

retbleed_select_mitigation()
{
..
         case RETBLEED_CMD_AUTO:
                 if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
                     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
                         if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
                                 retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
                         else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
                                 retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
                 }

> So, I suppose it should be something as:
> 
> 	depends on (MITIGATION_SPECTRE_V2 && (CPU_SUP_INTEL || (CPU_SUP_AMD && MITIGATION_UNRET_ENTRY))
> 
> Is this better?
> 
> Thanks!

