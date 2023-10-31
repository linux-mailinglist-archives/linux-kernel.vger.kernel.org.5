Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05277DD189
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbjJaQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjJaQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:26:15 -0400
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E39F5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698769571; bh=FFuVpp1QEvLteecX8RDwJQXzI/wF7TmQcz4oyiY5/xI=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=BMzP9rhdMwOeQBovx1dt1/zXtRcXsnzsov3VXrIDeFcrZtTNPlMQPeDGAEqqXb+Bs
         b5jmPs56sq9X2VfQ6VKylhznPHW/FvxULUT44JHTZdl/Kxl7ukaeE1wLAch6w79ZsZ
         MlL7zqCazhF725chf0PAUGJuWS6diX8G3x230ouafWF4OIPP02ZzBWhSBFdkS
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: Re: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine
 after a timeout
Author: Mike Isely <isely@isely.net>
Original-cc: Andi Shyti <andi.shyti@kernel.org>, mike.isely@cobaltdigital.com,
  Florian Fainelli <florian.fainelli@broadcom.com>,
  Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
  Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
  linux-rpi-kernel@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Received: from ts3-dock1.isely.net (ts3-dock1.isely.net [::ffff:192.168.23.13])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000806A4.0000000065412AA3.00001882; Tue, 31 Oct 2023 11:26:11 -0500
Date:   Tue, 31 Oct 2023 11:26:10 -0500 (CDT)
From:   Mike Isely <isely@isely.net>
Reply-To: Mike Isely at pobox <isely@pobox.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
cc:     Andi Shyti <andi.shyti@kernel.org>, mike.isely@cobaltdigital.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine
 after a timeout
In-Reply-To: <CAPY8ntBQ9MVYZVwndYsGNu+w8Jed727W4zCAZmVonSbRvsf32w@mail.gmail.com>
Message-ID: <a99eac6d-088c-f0e2-9393-1320e44854a8@isely.net>
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com> <20231030162114.3603829-2-mike.isely@cobaltdigital.com> <20231031114339.nutx2q2vtwbaaw6h@zenone.zhora.eu> <CAPY8ntBQ9MVYZVwndYsGNu+w8Jed727W4zCAZmVonSbRvsf32w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Response & details below...

On Tue, 31 Oct 2023, Dave Stevenson wrote:

> Hi Mike & Andi
> 
> On Tue, 31 Oct 2023 at 11:44, Andi Shyti <andi.shyti@kernel.org> wrote:
> >
> > Hi Mike,
> >
> > > When the driver detects a timeout, there's no guarantee that the ISR
> > > would have fired.  Thus after a timeout, it's the foreground that
> > > becomes responsible to reset the hardware state machine.  The change
> > > here just duplicates what is already implemented in the ISR.
> >
> > Is this a fix? What failing here?
> >
> > Can we have a feedback from Florian, Ray or Scott here?
> >
> > ...
> >
> > >       if (!time_left) {
> > > +             /* Since we can't trust the ISR to have cleaned up, do the
> > > +              * full cleanup here... */
> >
> > Please use the
> >
> >         /*
> >          * comment
> >          * comment
> >          */
> >
> > format
> >
> > >               bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
> > >                                  BCM2835_I2C_C_CLEAR);
> > > +             bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
> > > +                                BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
> >
> > I'm not sure this is really making any difference though. How
> > have you tested this?
> >
> > Have you tried reading those registers before and understand what
> > went wrong?
> 
> I guess we may have a race hazard here.

> The completion has timed out. The write to I2C_C will flush the FIFOs
> and mask the interrupts out, so if the transaction can complete at
> that point then the ISR won't handle clearing the status flags. As the
> flags are "write 1 to reset", they could still be set for the next
> transfer.

