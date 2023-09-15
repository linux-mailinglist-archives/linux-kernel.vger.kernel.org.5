Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E47A1FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjIONm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjIONm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:42:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23BC1BEB;
        Fri, 15 Sep 2023 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694785341; x=1726321341;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MNuTddJauiPRkBx+ucRB3S+YwwDAcFs5oVQUJiHydRY=;
  b=UV2DNlQWVtSuE31lqoKycRFSpD/LUNjd2BMzq+KptwWF4uwvfFhvNINE
   nNouIxmSGZQXkOMBGjoiJMd5khYSLrCHFUBSyp1eNSAKgawFGiteHSVwj
   D19YYDKd9TTuk1jsu1UjOfzarE7HFzEFg7fPz5d60n/5iuN2ci2i57eIW
   M7wBwVQws0MwQZoD8gvtWvYFprJPWMeeKrvKJABGjKWXyMp4k+eLr7MNt
   b816572vLeC1kuCuOZIwWf2NEEATiMiYZupwljCe7cH3CsV9Aig9+pY4l
   4/aO5WRaRqe71R2vIVnn3sRxBSsyMrB0ERIwiIbkJHaJ1PbqMK9fN9Z0O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="381978246"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="381978246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 06:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="744988928"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="744988928"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 06:42:18 -0700
Date:   Fri, 15 Sep 2023 16:42:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v4 1/4] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
In-Reply-To: <20230913212723.3055315-2-swboyd@chromium.org>
Message-ID: <b567a98b-8d4f-d0e4-145e-462a1edd5116@linux.intel.com>
References: <20230913212723.3055315-1-swboyd@chromium.org> <20230913212723.3055315-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2022163745-1694785340=:2347"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2022163745-1694785340=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Stephen Boyd wrote:

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
> The readl_poll_timeout() macro implements all of this, and it is
> shorter, so use that macro here to consolidate code and fix this.
> 
> There were some concerns with using readl_poll_timeout() because it uses
> timekeeping, and timekeeping isn't running early on or during the late
> stages of system suspend or early stages of system resume, but an audit
> of the code concluded that this code isn't called during those times so
> it is safe to use the macro.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
>  drivers/platform/x86/intel_scu_ipc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 6851d10d6582..4c774ee8bb1b 100644
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
> +	u8 status;
> +	int err;
>  
> -	do {
> -		u32 status;
> +	err = readx_poll_timeout(ipc_read_status, scu, status, !(status & IPC_STATUS_BUSY),
> +				 100, jiffies_to_usecs(IPC_TIMEOUT));
> +	if (err)
> +		return err;
>  
> -		status = ipc_read_status(scu);
> -		if (!(status & IPC_STATUS_BUSY))
> -			return (status & IPC_STATUS_ERR) ? -EIO : 0;
> -
> -		usleep_range(50, 100);
> -	} while (time_before(jiffies, end));
> -
> -	return -ETIMEDOUT;
> +	return (status & IPC_STATUS_ERR) ? -EIO : 0;
>  }
>  
>  /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
> 
--8323329-2022163745-1694785340=:2347--
