Return-Path: <linux-kernel+bounces-15260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734C822950
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0D0284E98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79601805D;
	Wed,  3 Jan 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H85/qPhS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4718046;
	Wed,  3 Jan 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704269301; x=1735805301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/JJwFyF29T1oOEA9KP3rktPCNu/Gfj6Z1AghnbazQsI=;
  b=H85/qPhSTsQ6q3Z1BJczoZIYVmdqa7MkbRFIBFaRzjz1qVS3mTpbdKA6
   ua4wgGDvJTTiJZlqUH8Ds/BVWKbCHWe2Lv4Ud6PRDkypSeeKv8FWRlLvM
   PtTmiOeDuocV4nof+pSqI0siTuz5lSG3+RiOE7vdIzHADmEwt9ttvWWp5
   yMugbhk+weMky8ljT4qjgHoOZDi381d9rS+aYWFVbuEYkAXUye3lqqtoJ
   07sWQErCF1cdXheSHvh7d8QbrCADl9kWvVwleLAHecCVYVJtvUB3VhPNS
   hr2wTXvvMETIY977JFdn0v6QZqEbJSRDccCM8ViYNqSs5yAifc+7GoXmb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4321761"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4321761"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953155403"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953155403"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:08:16 -0800
Message-ID: <03e61842-1ba1-4135-80f8-9071d859614d@intel.com>
Date: Wed, 3 Jan 2024 10:08:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
To: Jorge Ramirez-Ortiz <jorge@foundries.io>, Avri.Altman@wdc.com,
 ulf.hansson@linaro.org, christian.loehle@arm.com, ricardo@foundries.io
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20231211165500.310097-1-jorge@foundries.io>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231211165500.310097-1-jorge@foundries.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/23 18:55, Jorge Ramirez-Ortiz wrote:
> Requesting a retune before switching to the RPMB partition has been
> observed to cause CRC errors on the RPMB reads (-EILSEQ).
> 
> Since RPMB reads can not be retried, the clients would be directly
> affected by the errors.
> 
> This commit disables the retune request prior to switching to the RPMB
> partition: mmc_retune_pause() no longer triggers a retune before the
> pause period begins.
> 
> This was verified with the sdhci-of-arasan driver (ZynqMP) configured
> for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
> cases, the error was easy to reproduce triggering every few tenths of
> reads.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Acked-by: Avri Altman <avri.altman@wdc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  v2:
>     mmc_retune_pause() no longer can trigger a retune.
>     Keeping Avri Altman Acked-by since they are functionally equivalent.
>  v1:
>     modify mmc_retune_pause to optionally trigger a retune.
> 
>  drivers/mmc/core/host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..ed44920e92df 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -119,13 +119,12 @@ void mmc_retune_enable(struct mmc_host *host)
> 
>  /*
>   * Pause re-tuning for a small set of operations.  The pause begins after the
> - * next command and after first doing re-tuning.
> + * next command.
>   */
>  void mmc_retune_pause(struct mmc_host *host)
>  {
>  	if (!host->retune_paused) {
>  		host->retune_paused = 1;
> -		mmc_retune_needed(host);
>  		mmc_retune_hold(host);
>  	}
>  }
> --
> 2.34.1


