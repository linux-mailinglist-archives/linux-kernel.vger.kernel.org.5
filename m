Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D07F5DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbjKWLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345091AbjKWLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:38:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC6719D;
        Thu, 23 Nov 2023 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700739542; x=1732275542;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jCUMyFk9WCdxXuAk84ueFQmAh4DwRkOjYHbY7EDCxj8=;
  b=kAHrVt/mDa6/da83KP9ytQIVDrvfdplVYYl8y6XRhw/KV1FNISJoH8UC
   cSBkqNFSadYrbqS5sTkgxTxcmpDRD0CpsCk4rMGbR2d278MVCb9HURuDf
   ZuCw9x7eF+QiCS/43ZikNtryl8UntFRXn92PxHFz6LZ8pPNf7QiV7gFuX
   kiX9PE/O3y5KUJjLA9u9gCGbcFgZnTvjof5FyputLHbB9VduTepYtG4HB
   UO/CfVVGZtBFIjar6f/jmiZS9DDhO9p20c3ybl/KqLw0MoxKWfz4wWUd3
   KM2+nE3rtwC6FqfCxHnpXpMzh+c1927Nfs9YWPnIAu6DNvg1mM78qTyOC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10928694"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="10928694"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8648823"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:39:01 -0800
Date:   Thu, 23 Nov 2023 13:38:57 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V5 19/20] platform/x86/intel/pmc: Add debug attribute
 for Die C6 counter
In-Reply-To: <20231123040355.82139-20-david.e.box@linux.intel.com>
Message-ID: <5b3b7eb7-78c-c9ec-2acd-f54ff116188@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-20-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, David E. Box wrote:

> Add a "die_c6_us_show" debugfs attribute.  Reads the counter value using
> Intel Platform Monitoring Technology (PMT) driver API. This counter is
> useful for determining the idle residency of CPUs in the compute tile.
> Also adds a missing forward declaration for punit_ep which was declared in
> an earlier upstream commit but only used for the first time in this one.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V5 - Change comment for crystal error and return value
> 
> V4 - no change
> 
> V3 - Split previous PATCH V2 13. Separates implementation (this patch) from
>      platform specific use (next patch)
> 
> V2 - Remove use of __func__
>    - Use HZ_PER_MHZ
>    - Fix missing newlines in printks
> 
>  drivers/platform/x86/intel/pmc/core.c | 55 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  4 ++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 4a38d52558fd..fb2c84fba0ae 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c

> +static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_dev *pmcdev = s->private;
> +	u64 die_c6_res, count;
> +	int ret;
> +
> +	if (!pmcdev->crystal_freq) {
> +		dev_warn_once(&pmcdev->pdev->dev, "Crystal frequency unavailable\n");
> +		return -ENXIO;
> +	}

I actually started to wonder whether it would be better to just not show 
the file in this case (using .is_visible())? (I'm sorry I forgot to send 
the note about that earlier.)

-- 
 i.

