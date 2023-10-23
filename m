Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF27D2DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjJWJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:20:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A7B0;
        Mon, 23 Oct 2023 02:20:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52C2C433C8;
        Mon, 23 Oct 2023 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698052851;
        bh=mniIZRFgQ+O4sqQT3y40h2IlKCqc+FHbY8l30523e64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sc/8NNanHX5ny+kLtSTR/aPEvDiXB2wCMb0dLJSSI/3GP5E/e5Ivok4meeKLFLxFf
         +Jy+fGqCvMH0iLfHTTxr/NNQomoYqw9lHoZ4JLcckR1c9GfjrQ/KwmKEuK05YBkyws
         IzbNlN6qIj1XCBvv0ru3aRCJ8fhC9MeXIvhj8lA5I0ReA2FF9p0KEEOu1SHXLogRL7
         nDI/l5mgrRV47V6rp9OEcanwWlPefYFS1LsgelRQV/W+I9Eelt6C5CQUZBoUcJ6yT8
         yPJ1ZgTrpWNg/9Unewq9tOHxXXVU1DGIb5vitIrPs1BAogjbmxzFpyljzJ+z7+9xj9
         XVuY5IlX7o3Pg==
Date:   Mon, 23 Oct 2023 10:20:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Message-ID: <20231023092046.GA8909@google.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <20231019162359.GF2424087@google.com>
 <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, James Ogletree wrote:

> 
> Thank you for your thorough review. Anything not replied to below will be
> incorporated in the next version.
> 
> >> +/*
> >> + * CS40L50 Advanced Haptic Driver with waveform memory,
> > 
> > s/Driver/device/
> 
> CS40L50 is a “haptic driver”, like a "motor driver" in a car. It is an
> unfortunate name in this context, but it is straight from the datasheet.

Understood.  That's fine then.

> >> +static const struct mfd_cell cs40l50_devs[] = {
> >> + {
> >> + .name = "cs40l50-vibra",
> >> + },
> > 
> > 
> > Where are the other devices?  Without them, it's not an MFD.
> 
> The driver will need to support I2S streaming to the device at some point
> in the future, for which a codec driver will be added. I thought it better to
> submit this as an MFD driver now, rather than as an Input driver, so as
> not to have to move everything later.
> 
> Should I add the “cs40l50-codec” mfd_cell now, even though it does not
> exist yet?

What is your timeline for this to be authored?

Does the device function well without it?

> >> +static int cs40l50_handle_redc_est_done(struct cs40l50_private *cs40l50)
> >> +{
> >> + int error, fractional, integer, stored;
> > 
> > err or ret is traditional.
> 
> We received feedback to change from “ret” to “error” in the input
> subsystem, and now the opposite in MFD. I have no problem adopting
> “err” here, but is it understood that styles will be mixed across
> components?

That surprises me:

% git grep "int .*error" | wc -l
6152

vs

% git grep "int .*err" | grep -v error | wc -l
34753
% git grep "int .*ret" | wc -l  
76584

> >> +static irqreturn_t cs40l50_process_mbox(int irq, void *data)
> >> +{
> >> + struct cs40l50_private *cs40l50 = data;
> >> + int error = 0;
> >> + u32 val;
> >> +
> >> + mutex_lock(&cs40l50->lock);
> >> +
> >> + while (!cs40l50_mailbox_read_next(cs40l50, &val)) {
> >> + switch (val) {
> >> + case 0:
> >> + mutex_unlock(&cs40l50->lock);
> >> + dev_dbg(cs40l50->dev, "Reached end of queue\n");
> >> + return IRQ_HANDLED;
> >> + case CS40L50_MBOX_HAPTIC_TRIGGER_GPIO:
> >> + dev_dbg(cs40l50->dev, "Mailbox: TRIGGER_GPIO\n");
> > 
> > These all appear to be no-ops?
> 
> Correct.

Then why do the exist?

> >> + case CS40L50_MBOX_RUNTIME_SHORT:
> >> + dev_err(cs40l50->dev, "Runtime short detected\n");
> >> + error = cs40l50_error_release(cs40l50);
> >> + if (error)
> >> + goto out_mutex;
> >> + break;
> >> + default:
> >> + dev_err(cs40l50->dev, "Payload %#X not recognized\n", val);
> >> + error = -EINVAL;
> >> + goto out_mutex;
> >> + }
> >> + }
> >> +
> >> + error = -EIO;
> >> +
> >> +out_mutex:
> >> + mutex_unlock(&cs40l50->lock);
> >> +
> >> + return IRQ_RETVAL(!error);
> >> +}
> > 
> > Should the last two drivers live in drivers/mailbox?
> 
> Adopting the mailbox framework seems like an excessive amount
> of overhead for our requirements.

MFD isn't a dumping a ground for miscellaneous functionality.

MFD requests resources and registers devices.

Mailbox functionality should live in drivers/mailbox.

> >> +static irqreturn_t cs40l50_error(int irq, void *data);
> > 
> > Why is this being forward declared?
> > 
> >> +static const struct cs40l50_irq cs40l50_irqs[] = {
> >> + CS40L50_IRQ(AMP_SHORT, "Amp short", error),
> > 
> > I assume that last parameter is half of a function name.
> > 
> > Better to have 2 different structures and do 2 requests I feel.
> 
> I think I will combine the two handler functions into one, so as not
> to need the struct handler parameter, or the forward declaration.

Or the MACRO - win, win win.

> >> +{
> >> + struct device *dev = cs40l50->dev;
> >> + int error;
> >> +
> >> + mutex_init(&cs40l50->lock);
> > 
> > Don't you need to destroy this in the error path?
> 
> My understanding based on past feedback is that mutex_destroy()
> is an empty function unless mutex debugging is enabled, and there
> is no need cleanup the mutex explicitly. I will change this if you
> disagree with that feedback.

It just seems odd to create something and not tear it down.

> >> +struct cs40l50_irq {
> >> + const char *name;
> >> + int irq;
> >> + irqreturn_t (*handler)(int irq, void *data);
> >> +};
> >> +
> >> +struct cs40l50_private {
> >> + struct device *dev;
> >> + struct regmap *regmap;
> >> + struct cs_dsp dsp;
> >> + struct mutex lock;
> >> + struct gpio_desc *reset_gpio;
> >> + struct regmap_irq_chip_data *irq_data;
> >> + struct input_dev *input;
> > 
> > Where is this used?
> > 
> >> + const struct firmware *wmfw;
> > 
> > Or this.
> > 
> >> + struct cs_hap haptics;
> > 
> > Or this?
> > 
> >> + u32 devid;
> >> + u32 revid;
> > 
> > Are these used after they're set?
> 
> These are all used in the input driver, patch 4/4 of this series. If
> this is not acceptable in some way, I will change it per your
> suggestions.

Do they need to be shared with other devices?

If not, they should live where they are used.

-- 
Lee Jones [李琼斯]
