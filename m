Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F57AD14F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjIYHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjIYHVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:21:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B136C0;
        Mon, 25 Sep 2023 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695626487; x=1727162487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwm0ztNtqQCxIpKMtplcbblkEbTF1amu+3/nhNLIbIQ=;
  b=j9oiRVS41sZd4cG/paNUPhh4xsm6WjVz0xsace+w9WxcBus96bYjhQj1
   R9N6IzBZbtZ1NafDUQlbA8Ir6ezToZ1sBjRTLwQFjwBDpXe3ON03+GsZL
   jMjAgZiBO9Rr+qDcU+U4+jTO3xUb3JnHAcikkMUjm1xI9eE9sNqPW9++a
   8IF6DpGupK4WyS5tPyLjTq2zIWoT0FN0GJ+XeFdvBC6AcKrHjrnQbT9eg
   FYicMCaUaJOAMM+ehRyOTCrFiqsYHMxU3zbEVPz6YMzupXO19EI11lXSy
   DyUZdRodh7nlbDcXnTS8uf6Qt5HvYkyfeCDw/v9N/uWBpwBoHlpqYUHBu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378455991"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="378455991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="813835171"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="813835171"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 00:21:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qkfuE-00000000HGa-0Dhf;
        Mon, 25 Sep 2023 10:21:22 +0300
Date:   Mon, 25 Sep 2023 10:21:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 1/2] leds: pca955x: Convert enum->pointer for data in
 the match tables
Message-ID: <ZRE08RkhG2C+Pi3l@smile.fi.intel.com>
References: <20230923171921.53503-1-biju.das.jz@bp.renesas.com>
 <20230923171921.53503-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923171921.53503-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 06:19:20PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *pca955x_chipdefs for data in the match table.
> Simplify the probe() by replacing device_get_match_data() and ID lookup
> for retrieving data by i2c_get_match_data().
> 
> While at it, add const definition to pca955x_chipdefs[].

...

> -	struct pca955x_chipdef	*chipdef;
> +	const struct pca955x_chipdef	*chipdef;

No need to preserve TAB(s) here.

Otherwise looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


