Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B867F6550
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjKWRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjKWRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018BD5A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0638EC433CA;
        Thu, 23 Nov 2023 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700760170;
        bh=BuLWdTTGqavMGDf32PtDBpKYe8ub/X4Dej2UOp9+T6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKS84AFDEhCJ4KLTKAQityJ+XoUfRTWT5Olu/PDIbLlbvWNXl7XK7rNNwVSHWJU2e
         4yN56r9yNWBD4t6m8bvYdLd9PT4g1QO1PCefnIFfhhVu/Fmu4FJGo8PnD430ItzxM/
         cxKfwf9MLnDDFeIPY4zgBief1rMCTiv57ZjYQJEk=
Date:   Thu, 23 Nov 2023 14:12:46 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [Patch v8 5/6] leds: ledtrig-tty: make rx tx activitate
 configurable
Message-ID: <2023112334-unquote-robust-15b8@gregkh>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-6-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109085038.371977-6-fe@dev.tdt.de>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 09:50:37AM +0100, Florian Eckert wrote:
> Until now, the LED blinks when data is sent via the tty (rx/tx).
> This is not configurable.
> 
> This change adds the possibility to make the indication for the direction
> of the transmitted data independently controllable via the new rx and
> tx sysfs entries.
> 
> - rx:
>   Signal reception (rx) of data on the named tty device.
>   If set to 0, the LED will not blink on reception.
>   If set to 1 (default), the LED will blink on reception.
> 
> - tx:
>   Signal transmission (tx) of data on the named tty device.
>   If set to 0, the LED will not blink on transmission.
>   If set to 1 (default), the LED will blink on transmission.
> 
> This new sysfs entry are on by default. Thus the trigger behaves as
> before this change.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../ABI/testing/sysfs-class-led-trigger-tty   |  16 +++
>  drivers/leds/trigger/ledtrig-tty.c            | 124 ++++++++++++++++--
>  2 files changed, 130 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> index 2bf6b24e781b..504dece151b8 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> @@ -4,3 +4,19 @@ KernelVersion:	5.10
>  Contact:	linux-leds@vger.kernel.org
>  Description:
>  		Specifies the tty device name of the triggering tty
> +
> +What:		/sys/class/leds/<led>/rx
> +Date:		February 2024
> +KernelVersion:	6.8
> +Description:
> +		Signal reception (rx) of data on the named tty device.
> +		If set to 0, the LED will not blink on reception.
> +		If set to 1 (default), the LED will blink on reception.
> +
> +What:		/sys/class/leds/<led>/tx
> +Date:		February 2024
> +KernelVersion:	6.8
> +Description:
> +		Signal transmission (tx) of data on the named tty device.
> +		If set to 0, the LED will not blink on transmission.
> +		If set to 1 (default), the LED will blink on transmission.
> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> index 3badf74fa420..1a40a78bf1ee 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -17,6 +17,19 @@ struct ledtrig_tty_data {
>  	const char *ttyname;
>  	struct tty_struct *tty;
>  	int rx, tx;
> +	bool mode_rx;
> +	bool mode_tx;
> +};
> +
> +/* Indicates which state the LED should now display */
> +enum led_trigger_tty_state {
> +	TTY_LED_BLINK,
> +	TTY_LED_DISABLE,
> +};
> +
> +enum led_trigger_tty_modes {
> +	TRIGGER_TTY_RX = 0,
> +	TRIGGER_TTY_TX,
>  };
>  
>  static int ledtrig_tty_waitforcompletion(struct device *dev)
> @@ -86,12 +99,82 @@ static ssize_t ttyname_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(ttyname);
>  
> +static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
> +				     enum led_trigger_tty_modes attr)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	int completion;
> +	bool state;
> +
> +	reinit_completion(&trigger_data->sysfs);
> +	completion = ledtrig_tty_waitforcompletion(dev);
> +	if (completion < 0)
> +		return completion;

Why do you need to wait for anything just to read the sysfs file?  What
does that sync up with?  And why would it matter?

> +
> +	switch (attr) {
> +	case TRIGGER_TTY_RX:
> +		state = trigger_data->mode_rx;
> +		break;
> +	case TRIGGER_TTY_TX:
> +		state = trigger_data->mode_tx;
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", state);
> +}
> +
> +static ssize_t ledtrig_tty_attr_store(struct device *dev, const char *buf,
> +				      size_t size, enum led_trigger_tty_modes attr)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	int completion;
> +	bool state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&trigger_data->sysfs);
> +	completion = ledtrig_tty_waitforcompletion(dev);
> +	if (completion < 0)
> +		return completion;

Same here, why sync anything?

What am I missing as to why a completion is needed?

thanks,

greg k-h
