Return-Path: <linux-kernel+bounces-123227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB38904CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB65BB22889
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53ED130E3B;
	Thu, 28 Mar 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OSCiqtkn"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2B130A4D;
	Thu, 28 Mar 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642676; cv=none; b=X2BlFPVTpWNqDhcrDeKaCanz4d8qleED+DU3p/+ribJhYRxaF+OcWR9D2vpXctnv0PLkZjqc6VZmhc3dxA++1DIC9lbnb6lfg/x2ueuAi7i3mFgkIdisdHhho2cyYmFyV1KGI8TnHyb1WvM903qpK5aK3v1CS0nPgbaY7Q1+qgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642676; c=relaxed/simple;
	bh=XXzHklSlwZUBc70mb+IrCrGHDHHicLnr6FwTlMm8dZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSimGF5uZI734DqLJXU1D+bCk3QXwp896bkCqtNl5bZpRwrydlDziAK3atuUQf3SFHFvjHPCQAKtJm60y2RyWJaWZukbAnLN+l7TCZiEN0O2VMh8hOHyw8sEVFjz/az//0YZL+Uhj0Bh76sJwHkHC+TorGOiJIKjV0+xWTKAWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OSCiqtkn; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SGGknu029299;
	Thu, 28 Mar 2024 16:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=O1mCM99rDKh1WnktnKGuwlFcn5k0KykkoCp2lndeuMg=;
 b=OSCiqtkn8xZcj7dr0jQBJM5mHq+Izb5Ir7I+Xzk/K8ZeLGHC/r7pLTDegj/BubOKPyol
 oCR8CBxkG0QMHMhRPGH8PmMVI09Tf0NAWaIVYuolQ4VLPi2VTd4tlIPiLEI1Up3iO+0t
 u5+N2X0xnNezU9MslN+WKpxNmaSdfWOEzMgBADr1KisT+gFKxq9DAWDFwYu60CYUefnF
 QOS+0/fMql4uW0HaT714ZHrzQNj8avHslcd3l9NUzAB990JQk/j4aRkSY7qWAXU10O1W
 WlMDmE8PXQf2oBAu+c4EjXRvrNVBudb3DILoXPyjTwC/c1B77T0DL6/pSM18lqfvcXEW Zg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3x51q7da27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:17:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 86D3313045;
	Thu, 28 Mar 2024 16:17:09 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 90E168014FE;
	Thu, 28 Mar 2024 16:17:05 +0000 (UTC)
Date: Thu, 28 Mar 2024 11:17:03 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
Message-ID: <ZgWX_x-CB7OjKAGD@swahl-home.5wahls.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328160614.1838496-1-steve.wahl@hpe.com>
X-Proofpoint-GUID: yktVL9b0sBOCXIFUqc1t4HYfWi__5IaH
X-Proofpoint-ORIG-GUID: yktVL9b0sBOCXIFUqc1t4HYfWi__5IaH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280111

Note: I cc:'d stable in the email headers by mistake.  NO CC: stable
tag, I don't want this to go into stable.

Thanks,

--> Steve

