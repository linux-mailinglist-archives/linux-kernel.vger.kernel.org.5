Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D937F654B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbjKWRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbjKWRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281D1BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBBEC433CB;
        Thu, 23 Nov 2023 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700760167;
        bh=4297UUYd2y99yNrz1B47l1NxhhE7aZJo2hPif4wzTU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ll49BDTSDAAA9FwoEwJc+oYmPkeIkJV2lLEDdIBkGrzG5LzK3UDffB/1Q2E/qIY3E
         GHLLx/lDh91ODzy2fgWmPIFhaJnGL67ypjsTCBZmjaMryAKu86NqwNohY/z809XRXo
         55r8G53SCFfGD+sdt5DBsUn73PS7Jb5kYX7qW5IY=
Date:   Thu, 23 Nov 2023 14:10:44 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [Patch v8 4/6] leds: ledtrig-tty: replace mutex with completion
Message-ID: <2023112310-salaried-shower-bc76@gregkh>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-5-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109085038.371977-5-fe@dev.tdt.de>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 09:50:36AM +0100, Florian Eckert wrote:
> With this commit, the mutex handling is replaced by the completion
> handling. When handling mutex, it must always be ensured that the held
> mutex is also released again. This is more error-prone should the number
> of code paths increase.
> 
> This is a preparatory commit to make the trigger more configurable via
> additional sysfs parameters. With this change, the worker always runs and
> is no longer stopped if no ttyname is set.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/leds/trigger/ledtrig-tty.c | 60 +++++++++++++++---------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> index 86595add72cd..3badf74fa420 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/leds.h>
>  #include <linux/module.h>
> @@ -12,15 +13,24 @@
>  struct ledtrig_tty_data {
>  	struct led_classdev *led_cdev;
>  	struct delayed_work dwork;
> -	struct mutex mutex;
> +	struct completion sysfs;
>  	const char *ttyname;
>  	struct tty_struct *tty;
>  	int rx, tx;
>  };
>  
> -static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
> +static int ledtrig_tty_waitforcompletion(struct device *dev)

Nit, you might want to add a few more '_' characters, right:
	ledtrig_tty_wait_for_completion()
to match up with the call to wait_for_completion_timeout() it makes.

>  {
> -	schedule_delayed_work(&trigger_data->dwork, 0);
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	int ret;
> +
> +	ret = wait_for_completion_timeout(&trigger_data->sysfs,
> +					  msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 20));
> +

Nit, no blank line needed here, if you happen to redo this patch.

thanks,

greg "naming is hard" k-h
