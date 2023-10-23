Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD17D3305
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjJWLZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjJWLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:25:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278FD6;
        Mon, 23 Oct 2023 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698060349; x=1729596349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BT1f7Iex0XAyJsTj/kj5X5QAFWs1h789Jw5nBVP3ffU=;
  b=mhnoRdN/aBf8lctQRtVtg5wJUHUgsValcy16ZSipHFg+Ywsarij/NiPy
   XlqoVZ3OXR0i5PX5khBRwcEzYruL3f2oydNzh4BN3IeetEUWSfaB8WLk/
   n3RcS8i7DmZWFXUpMw1c6LrtDaiT93DRw5UGjz7n861MnwgJVeBb+txyz
   0v1jRyX4crbSElCTQIGmbXFFPKcbjCmTyLDpL2ki9Ardrb0AElOys794h
   DEnO32tn0QZLwcRe8PLA0G3HnFSaJLR368TE3MDnYSFCgGTbR1LybNewx
   /FCxR6MlUUzCeDIsTwu/rnfWRmuaiZ3z5Igxsm4sObNibavjbUS8DSJTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="386633174"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="386633174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="761714038"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="761714038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:25:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qut42-00000007v9d-3saM;
        Mon, 23 Oct 2023 14:25:42 +0300
Date:   Mon, 23 Oct 2023 14:25:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Allow multiple chips id
 per family of devices
Message-ID: <ZTZYNjq/1X95ijXh@smile.fi.intel.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
 <eade22d11e9de4405ea19fdaa5a8249143ae94df.1697994521.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eade22d11e9de4405ea19fdaa5a8249143ae94df.1697994521.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 07:22:20PM +0200, Angel Iglesias wrote:
> Improve device detection in certain chip families known to have various
> chip ids.
> When no known ids match, gives a warning but follows along what device
> said on the firmware and tries to configure it.

I would rephrase it a bit:

"Improve device detection in certain chip families known to have
various chip IDs. When no ID matches, give a warning but follow
along what device said on the firmware side and try to configure
it."

...

> +	for (i = 0; i < data->chip_info->num_chip_id; i++) {
> +		if (chip_id == data->chip_info->chip_id[i]) {
> +			dev_info(dev, "0x%x is a known chip id for %s\n", chip_id, name);
> +			break;
> +		}

> +		dev_warn(dev, "chip id 0x%x does not match known id 0x%x\n",
> +			 chip_id, data->chip_info->chip_id[i]);

If the matching ID is not the first one, user will have an unneeded warning here.

>  	}

-- 
With Best Regards,
Andy Shevchenko


