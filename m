Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76831793F16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbjIFOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjIFOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:40:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF0792;
        Wed,  6 Sep 2023 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694011227; x=1725547227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H0p5vxGoZ0M3SEpMB1FMA78MtBUfSycbnSLthNErt9c=;
  b=O8qC2zlEg/AUMfJ0KfCAXpHSlzMHVv2XJ2kEyvQhYuPSKbOmRFeKQEUD
   wmAR2pKMmBGPAMlTtW4mxRpJPQH7Q3T14n5ktyZGSd6YWoXMSbUeYtsVB
   cwYRCchce5Ek/zSIhdKtR1iTEtpyyWvrN9rmmqn5rymZ2gSiCU1/yJhSL
   0NUJONrNnlr7vf8nv1GReeM3/hqtv7JYiQwSExIYcVvY8WnZJT1TxvkJc
   FedKklEyt3Mwd4i6OPR/fnEepjnhaf871/nX4LT+ddZjb+Y70mi4teIHk
   ibeuP9Ygkf5yfuuYaGDbEmoEGfSVq7rO/DpXAnNcwS5K0y7sJQqGAExBN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357392989"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="357392989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770776939"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="770776939"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:40:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdthd-006xvs-2d;
        Wed, 06 Sep 2023 17:40:21 +0300
Date:   Wed, 6 Sep 2023 17:40:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v4 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Message-ID: <ZPiPVZKXeDfLsU64@smile.fi.intel.com>
References: <20230905184252.222742-1-biju.das.jz@bp.renesas.com>
 <20230905184252.222742-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905184252.222742-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:42:51PM +0100, Biju Das wrote:
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
> +#define TMP51X_TEMP_CONFIG_RC		BIT(10)
> +#define TMP51X_TEMP_CHANNEL_MASK(n)	FIELD_PREP(GENMASK(14, 11), \
> +						   GENMASK((n) - 1, 0))

Why do you need FIELD_PREP() for the pure constants here? Why can you simply
define the constants in the proper place?

...

> +#define TMP51X_TEMP_CONFIG_DEFAULT(n)	(TMP51X_TEMP_CONFIG_CONT | \
> +			TMP51X_TEMP_CHANNEL_MASK(n) | \
> +			TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)

This is better to read in a form of

#define TMP51X_TEMP_CONFIG_DEFAULT(n)					\
	(TMP51X_TEMP_CHANNEL_MASK(n) | TMP51X_TEMP_CONFIG_CONT |	\
	 TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)

-- 
With Best Regards,
Andy Shevchenko


