Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA1794405
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjIFT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbjIFT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:56:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727F171A;
        Wed,  6 Sep 2023 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694030210; x=1725566210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTfo7kz2LXmpr32HaWGS1Sx15Bua+NE3xKYiot9REO8=;
  b=n3VhyupGJ00lpfZBxYUmPZC1xEdAplKvMwgNiQoIHhCNMiGqtdZuzcFz
   XizE8sXAPNeX2Rlb7XFG4GocE9Bp1q3XcZSgVFqwgcpC+zM99wbWEVm21
   OjFv8w34V2MZBv4Ra/epbSX/8s/q8KSat5390IwD2O4Rmhrwi1rTTs9Y3
   3cQ6AYlzbNoFJ6lf75LiZi/4hM+zSnCAngNy0e5P6ET7iCrcVI3nCanv0
   n1/bM71u5Syn381T8UOy1exmBYfmeiwmslvU1l+yyaBqoHGW85YoZv8T4
   yvp4Pgw1aB6WRxG1BWw0VF0d3rGfERAhVE6uH0LDlUunk70lSScHOAakn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="356650796"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="356650796"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856593052"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="856593052"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:56:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdydp-0078zK-0H;
        Wed, 06 Sep 2023 22:56:45 +0300
Date:   Wed, 6 Sep 2023 22:56:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v5 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Message-ID: <ZPjZfK7+4jW3AFEB@smile.fi.intel.com>
References: <20230906180837.284743-1-biju.das.jz@bp.renesas.com>
 <20230906180837.284743-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906180837.284743-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 07:08:36PM +0100, Biju Das wrote:
> The tmp512 chip has 3 channels whereas tmp513 has 4 channels. Avoid
> using tmp51x_ids for this HW difference by replacing OF/ID table
> data with maximum channels supported by the device.
> 
> Replace id->max_channels variable from struct tmp51x_data and drop the
> macros TMP51{2,3}_TEMP_CONFIG_DEFAULT as it can be derived from the macro
> TMP51X_TEMP_CONFIG_DEFAULT and update the logic in tmp51x_is_visible(),
> tmp51x_read_properties() and tmp51x_init() using max_channels.
> 
> While at it, drop enum tmp51x_ids as there is no user and remove
> trailing comma in the terminator entry for OF table.

...

> +#define TMP51X_TEMP_CONFIG_CONV_RATE	FIELD_PREP(GENMASK(9, 7), 0x7)

I also commented on this one. Any explanation why you didn't accept recommended
variant?

...

Otherwise looks good to me.

-- 
With Best Regards,
Andy Shevchenko


