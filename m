Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F13785D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbjHWQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjHWQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:18:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14210C7;
        Wed, 23 Aug 2023 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692807511; x=1724343511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vWB7hPu7u+MNP+Ouru9SsOGj48S3oHS9sUrc6394ds8=;
  b=eiEs12qJPIxudSKBhNjVK6JhZDdzIhRnr2Q2AD38YFc8pqYca2GiZ4A8
   z+rqWKa5sNPM/b/lV1tgmARx7nyRsYMALnJfnYpkhn9100mBUAg6CPXOH
   nKcZC4cmqOXGCoOLY972VGPm+D8ooR/ubavSMs28tf0SFKKeX73zDlIt4
   AkarNE017tzqiD6WEur+IdooKH60AwqoEs0TLcsQ8HGAo1kAL5Ny2T3kb
   4It1/6IrNoiKlo0GnqtapCNMWcC9mL2LL2oxnQitr/0y40pBkQ3OUEXms
   qGwdOI0Nur5DZ57l1QfWbgs/UIpwAHhg09t27jNh7OH6FNvXzRTDFAOma
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="460570758"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="460570758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="730260372"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="730260372"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Aug 2023 09:17:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYqXy-00F05D-1Q;
        Wed, 23 Aug 2023 19:17:30 +0300
Date:   Wed, 23 Aug 2023 19:17:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] iio: pressure: bmp280: Use uint8 to store chip ids
Message-ID: <ZOYxGhZxpTDUpURQ@smile.fi.intel.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
 <cf08dd2fab1fd91ca7ed0724d1f50435c8c2914b.1692805377.git.ang.iglesiasg@gmail.com>
 <ZOYveUBg3rKK+ZQ9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOYveUBg3rKK+ZQ9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 07:10:33PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 23, 2023 at 05:58:05PM +0200, Angel Iglesias wrote:
> > Represent the device id reg values using uint8 to optimize memory use.
> 
> This doesn't correspond to the code, in the code you used uint8_t.

...

> >  struct bmp280_chip_info {
> >  	unsigned int id_reg;
> > -	const unsigned int chip_id;
> > +	uint8_t chip_id;
> 
> While this will compile and even work properly in kernel we use uXX types,
> here u8.

Actually this patch doesn't optimize memory use. The alignment will create
a gap anyway.

That said, this patch is simply redundant.

-- 
With Best Regards,
Andy Shevchenko


