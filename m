Return-Path: <linux-kernel+bounces-92890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD587279F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E881C252EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF734CB28;
	Tue,  5 Mar 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb2wD18u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C051C01;
	Tue,  5 Mar 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667445; cv=none; b=jhXHGHBuMEcLPgvfB/SFm+nVmN5cZUfWikTJHk07ezbsAIdWIgEzuUY7j7gJHk4wMqGzx9RvM1OpegXxrDeZqo5zEkoLTw+ug9w0oggozoszeugquWuJ2AQIdCEzDiPFTjkYSyGqHn2QsMDnrF/d0b8uVD7cLTMDe522WEvgggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667445; c=relaxed/simple;
	bh=RKacaIGOQgxF1LtEIPG8UQU9TTZMHa2e7nuPpGI22/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNl0RQmD9RrVuAeJGhgS7bf2C/gnfEck4vveH++qlYOffpFIg+w/7vb9V48fRVfXbvo7o4Gy+MnZ0In+FZTiViR1CixvopNiqs44UiVXo+XbpeX9YDHaOM7PlZzotomalZBOa38x4OwCCV+MDcoDbtCwyZi7OzLegjEo6E+HWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb2wD18u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709667443; x=1741203443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RKacaIGOQgxF1LtEIPG8UQU9TTZMHa2e7nuPpGI22/w=;
  b=Wb2wD18ujEowuY8haY7tQZtmptc8DVDypm0PSLPtVrJgBNEW9YP82kQd
   KXniZitwLZ2pZhdLaBBolCu3dzQyWMwZrArClnCC67SMhyeqSUOAd9LUS
   7S+OiEnmmPNdMfqEEoEuINOcw2yzGCzmp+ZzR7QlSoI48vCi8JMoAy8J5
   GnGKmHp1vIAhjvnyCWjtLtPlaI64jge/AxaJEk5hRINOQNux+EHY7zCqm
   GUF79ipuekqEw/of0NbVvStatRT6SMMpdgaawq4UQluWbT/6OTYnRF/Ue
   sYv0i7WGvDK1qfuPzqnSFdT23RBqNuo11M29XQJJgQD8vxan5XYAwKAli
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4102061"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4102061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="40367715"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:37:23 -0800
Message-ID: <c36ebc06-d8bb-4712-9d90-4e458ee495e6@linux.intel.com>
Date: Tue, 5 Mar 2024 11:37:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] platform/x86: intel_scu_wdt: Remove unused
 intel-mid.h
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Julian Winkler
 <julian.winkler1@web.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com>
 <20240305161539.1364717-2-andriy.shevchenko@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240305161539.1364717-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/24 8:14 AM, Andy Shevchenko wrote:
> intel-mid.h is providing some core parts of the South Complex PM,
> which are usually are not used by individual drivers. In particular,
> this driver doesn't use it, so simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/intel_scu_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
> index c2479777a1d6..a5031a25632e 100644
> --- a/drivers/platform/x86/intel_scu_wdt.c
> +++ b/drivers/platform/x86/intel_scu_wdt.c
> @@ -13,7 +13,6 @@
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> -#include <asm/intel-mid.h>
>  #include <asm/io_apic.h>
>  #include <asm/hw_irq.h>
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


