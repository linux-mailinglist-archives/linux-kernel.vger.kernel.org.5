Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9A7973BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjIGPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245668AbjIGP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F8171C;
        Thu,  7 Sep 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100568; x=1725636568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hD3LejHxGSj1Y4O7RxxMtwEUlF2sJ4z4g4K8ODPu3sY=;
  b=KaVLjZF6ZgH0ifcU1nwqydEai3CeOp16k+eTqEd3g/5pfDecwP2j+sYZ
   NQPy1H7Xxirib9J+xKAhdXtAd75spx+2t3e8jxvscJj899erH4yEFMTo4
   +Mv7lRZVM2NvLXelVFA8aTrMMuwcHCYH0fu9665YrYz7m7OPolZfa6OiU
   u3STG8jpHWx1dnsKwolgYN/r96k8TTp0eyOiNPg928vZiyPd5q9CgWbwO
   HINZGqIQBHXlsFrAbAV7oH0D0ZoiVt1hEb0l7To6a/InsQHiTZRbrDwCx
   n6i7+1lUQ9vrboDguu4P97/nUPKQMHr1Wc4YZ/4Etii3hxdPIF8qVwPtc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357675749"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357675749"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735514227"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735514227"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:11:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qeFj1-007KK9-1d;
        Thu, 07 Sep 2023 17:11:15 +0300
Date:   Thu, 7 Sep 2023 17:11:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Message-ID: <ZPnaA4xp2THUVqCy@smile.fi.intel.com>
References: <20230907071404.24334-1-biju.das.jz@bp.renesas.com>
 <20230907071404.24334-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071404.24334-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:14:03AM +0100, Biju Das wrote:
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

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


