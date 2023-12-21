Return-Path: <linux-kernel+bounces-8353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E04181B617
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B501F21C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E26EB63;
	Thu, 21 Dec 2023 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EV8B6e3T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4E6EB4D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703162494; x=1734698494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lsmG7fipfeogrSZNkFVhTw0jNcxSpeksRFqeTjy2V8s=;
  b=EV8B6e3TDYBV4Ml6LHF6BrI7vblfxfdS6OTBc/z8xrM/H3gJc58BDvch
   bSS6THBUrUGlTtfFBFjE6xq4pt357ZdDC8DexVicjw+EoHQomeKgvea8+
   bjfVOpK6FTadZuIQjByThO/AYzPvPheVgfxJHtTLjLpEqdldxEMm95aDm
   GZ0ShE71QqFSMeGUzCBM7LH3n47PV3aE7dKmNxdlxyf1tb/aZQVMiWs3A
   /qvz7f8OxoyZz80RhcpyQZQ1OWHOun/Ge+lOSKeoh4Z7TJhouBO+dR444
   AVwHNm7xonS/TnqBZVgu9kOIWgik7Q8kj3dTshpVddrAxsDaIlwhMYfXR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="375455866"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="375455866"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="949918527"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949918527"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:41:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGIMi-00000007qsM-0Eol;
	Thu, 21 Dec 2023 14:41:28 +0200
Date: Thu, 21 Dec 2023 14:41:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: hdegoede@redhat.com, lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <ZYQydxWHmKSQgZN4@smile.fi.intel.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-2-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220205621.8575-2-alex.vinarskis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 09:56:20PM +0100, Aleksandrs Vinarskis wrote:
> Introduce generic quirk table, and port existing walkaround for select
> Microsoft devices to it. This is a preparation for
> QUIRK_CLOCK_DIVIDER_UNITY.

Thank you for the update!
Some nit-picks below, after addressing them feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	{ }

> +	{}

No need to change here.

Also I'm not sure about "}, {" style. Lee as the maintainer can clarify
on this.

...

>  	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
>  	struct intel_lpss_platform_info *info;
> +	const struct pci_device_id *quirk_pci_info;
>  	int ret;

I would preserve reversed xmas tree order:

	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
	const struct pci_device_id *quirk_pci_info;
	struct intel_lpss_platform_info *info;
	int ret;

...

> +	quirk_pci_info = pci_match_id(quirk_ids, pdev);
> +	if (quirk_pci_info)
> +		info->quirks = quirk_pci_info->driver_data;

Can you confirm that there is no compiler warning if you compile for 32-bit?

...

> +/*
> + * Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources
> + * Set to ignore resource conflicts with ACPI declared SystemMemory regions

Please, mind the periods at the ends of sentences.

> + */

...

> +	unsigned int quirks;

Depending on the above (32-bit compilation) this might be converted to
unsigned long.

-- 
With Best Regards,
Andy Shevchenko



