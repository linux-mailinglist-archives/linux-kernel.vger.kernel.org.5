Return-Path: <linux-kernel+bounces-24842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768082C34E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB5D1F22733
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318F7316B;
	Fri, 12 Jan 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqnrWroN"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E126EB79
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705075642; x=1736611642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gJvMDDaNQOzwnZXgG/ZxbNuPh7MjsOZjab+zr5MaACk=;
  b=PqnrWroNWvmOP++ay3ghhVY0vzsY90jt9h9/z6Ck4xXPUivZR6EuO83u
   MpDoEXiygtMZacfmxtxZ08g67IbSdxus13l3MX6wMeorGWG+/uA+p4kg6
   Z1aXWOKpwcY7EwgMjnvIf6LccGgGUuIpyuScqdy24NnPvdCLq8XFLIqDx
   +FyKlVrzjRujIPk6id4uBiF8gqjE587xSf70Yfqcbmt0XIaaq6mBBnshN
   fNf+DDhoYcuffBwlvq/nKUcJdN+aNyJ/ktCpggSZOLBCnuvrxSA4cgXaT
   5rsRelYfGXkGOFFpJFxtuiRgJqTClPsuiba9G1C9QBCqGuKgseM+Ys8z/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="396348886"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="396348886"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 08:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="759171711"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="759171711"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149]) ([10.93.22.149])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 08:07:19 -0800
Message-ID: <2c29a7ba-2ef8-4e2c-90d3-1ea2aeea48ec@intel.com>
Date: Sat, 13 Jan 2024 00:07:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/2024 11:32 AM, Kuppuswamy Sathyanarayanan wrote:
> During the TDX guest attestation process, TSM ConfigFS ABI is used by
> the user attestation agent to get the signed VM measurement data (a.k.a
> Quote), which can be used by a remote verifier to validate the
> trustworthiness of the guest. When a user requests for the Quote data
> via the ConfigFS ABI, the TDX Quote generation handler
> (tdx_report_new()) forwards the request to VMM (or QE) via a hypercall,
> and then shares the output with the user.
> 
> Currently, when handling the Quote generation request, tdx_report_new()
> handler only checks whether the VMM successfully processed the request
> and if it is true it returns success and shares the output to the user
> without actually validating the output data. Since the VMM can return
> error even after processing the Quote request, always returning success
> for the processed requests is incorrect and will create confusion to
> the user. Although for the failed request, output buffer length will
> be zero and can also be used by the user to identify the failure case,
> it will be more clear to return error for all failed cases.
> 
> Validate the Quote data output status and return error code for all
> failed cases.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> 
> Changes since v1:
>   * Updated the commit log (Kirill)
> 
>   drivers/virt/coco/tdx-guest/tdx-guest.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..61368318fa39 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -228,6 +228,12 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>   		goto done;
>   	}
>   
> +	if (quote_buf->status != GET_QUOTE_SUCCESS) {
> +		pr_err("GetQuote request failed, ret %llx\n", quote_buf->status);
> +		ret = -EIO;
> +		goto done;
> +	}
> +
>   	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
>   	if (!buf) {
>   		ret = -ENOMEM;


