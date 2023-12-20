Return-Path: <linux-kernel+bounces-7167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A881A28A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C4E288FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429F46432;
	Wed, 20 Dec 2023 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoDzaHH2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396ED45C01
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703086192; x=1734622192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MOnoLBQejmZKFZNUDVEcWqeRnZdaNiLUX2MZ2LVWS5I=;
  b=PoDzaHH2Wk5r56drXJhoA4EL1bjWOYZgD8hvu5z61OtcrZz0YuZiYKH0
   +iScCz6Qw9OI/QabvuFS0vCHHVum7xjtQXpIbmj+sZPk1rMSUsdzqElzx
   OF93DmK7vuR/wAV5R4ImvX8eUmb2y9F911/nCArsjILgVhQxXs0hhDXMB
   WEV0j8GN8yjzIhuOmxXgT1/iB2rWeL1ycoKbcK220yt8m0B0EiAj33Mst
   B1gzCCvQz7jpj4Sj7Yi59hJ1H0mZ3pXzS20SCAyy6SWlhq2OBfIYx3WKt
   9d8lVjako7Bq5upA5vS7ZhBGzp56Ck7mq6gzKtkd3TENSYvsmkAH3MsHS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462279304"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="462279304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805299576"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="805299576"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:29:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFyFU-00000007ZSv-2Wrf;
	Wed, 20 Dec 2023 17:12:40 +0200
Date: Wed, 20 Dec 2023 17:12:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v1 2/2] mfd: intel-lpss: Introduce
 QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Message-ID: <ZYMEaBWwtGEyaNVL@smile.fi.intel.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
 <20231220073148.19402-3-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220073148.19402-3-alex.vinarskis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 08:31:48AM +0100, Aleksandrs Vinarskis wrote:
> Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
> misconfigured clock divider, which should've been 1:1. This introduces
> quirk which conditionally re-configures the clock divider to 1:1.

(Btw, do you use --histogram when preparing patches? Use it in v2.)

...

> +	}, {	/* Dell XPS 9530 (2023) */
> +		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
> +		.driver_data = (kernel_ulong_t)&quirk_skip_clock_divider,
>  	},

Should be

	}, {	/* Dell XPS 9530 (2023) */
		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
	},

...

>  #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
> +#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)

Each quirk should be documented, see, for example,
https://elixir.bootlin.com/linux/latest/source/include/linux/gpio/consumer.h#L593

-- 
With Best Regards,
Andy Shevchenko



