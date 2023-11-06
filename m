Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEB7E25E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjKFNoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:44:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC38DB;
        Mon,  6 Nov 2023 05:44:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E549C433C8;
        Mon,  6 Nov 2023 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699278252;
        bh=NZKyo0v5o4Qa29+Coxx3DHukZcEIzNSUZ3Uru0ifU3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvNiIG3hVziItCOnq+6SiJHxc1LtAAqDWAf+4blAuujZpnUrQsdJLdYEuXAIk89vA
         aeJp1bcq5zao1cNTtCbb66gxVcQYX1F/QebrkL5z/2orrcuLwH0gI4WiULM0T2BEx1
         Xv7iUU3kOZwAQQskAkdq1cvPG0tHHqudW68blxD8=
Date:   Mon, 6 Nov 2023 14:34:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-tty: free allocated ttyname buffer on
 deactivate
Message-ID: <2023110631-tidy-graffiti-4ed3@gregkh>
References: <20231106132246.3369826-1-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106132246.3369826-1-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:22:46PM +0100, Florian Eckert wrote:
> The ttyname buffer for the ledtrig_tty_data struct is allocated in the
> sysfs ttyname_store() function. This buffer must be released on trigger
> deactivation. This was missing and is thus a memory leak.
> 
> While we are at it, the tty handler in the ledtrig_tty_data struct should
> also be returned in case of the trigger deactivation call.
> 
> Fixes: fd4a641ac88f ("leds: trigger: implement a tty trigger")
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/leds/trigger/ledtrig-tty.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> index 8ae0d2d284af..3e69a7bde928 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct led_classdev *led_cdev)
>  
>  	cancel_delayed_work_sync(&trigger_data->dwork);
>  
> +	kfree(trigger_data->ttyname);
> +	tty_kref_put(trigger_data->tty);
> +	trigger_data->tty = NULL;
> +
>  	kfree(trigger_data);
>  }
>  
> -- 
> 2.30.2
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
