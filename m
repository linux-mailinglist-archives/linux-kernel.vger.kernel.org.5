Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6307D1FBB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjJUVGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:06:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5CD51
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:06:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0906AC433C7;
        Sat, 21 Oct 2023 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697922402;
        bh=8wrp04eu57Wu4YRlX3diD5ih+G9GnM8VSg0urfpezNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBUDlKfPOwNm+U0lBYjh4V0nJ4V/36UsLGwFt8J+S3GjHqow1ycHSuYR7nqy7vv/V
         lgOwu6DHBUGKRCO9VPJqcg2LkSAMNRdu+EtBoBHSSKaqWWwlAwO+/TBdKmFZSWRgnf
         2rN89AIIYuuazBYboLX0gnCW2acqdWV4r3wYoXcM=
Date:   Sat, 21 Oct 2023 23:06:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Release all resources during unbind
 before updating device links
Message-ID: <2023102126-fridge-clammy-bb12@gregkh>
References: <20231018013851.3303928-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018013851.3303928-1-saravanak@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 06:38:50PM -0700, Saravana Kannan wrote:
> This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
> dependencies tracking support") where the device link status was
> incorrectly updated in the driver unbind path before all the device's
> resources were released.
> 
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Reported-by: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengutronix.de/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: James Clark <james.clark@arm.com>
> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a528cec24264..0c3725c3eefa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1274,8 +1274,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  		if (dev->bus && dev->bus->dma_cleanup)
>  			dev->bus->dma_cleanup(dev);
>  
> -		device_links_driver_cleanup(dev);
>  		device_unbind_cleanup(dev);
> +		device_links_driver_cleanup(dev);
>  
>  		klist_remove(&dev->p->knode_driver);
>  		device_pm_check_callbacks(dev);
> -- 
> 2.42.0.655.g421f12c284-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
