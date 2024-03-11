Return-Path: <linux-kernel+bounces-98798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD92877F95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8D0283824
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A63D0A3;
	Mon, 11 Mar 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mg9M+WTn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32193C460
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158745; cv=none; b=iZD5mAfSPyalyS5fNHx8ktnGYHrgUYDiId9Ora+eudXTo6NcRaVjwF/Awq13rakf6v+bknAdKkKwdO4AYaHnIiVYCcADf/vZucoAVzyhCIhZpHWbgiMgSwh/8z2fghv7VgZoOLnZhs83ddnAdRRDiYvtFp9aNtMSdVodGr5kuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158745; c=relaxed/simple;
	bh=KImMKTG1EAP2NsDmf0Yhr0pijdhknh+XUu4hVW9JTdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5Pwyss5D4IdZr82IhPk+8AG3OolCyfbvor9ss3ZMGOBBO1MJS8dMJEpoGlHgdjfoW+z/mPp/mOPIgZ8nup0h5HfrSHzhb+01CgdvFZSBgT2Dak7UCYWh1uVyGZRwBA/AkAY2tggPIvA2lRYPXHHgxyHIi7/fe0gBX5C9V7ok5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mg9M+WTn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158744; x=1741694744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KImMKTG1EAP2NsDmf0Yhr0pijdhknh+XUu4hVW9JTdM=;
  b=Mg9M+WTnjuEbrJNqMN14jmaMfoM/IgFTvLdT56T6fJMBVKEQqKGPM2cn
   H3OddqxaTgeFgfBcKj/JCfyniz9KgppXN7QO/hLSZwSYi3YfvMQUHQ/pc
   5feE74cNgLc3xVTJ9wUcJ3HsiEZjTIkqxqGgZu4dfd6fs+HvYjyxFI7DR
   nUrZs30TY59+BKUDs9CRHkJolII5SeWWt73n31v4dHOXOYau6A2uIdh/T
   kfi77ztOnMA5mZcckA/HeAcIZU5UGRpDN4Vjs/mCygm44Fu/nGUciHJJ0
   9CoZmF+ETLJ39rU81dpS3/YRcwyplRHeBU53IBNLt4fBad525shQWp02D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4676524"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4676524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049707"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049707"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 05:05:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 55FB4177; Mon, 11 Mar 2024 14:05:39 +0200 (EET)
Date: Mon, 11 Mar 2024 14:05:39 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@intel.com, hpa@zytor.com, seanjc@google.com, ele.reshetova@intel.com, 
	rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Message-ID: <fivnqmu4rfm22ps4mevrmeq2oncjwxe6i2t5foptxxhdb6dzgp@dur4zezgxd23>
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
 <20240309210230.239045-5-kirill.shutemov@linux.intel.com>
 <95ba9bb3-7c48-4d99-b05e-5a45a796af3c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ba9bb3-7c48-4d99-b05e-5a45a796af3c@linux.intel.com>

On Sat, Mar 09, 2024 at 07:56:11PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 3/9/24 1:02 PM, Kirill A. Shutemov wrote:
> > TDX 1.0 generates a #VE when accessing topology-related CPUID leafs
> > (0xB and 0x1F) and the X2APIC_APICID MSR. The kernel returns all
> > zeros on CPUID #VEs. In practice, this means that the kernel can only
> > boot with a plain topology. Any complications will cause problems.
> 
> Is this issue only for TDX 1.0? What about TDX > 1.0?

TDX 1.0 defines the baseline for TDX. Any change in behaviour will be
gated by explicit opt-in. In this case, it is ENUM_TOPOLOGY.

> > The ENUM_TOPOLOGY feature allows the VMM to provide topology
> > information to the guest in a safe manner. Enabling the feature
> > eliminates topology-related #VEs: the TDX module virtualizes
> > accesses to the CPUID leafs and the MSR.
> >
> > Enable ENUM_TOPOLOGY if it is available.
> 
> I cant find the ENUM_TOPOLOGY in ABI spec (https://cdrdv2.intel.com/v1/dl/getContent/795381).
> 
> Can you point me to the correct document?

I guess JSON dump is out of sync with the PDF doc. See this:

https://cdrdv2.intel.com/v1/dl/getContent/733579

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