On Thu, Mar 28, 2024 at 11:06:14AM -0500, Steve Wahl wrote:
> When ident_pud_init() uses only gbpages to create identity maps, large
> ranges of addresses not actually requested can be included in the
> resulting table; a 4K request will map a full GB.  On UV systems, this
> ends up including regions that will cause hardware to halt the system
> if accessed (these are marked "reserved" by BIOS).  Even processor
> speculation into these regions is enough to trigger the system halt.
> And MTRRs cannot be used to restrict this speculation, there are not
> enough MTRRs to cover all the reserved regions.
> 
> The fix for that would be to only use gbpages when map creation
> requests include the full GB page of space, and falling back to using
> smaller 2M pages when only portions of a GB page are included in the
> request.
> 
> But on some other systems, possibly due to buggy bios, that solution
> leaves some areas out of the identity map that are needed for kexec to
> succeed.  It is believed that these areas are not marked properly for
> map_acpi_tables() in arch/x86/kernel/machine_kexec_64.c to catch and
> map them.  The nogbpages kernel command line option also causes these
> systems to fail even without these changes.
> 
> So, create kexec identity maps using full GB pages on all platforms
> but UV; on UV, use narrower 2MB pages in the identity map where a full
> GB page would include areas outside the region requested.
> 
> No attempt is made to coalesce mapping requests. If a request requires
> a map entry at the 2M (pmd) level, subsequent mapping requests within
> the same 1G region will also be at the pmd level, even if adjacent or
> overlapping such requests could have been combined to map a full
> gbpage.  Existing usage starts with larger regions and then adds
> smaller regions, so this should not have any great consequence.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> 
> Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> Reported-by: Pavin Joseph <me@pavinjoseph.com>
> Closes: https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
> Link: https://lore.kernel.org/all/20240322162135.3984233-1-steve.wahl@hpe.com/
> Tested-by: Pavin Joseph <me@pavinjoseph.com>
> Tested-by: Eric Hagberg <ehagberg@gmail.com>
> Tested-by: Sarah Brofeldt <srhb@dbc.dk>
> ---
> 
> v4: Incorporate fix for regression on systems relying on gbpages
>     mapping more than the ranges actually requested for successful
>     kexec, by limiting the effects of the change to UV systems.
>     This patch based on tip/x86/urgent.
> 
> v3: per Dave Hansen review, re-arrange changelog info,
>     refactor code to use bool variable and split out conditions.
> 
> v2: per Dave Hansen review: Additional changelog info,
>     moved pud_large() check earlier in the code, and
>     improved the comment describing the conditions
>     that restrict gbpage usage.
>    
> 
>  arch/x86/include/asm/init.h        |  1 +
>  arch/x86/kernel/machine_kexec_64.c | 10 ++++++++++
>  arch/x86/mm/ident_map.c            | 24 +++++++++++++++++++-----
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index cc9ccf61b6bd..371d9faea8bc 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -10,6 +10,7 @@ struct x86_mapping_info {
>  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
>  	unsigned long offset;		 /* ident mapping offset */
>  	bool direct_gbpages;		 /* PUD level 1GB page support */
> +	bool direct_gbpages_only;	 /* use 1GB pages exclusively */
>  	unsigned long kernpg_flag;	 /* kernel pagetable flag override */
>  };
>  
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index b180d8e497c3..3a2f5d291a88 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  #include <asm/cpu.h>
> +#include <asm/uv/uv.h>
>  
>  #ifdef CONFIG_ACPI
>  /*
> @@ -212,6 +213,15 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  
>  	if (direct_gbpages)
>  		info.direct_gbpages = true;
> +	/*
> +	 * UV systems need restrained use of gbpages in the identity
> +	 * maps to avoid system halts.  But some other systems rely on
> +	 * using gbpages to expand mappings outside the regions
> +	 * actually listed, to include areas required for kexec but
> +	 * not explicitly named by the bios.
> +	 */
> +	if (!is_uv_system())
> +		info.direct_gbpages_only = true;
>  
>  	for (i = 0; i < nr_pfn_mapped; i++) {
>  		mstart = pfn_mapped[i].start << PAGE_SHIFT;
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..a538a54aba5d 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -26,18 +26,32 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>  	for (; addr < end; addr = next) {
>  		pud_t *pud = pud_page + pud_index(addr);
>  		pmd_t *pmd;
> +		bool use_gbpage;
>  
>  		next = (addr & PUD_MASK) + PUD_SIZE;
>  		if (next > end)
>  			next = end;
>  
> -		if (info->direct_gbpages) {
> -			pud_t pudval;
> +		/* if this is already a gbpage, this portion is already mapped */
> +		if (pud_leaf(*pud))
> +			continue;
> +
> +		/* Is using a gbpage allowed? */
> +		use_gbpage = info->direct_gbpages;
>  
> -			if (pud_present(*pud))
> -				continue;
> +		if (!info->direct_gbpages_only) {
> +			/* Don't use gbpage if it maps more than the requested region. */
> +			/* at the beginning: */
> +			use_gbpage &= ((addr & ~PUD_MASK) == 0);
> +			/* ... or at the end: */
> +			use_gbpage &= ((next & ~PUD_MASK) == 0);
> +		}
> +		/* Never overwrite existing mappings */
> +		use_gbpage &= !pud_present(*pud);
> +
> +		if (use_gbpage) {
> +			pud_t pudval;
>  
> -			addr &= PUD_MASK;
>  			pudval = __pud((addr - info->offset) | info->page_flag);
>  			set_pud(pud, pudval);
>  			continue;
> 
> base-commit: b6540de9b5c867b4c8bc31225db181cc017d8cc7
> -- 
> 2.26.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

