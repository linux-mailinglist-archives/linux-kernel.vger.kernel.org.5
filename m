Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B078F831
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348296AbjIAFuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjIAFuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:50:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579B10C4;
        Thu, 31 Aug 2023 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693547415; x=1725083415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VCwDKR0+XuajmyREC4vrMp5tg6MbHHMUwY4gC4BjQC8=;
  b=hrvarstXzYZh4VUqGqfjfRFxpQYSmSkt5R3ozJ1EnsktPyENgudj4lID
   XdPCYIpqx+1qzqTCRO6u77x/WdetswcNWS7EegYcKTMx9WhJn4BRoSU/8
   uzOyh1/QZ2EYQYWBnawb7gUzgR3/wrRpnzG3UleSf2p5xtuhKQlBCOhSC
   LFzvWn8TQtz0Z1TO40y7in3eFMguFsrUvvwTQt8O7D2i5eFMUEaljrh4Y
   1EeLDItDJXJaRN7wPFhIPPY+FU7zyGIrAzssc3GX8X1j/sPKQe2TAdpth
   VWoyQrgzTuK8je9/H8pVlf1MAs/9AWeSj7RK6pnvOupa50Pk9VUfdiIgR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440123006"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="440123006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 22:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070608229"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="1070608229"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2023 22:50:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1DA06DE; Fri,  1 Sep 2023 08:50:11 +0300 (EEST)
Date:   Fri, 1 Sep 2023 08:50:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 1/3] platform/x86: intel_scu_ipc: Check status after
 timeouts in busy_loop()
Message-ID: <20230901055011.GT3465@black.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org>
 <20230831011405.3246849-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831011405.3246849-2-swboyd@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:14:01PM -0700, Stephen Boyd wrote:
> It's possible for the polling loop in busy_loop() to get scheduled away
> for a long time.
> 
>   status = ipc_read_status(scu);
>   <long time scheduled away>
>   if (!(status & IPC_STATUS_BUSY))

How can the status bit change here as we are the only user and the SCU
access is serialized by ipclock?

> If this happens, then the status bit could change and this function
> would never test it again after checking the jiffies against the timeout
> limit. Polling code should check the condition one more time after the
> timeout in case this happens.
> 
> The read_poll_timeout() helper implements this logic, and is shorter, so
> simply use that helper here.

Yes, I agree it makes the code simpler.

> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 6851d10d6582..5a37becc65aa 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> @@ -231,19 +232,15 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
>  /* Wait till scu status is busy */
>  static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>  {
> -	unsigned long end = jiffies + IPC_TIMEOUT;
> -
> -	do {
> -		u32 status;
> -
> -		status = ipc_read_status(scu);
> -		if (!(status & IPC_STATUS_BUSY))
> -			return (status & IPC_STATUS_ERR) ? -EIO : 0;
> +	u8 status;
> +	int err;
>  
> -		usleep_range(50, 100);
> -	} while (time_before(jiffies, end));
> +	err = read_poll_timeout(ipc_read_status, status, !(status & IPC_STATUS_BUSY),
> +				100, jiffies_to_usecs(IPC_TIMEOUT), false, scu);
> +	if (err)
> +		return err;
>  
> -	return -ETIMEDOUT;
> +	return (status & IPC_STATUS_ERR) ? -EIO : 0;
>  }
>  
>  /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
> -- 
> https://chromeos.dev
