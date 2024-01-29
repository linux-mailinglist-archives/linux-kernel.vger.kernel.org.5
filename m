Return-Path: <linux-kernel+bounces-42550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384798402F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B0F2846E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F851C2C;
	Mon, 29 Jan 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="STCR4vUq"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423744371
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524888; cv=none; b=pkkSXxqQ7hcgG5zNvMXB61XZbyRn2GJRD+JFc2xUYnbqCkqUwbI1etvT2/ovzl78tfKWrZ0Vbndcx0KeazlizCI3d5X0QFQF36ChHsJzR2WOpHqG+gSFGBEnuPqeuw4RCtTq7C5MmYjx8a20bmlGZux7ARg3Hjbxevs/drcadV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524888; c=relaxed/simple;
	bh=mziL3smNpACHeEVkLl7JlHuipOHyJpTEIIo2FfIWXuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyyUVIyAsvotaGObiMf3rh79ElZ3koehj6JcWVfgFRTXSZx6XIGfja0w4JUT2UY6lGE+hs5WkuqPQ+RFiSFd9njLvcGSqDwKHouDnvdPPaU5a//Lkl9LBUYVYAEqJIyvEQ9CRa7ulLeZgU27glwVz1jMYf7bXKlCLB8Mw3MsJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=STCR4vUq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1112)
	id 6E48820E67D1; Mon, 29 Jan 2024 02:41:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E48820E67D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706524885;
	bh=poMPwNlCA9ASorWGoIcCLj1xsjtr7a7gs6hsW60aNI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STCR4vUqyLhO4ItMg9dbXnXPUlEmkYF6gyp14yscuoLtZTrCQSj4wR0JAliItBFGf
	 iTjjeMxbC+Rm9iTq6PzFtGwSiVnZFo0Uwv6sjiaTrowrStgJ40D5FrKwAqV4155FOH
	 Pc+DWe8upwpS7MAFselbmv8CaIkRfQpzeZK3Dv+c=
Date: Mon, 29 Jan 2024 02:41:25 -0800
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 07/11] x86/sev: Provide SVSM discovery support
Message-ID: <20240129104125.GA20729@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <2518c82f24f3e5d7533eea72512cea9ce985704b.1706307364.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2518c82f24f3e5d7533eea72512cea9ce985704b.1706307364.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 26, 2024 at 04:16:00PM -0600, Tom Lendacky wrote:
> The SVSM specification documents an alternative method of discovery for
> the SVSM using a reserved CPUID bit and a reserved MSR.
> 
> For the CPUID support, the #VC handler of an SEV-SNP guest should modify
> the returned value in the EAX register for the 0x8000001f CPUID function
> by setting bit 28 when an SVSM is present.
> 

It seems awkward that the guest would have to set the bit in the CPUID response
itself. Is there no way for the SVSM to fixup the CPUID page contents, or the
CPUID instruction return?

Could you also add a definition for the feature to arch/x86/include/asm/cpufeatures.h.

> For the MSR support, new reserved MSR 0xc001f000 has been defined. A #VC
> should be generated when accessing this MSR. The #VC handler is expected
> to ignore writes to this MSR and return the physical calling area address
> (CAA) on reads of this MSR.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h |  2 ++
>  arch/x86/kernel/sev-shared.c     |  4 ++++
>  arch/x86/kernel/sev.c            | 17 +++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index f1bd7b91b3c6..4746135cbe21 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -622,6 +622,8 @@
>  
>  #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>  
> +#define MSR_SVSM_CAA			0xc001f000
> +
>  /* AMD Collaborative Processor Performance Control MSRs */
>  #define MSR_AMD_CPPC_CAP1		0xc00102b0
>  #define MSR_AMD_CPPC_ENABLE		0xc00102b1
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index f26e872bc5d0..9bd7d7e75b31 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -628,6 +628,10 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		/* node ID */
>  		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
>  		break;
> +	case 0x8000001f:
> +		if (vmpl)
> +			leaf->eax |= BIT(28);
> +		break;
>  	default:
>  		/* No fix-ups needed, use values as-is. */
>  		break;

