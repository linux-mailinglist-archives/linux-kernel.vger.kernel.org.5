Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796037D75BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJYUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:33:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F5D6;
        Wed, 25 Oct 2023 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698266026; x=1729802026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Elh1JXJLo3TVoGeHHdFgceAsuCm69jUSI3BArgC3C3w=;
  b=A+lT0VXA4IrTj2RnkoG/sLutYnOw3mVNpxHlZdFzwGRyqh/iFRKEhXn2
   IHd66Nf52jbOuILxQ0GcJqGnoxesURneF7dr3IkEEAdZ/r5/kLyLI8Xhr
   OmxCJeqoOLW6LunG1FE6MRJX0DL+Jq39lr+Yo1ORbxMhrocObF9ik3a+V
   TiUA7V5tIKD36yI9q2k83b0u6NGCKGSsz3opOkSBZi2oXzAvl0S/Jw2XM
   kqH4KKxDV8TSQL/eeVjc74wSR1osYlSQ8DXvFpxrPcJlTTmD+1q5CW+uF
   3lmA5Hjm6Mm9ly5zNhK+Du3nb3vWb4ZT89TEE3O0bWrCszAiASig72S+r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="8949463"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="8949463"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="762578874"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762578874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:33:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvkZR-00000008gFE-0oOY;
        Wed, 25 Oct 2023 23:33:41 +0300
Date:   Wed, 25 Oct 2023 23:33:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com,
        mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025053833.16014-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> Use acpi_dev_uid_match() for matching _UID instead of treating it
> as an integer.

NAK. See below why.

...

>  static void byt_pwm_setup(struct lpss_private_data *pdata)
>  {
> -	u64 uid;
> -
>  	/* Only call pwm_add_table for the first PWM controller */
> -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> +	if (!acpi_dev_uid_match(pdata->adev, "1"))

_UID by specification is a type of _string_. Yet, that string may represent an
integer number. Now, how many variants of the strings can you imagine that may
be interpreted as integer 1? I can tell about dozens.

With your change you restricted the all possible spectre of the 1
representations to a single one. Have you checked ALL of the DSDTs
for these platforms to say 'hey, all current tables uses "1" and
this is not an issue'? Further question, will you guarantee that new
platforms on this chip won't use something different? (Not that big
issue, but will require to actively revert your change in the future).

>  		return;
>  
>  	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
> @@ -218,10 +216,8 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
>  
>  static void bsw_pwm_setup(struct lpss_private_data *pdata)
>  {
> -	u64 uid;
> -
>  	/* Only call pwm_add_table for the first PWM controller */
> -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> +	if (!acpi_dev_uid_match(pdata->adev, "1"))
>  		return;

-- 
With Best Regards,
Andy Shevchenko


