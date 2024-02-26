Return-Path: <linux-kernel+bounces-80583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F618669F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065F21F22565
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B021BC4C;
	Mon, 26 Feb 2024 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdOIx5Lz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942301B7E5;
	Mon, 26 Feb 2024 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928125; cv=none; b=QbOOoAUL5IXX+vxWGh9wPKivFUoVoPXdGdxoZZKmclIyHHFxoFk66Ci9jQeavQxnWdgbPS1CBt1F+zMEmF494+s1oplljDxj7tYqOrXnOqxO0e7QZ0iPAJWvl4Rxo6Mijo8uaeF6Za7uTgOstSrCzt1LO4U3DSnMYVQEYHGs3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928125; c=relaxed/simple;
	bh=HQrmzzWDLhjubSxo7AflYgWxHtE1KBZ4wM94UIcsutI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JZoP/csszWS5KyZ5jrVEfZXVUbHVwKVqYPAPLM8oAN1e63i5iNXFO+ij/vKEF2pzUB5pO0uzn/MbXrFv5BUnXrVyjrMCe//RP2VEptiFqXgXyfc36nkDiWN6mB/f53qEmQ9zcEabz/lEr/5/LLlVRSTJTNilMCefHYU6e24J7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdOIx5Lz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708928124; x=1740464124;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HQrmzzWDLhjubSxo7AflYgWxHtE1KBZ4wM94UIcsutI=;
  b=HdOIx5Lzp9s7aqFX4wQzozw2eFIhPxCiPKoAqZBoKOWL0Z4h50Cz54bT
   HLFozFWbKU71k3JywoISJO1PeP/oprs0ufLVTEMOuU4MxMpvVa1zxTgod
   mUn2OKf1oKOjWbkRq5i0o+FYvi/wvSiEZJxa03n7OwKIhrXBTBuTlX4Uq
   u39Z70cvowFW/x6o29V8levyX+LjuYASOsW0PhujRmm9flvYvW6hEo9lU
   cpZBnApuFSPOpgfO/tJcaIy2Q4puEH2ctgkfwDmIihJ91GVfbiAjI38nt
   cZ1MyidEMvNKyqavVe0tLWTnBYrs1oHA4ne5z/B6xCafmL7qCD7ZcQG33
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3738339"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3738339"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11130153"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2024 22:15:20 -0800
Message-ID: <1e3b71a7-1515-4533-a102-34509f8b2f01@linux.intel.com>
Date: Mon, 26 Feb 2024 14:09:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, David Woodhouse
 <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
References: <20240211175143.9229-1-erick.archer@gmx.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240211175143.9229-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 1:51 AM, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because DMAR_LATENCY_NUM
> is the number of latency types defined in the "latency_type" enum.
> 
> enum latency_type {
> 	DMAR_LATENCY_INV_IOTLB = 0,
> 	DMAR_LATENCY_INV_DEVTLB,
> 	DMAR_LATENCY_INV_IEC,
> 	DMAR_LATENCY_PRQ,
> 	DMAR_LATENCY_NUM
> };
> 
> However, using kcalloc() is more appropriate [2] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link:https://github.com/KSPP/linux/issues/162  [1]
> Link:https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments  [2]
> Signed-off-by: Erick Archer<erick.archer@gmx.com>
> ---
>   drivers/iommu/intel/perf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

I have queued this patch for v6.9.

Best regards,
baolu

