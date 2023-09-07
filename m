Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B346797020
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjIGFf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjIGFf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:35:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF819B0;
        Wed,  6 Sep 2023 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694064922; x=1725600922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YydbqhJarc2vSKbDb2N/By/s4B0ANbgj0fmO0TLAQv8=;
  b=GvZSoCVGqbEdFMW3fcmNmvk/+Mfmn6ggwQyf0iGWjSEL2B+AGr7HicsX
   navKjGiODAcTXwRn1J0kc+pg6GNc0l0FWD2SrAe3kDWm/6ijfW9CsNWLp
   Ss7v5k4Fmb4MSJmP3djUgJI69HVBfFUytag0cAxcpHF8lQomvFsrNtyzR
   M4WD07aUzmq/YftvHj4aKUKTQcw9CbThmZ/ock+3o97X343SAfUxNfaaQ
   /JTVB2+rKjjZm1RXsDtZ+gFKk9CArzFr4BtNhNnD2MkCNKdqit4cpCo+b
   Tz3w90msfrIPwEVTXBWY715UxlQYRmVqPJFGL0rF1V3mp2cRKZE+Lg1wV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463641389"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="463641389"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 22:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865480969"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="865480969"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2023 22:35:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 17938177; Thu,  7 Sep 2023 08:35:13 +0300 (EEST)
Date:   Thu, 7 Sep 2023 08:35:13 +0300
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
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
Message-ID: <20230907053513.GH1599918@black.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906180944.2197111-2-swboyd@chromium.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> This is sufficiently busy so I didn't add any tags from previous round.
> 
>  drivers/platform/x86/intel_scu_ipc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 6851d10d6582..b2a2de22b8ff 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -232,18 +232,21 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
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
>  
>  		usleep_range(50, 100);
>  	} while (time_before(jiffies, end));
>  
> -	return -ETIMEDOUT;
> +	status = ipc_read_status(scu);

Does the issue happen again if we get scheduled away here for a long
time? ;-)

Regardless, I'm fine with this as is but if you make any changes, I
would prefer see readl_busy_timeout() used here instead (as was in the
previous version).

> +	if (status & IPC_STATUS_BUSY)
> +		return -ETIMEDOUT;
> +not_busy:
> +	return (status & IPC_STATUS_ERR) ? -EIO : 0;
>  }
>  
>  /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
> -- 
> https://chromeos.dev
