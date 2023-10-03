Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA87B64F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbjJCJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjJCJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:05:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FFFA9;
        Tue,  3 Oct 2023 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696323938; x=1727859938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3A4Xsgt2ENTV3OdXZZCuv0qf+6Y37EwvUrpqsTmdJmI=;
  b=QvC2kg/Dhx5oQOxLn66dJRpDYgEh+wgATBfDQnVZGBexbIiJXmeUby88
   7nv0t6MQlGFrJPLL6PtCI9gSaISXKgLb7xwBy7ke4zPaEmdPhD+L6JtTP
   qFjAN8WP4AnzD8QA6p4dsJimj4WU7I0bVJSWn0p6kBtqgxASLIJtFpG+6
   wU4P3vsKS+RHxno6FeIy/ijL7qapnmxAdxM2w+duIlAZkjgGsOJQ24olq
   f6PDXVW12eZ42ylI4ogOmyM/knCeExC33/QfeLkeiylmVL6Qo9PL18x5I
   0qMrcgTSkmR8pj2vUYGuDzmnCTIBzUcmCBbUZmjU5iFiV89waTZcGxh9N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373170450"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="373170450"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841272903"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="841272903"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:05:37 -0700
Date:   Tue, 3 Oct 2023 12:05:34 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 1/2] pinctrl: baytrail: drop runtime PM support
Message-ID: <ZRvZXlmHOqU8RcGv@black.fi.intel.com>
References: <20231003081519.27524-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003081519.27524-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:45:18PM +0530, Raag Jadav wrote:
> Since Baytrail pinctrl device is not attached to acpi_lpss_pm_domain,
> runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
> as now we only have suspend and resume handles in place.
> 
> No functional impact.
> 
> TODO:
> Consider moving to DEFINE_LATE_DEV_PM_OPS() in the future once we have
> enough users to account for its introduction.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-baytrail.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index ec76e43527c5..14a61a262be1 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -16,7 +16,6 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/seq_file.h>
>  #include <linux/string_helpers.h>

I just realized I forgot to add pm.h here.
I'll send out a v2.

Raag
