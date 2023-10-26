Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C87D7B22
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:00:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58DA182;
        Wed, 25 Oct 2023 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698289254; x=1729825254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AiMwsKoIqJ/vLjZTysZ5Brq6QaeclE1a+bWmPlvUU8w=;
  b=FWiqRLr1y50gB5xRAZeBtYoHYxlwHbRrWeXxZsTqPryRPcK3Ek7xpCsr
   6MElyy4R/MAwEV+B6pxFJ00GFb87DQyH7iBf/rAQ0bJc0TbreZS0ThCgh
   PG+u2VYr3WHMLEXk6pB3SRqk60qz17UlQarcikGjTo9+Wi+nlMN3+hVfz
   w2kwVmw0PlkCYeugjnsnImEf8S+bQjUeDNoDM2MQpTfzEN4Z97+654jXv
   t390MTBNdnqdS8uZbYCFjvgCBUisemf7g/l0eC8TM6oaVuErfKOxXClna
   poXlgjxSLxXuTNMffCirS1C9zjsjhDw6kvAmS4GECZEsiVshpA3I7NWAE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366796595"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="366796595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735606846"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735606846"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:00:28 -0700
Date:   Thu, 26 Oct 2023 06:00:25 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com,
        mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTnWSRIr1o7RLcOl@black.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
 <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTl7pDRypS3ZDIMy@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:33:40PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> > Use acpi_dev_uid_match() for matching _UID instead of treating it
> > as an integer.
> 
> NAK. See below why.
> 
> ...
> 
> >  static void byt_pwm_setup(struct lpss_private_data *pdata)
> >  {
> > -	u64 uid;
> > -
> >  	/* Only call pwm_add_table for the first PWM controller */
> > -	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
> > +	if (!acpi_dev_uid_match(pdata->adev, "1"))
> 
> _UID by specification is a type of _string_. Yet, that string may represent an
> integer number. Now, how many variants of the strings can you imagine that may
> be interpreted as integer 1? I can tell about dozens.
> 
> With your change you restricted the all possible spectre of the 1
> representations to a single one. Have you checked ALL of the DSDTs
> for these platforms to say 'hey, all current tables uses "1" and
> this is not an issue'?

I'm not sure if I'm following you, this would basically invalidate every
usage of acpi_dev_hid_uid_match() helper across the driver.

Raag
