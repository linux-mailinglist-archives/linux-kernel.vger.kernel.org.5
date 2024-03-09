Return-Path: <linux-kernel+bounces-97967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1F87727D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9DB21244
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F74C249ED;
	Sat,  9 Mar 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIHnnlHt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8E15B1;
	Sat,  9 Mar 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006107; cv=none; b=TD86GMvjK+7dIBFmCtwDCn61NLWqcq9XaevwRo7N7xJOQwFI0o++QMQVGIXFrlHI2d66VbO/KI4W85ZyP/aVhwQ7YmlitE268VJnCxFL6cct7Uch/Rg03h8u5H7J9mTidTCIa/nG6Cg24ycUcsyblXN+1NE+mI3s6XNDJJVnKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006107; c=relaxed/simple;
	bh=KvP3pQJflqN5TfqK6M4/lAhnNxI9v6UrGX+mjDEbnwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjsKFxxrL1PbkXO7fN+N7S/teQ/zR9rZ919qMo/B/uPRjEJse0UutJbfZarLZq0v/k9pLwBGaTFWybyAkXdqq+MIf1nc0VTKtljW3lbFomUGeGU2q3HtOVN1koN9BnVvWYhA5XzdALsY+b2UGHFCSynX9RJv+yvis5PQavEbAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIHnnlHt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710006106; x=1741542106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KvP3pQJflqN5TfqK6M4/lAhnNxI9v6UrGX+mjDEbnwQ=;
  b=iIHnnlHtvORWeORR1PsxH3jkYZy1oX7NgDJXw+Nf5ZkFklbQNcLbP3/7
   1Um9ZGN/012nhID43aqpbGW8bGeAZ/V2P6qo8QydYPs8k/4spTzSkud+h
   Q/VYRs/1lvdqexgNvA6BGBurCvy2qWa2XJAzXSIAp824s9kIWUfr/s6zC
   osm689yoKD/jEQDqO4Gticbxa+ZvDQQlOVj95NDp6yaaFEVK6d9YUfFPz
   fskFz3FDAMA1DLtXWddNKs623p1Ul43wp3jH76ijPJrnhlS8G+guS7Dzk
   2oFL6wsQZysy71T1EsDqlh7fqnWK4tdbx+Ot7qagW0uLJnpHDAojMzE58
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4598824"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4598824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 09:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="33912033"
Received: from chengyin-mobl.amr.corp.intel.com (HELO [10.209.27.224]) ([10.209.27.224])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 09:41:44 -0800
Message-ID: <42aa0678-4472-4964-b84e-33beb0a23058@linux.intel.com>
Date: Sat, 9 Mar 2024 09:41:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] platform/x86: wmi: Avoid returning AE_OK upon
 unknown error
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240308210519.2986-1-W_Armin@gmx.de>
 <20240308210519.2986-2-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240308210519.2986-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/8/24 1:05 PM, Armin Wolf wrote:
> If an error code other than EINVAL, ENODEV or ETIME is returned
> by ec_read()/ec_write(), then AE_OK is wrongly returned.
>
> Fix this by only returning AE_OK if the return code is 0, and
> return AE_ERROR otherwise.
>
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index d9bf6d452b3a..84d1ccf6bc14 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1218,8 +1218,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  		return AE_NOT_FOUND;
>  	case -ETIME:
>  		return AE_TIME;
> -	default:
> +	case 0:
>  		return AE_OK;
> +	default:
> +		return AE_ERROR;
>  	}

After checking the callers of acpi_wmi_ec_space_handler() it looks like there is no benefit in returning different ACPI status per error values. It is not being used. why no just return for result < 0 AE_ERROR and return for other cases?
>  }
>
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


