Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1797B60AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjJCGVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjJCGVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:21:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8DCE;
        Mon,  2 Oct 2023 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696314073; x=1727850073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aZY00p5Zs6evElTgNGG3NrD4dyDiLSahudswiJ1LeXk=;
  b=A9KtoCkT/hQw6Do0WapGZOfmqUQA29KiucFV902C3OI51Xf1wJnWOeCV
   Vy2+q8FMyghdMyJOM1mXxU86t4Q3x2IipAjenVAm7YLQDlxyauh7ymwKz
   EsoXjJotYI7TTD6rH3DP9jhX4784Fq5YpObtiz5z90PGu1OYaXMZi79jK
   ZdN4PMYMWIJ9BtyP8qaABdB7WsTad+scvRoAIw0rq2OcO9KLQyhg12OV5
   WucwCHjrETlDMWELH67Fa542Ci4z/uly4GvJErqbFJvfXypsC9FV6E/C5
   9yNeh7WpOKxM5TmBeq56gDZMvLPP0oP5EhrAzuIHDPqh2lBqQNSAYbGBI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="380079960"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="380079960"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081895650"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081895650"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 02 Oct 2023 23:21:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 09:21:08 +0300
Date:   Tue, 3 Oct 2023 09:21:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 07/14] USB: typec: tps6598x: Apply patch again after
 power resume
Message-ID: <ZRuy1NqA/VfWbBWn@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-8-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-8-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:27AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 PD controller might be powered off externally at power suspend,
> after resuming PD controller power back, apply the patch again.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

This one looks also like something that should be part of the patch 4.

My concern is that with these separated features you are creating points
into the kernel git tree where TPS25750 is enabled, but it's not fully
functional, or even broken in scenarious like this (suspend/resume).
You can't do that unless you have some really good reason.

Since all of these add only a bit of code each, I think it would be
better to just merge these into the initial patch that enabled
TPS25750 - so I belive patch 4/14.

> ---
> Changes in v9:
>   - No changes
> Changes in v8:
>   - Use device_is_compatible instead of of_device_is_compatible
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - Check tps25750 using is_compatiable device node
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
>  drivers/usb/typec/tipd/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 2598433a69cf..32e42798688f 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1203,6 +1203,17 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct tps6598x *tps = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = tps6598x_check_mode(tps);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
> +		ret = tps25750_apply_patch(tps);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (tps->wakeup) {
>  		disable_irq_wake(client->irq);
> -- 
> 2.34.1

-- 
heikki
