Return-Path: <linux-kernel+bounces-92900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A955D8727C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602B21F28CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B95BAE6;
	Tue,  5 Mar 2024 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoYBPNwg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F4BA49;
	Tue,  5 Mar 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667591; cv=none; b=EaaO0zBfj6YH6UkmH5sBd0HPUg3gz5/nmu9kwqHQyoPYlsm6mwG1pQoKR+0pZ6Ie/zxFW9KaGRloqPCXOgxPXqm46SLOd8F+O3GM9ptAiYtfyU2vV3qNomIQ5MGSo/muuTgC1PPlF9SijxZxJjEb6HOWZbo8RcMit/HyOcfU+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667591; c=relaxed/simple;
	bh=0WEb+NchTg4/CBycIN9Awl/P6Rn+1kQa5e6+ee9dpeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUNs+kOd+A64AyCO7XMQjfqCWQHXdjRGV1Z9MhlImNlZmuB0FlH6tMxv3miRd5KyKXChV63VkuRSPAcdS2Io7FKnhSkzN1IaMsDTwr3YGofAH6dXze5tItPumHvFBQociInsCSHSld43N82NfMwDtY6ooAyD8fHODCvTWFK5T+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoYBPNwg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709667590; x=1741203590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0WEb+NchTg4/CBycIN9Awl/P6Rn+1kQa5e6+ee9dpeQ=;
  b=YoYBPNwgquFL3RAp6ptdxeUgZnmMgWJeGrVIJMEoZZAPekvdP2h/VKN+
   sOPPDOWFcjvje07s1s5bAhUoufKJN+duOcr7ksYgiiuuSdm4rszNJWk+G
   S/zoBhu18uujC5tl8L1vpX/0oCi5IVIcU1zaT060K3wVMqGjX/MEQLbVy
   aNAx3+oLN7W7p74PkWEocKla+e+HTigBCs59RmeNqINI0YuBFzMBkPO9u
   ZO9O1PgmSkmOeeJO5ZHEcFBcBZ/9n8E8xIF8LNzTP44FoHhZh6EdwYQ8u
   HapxnikNI0aYHjZAXdwO2wL0mDmyNSMSmJtfZLGDmH+0arS/acjYEYiaZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15389028"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15389028"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9590847"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:39:48 -0800
Message-ID: <ac6b8e78-4962-433f-923c-b56293f4f896@linux.intel.com>
Date: Tue, 5 Mar 2024 11:39:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] platform/x86: intel_scu_pcidrv: Remove unused
 intel-mid.h
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Julian Winkler
 <julian.winkler1@web.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com>
 <20240305161539.1364717-3-andriy.shevchenko@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240305161539.1364717-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/24 8:14 AM, Andy Shevchenko wrote:
> intel-mid.h is providing some core parts of the South Complex PM,
> which are usually are not used by individual drivers. In particular,
> this driver doesn't use it, so simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


