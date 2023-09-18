Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF67E7A4804
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjIRLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIRLI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:08:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8E119;
        Mon, 18 Sep 2023 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035269; x=1726571269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aRKzpkjTca0SXK7A2lb362HBVbvXPIZVTJbulPt7FYU=;
  b=bL1uq7XNPwbBtLcDJiIVKRQKtKp/HZ4q4LNG+hWLVpIaU5maGIp4h21U
   CUvG1tUJ4gaQg0/e8sxSAovM6R2RmmRZ9V1eby5UphFSgk8bPkhsBbch5
   3VSxfyKvXVRXaDqjvFf/PwlDDizoVyA6zu7uVV5/l3ttFrpA5JVGJZHKr
   nCoR9wTVN+wKy7P0KkILBBd9RtSvutUJXXcGU0rgVozFnW6UpTmDIBndT
   rjLWDePHyFa2dutbRjXGYcNDo6XgmrSGoXSuVD0PD4MqExVCQZeoEOwBq
   Xb9lF+aEv+QkEid8OX3oArZkVIt9fvkYSP/DTKPpbRHBve6EVK5uIkEDk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="369950109"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="369950109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="775094447"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="775094447"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga008.jf.intel.com with SMTP; 18 Sep 2023 04:07:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Sep 2023 14:07:44 +0300
Date:   Mon, 18 Sep 2023 14:07:44 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 03/15] USB: typec: Add patch mode to tps6598x
Message-ID: <ZQgvgJRLK+ysS30D@kuha.fi.intel.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-4-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917152639.21443-4-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:26:27AM -0400, Abdel Alkuor wrote:
> TPS25750 has a patch mode indicating the device requires
> a configuration to get the device into operational mode
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
>  drivers/usb/typec/tipd/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index a8aee4e1aeba..6d2151325fbb 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -68,6 +68,7 @@ enum {
>  	TPS_MODE_BOOT,
>  	TPS_MODE_BIST,
>  	TPS_MODE_DISC,
> +	TPS_MODE_PTCH,
>  };
>  
>  static const char *const modes[] = {
> @@ -75,6 +76,7 @@ static const char *const modes[] = {
>  	[TPS_MODE_BOOT]	= "BOOT",
>  	[TPS_MODE_BIST]	= "BIST",
>  	[TPS_MODE_DISC]	= "DISC",
> +	[TPS_MODE_PTCH] = "PTCH",
>  };
>  
>  /* Unrecognized commands will be replaced with "!CMD" */
> @@ -576,7 +578,7 @@ static void tps6598x_poll_work(struct work_struct *work)
>  			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>  }
>  
> -static int tps6598x_check_mode(struct tps6598x *tps)
> +static int tps6598x_check_mode(struct tps6598x *tps, u8 *curr_mode)
>  {
>  	char mode[5] = { };
>  	int ret;
> @@ -585,8 +587,11 @@ static int tps6598x_check_mode(struct tps6598x *tps)
>  	if (ret)
>  		return ret;
>  
> -	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
> +	*curr_mode = match_string(modes, ARRAY_SIZE(modes), mode);
> +
> +	switch (*curr_mode) {
>  	case TPS_MODE_APP:
> +	case TPS_MODE_PTCH:

This check is OK, but it seems that you are not using that curr_mode
for anything yet, so don't change the paramaters of this function in
this patch.

I would also just return the mode. Then this function would be used
like this:

        ret = tps6598x_check_mode(...)
        if (ret < 0)
                return ret;

Now mode = ret.

>  		return 0;
>  	case TPS_MODE_BOOT:
>  		dev_warn(tps->dev, "dead-battery condition\n");
> @@ -715,6 +720,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	u32 vid;
>  	int ret;
>  	u64 mask1;
> +	u8 mode;
>  
>  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
>  	if (!tps)
> @@ -759,7 +765,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  	tps->irq_handler = irq_handler;
>  	/* Make sure the controller has application firmware running */
> -	ret = tps6598x_check_mode(tps);
> +	ret = tps6598x_check_mode(tps, &mode);

Actually, if you need to know the mode in here later, then I'm not
sure tps6592x_check_mode() is useful after that. This is the only
place it's called. Just read and check the mode in here directly at
that point.

thanks,

-- 
heikki
