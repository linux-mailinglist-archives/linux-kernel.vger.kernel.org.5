Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8610D77B790
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjHNL1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjHNL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:26:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19765E61;
        Mon, 14 Aug 2023 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692012397; x=1723548397;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4alXUbWY/jCOus0cSzC/GsFDI54X66LesvCwVXEbq2Q=;
  b=QiLhtCqXbOnXrdGQwFAEa2Drn7srzXPoiJrVjnFEuh0CF2c6Q+uUNqOo
   dRDRd3kM93rY9/uoCYeM0MQO40Nw2qIdbHr7eCOrxzxEvfJt5bQN+uBu7
   0MFODSdx9poECVZvkQZJjPreHD69oOh1wwnZR7auJXk+Lb0AsJxBjhjxV
   YEE2L1fVFOOfPfqAdkbqDFDW/e9JA70N3YZRXK8w/w6RxFYLeEpeosPg6
   Ie6rcUUK4y04ugedzHaJaCUuvjXzDOE8FNb66PvE8NodgOxSFmi51APCY
   VfSrEJTpU4baVRfp6PMukyK1Pte++o38j0Q8s7IbRprwib7LwAAVGWljA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="356980149"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="356980149"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="762906161"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="762906161"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:26:32 -0700
Message-ID: <f1e154c4-bbb3-18a2-cb7a-41adae292b48@intel.com>
Date:   Mon, 14 Aug 2023 14:26:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v3 2/2] ufs: poll HCS.UCRDY before issuing a UIC
 command
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        kwangwon.min@samsung.com, junwoo80.lee@samsung.com,
        wkon.kim@samsung.com
References: <cover.1690939662.git.kwmad.kim@samsung.com>
 <CGME20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e@epcas2p2.samsung.com>
 <9c7ccbfb8fe05c29ab3e31d9cd14e6b91065b8b0.1690939662.git.kwmad.kim@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9c7ccbfb8fe05c29ab3e31d9cd14e6b91065b8b0.1690939662.git.kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/08/23 04:28, Kiwoong Kim wrote:
> With auto hibern8 enabled, UIC could be working
> for a while to process a hibern8 operation and HCI
> reports UIC not ready for a short term through HCS.UCRDY.
> And UFS driver can't recognize the operation.
> UFSHCI spec specifies UCRDY like this:
> whether the host controller is ready to process UIC COMMAND
> 
> The 'ready' could be seen as many different meanings. If the meaning
> includes not processing any request from HCI, processing a hibern8
> operation can be 'not ready'. In this situation, the driver needs to
> wait until the operations is completed.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>  drivers/ufs/core/ufshcd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index a89d39a..10ccc85 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched/clock.h>
> +#include <linux/iopoll.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_dbg.h>
>  #include <scsi/scsi_driver.h>
> @@ -2365,7 +2366,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>   */
>  static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>  {
> -	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
> +	u32 val;
> +	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
> +				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
> +				    REG_CONTROLLER_STATUS);
> +	return ret == 0 ? true : false;

Could use a comment in the code.

And perhaps the following is neater:

	u32 val;

	return !read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
				  500, UIC_CMD_TIMEOUT * 1000, false, hba,
				  REG_CONTROLLER_STATUS);

>  }
>  
>  /**

