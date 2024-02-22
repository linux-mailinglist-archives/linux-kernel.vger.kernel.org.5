Return-Path: <linux-kernel+bounces-77489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9817C860642
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A81F25ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C918AED;
	Thu, 22 Feb 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCaHFbZw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F417BCA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643342; cv=none; b=U7lQHQD0OzPIfKzNU3o3qyK/Xx7ezCmVWRToATU/Mw9iUH/KWH545QS/UiffVzxyW+q9Jg2HwE7R1D1o6fUbtox528YB1u55Px7euJS/yQ6C+rp29iZQ3s1sJm399W2fiieH9pSWoyxe1QkrZXj8vFCB99W2HlAO2d7mgtetsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643342; c=relaxed/simple;
	bh=CUEbmC3xxg97bqbF8nhMBRdSGGgUTSxwxVsPeikIJGo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kNBzRua7tNb7DjLyoT5mFecVX4shGWWYozMgDqYgRsNoCIplrnNGyfqKsn/XdgwQbu5xr+4ZI+D9rmPPHuAjYFnHvlZVq6L98ymoUNt3P8YXVonEPqbsoYqKoP+cVM09H+33bPdMbbD2HsU5C9dlPlPLObtfROC9uzecP3+SdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCaHFbZw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708643341; x=1740179341;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CUEbmC3xxg97bqbF8nhMBRdSGGgUTSxwxVsPeikIJGo=;
  b=WCaHFbZwyiEKDrBeuJWZNqt7vtiL341LVfYjouLZzJO0zzuSghYiX+/e
   0cPRErL2POOY+ueGSxy2xSC5sj5Cm534n1K67v43b2im26VCwkj7KcuzP
   wtzF9qjc1/8lzLUDQ6ejKOMztrWVk9nlYSP4woe3YCzTNtD0zrlf3FIpn
   jN1QssvPfmK30KPVPD0aYVR8m/C/g1Ce1t62cBT1xdpwG56tmVn9bl94U
   dA4MFseVTBVHTYwKu09JkIha2VriGnyJPLETmQ2YW/0wvzHXcDDcnsGjH
   Q5mmGsAAOfCBR/NRInfOaNU2tMS0dQEFzFfXadJR5QYm+rA/rHbENvlif
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6689157"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6689157"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 15:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936918708"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936918708"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 15:08:52 -0800
Message-ID: <3e237f17-7992-4852-8888-7a6e5a6de31c@linux.intel.com>
Date: Thu, 22 Feb 2024 15:08:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi x86 Maintainers,

On 1/10/24 7:32 PM, Kuppuswamy Sathyanarayanan wrote:
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
> ---

Can you consider merging this fix? It already got acks from Kirill, Kai and Li. Do
you want me rebase it and resend it with updated tags?

>
> Changes since v1:
>  * Updated the commit log (Kirill)
>
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..61368318fa39 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -228,6 +228,12 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>  		goto done;
>  	}
>  
> +	if (quote_buf->status != GET_QUOTE_SUCCESS) {
> +		pr_err("GetQuote request failed, ret %llx\n", quote_buf->status);
> +		ret = -EIO;
> +		goto done;
> +	}
> +
>  	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
>  	if (!buf) {
>  		ret = -ENOMEM;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


