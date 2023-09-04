Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360FF79157B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbjIDKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjIDKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:07:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7991B4;
        Mon,  4 Sep 2023 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822075; x=1725358075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8U8X5IYT7tGONc/ZX9PrJDgAjq9Zx/80DUmr+XzUeo=;
  b=kAzGWkhdS1E5vxKAqK2FhNGLRJ+DQwUn4oUsny9V6YmK7wP1pFxF8LRI
   Kb0Dr6fNooIyxuJh2I6EYm/csw7s1akY1O/+zyV4bq+/uJhvZ443MWkTl
   nNnL0dzwdfNrkX30lNS7E6wlyV0RunA1sbRIYSOq+ELJCjrQAEOdVvozB
   UVv7CNYmyrpWxxn+gybARiLjg2lXm98YMvqOzYGxDdhxi/YWHAAT3P43i
   MXWbNYN8PoNmQzFaURb9V5BOL3RhQ52W4jC69WZQy5GrxKoS8snWWGCQI
   pF+ngmvarB90Rb8I6D0Ma7RiAi8OXby9PBkeD30M3TBVH94cbrvzFo7uM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442962629"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="442962629"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="734270838"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="734270838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:07:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6Uo-006OaI-1b;
        Mon, 04 Sep 2023 13:07:50 +0300
Date:   Mon, 4 Sep 2023 13:07:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and
 name in sync
Message-ID: <ZPWsdjlFvUzeFy45@smile.fi.intel.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
 <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 08:33:30PM +0100, Biju Das wrote:
> Add struct bq2425x_chip_info to make enum bq2425x_chip and it's name in
> sync and replace chip->info in struct bq24257_device and add struct
> bq2425x_chip_info as match data for OF/ACPI/ID tables.
> 
> Simpilfy probe() by replacing acpi_match_device() and id lookup for
> retrieving match data by using i2c_get_match_data().
> 
> Drop bq2425x_chip_name as there is no user and also drop the comment
> related to syncing chip and name as it is taken care by struct
> bq2425x_chip_info.

...

> -	if (ACPI_HANDLE(dev)) {
> -		acpi_id = acpi_match_device(dev->driver->acpi_match_table,
> -					    &client->dev);
> -		if (!acpi_id) {
> -			dev_err(dev, "Failed to match ACPI device\n");
> -			return -ENODEV;
> -		}
> -		bq->chip = (enum bq2425x_chip)acpi_id->driver_data;
> -	} else {
> -		bq->chip = (enum bq2425x_chip)id->driver_data;
> -	}

Do we still need acpi.h after this change?

-- 
With Best Regards,
Andy Shevchenko


