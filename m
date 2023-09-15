Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D17A2027
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjIONtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjIONtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:49:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C9B2121;
        Fri, 15 Sep 2023 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694785750; x=1726321750;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4IcYhwjz5QUsOTeYLbkK5pEmiuhen3zjH9p2Ck1k6DY=;
  b=AOiHtp/3ToKHmTiTKajWx7K8ccLhvQCyvUOalvJ34iRx04M3K19yMEI3
   ihhUEyCVWY/laRHPyx9ro+s4lZDuijuy6ieqf12cFvI7RCPIup0pSAnQ3
   icf8DblxEeLDIoQtet9Jl+2Kiqc4QVjGSfxaoVShzjoG/eJfbu2bmOCCr
   PtYWtmJU7cOe5jwcpRqZhFQuRXAvGZydGumn2KIwAndgTCv2bquqE86+h
   ZFjw/yJs+mn9jJFPn7tC/qgE3YtrkaLsO7u16oGp4jUOXtQpEcdX90c7T
   znqjUagROMzCSZ5mOGky53BZxkeg8+tYCJCl4V+OwZdb7fRvg20bbFJjI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465613862"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="465613862"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 06:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="694726004"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="694726004"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 06:49:06 -0700
Date:   Fri, 15 Sep 2023 16:49:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v4 2/4] platform/x86: intel_scu_ipc: Check status upon
 timeout in ipc_wait_for_interrupt()
In-Reply-To: <20230913212723.3055315-3-swboyd@chromium.org>
Message-ID: <2bd9b7e2-a558-305b-bfd9-e64c28b6303d@linux.intel.com>
References: <20230913212723.3055315-1-swboyd@chromium.org> <20230913212723.3055315-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Stephen Boyd wrote:

> It's possible for the completion in ipc_wait_for_interrupt() to timeout,
> simply because the interrupt was delayed in being processed. A timeout
> in itself is not an error. This driver should check the status register
> upon a timeout to ensure that scheduling or interrupt processing delays
> don't affect the outcome of the IPC return value.
> 
>  CPU0                                                   SCU
>  ----                                                   ---
>  ipc_wait_for_interrupt()
>   wait_for_completion_timeout(&scu->cmd_complete)
>   [TIMEOUT]                                             status[IPC_STATUS_BUSY]=0
> 
> Fix this problem by reading the status bit in all cases, regardless of
> the timeout. If the completion times out, we'll assume the problem was
> that the IPC_STATUS_BUSY bit was still set, but if the status bit is
> cleared in the meantime we know that we hit some scheduling delay and we
> should just check the error bit.

Hi,

I don't understand the intent here. What prevents IPC_STATUS_BUSY from 
changing right after you've read it in ipc_read_status(scu)? Doesn't that 
end you exactly into the same situation where the returned value is stale 
so I cannot see how this fixes anything, at best it just plays around the 
race window that seems to still be there after this fix?

-- 
 i.


> Cc: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Fixes: ed12f295bfd5 ("ipc: Added support for IPC interrupt mode")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 4c774ee8bb1b..299c15312acb 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -248,10 +248,12 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
>  {
>  	int status;
>  
> -	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
> -		return -ETIMEDOUT;
> +	wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT);
>  
>  	status = ipc_read_status(scu);
> +	if (status & IPC_STATUS_BUSY)
> +		return -ETIMEDOUT;
> +
>  	if (status & IPC_STATUS_ERR)
>  		return -EIO;
>  
> 
