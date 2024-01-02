Return-Path: <linux-kernel+bounces-14335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA1821B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D33283274
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15362FBEA;
	Tue,  2 Jan 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG0r85lG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B9FBE8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704198160; x=1735734160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jFWs60/Q3A2WBu1fa04HgfsxlZlwG1DcInPIPF0lIQ=;
  b=HG0r85lGaK7BZfyKTLyU9I2ZvYKSFT8Ctdl4djFusrb3MaaLDoS+mWbF
   r7lzLbxmjm10IFqiH1Tinx6jP/FRMVg+BSqrTpcJDb1E8X9F8rjmvrT/n
   5DvwhoZuMbMnnsd8QDRvWr6JT2sOmQD9EQ0hpaoLbkoGDcOKricGzxr2y
   6GJTiDof0mo8uQU4PcI9hGvPNPYz0W9XkmlonsW/d5V10IWp4CO2eNFt9
   BRArreg6vnTuU4mj/YKXXXlLB+YsRA5aJvtFTCLTpgN7T93YMnCWOvKvv
   Vxkh/n15yFP9RXOvJDSS99kDenSTjw25lf7LfwTKKb23+iQXAmJ1gbjZ+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4210771"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4210771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:22:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="729487207"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="729487207"
Received: from rmuntslx-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.36.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:22:36 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6615410A568; Tue,  2 Jan 2024 15:22:33 +0300 (+03)
Date: Tue, 2 Jan 2024 15:22:33 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
Message-ID: <20240102122233.fng76fdmq5xsqkhi@box.shutemov.name>
References: <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
 <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
 <20231205172436.GFZW9c1EaCaguGhglb@fat_crate.local>
 <20231205180813.phbxg5jdumfovshz@box.shutemov.name>
 <20231205185241.GGZW9xeTtiG6sORMTr@fat_crate.local>
 <20231205203337.GKZW+JIe9m2/QVi7Xl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205203337.GKZW+JIe9m2/QVi7Xl@fat_crate.local>

On Tue, Dec 05, 2023 at 09:33:37PM +0100, Borislav Petkov wrote:
> On Tue, Dec 05, 2023 at 07:52:41PM +0100, Borislav Petkov wrote:
> > So yes, we will fix your issue, no worries. I'm figuring out the
> > details as we speak.
> 
> So you can do for the short term:
> 
> ---
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index c461c1a4b6af..f8999f6d1b00 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -434,7 +434,7 @@ static void __init sev_map_percpu_data(void)
>  {
>  	int cpu;
>  
> -	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +	if (cc_vendor != CC_VENDOR_AMD || !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		return;
>  
>  	for_each_possible_cpu(cpu) {
> ---
> 
> until we've sorted out the bigger picture.

So, there seems no movement on the issue.

Borislav, could you share your view on the bigger picture. I can try to
implement it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

