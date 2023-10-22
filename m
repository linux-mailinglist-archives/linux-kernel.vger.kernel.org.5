Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038D7D22E5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJVLYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:24:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE11E5;
        Sun, 22 Oct 2023 04:24:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06992C433C7;
        Sun, 22 Oct 2023 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697973884;
        bh=wl7IrqiQxUg4zaYRUzrv146WVifzpKecnQb2nxtkafo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNQYQqkWoSlwGNlRb3nIpsJtH+17ZTXd2PyYqGRJsGLGj5VA/ch29t7fYgxmNn6/W
         aV7UpfbtAVKgoh5Pv8aBasu3lAsi0NBIBSrOrJ7BZKCLd/1TSUrkserZUcsA8UbT4p
         +qW3WWVFRWL59ZjmZGHMtLSpr8VPw14TXAhehE0I=
Date:   Sun, 22 Oct 2023 13:24:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 3/3] leds: ledtrig-tty: add new line mode evaluation
Message-ID: <2023102235-wafer-plethora-ac3c@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-4-fe@dev.tdt.de>
 <2023102136-reenact-cash-7295@gregkh>
 <72be6923ff6dd03a5d02d04ee1c5796f@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72be6923ff6dd03a5d02d04ee1c5796f@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 12:24:27PM +0200, Florian Eckert wrote:
> On 2023-10-21 18:07, Greg KH wrote:
> > > diff --git a/drivers/leds/trigger/ledtrig-tty.c
> > > b/drivers/leds/trigger/ledtrig-tty.c
> > > index 8ae0d2d284af..6a96439a7e55 100644
> > > --- a/drivers/leds/trigger/ledtrig-tty.c
> > > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > > @@ -16,6 +16,24 @@ struct ledtrig_tty_data {
> > >  	const char *ttyname;
> > >  	struct tty_struct *tty;
> > >  	int rx, tx;
> > > +	unsigned long mode;
> > 
> > Why is mode "unsigned long" when the tty layer treats it as an int?  And
> > really, this should be set to an explit size, u32 perhaps?  Or am I
> > confused as to exactly what this is?
> 
> This is about the line state that the LED should show "altogether".
> All states that the LED is to display are stored here.
> 
> For example:
> Via the sysfs of the LED I can set the flags rx, tx and line_cts to
> a "not" zero value. That means that the led is enable if the CTS of the
> tty ist set, and the LED flashes if rx/tx data are transmitted via
> this tty.
> 
> Therefore, the bits 0 (TRIGGER_TTY_RX), 1 (TRIGGER_TTY_TX) and
> 2 (TRIGGER_TTY_CTS) are set in the variable. As defined in the
> enum led_trigger_tty_modes

So the enum is a bitfield value?  That's not obvious either, a comment
for the enum might be good to help describe that.

> I think I have not chosen the correct name for the variable there.
> Maybe line_state, would be a better choice?

Or "trigger_modes"?  "mode" feels odd, these are values, so maybe just
"triggers"?

Naming is hard :(

> > > +};
> > > +
> > > +enum led_trigger_tty_state {
> > > +	TTY_LED_BLINK,
> > > +	TTY_LED_ENABLE,
> > > +	TTY_LED_DISABLE,
> > > +};
> > > +
> > > +enum led_trigger_tty_modes {
> > > +	TRIGGER_TTY_RX = 0,
> > > +	TRIGGER_TTY_TX,
> > > +	TRIGGER_TTY_CTS,
> > > +	TRIGGER_TTY_DSR,
> > > +	TRIGGER_TTY_CAR,
> > > +	TRIGGER_TTY_RNG,
> > > +	/* Keep last */
> > > +	__TRIGGER_TTY_MAX,
> > >  };
> > > 
> > 
> > Oh wait, is "mode" this?  If so, why not define it as an enum?  Or if
> > not, I'm totally confused as to what is going on here, sorry.
> 
> See explanation above. I can not set this to an enum because I could
> set more then one Flag via the sysfs.

Ah, then say they are bits, enums are usually not used for that, or if
they are, they are documented better :)

> > >  static void ledtrig_tty_restart(struct ledtrig_tty_data
> > > *trigger_data)
> > > @@ -78,13 +96,106 @@ static ssize_t ttyname_store(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR_RW(ttyname);
> > > 
> > > +static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
> > > +	enum led_trigger_tty_modes attr)
> > > +{
> > > +	struct ledtrig_tty_data *trigger_data =
> > > led_trigger_get_drvdata(dev);
> > > +	int bit;
> > > +
> > > +	switch (attr) {
> > > +	case TRIGGER_TTY_RX:
> > > +	case TRIGGER_TTY_TX:
> > > +	case TRIGGER_TTY_CTS:
> > > +	case TRIGGER_TTY_DSR:
> > > +	case TRIGGER_TTY_CAR:
> > > +	case TRIGGER_TTY_RNG:
> > > +		bit = attr;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return sprintf(buf, "%u\n", test_bit(bit, &trigger_data->mode));
> > 
> > sysfs_emit() for all new sysfs attributes please.
> 
> Correct. Thanks for the hint will use sysf_emit() function in the next
> patchset round.
> 
> > 
> > > +}
> > > +
> > > +static ssize_t ledtrig_tty_attr_store(struct device *dev, const
> > > char *buf,
> > > +	size_t size, enum led_trigger_tty_modes attr)
> > > +{
> > > +	struct ledtrig_tty_data *trigger_data =
> > > led_trigger_get_drvdata(dev);
> > > +	unsigned long state;
> > > +	int ret;
> > > +	int bit;
> > > +
> > > +	ret = kstrtoul(buf, 0, &state);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	switch (attr) {
> > > +	case TRIGGER_TTY_RX:
> > > +	case TRIGGER_TTY_TX:
> > > +	case TRIGGER_TTY_CTS:
> > > +	case TRIGGER_TTY_DSR:
> > > +	case TRIGGER_TTY_CAR:
> > > +	case TRIGGER_TTY_RNG:
> > > +		bit = attr;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (state)
> > > +		set_bit(bit, &trigger_data->mode);
> > > +	else
> > > +		clear_bit(bit, &trigger_data->mode);
> > 
> > I think your test of "state" here is wrong, if you write in "40000" you
> > are treating it as "1", which I don't think you want, right?
> 
> If I have understood your question correctly, then I would say that your
> assumption is not correct. I just want to check here whether it is a number
> greater than zero or not. If the number is greater than zero then the bit
> should be set in the 'mode' variable of the struct and if it is zero then
> it should be cleared.

"greater than 0" can be any number, that's not a good api.  Use the
sysfs api that can handle a boolean, it will deal with "y/N" and 0/1 and
all sorts of other options that way for you automatically.

> The LED could indicate more then one state there. As described above.
> This was requested by Uwe Kleine-König in the old v7 patch series [1].

That's fine, but you need to fix up the userspace api a bit here.

thanks,

greg k-h
