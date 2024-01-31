Return-Path: <linux-kernel+bounces-46775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB408443F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1208B2702D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861D12AAFF;
	Wed, 31 Jan 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DA9zV1fd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995312A146
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717840; cv=none; b=okfK757/urOMeCElkyYrQS00TP9c8FHoXz1UkimNdWdK6ui0NpFX7BF869cKPwBWakBgUJDJH8/iJJBgpN2P4NXp65x0DbFWLj0oYIovAVEXINB5E5FaLSLFV22k9fzlHpD1ympEU3wsV8e30dzJDafhzB7+62CFqMG+p7sXjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717840; c=relaxed/simple;
	bh=ZBvftZEA8h+jPKNWGdCM8l+DDEkktcde2JqVYxQKRIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quJ8aJamyPn/xQOr9+2VSTnVSpT7802MFRpRpp+dkgR3h/UWAccQ1Iq+7esvqLIzy2w3OkTWzWhoPj1jSJf679QP/MrQ0jtyh2lu0K51oAvvfu9jKOEY6vVvd2GiQzv5c1koxmKu30ijutuKPKU7pZ8Y4i35fyQfWZrDbHkVr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DA9zV1fd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706717838; x=1738253838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZBvftZEA8h+jPKNWGdCM8l+DDEkktcde2JqVYxQKRIU=;
  b=DA9zV1fdsGd1ty+1wGc4B6ac1Kpd1V03m0ZfTxgIUbeYSGoJe2vcL7d+
   Vwv+dS3OEvkDRLmAVHSfP9GRy43C/nrozgUARAp5Ry8PANPlqFR0Kd4qT
   gvgc+oSQkxmdzpOH2XT4VIMQVNT0N5VFAF0CfqQdkXmTDw/0j/TxtsQ9L
   7qinvr7m66kPNYEMdyFQVRJkvPD4SURPZ4bohfEJSNLLqPlXWrMJpShHu
   annkB+g1KOQej7EPgf9XgeXMLiE/0IZ8KtKeGEpR7cRcJNLofk6v5s8Tf
   27yWx2LxMPKoXa3HpugHGbjQJ2F3EzC58qR/uE6YF3W0doA6smPZQCfHW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2583358"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2583358"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 08:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822613711"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822613711"
Received: from dspeerx-mobl.amr.corp.intel.com (HELO [10.212.131.185]) ([10.212.131.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 08:17:16 -0800
Message-ID: <db477cef-f63b-4950-82b0-275bd10dbe5c@intel.com>
Date: Wed, 31 Jan 2024 08:17:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 4/5] x86: CVMs: Allow allocating all DMA memory from
 SWIOTLB
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
 <20240112055251.36101-5-vannapurve@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240112055251.36101-5-vannapurve@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 21:52, Vishal Annapurve wrote:
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -112,10 +112,14 @@ void __init mem_encrypt_setup_arch(void)
>  	 * The percentage of guest memory used here for SWIOTLB buffers
>  	 * is more of an approximation of the static adjustment which
>  	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 *
> +	 * Extra 2% is added to accommodate the requirement of DMA allocations
> +	 * done using dma_alloc_* APIs.
>  	 */
> -	size = total_mem * 6 / 100;
> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	size = total_mem * 8 / 100;
> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, (SZ_1G + SZ_256M));
>  	swiotlb_adjust_size(size);
> +	swiotlb_adjust_alignment(SZ_2M);

FWIW, this appears superficially to just be fiddling with random
numbers.  The changelog basically says: "did stuff".

What *are* "the requirement of DMA allocations done using dma_alloc_* APIs"?

