Return-Path: <linux-kernel+bounces-141386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B88A1D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52787288E57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402811E5A99;
	Thu, 11 Apr 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFq7Wfze"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC71DDD12
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855598; cv=none; b=AzctTpfaIBFERRK7wWAoGRcGDoMqWKTBpo9MIkPrZQLJbLg0YhRqB85yjDm3wgmtt0gHGcdE0u9Qvib89BsWsVs8790Cy2bxxVKvFGKAxeH0QztiDdF18qJiQInGNzGA/tkXb8DNu2GOvnfYCNF1eWmmWRtytDU6qmIIGL99Xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855598; c=relaxed/simple;
	bh=JuCX7IDbA2E8+R/QgSHb55hwJv7782KYpQqi83nOWZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIEz8toRfdh0rqMF11by0s6uTNZyFHPTr+66Yw3RG9LTDb4nxG8miTfUPzZxcTu2idmeIiOHxdJydidMxEHCuZwtDs855ME5HUGsrfJOJxhiW0ITPMxHssPuE/qHQsktyMDGBKJQr4qpMZS7eD4ZGhNp725SBIz2ofqqUFB7g34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFq7Wfze; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712855597; x=1744391597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JuCX7IDbA2E8+R/QgSHb55hwJv7782KYpQqi83nOWZc=;
  b=CFq7Wfze45bUBUoWoaWaEtIgU2Ico8boaoA4hzHjh6kA4XSUIF7rfs5z
   qYXMc8yDWdT0cziFHL612YFQdm6K3SAoh35glW+Vc7/j0B3UZFYTg1gmW
   mjMgvm84ANLW8KHhVVlewwLxvEAnfxrautOrYPL7c01x6wZxphV6PyI5v
   O+cvrv+LMAbQbInb5/sVyfuqWJZFRu9It/t2tmYClCseJc/BwVC/uif9v
   7ZMCuc6na4doQq6hrWwoyuCO5mq+Zfm+cdnFmGkao9IS3tqy6r7esvIE8
   B1FB6ZZVLFGPYRpW4wDXAiW8duf+QXTA6uUXX0/pQ5CinuFfwMfM7K60c
   Q==;
X-CSE-ConnectionGUID: ofDVySbnR4aSuQiG35STpg==
X-CSE-MsgGUID: HWZh/aF9RzCe73MamyExzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19434544"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19434544"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:13:16 -0700
X-CSE-ConnectionGUID: AgNcAFEbT+6zyznhlNsBrQ==
X-CSE-MsgGUID: uJC+gPvsTkO3luzeB2Y5Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21050440"
Received: from tgrabows-mobl.amr.corp.intel.com (HELO [10.209.89.64]) ([10.209.89.64])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:13:15 -0700
Message-ID: <af4c78c1-ccd5-4c4d-92de-564a44fa815b@intel.com>
Date: Thu, 11 Apr 2024 10:13:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] x86/mm: Don't disable INVLPG if the kernel is
 running on a hypervisor
To: Sean Christopherson <seanjc@google.com>, Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240411144322.14585-1-xry111@xry111.site>
 <20240411144322.14585-2-xry111@xry111.site> <ZhgOPRIA5lyhTfGs@google.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <ZhgOPRIA5lyhTfGs@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 09:22, Sean Christopherson wrote:
> In other words, simply checking HYPERVISOR *might* be safe, but it might not.
> If we wanted to be paranoid, this could also check X86_FEATURE_VMX, which also
> doesn't guarantee VMX non-root mode and would unnecessarily restrict PCID usage
> to setups that allow nested VMX, but AFAIK there aren't any hypervisors which
> fully emulate VMX.

X86_FEATURE_HYPERVISOR is most commonly used for vulnerabilities to see
if the data coming out of CPUID is likely to be garbage or not.  I think
that's the most important thing to focus on.

It's arguable that x86_match_cpu() itself should just have a:

	/*
	 * Don't even waste our time when running under a hypervisor.
	 * They lie.
	 */
	if (boot_cpu_bas(X86_FEATURE_HYPERVISOR))
		return NULL;

(well, it should probably actually be in the for() loop because folks
might be looking for an X86_FEATURE_* that is set by software or derived
from actually agreed-upon host<->guest ABI, but you get my point...)

If the hypervisor is duplicitous enough to keep X86_FEATURE_HYPERVISOR
from getting set, then the hypervisor gets to clean up the mess.  The
kernel can just wash its hands of the whole thing.

So, there are two broad cases and a few sub-cases:

1. "Nice" hypervisor.  Kernel sees X86_FEATURE_HYPERVISOR and knows that
   x86_match_cpu() and invlpg_miss_ids[] are irrelevant because:
 1a.  It is running in VMX non-root mode and is not vulnerable, or
 1b.  CPUID is a lie and x86_match_cpu() is meaningless, or
 1c.  The kernel is in ring3 and can't execute INVLPG anyway.  Whatever
      is running in ring0 will have to deal with it.
2. X86_FEATURE_HYPERVISOR is unset.
 2a. "Mean" hypervisor. All bets are off anyway.
 2b. Actual bare metal. Actually look for the bug.

I _think_ I'm OK with skipping the mitigation in all of the #1 cases and
applying it in both of the #2 cases.  I don't think that checking for
VMX makes it much better.

Am I missing anything?

