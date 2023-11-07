Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD747E3B11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjKGLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjKGLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:23:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33B170F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:22:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE4AC433CA;
        Tue,  7 Nov 2023 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699356178;
        bh=V9rogjxpff4kHHYkRMqrsxPtJ59m8lpdrZIxg0uCj+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNIe8kZ5L+rXRYTmPJfXCa7H1DsxeAAKzaGbUO1pBahcX2VU1/aQy2nqPOP2ZH1p7
         x5g4fAA8Rea/gcouyfOkcWp85RZZjSDXrLKkqWJiw60uvvHQWCrMrVGALZhXus8gBq
         xb8kP960MuVQOFaMfGINHgrAK1WW3FzOjmaGPX3M=
Date:   Tue, 7 Nov 2023 12:22:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] devcoredump: Send uevent once devcd is ready
Message-ID: <2023110747-outcast-emote-e46f@gregkh>
References: <1699355026-6788-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699355026-6788-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 04:33:46PM +0530, Mukesh Ojha wrote:
> dev_coredumpm() creates a devcoredump device and adds it
> to the core kernel framework which eventually end up
> sending uevent to the user space and later creates a
> symbolic link to the failed device. An application
> running in userspace may be interested in this symbolic
> link to get the name of the failed device.
> 
> In a issue scenario, once uevent sent to the user space
> it start reading '/sys/class/devcoredump/devcdX/failing_device'
> to get the actual name of the device which might not been
> created and it is in its path of creation.
> 
> To fix this, suppress sending uevent till the failing device
> symbolic link gets created and send uevent once symbolic
> link is created successfully.
> 
> Fixes: 833c95456a70 ("device coredump: add new device coredump class")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v2:
>  - Added Fixes tag as per suggestion from [Johannes]
> 
>  drivers/base/devcoredump.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 91536ee05f14..7e2d1f0d903a 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -362,6 +362,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	devcd->devcd_dev.class = &devcd_class;
>  
>  	mutex_lock(&devcd->mutex);
> +	dev_set_uevent_suppress(&devcd->devcd_dev, true);
>  	if (device_add(&devcd->devcd_dev))
>  		goto put_device;
>  
> @@ -376,6 +377,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  		              "devcoredump"))
>  		dev_warn(dev, "devcoredump create_link failed\n");
>  
> +	dev_set_uevent_suppress(&devcd->devcd_dev, false);
> +	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
>  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
>  	mutex_unlock(&devcd->mutex);
> -- 
> 2.7.4
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