Yes, that's the problem with the state cleanup that the first patch 
fixes.  In addition to clearing stuff in the control register (which was 
already there), one must also clear out pending status bits in the 
status register, i.e. ERR, DONE, and CLKT, which is what happens here.  
Realize that if the status bits are not cleaned up, then these bits will 
lead the ISR astray in the next transfer...

Note that the comment I added is one statement ABOVE where I added code, 
since the two statements together define the full cleanup.  So I'm 
talking about adding cleanup for the status bits as the control register 
is already handled in the first statement here.


> It'd be down to the exact timing of hitting I2C_C_CLEAR (to clear the
> FIFOs and disable the interrupts) and when that terminates the
> transfer. Ensuring the status bits are cleared will do no harm, but
> I'm not convinced that there is an issue in the first place that needs
> fixing. Can you give any more detail of when you've seen this fail?

See further down.  But basically, if a timeout occurs, then the control 
register won't be cleared at all since that is happening in the ISR - 
which never fires.  The fix clones the cleanup into the timeout handler 
as well - just a single line to clear the control register same as in 
the ISR.

This *definitely* fixes a problem because without it the next transfer 
will start with the hardware in a non-idle state (status bits still 
set), cascading to more errors when the ISR next fires and goes sideways 
due to the erroneous bits.


> 
>   Dave

There are 2 bugs here.  (Actually there were 3 but I noticed a separate 
fix for the third one involving anintermittent incorrect error code on 
slave select errors is already merged in 6.5.9 so I dropped that from my 
patch set).

1. If the driver detects a timeout, the hardware isn't fully cleaned up.  
This can cause the subsequent transaction to be fouled - this is the 
actual symptom which started me down this rabbit hole in the first 
place.  (The subsequent transaction was an EEPROM access which caused 
our logic to conclude it was corrupted and then re-initializing it, 
destroying the rest of its contents...)  But I have seen cases where 
this behavior leads to an infinite loop of slave select errors, probably 
again because of the leftover hardware state after the timeout.  The 
first patch fixes that by applying the same cleanup in the timeout 
handling as that which would have happened in the ISR.

2. There is a race going on, and I believe it's in the controller 
silicon.  It's the cause for the driver-detected timeouts that I have 
seen here.  This is the reason for the very lengthy comment for that 
patch.  The race happens in the hardware (1) which triggers the first TX 
interrupt vs (2) the hardware that detects a slave select error.  Both 
should generate an interrupt, but each is controlled by a separate 
interrupt enable.  Things go awry if the slave select error wins the 
race and INTD is off.  This is apparently because when the slave select 
error implicitly causes DONE to be set, which then masks the TX 
interrupt - and if INTD isn't also set then NO interrupt occurs at all, 
everything hangs, and you get the timeout.  One of the tests I did was 
to add instrumention in the timeout detection to log the hardware state 
at that moment and it clearly shows INTD clear, ERR set, DONE set, INTT 
set, TXW set, and *no* ISR had ever fired.  I had also instrumented a 
counter in the ISR itself so I could positively prove if the ISR had 
been fired.  The fix for this is for INTD to be enabled at all times 
when a transaction is underway, which is what this patch does.  
According to my reading of the datasheet and extensive empirical tests, 
having INTD on whenever the transaction is active is otherwise benign.  
And with that fix, I have yet to see another I2C driver timeout take 
place.  Not a single one.

I also suspect that unless there's another bug in the controller 
silicon, then with this INTD fix you'll probably never see I2C timeouts 
ever happen again.  But I'd want to keep the timeout detection there 
"just in case" and it's good hygiene anyway to ensure the hardware can't 
ever hang the driver.

The first patch, the timeout cleanup, should prevent any subsequent 
foulups should the timeout ever happen again.  The second patch, the 
race condition fix involving INTD, prevents the timeouts from happening 
in the first place.

  -Mike
   isely@pobox.com


> 
> > Andi
> >
> >
> > _______________________________________________
> > linux-rpi-kernel mailing list
> > linux-rpi-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
> 
