Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD447D823E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjJZMGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJZMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:06:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA71B9;
        Thu, 26 Oct 2023 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698321992; x=1729857992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfL3s1I3aKOjx8ccqmiD0Okk8hzwOsN0gZvCSpTmYgw=;
  b=ItkDswBxB91ywWi2rnMe/1Mk86nP/mi25Jp4hPzxFI3iaLW90qQrWGQc
   Y9f4XxNjtKHfpMQRgH9mxSkieUxGuKXfsD3qh577/oo9Xg2jqwKTZJmwl
   bijXmXfvyfkvRq+/DUyklnMDBtuUEIxlNBiNA/7te+4j6RJVtK8s4jTYv
   IBOHEEj29tr3j4HkkuFM1fy/yPI0G1afzDcwFtGIWHpgigRvYOga9egYC
   JNMPwFkKLB8fZfFcsjMMlgB5Wx7WrKz+YXCjeH6msKtmxA4c3l8iDvuMF
   6JcGjtSfkrXRMV/TKaqVAB/8SnkKgnx7w3JNWTRdBLhEXWWLamRzIwMOj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391393717"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391393717"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794180501"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="794180501"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:06:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvz7p-00000008qdG-2v6I;
        Thu, 26 Oct 2023 15:06:09 +0300
Date:   Thu, 26 Oct 2023 15:06:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com,
        mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTpWMVjti2JpAK4y@smile.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
 <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>
 <ZTnWSRIr1o7RLcOl@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTnWSRIr1o7RLcOl@black.fi.intel.com>
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

On Thu, Oct 26, 2023 at 06:00:25AM +0300, Raag Jadav wrote:
> On Wed, Oct 25, 2023 at 11:33:40PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:

...

> > >  static void byt_pwm_setup(struct lpss_private_data *pdata)
> > >  {
> > > -	u64 uid;
> > > -
> > >  	/* Only call pwm_add_table for the first PWM controller */
> > > -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> > > +	if (!acpi_dev_uid_match(pdata->adev, "1"))
> > 
> > _UID by specification is a type of _string_. Yet, that string may represent an
> > integer number. Now, how many variants of the strings can you imagine that may
> > be interpreted as integer 1? I can tell about dozens.
> > 
> > With your change you restricted the all possible spectre of the 1
> > representations to a single one. Have you checked ALL of the DSDTs
> > for these platforms to say 'hey, all current tables uses "1" and
> > this is not an issue'?
> 
> I'm not sure if I'm following you, this would basically invalidate every
> usage of acpi_dev_hid_uid_match() helper across the driver.

It depends.

-- 
With Best Regards,
Andy Shevchenko


