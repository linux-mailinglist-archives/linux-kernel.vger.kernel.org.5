Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C1E7B64FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbjJCJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjJCJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:08:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F2C4;
        Tue,  3 Oct 2023 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696324112; x=1727860112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZS+0ZnNNPkyQhvYwBrFY8CRx+efo3X03zvesWBOoJQ=;
  b=ir0CkzfjgNg1MFWboKYawcKNi26hL2xAgeNh+ZjU4UcCNMLEV5kOJyHm
   mYGGcG0tiTTO/bfpZNZST3Cf9q7pWxIxG9GAvPVDA9R/OlkeEa/3AzOX7
   7AbICsCkcxB1WappAfRpR1HYXs8SHfoFD77qAiR3zMGvW3IwWd/XtXhQF
   SCv3VLt7h2BXyJTdUZN0OGIEvtSsxeAHe1I9c7irGgMeegYc4pQGqDLZv
   BcNHyRRT0O0Iopb53T5unsu0QVda2O5jZrD7wFjEZmnlgxJjCYt5xKzgG
   0H3da8FTJJfcYdig3cJ0xsYIvQzhCsrnzTOMmu3/GZGeclTP/LwKWXzRm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="380104466"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="380104466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="727549522"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="727549522"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:08:21 -0700
Date:   Tue, 3 Oct 2023 12:08:11 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 2/2] pinctrl: lynxpoint: drop runtime PM support
Message-ID: <ZRvZ+0+nB/65F6RQ@black.fi.intel.com>
References: <20231003081519.27524-1-raag.jadav@intel.com>
 <20231003081519.27524-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003081519.27524-2-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:45:19PM +0530, Raag Jadav wrote:
> Since Lynxpoint pinctrl device is not attached to acpi_lpss_pm_domain,
> runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
> as now we only have resume handle in place.
> 
> No functional impact.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-lynxpoint.c | 31 ++---------------------
>  1 file changed, 2 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
> index c3732a9f0658..18ea1c3fa7bb 100644
> --- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
> +++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
> @@ -15,7 +15,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>

Same as baytrail.

Raag
