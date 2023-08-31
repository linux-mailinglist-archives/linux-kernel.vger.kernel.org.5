Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96E78EF92
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbjHaO32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHaO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:29:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027BD1;
        Thu, 31 Aug 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693492159; x=1725028159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=14SEUhfhuXCd3crFTb7Q/Qo1nASIqzlXwb6vFU9XxOM=;
  b=jXXuqVyon+9QDo7oKnDdBsHEhlrddNBgaPGC21nTcjR4IFo1VMI1Tz6k
   FXc9jUbJ5l02jBQgUBIi1ZynpN+LCq5bs4tCE+LMQeRj9cLHCTGbkdqwd
   FBhibF2OcS87rti2TlYJgN3HSvmGwIWRxi0s26uyW8/Zy2LmM4Lvtiqcr
   e0ejudaSHu3qyRxLxEQ4qBhYmGPBIqqNh2kg0pLPF7mfDJPtvBSSFM6n/
   h21Ft66M4gsVYky9JE0YkdywpdfsOxU3Is8LqKIJpuHrDpLAuU9i5g3JQ
   +sDGfDTYIPBlqXJgtjZ0Hkum4QRDtrr8aRSb3bXbZTQi39W/ByR5Tvx84
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="360980372"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="360980372"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689371496"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="689371496"
Received: from bcnelson-mobl2.amr.corp.intel.com (HELO [10.209.16.42]) ([10.209.16.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:27:34 -0700
Message-ID: <321578a9-91fb-4733-b4c7-82dcc0ec8f8f@linux.intel.com>
Date:   Thu, 31 Aug 2023 07:27:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86: intel_scu_ipc: Check status upon
 timeout in ipc_wait_for_interrupt()
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
References: <20230831011405.3246849-1-swboyd@chromium.org>
 <20230831011405.3246849-3-swboyd@chromium.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230831011405.3246849-3-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 6:14 PM, Stephen Boyd wrote:
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
>   [TIMEOUT]                                             status[IPC_BUSY]=0
> 
> Fix this problem by reading the status bit in all cases, regardless of
> the timeout. If the completion times out, we'll assume the problem was
> that the IPC_BUSY bit was still set, but if the status bit is cleared in
> the meantime we know that we hit some scheduling delay and we should
> just check the error bit.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Fixes: ed12f295bfd5 ("ipc: Added support for IPC interrupt mode")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 5a37becc65aa..2a21153e3bf3 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -246,16 +246,19 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>  /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
>  static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
>  {
> -	int status;
> +	unsigned long time_left;
> +	u8 status;
> +	int err = 0;
>  
> -	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
> -		return -ETIMEDOUT;
> +	time_left = wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT);
> +	if (!time_left)
> +		err = -ETIMEDOUT;

Since you are not using the return value, I would not use time_left. I think the
following version is easy to read. But it is up to you.

wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)

status = ipc_read_status(scu);

if (status & IPC_STATUS_BUSY)
   return -ETIMEDOUT;

if (status & IPC_STATUS_ERR)
   return -EIO;

return 0;

With above fixed, you can add

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  
>  	status = ipc_read_status(scu);
> -	if (status & IPC_STATUS_ERR)
> -		return -EIO;
> +	if (!(status & IPC_STATUS_BUSY))
> +		err = (status & IPC_STATUS_ERR) ? -EIO : 0;
>  
> -	return 0;
> +	return err;
>  }
>  
>  static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
