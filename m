Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CC7D3756
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjJWM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:59:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DCB3;
        Mon, 23 Oct 2023 05:59:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BC2C433C8;
        Mon, 23 Oct 2023 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698065945;
        bh=/tg5ZQeWZUyFxMOP7fdZq8yaLOE+w3tQK2RQChg72kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifWBwQhYL7jeodAM5aD8MOGN/QGCDnA469TGx8WsmKIDbEKEOuSkQoNUk1XPArV0T
         HyiyUm4NEj8Y1t1BBY7rhwLVRcK7RVhM8uGANYW8CgMYYr1Pb1xWSMNsikMV7Ra0UH
         8QxjhDNndAUaNXDszogm8OYUjUr/4kjN1PtY6Xls=
Date:   Mon, 23 Oct 2023 14:59:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
Message-ID: <2023102333-skewer-reclining-8d04@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <2023102341-jogger-matching-dded@gregkh>
 <7e8860574413505c314bdfd0f3e10188@dev.tdt.de>
 <2023102320-princess-issuing-be13@gregkh>
 <c4398f09d5a07672ad77f2100ccae0f4@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4398f09d5a07672ad77f2100ccae0f4@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:45:55PM +0200, Florian Eckert wrote:
> 
> 
> On 2023-10-23 14:27, Greg KH wrote:
> > On Mon, Oct 23, 2023 at 02:15:55PM +0200, Florian Eckert wrote:
> > > > Again, I thought we had rx/tx already?  If not, how was that controlled
> > > > today?
> > > 
> > > It could not be controlled! The LED flashed when data where
> > > transferred.
> > > This was the only function that the trigger supported.
> > 
> > Ok, then maybe this needs to be a bit longer of a series.  One that does
> > the "tx/rx" feature, as that is needed today, and will be the more
> > complex one, and then one-per-line-setting that you want to apply.
> > 
> > That should make it much easier to review overall, right?
> 
> Sorry for asking, but why should I split the change.
> What is the added value? But if it is necessary, then I will do it.
> 
> Before my change, the trigger could not be configured.
> The LED always flashed when data was transferred.

But you could configure that, right?  on/off, correct?  And now you are
splitting this out into different "options", which are all different.

> Now I can configure for which tty event the LED should flash or be on/off.

Great.

> So that the trigger behaves the same as before (flash on rx/tx
> transmission),
> I set the rx/tx bits in the function ledtrig_tty_activate() with the
> following code. Nothing changes for the user of the trigger.
> 
> /* Enable default rx/tx LED blink */
> set_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger);
> set_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger);

I agree, but now you are splitting this up into a much finer grained
feature.

Anyway, just a thought, I'll defer to the LED maintainers here as to how
they want to see this, I thought it would actually be easier this way,
maybe not, your call.

thanks,

greg k-h
