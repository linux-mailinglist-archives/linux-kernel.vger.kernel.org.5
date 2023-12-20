Return-Path: <linux-kernel+bounces-7115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F174A81A1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54611F23D51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3283E47C;
	Wed, 20 Dec 2023 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y99cSCiX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5F3DB9C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703084904; x=1734620904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNp6C2oV5taQk8SCZKnojmS47FJsXeukrfAIpNVBbPo=;
  b=Y99cSCiXI+aWHCrReW1z0Sn27VchKnWrFiYWdI/wmc68xDsXhYOLRT8U
   KAp55cZxUiZJQoc0CuxZKUdceNYfnS2IBlpy6DhbIItfZfn8oaO5ygxCh
   OorAF7dbmRmLqkIAhf+y3v5d708RfTSaDico615x5OM4AKP4b8PgZeu/W
   jz0VKk0bRwnMsXEs7wNifrcss4ovGE7OAfAClwsl7GOjJrQmGXgT+Yb5Q
   9semy1jk/yFqR/tqHdpNB/aYJdsZ4Nn2eA/QckL7MG86QdIX+c2C5L4Ip
   SQj1aPkBA0h1T1WeICeaLtgKrBrov3SGnjt498es6vST3PRExrzrfbbzc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="17380940"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="17380940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810630407"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="810630407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:08:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFyBH-00000007ZL1-10fv;
	Wed, 20 Dec 2023 17:08:19 +0200
Date: Wed, 20 Dec 2023 17:08:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v1 1/2] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <ZYMDYsWj3eONUnjs@smile.fi.intel.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
 <20231220073148.19402-2-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220073148.19402-2-alex.vinarskis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 08:31:47AM +0100, Aleksandrs Vinarskis wrote:
> Introduce generic quirk table, and port existing walkaround for select
> Microsoft devices to it. This is a preparation for
> QUIRK_CLOCK_DIVIDER_UNITY.

...

> +	quirk_pci_info = pci_match_id(quirk_ids, pdev);
> +	if (quirk_pci_info) {
> +		quirk_lpss_info = (void *)quirk_pci_info->driver_data;
> +		info->quirks = quirk_lpss_info->quirks;
> +	}

Just use driver_data as the quirks. No need to have an intermediate data
structure. This will become as simple as

	quirk_pci_info = pci_match_id(quirk_ids, pdev);
	if (quirk_pci_info)
		info->quirks = quirk_pci_info->driver_data;

No ugly castings is a good side effect of the change.

...

>  

+ bits.h as you used BIT() below.

>  #include <linux/pm.h>
>  
> +#define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)

-- 
With Best Regards,
Andy Shevchenko



