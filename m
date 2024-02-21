Return-Path: <linux-kernel+bounces-75615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2685EBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF760B238CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597412D762;
	Wed, 21 Feb 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYI73Au6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF23BB37;
	Wed, 21 Feb 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555678; cv=none; b=W3UmqLgcDfTiT7kv/RaeDGCNrk64AbXql26ZaSLp3L5B2hKYhsgFV3TJeNWLJIwaaU9KgGJjc2e6+ilfFAbu4Tp3SOggUo3Kj2njMF4Wk8TZFsn8w7VwDHotOMnfbh7Zh5WvXOmqpaF8bUlBOgByzzCrGah756voXD848RzlU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555678; c=relaxed/simple;
	bh=I9DvEAjDVvD5M2ShbXhVz7GBfmeNSwr//RvjAhnkjrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4D7BlqmxwVmJG+Yh+VV9yXOsdNYc0Pn9v7q3MArA1FHKUb7tbtmxOLYXvuVjfBD1Y5LVXKPbgmC5M/T9tDk/GywTw4Fudg6d4f4/iUUOTmHwIxQ6ZYJkyMxY19ITNLgDbFAIZwrat6YT6HSrvbsejdkC4tctEeC84RIzRNbelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYI73Au6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708555664; x=1740091664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I9DvEAjDVvD5M2ShbXhVz7GBfmeNSwr//RvjAhnkjrc=;
  b=HYI73Au6LqPgd2uufKyBLSI/miOmf9/AangLRh7sWKojIco3loOpun64
   c+Cf1vi4FSJdPvtlfW6CsS0jtSHLkxPbnUYqa/c8oQy426UIpQzVTEfRB
   W4eCVkFgNsloY2yPHTr5DBJxcGxjy9ANV1UYisPKBtVagwBXabCb0awq3
   DLoTP4DhDUuo6r4g3LWpeQWIjh1AcA//BkTYzW6GpxM0d1VSABLqKhNoc
   +r/A/15IJH3BOPC38Vf9cwDY89wDfyvnwsHcv6BrNxIxaCUYGyIdZJ+Jc
   jVaxB0DZqXkWcJMnxkiYeghnLskcwilIt9xW58oymEHFhv/An9bSTu5Rx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13305994"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13305994"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:47:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="36085185"
Received: from mstewart-mobl.amr.corp.intel.com (HELO [10.209.73.168]) ([10.209.73.168])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:47:40 -0800
Message-ID: <c581f8c0-3c2c-45e5-ad87-f6183c497f29@linux.intel.com>
Date: Wed, 21 Feb 2024 14:47:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/x86: intel_scu_ipcutil: Make scu static
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, Shyam-sundar.S-k@amd.com,
 mika.westerberg@linux.intel.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220054513.2832-1-W_Armin@gmx.de>
 <20240220054513.2832-3-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240220054513.2832-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/19/24 9:45 PM, Armin Wolf wrote:
> The variable is only used internally and has no external users,
> so it should me made static.
>
> Compile-tested only.
>
> Fixes: 663cc18861a0 ("platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---


Since it is not a bug fix, I am not sure whether it makes sense to add Fixes: tag.

But the change wise, it is fine.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/platform/x86/intel_scu_ipcutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel_scu_ipcutil.c
> index b7c10c15a3d6..7d87cbd4b9c6 100644
> --- a/drivers/platform/x86/intel_scu_ipcutil.c
> +++ b/drivers/platform/x86/intel_scu_ipcutil.c
> @@ -22,7 +22,7 @@
>
>  static int major;
>
> -struct intel_scu_ipc_dev *scu;
> +static struct intel_scu_ipc_dev *scu;
>  static DEFINE_MUTEX(scu_lock);
>
>  /* IOCTL commands */
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


