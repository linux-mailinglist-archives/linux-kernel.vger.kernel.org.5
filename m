Return-Path: <linux-kernel+bounces-93800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2BD8734B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2A51C21E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C02605BC;
	Wed,  6 Mar 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zpmns5nj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F225F566;
	Wed,  6 Mar 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721854; cv=none; b=d+JFnIUrI74YLliE4aoEqOnkD3Qh1VXhcrx8NeTc5o/nR1UhpJuZCpjsRyuw4vGvgA3uo8VwenUjAFJIT9WHCDxQApdmwZjeMMLKxk2j1ofy+07y3LNfRp5MtrgNPGMn4mRgZIV4vQTRihnUxQrs9e2miA+eKpdBrIPStjmCMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721854; c=relaxed/simple;
	bh=HhnXlWY9s6EDZvVdpbAhFNG9/tYqle4lWF2NCBXLZrE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QBBFzAUCcq7Q8tQajPND5llCMO49KH9Zk+aQZgkAnfFV0WnUSh6tkFNazHjAw/w2um4xIInfog/NZXd9eYUK1gLY8ghn+2XyS6WzwBJaU8KjJ5gDIQDnqqG+JI0j8881F+jYr0QabiCYPtyjK0/ADIGNq1lcOVG10BovTB6GKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zpmns5nj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709721852; x=1741257852;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HhnXlWY9s6EDZvVdpbAhFNG9/tYqle4lWF2NCBXLZrE=;
  b=Zpmns5njKwOmFONMwp6ByePF2HL0PxjZEN43rh+kEA+GrJ8f7c+9czdQ
   75L98eMxYNqLd4GhlDibObxWUWc27gVMuQZR9KdsvsIolkl2EXF4HKYSo
   nN/GWPfhhxXGQ3CMtEItOlCyxOAj/TDyM4aisEjZKowAnRQYCOOmJhYLV
   cJIe1i3euR0OwnXJ0rvloQmIK0ZQk1SBPLBKzEe35XDAeRa7omoHRCbH5
   6jJPovdmGCZmtk2m+oIsojp5zBrW7c7ZUNRV0+qsprpGr2pRitMinL9YT
   bDrRC0SAJ2oyVZVHllgVQ9+McBSKGSH1VBMHjQo48U5g7nz+Af4ySlJOx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4190472"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4190472"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9801470"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:44:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Mar 2024 12:44:03 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Julian Winkler <julian.winkler1@web.de>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] platform/x86: intel_scu_pcidrv: Remove unused
 intel-mid.h
In-Reply-To: <20240305161539.1364717-3-andriy.shevchenko@linux.intel.com>
Message-ID: <31213f82-196d-8ab0-6c24-a09a2db43388@linux.intel.com>
References: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com> <20240305161539.1364717-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 5 Mar 2024, Andy Shevchenko wrote:

> intel-mid.h is providing some core parts of the South Complex PM,
> which are usually are not used by individual drivers. In particular,

Both applied to review-ilpo. I fixed that double "are" for you while 
applying.

-- 
 i.


> this driver doesn't use it, so simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_pcidrv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
> index d904fad499aa..dbf0310448da 100644
> --- a/drivers/platform/x86/intel_scu_pcidrv.c
> +++ b/drivers/platform/x86/intel_scu_pcidrv.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  
> -#include <asm/intel-mid.h>
>  #include <asm/intel_scu_ipc.h>
>  
>  static int intel_scu_pci_probe(struct pci_dev *pdev,
> 

