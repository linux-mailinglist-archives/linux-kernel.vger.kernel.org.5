Return-Path: <linux-kernel+bounces-48102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A6845742
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166AAB20D66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860215DBA4;
	Thu,  1 Feb 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="THozEcgT"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C415DBB1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790012; cv=none; b=MigbesTYSP4HDbUtXjE35NlC9lAj5AXg7EFtMGndDEV7e014wy+TFCQzh29KU9hFIEAfe/DQvo7cwkU3ljzVG9DvE8ebEBnZvxo1Ndp4qh2nzbjHbV45ppQfUUAetOx3Zm8xAierVJH5n6xfuId+4R2iXoGiVDI8YzZG4zehjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790012; c=relaxed/simple;
	bh=mkpPJwo8nkKG5bpESYi5qYl29ciuB88ElRNBgkzAMv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YANVtpVsMF9KkhQ4zgZbqrbrjB8nfG2OEKMIlcn5lt102+ENKFZjOHqH7K/+juVu4+Z9MCw2mqHwM4Vq5sliIantLsFSREVcI/7xgYeGqZ9XZtEEKMsvlU4Pt6y39c8GDwioUvAfsctPyCxdZMcQffnAb5u45Xoij7P6wAvIBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=THozEcgT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.66.96.10] (unknown [108.143.43.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 47181206FCCE;
	Thu,  1 Feb 2024 04:20:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47181206FCCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706790010;
	bh=DoGkwwTfNrBvre86yV2tHsglFQXvOb9/ZoWRaatJS54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THozEcgTrrRliYGkmJpSosuyTA8Ufby2M+CKXOrYTUpK3cTluLWnEniWX84AjNaJE
	 nNw6UOATefXyM8Y+odJnBinFjc4pIBOzS6/T81BmAVl2xgcr4AtoNnISj/ZKfVXytv
	 cfGCdqpmGjXFLpaONbOJJrTBwWPnlIvrASA6KzPw=
Message-ID: <0fda610f-a8ae-4133-a9d5-e9084c88ba7b@linux.microsoft.com>
Date: Thu, 1 Feb 2024 13:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 3/5] x86: CVMs: Enable dynamic swiotlb by default for
 CVMs
Content-Language: en-US
To: Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com,
 seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com,
 jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com,
 vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
 michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com,
 dave.hansen@linux.intel.com, linux-coco@lists.linux.dev,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de,
 m.szyprowski@samsung.com, bp@suse.de, rostedt@goodmis.org,
 iommu@lists.linux.dev
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-4-vannapurve@google.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20240112055251.36101-4-vannapurve@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 06:52, Vishal Annapurve wrote:
> CVMs used SWIOTLB for non-trusted IO using dma_map_* APIs. This series
> will ensure that dma_alloc_* API to also allocate from SWIOTLB pools.
> Initial size of SWIOTLB pool is decided using heuristics and has been
> working with CVM usecases so far.
> 
> It's better to allow SWIOTLB to scale up on demand rather than keeping
> the size fixed to avoid failures with possibly increased usage of
> SWIOTLB with dma_alloc_* APIs allocating from SWIOTLB pools. This should
> also help in future with more devices getting used from CVMs for
> non-trusted IO.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  arch/x86/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1566748f16c4..035c8a022c4c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
>  	select UNACCEPTED_MEMORY
> +	select SWIOTLB_DYNAMIC
>  	help
>  	  Support running as a guest under Intel TDX.  Without this support,
>  	  the guest kernel can not boot or run under TDX.
> @@ -1534,6 +1535,7 @@ config AMD_MEM_ENCRYPT
>  	select ARCH_HAS_CC_PLATFORM
>  	select X86_MEM_ENCRYPT
>  	select UNACCEPTED_MEMORY
> +	select SWIOTLB_DYNAMIC
>  	help
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory

What this does is unconditionally enable SWIOTLB_DYNAMIC for every kernel compiled
to support memory encryption, regardless of whether it runs inside a confidential guest.
I don't think that is what you intended.

Best wishes,
Jeremi



