Return-Path: <linux-kernel+bounces-80599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287D866A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1373BB21FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E518E2A;
	Mon, 26 Feb 2024 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqthvdpD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9261BF3B;
	Mon, 26 Feb 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929695; cv=none; b=HPU1tgyQ8der4qNE7tiU5HpV1MRq5sYGB3v7y5Dju3i+l7jPx2dALoAoX8jyVbF1JNPlMROy6rybtVzMRmthvwvd4OnuvPZPTulNr5MdYMv1gWkGGBBmfb5g1ad6emjDWNQD1kTuBlCLIH7OilxFwhULfjYmbFqoY7upDchKaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929695; c=relaxed/simple;
	bh=j40oYN2bGZFA2D+CuG1URy2KNXuvkXaM/JtfuChA0YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CD2jCAtYwr2mu0Nf2azxjEtxETc/CGzvn0ArXNCnGr/EyBPcu5I0bwmwnfZcqpOxrBGRsOGvEBZWYhumGAXqXNY7v2ovuy7hh4ASLNtpJd2iSed9wJY3kYc83JaYKjcVlKd4v7P6yM3Zf4Xt9qQaHDkrTKKBjDfqkiP5EczxbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqthvdpD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708929694; x=1740465694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j40oYN2bGZFA2D+CuG1URy2KNXuvkXaM/JtfuChA0YM=;
  b=HqthvdpD4/TEDSj1jSb2OyRHAg/shpBQHjd9ujOzcYVXUbuqM5Bbewd0
   VWwALX5HQeaOQW07a1GFqkoqkrOBQrxDx4Ep6A+XTc0mx3N1mm+1cmzId
   XcjQWysOb5yZD5DFJvNv1qzKosYyVP4nsJL7z/kXGWqVorJrh1bXS7q2B
   9s7sGL9TMx/WnD2yM2nbwsT5My3VLfAaT+D5LEDKGjO1xWIL/DMnDGGI3
   daHCeciOYq1fxJfpzV2MC6G8atiyyqpQKBbV2S4qp9ci6aW30GGH7N7EP
   jjSwIqPlCbWuTknrNijIHOy/V0sZ9y6OgtgINegOBiicHbTPgOIk9bBbT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14631258"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14631258"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6916072"
Received: from gcsargen-mobl1.amr.corp.intel.com (HELO [10.255.228.214]) ([10.255.228.214])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:41:34 -0800
Message-ID: <d152f185-d34f-4a06-be85-9bffd10175fc@linux.intel.com>
Date: Sun, 25 Feb 2024 22:41:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] platform/x86/amd/pmf: Add missing __iomem
 attribute to policy_base
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, Shyam-sundar.S-k@amd.com,
 mika.westerberg@linux.intel.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223163901.13504-1-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240223163901.13504-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/23/24 8:38 AM, Armin Wolf wrote:
> The value of policy_base is the return value of a devm_ioremap call,
> which returns a __iomem pointer instead of an regular pointer.
> Add the missing __iomem attribute.
>
> Compile-tested only.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/platform/x86/amd/pmf/pmf.h    | 2 +-
>  drivers/platform/x86/amd/pmf/tee-if.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index 16999c5b334f..bcf777a5659a 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -229,7 +229,7 @@ struct amd_pmf_dev {
>  	struct delayed_work pb_work;
>  	struct pmf_action_table *prev_data;
>  	u64 policy_addr;
> -	void *policy_base;
> +	void __iomem *policy_base;
>  	bool smart_pc_enabled;
>  };
>
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index f8c0177afb0d..16973bebf55f 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -346,7 +346,7 @@ static int amd_pmf_get_bios_buffer(struct amd_pmf_dev *dev)
>  	if (!dev->policy_base)
>  		return -ENOMEM;
>
> -	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
> +	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
>
>  	amd_pmf_hex_dump_pb(dev);
>  	if (pb_side_load)
> --
> 2.39.2
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


