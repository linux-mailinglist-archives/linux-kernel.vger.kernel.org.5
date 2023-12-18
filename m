Return-Path: <linux-kernel+bounces-3567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224FA816DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398E21C2286E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD614B13E;
	Mon, 18 Dec 2023 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSpSr14y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781F495E9;
	Mon, 18 Dec 2023 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702902609; x=1734438609;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t7QldH+LzZh2vXENg520NIwUceRKwR941rV6ZSbk+dw=;
  b=jSpSr14yDFPgcMB1lVKUw4nPGRkQ76gMO6MvEzwWSpiaHR/znXWzJpaF
   rpZmYhVbKQNBeu88/9/3HRslGQ5DbaxB+isUQO5i3RefZhiNwptXqsI8/
   m4jV3LzGDs/5hazvHqJ/qEbrtSTXSGRkewmUFETSfs8ZRPwIYu0a3H5pg
   T75ZuC62ytvrdshsllK4yRYXzZQrQ/dHgBG0NnYx6Gg/G8xQ0TMcQ00Mz
   E0hKgDfdR+I43WPL6SxE7UAPORKAzjHQtk2YM3AKYpM5KVfUPToRAm7tN
   9AwzTxDfnsrQqD5nc2xMZ3r7g/eMzekbP08X39btOlNQ0eMQxtPkH+x55
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375649030"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="375649030"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 04:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="948760708"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="948760708"
Received: from gmarin-mobl1.ger.corp.intel.com ([10.252.34.78])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 04:30:06 -0800
Date: Mon, 18 Dec 2023 14:30:04 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: rjingar <rajvi.jingar@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>
cc: irenic.rajneesh@gmail.com, david.e.box@intel.com, markgross@kernel.org, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86/intel/pmc: Fix hang in
 pmc_core_send_ltr_ignore()
In-Reply-To: <20231216011650.1973941-1-rajvi.jingar@linux.intel.com>
Message-ID: <5bf1ca2-92e2-25bb-10fa-59db2ed5839@linux.intel.com>
References: <20231216011650.1973941-1-rajvi.jingar@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1553889773-1702902608=:2348"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1553889773-1702902608=:2348
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2023, rjingar wrote:

> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> For input value 0, PMC stays unassigned which causes crash while trying
> to access PMC for register read/write. Include LTR index 0 in pmc_index
> and ltr_index calculation.
> 
> Fixes: 2bcef4529222 ("platform/x86:intel/pmc: Enable debugfs multiple PMC support")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 983e3a8f4910..55eb6a4683fb 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -474,7 +474,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>  	 * is based on the contiguous indexes from ltr_show output.
>  	 * pmc index and ltr index needs to be calculated from it.
>  	 */
> -	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index > 0; pmc_index++) {
> +	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index >= 0; pmc_index++) {
>  		pmc = pmcdev->pmcs[pmc_index];
>  
>  		if (!pmc)
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I'll have to say though I really don't like they way that function is 
playing with fire by mixing the use of signed and unsigned variables.

As is, this can only be triggered through a debugfs write and we're 
already in -rc6 so IMO next material.

-- 
 i.

--8323329-1553889773-1702902608=:2348--

