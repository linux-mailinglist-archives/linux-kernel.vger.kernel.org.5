Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91B79443F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbjIFUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbjIFUFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:05:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F63D7;
        Wed,  6 Sep 2023 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694030700; x=1725566700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJlCMxh78bP4gJBjCZmZsU6b6qkBCCueDO40mugKio4=;
  b=etNZ+IbGp/4Uuj8ytmLXFLzBA7bmXOr4ZcWj+5GHk1w/MuEnhEOCMvDB
   Bcv1rWCjdoOLhy4gtKb88wBjWaDZesVH1CCsbO4w7u6gLMbiqZEpjjR/z
   KmjMVR2oGxZyNlxpaee7C9FQwz5hN1agxDFq2p9JXWYGs/N4kxrEKseo0
   eHCWJMNrYDI0l3pTBdSytejOIpPuZVpxyCdQxULadCMhh6Ua1NYqTkbEC
   0ura4XBvvGmYwmcAx2sVtBEfxSwpIBW/3lZmjH6756E+IeuTaJhmrBaf8
   jDhniuJwvLsioOMthQHovB8Lgb0rjKy1hC8mEQAnmFiNioubRWPXmo/Ms
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443559255"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="443559255"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="811807641"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="811807641"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:04:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdyli-00795D-1t;
        Wed, 06 Sep 2023 23:04:54 +0300
Date:   Wed, 6 Sep 2023 23:04:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
Message-ID: <ZPjbZqIQBlIGpoCK@smile.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906180944.2197111-2-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 11:09:41AM -0700, Stephen Boyd wrote:
> It's possible for the polling loop in busy_loop() to get scheduled away
> for a long time.
> 
>   status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
>   <long time scheduled away>
>   if (!(status & IPC_STATUS_BUSY))
> 
> If this happens, then the status bit could change while the task is
> scheduled away and this function would never read the status again after
> timing out. Instead, the function will return -ETIMEDOUT when it's
> possible that scheduling didn't work out and the status bit was cleared.
> Bit polling code should always check the bit being polled one more time
> after the timeout in case this happens.
> 
> Fix this by reading the status once more after the while loop breaks.

...

>  static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>  {
>  	unsigned long end = jiffies + IPC_TIMEOUT;
> +	u32 status;
>  
>  	do {
> -		u32 status;
> -
>  		status = ipc_read_status(scu);
>  		if (!(status & IPC_STATUS_BUSY))

> -			return (status & IPC_STATUS_ERR) ? -EIO : 0;
> +			goto not_busy;

Wouldn't simple 'break' suffice here?

>  		usleep_range(50, 100);
>  	} while (time_before(jiffies, end));
>  
> -	return -ETIMEDOUT;
> +	status = ipc_read_status(scu);
> +	if (status & IPC_STATUS_BUSY)
> +		return -ETIMEDOUT;
> +not_busy:
> +	return (status & IPC_STATUS_ERR) ? -EIO : 0;



>  }

-- 
With Best Regards,
Andy Shevchenko


