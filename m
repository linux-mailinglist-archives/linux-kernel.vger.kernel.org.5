Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAF791586
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbjIDKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIDKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:12:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441EAD;
        Mon,  4 Sep 2023 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822345; x=1725358345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8q6jkVH59oY7RpN/0ktD9IL+V0p4TrXwNyR5wB9s2s4=;
  b=J/jPVL3SAqYBJAZ3mEgPqtDoUcC3SA2RlsEy71yw7zUzWeRgKE+Lzf56
   yb5XA/oBcBJktPv0YsrSj7aw3vmQ2DtfgelahRGsDDyhBduCcd5Z43gpp
   v6vtYTwCAdYKTU0oX2x/Cf3vBz9cZvx/buxK5VUayQA8mHde7ORwyjxxp
   f7L0omKTAi8Nac84a/v8YRWEedpBQ9VvWyMziYx/Mj0XEkHJxlZ3aCTRe
   BmVX1L4GNSUb/v9AK213MA0Gp1Cv0hCi5PvryiBWpFZ3aONvjqWf9REOE
   J5iMzkF1Vbpz0lK+dn0o5tMjvO9NEUI+V6c7xp1M49UbQIl4vaiigow0h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="440530794"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440530794"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="690542852"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="690542852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:12:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6Z9-006Odr-1X;
        Mon, 04 Sep 2023 13:12:19 +0300
Date:   Mon, 4 Sep 2023 13:12:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq2515x: Simpilfy
 bq2515x_read_properties() and probe()
Message-ID: <ZPWtg5VU4S7InmmL@smile.fi.intel.com>
References: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
 <20230902200518.91585-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902200518.91585-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 09:05:17PM +0100, Biju Das wrote:
> Add struct bq2515x_info and replace device_id->info in struct
> bq2515x_device.
> 
> Simpilfy bq2515x_read_properties() and probe() by adding struct
> bq2425x_chip_info as match data for OF/ID tables and use
> i2c_get_match_data for retrieving match data instead of ID lookup.
> 
> Drop enum bq2515x_id as there is no user.

...

> +/**
> + * struct bq2515x_info -

Missing description.

> + * @regmap_config: register map config
> + * @ilim: input current limit
> + */
> +struct bq2515x_info {
> +	const struct regmap_config *regmap_config;
> +	int ilim;
>  };

-- 
With Best Regards,
Andy Shevchenko


