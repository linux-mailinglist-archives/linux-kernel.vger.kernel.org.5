Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B587E2283
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjKFM46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjKFM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:56:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA497A9;
        Mon,  6 Nov 2023 04:56:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51F0C433CA;
        Mon,  6 Nov 2023 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275413;
        bh=RovK8HQK7N44J2KsgwsMa0xpeZZiEG8V4eFEcPd221s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2qcj/PjkGVdh1W0Z3qTCvT3G/x7/VbhsxzKo8YosgdddchlTWctYh+LOpQILWXPGo
         lVxTJIKnA1BaVHHRb2QAOeaLmzBBNBQjN6fW9TuEXaPU0XP6NT+Frq4fe00HmzNtO6
         wHSgXu7hA6XBItEFcf9jFLjdB5llWP0Ewxp5lbck=
Date:   Mon, 6 Nov 2023 13:56:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [Patch v7 2/6] leds: ledtrig-tty: free allocated ttyname buffer
 on deactivate
Message-ID: <2023110629-scenic-rounding-905f@gregkh>
References: <20231106123415.3365732-1-fe@dev.tdt.de>
 <20231106123415.3365732-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106123415.3365732-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 01:34:11PM +0100, Florian Eckert wrote:
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

This should be sent independent of your new changes please, as it is a
bugfix for all kernels.

thanks,

greg k-h
