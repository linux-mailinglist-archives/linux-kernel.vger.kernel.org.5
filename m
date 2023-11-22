Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7EE7F44E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbjKVL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjKVL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:28:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E91112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:28:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAD6C433C8;
        Wed, 22 Nov 2023 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700652489;
        bh=NHKa/vsYdWoic3tnDG4NhIrwxU9ejnwncYNv1XBIf+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOKzSTbBYo09L0g7JzNNnmRkY5XZl2INwwN3NJ8liLcs3zH7xNW9YcExKAzR7yniW
         kE7/mG0zekuBD2Oa0KwVd8wiutHPmQ+M9iNTBXslU7+mh+bbxhNQNqV0KOwpdBF36h
         oUGYx38J41CXVS/sW3xMghpyHZ+K/Z8O0quSMM+AUC5HYrkNnsmVpiWMVy2DASl5Bq
         TuYWAoxFbA29ZrZQrMK/ZnQ7ItqKoOhbPrA1NhFQGxUVC1cK/amCnHtiagNRQNaNko
         RfmP1C2s1rc1DM6uPwx2fjcvez4qgC322E+diID8oAnkoPf4zL9HbwHjke3b8IBTxx
         qcAg1iJ4pbJLA==
Date:   Wed, 22 Nov 2023 11:28:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     m.brock@vanmierlo.com, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [Patch v8 6/6] leds: ledtrig-tty: add additional line state
 evaluation
Message-ID: <20231122112803.GG173820@google.com>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-7-fe@dev.tdt.de>
 <39e7c892299c74821b1105a0967063ca@vanmierlo.com>
 <20231117121253.GB137434@google.com>
 <bc369f8759778c2c3b8be3a5d755064a@dev.tdt.de>
 <20231121152336.GC173820@google.com>
 <c8635ad8fd369283f33e1f9b7e4ee66d@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8635ad8fd369283f33e1f9b7e4ee66d@dev.tdt.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, Florian Eckert wrote:

> 
> 
> On 2023-11-21 16:23, Lee Jones wrote:
> > On Mon, 20 Nov 2023, Florian Eckert wrote:
> > 
> > > 
> > > 
> > > On 2023-11-17 13:12, Lee Jones wrote:
> > > > On Thu, 09 Nov 2023, m.brock@vanmierlo.com wrote:
> > > >
> > > > > Florian Eckert schreef op 2023-11-09 09:50:
> > > > > > The serial tty interface also supports additional input signals, that
> > > > > > can also be evaluated within this trigger. This change is adding the
> > > > > > following additional input sources, which could be controlled
> > > > > > via the '/sys/class/<leds>/' sysfs interface.
> > > > > >
> > > > > > Explanation:
> > > > > > DCE = Data Communication Equipment (Modem)
> > > > > > DTE = Data Terminal Equipment (Computer)
> > > > > >
> > > > > > - cts:
> > > > > >   DCE is ready to accept data from the DTE (CTS = Clear To Send). If
> > > > > >   the line state is detected, the LED is switched on.
> > > > > >   If set to 0 (default), the LED will not evaluate CTS.
> > > > > >   If set to 1, the LED will evaluate CTS.
> > > > > >
> > > > > > - dsr:
> > > > > >   DCE is ready to receive and send data (DSR = Data Set Ready). If the
> > > > > >   line state is detected, the LED is switched on.
> > > > > >   If set to 0 (default), the LED will not evaluate DSR.
> > > > > >   If set to 1, the LED will evaluate DSR.
> > > > > >
> > > > > > - dcd:
> > > > > >   DTE is receiving a carrier from the DCE (DCD = Data Carrier Detect).
> > > > > >   If the line state is detected, the LED is switched on.
> > > > > >   If set to 0 (default), the LED will not evaluate DCD.
> > > > > >   If set to 1, the LED will evaluate DCD.
> > > > > >
> > > > > > - rng:
> > > > > >   DCE has detected an incoming ring signal on the telephone line
> > > > > >   (RNG = Ring Indicator). If the line state is detected, the LED is
> > > > > >   switched on.
> > > > > >   If set to 0 (default), the LED will not evaluate RNG.
> > > > > >   If set to 1, the LED will evaluate RNG.
> > > > > >
> > > > > > Also add an invert flag on LED blink, so that the LED blinks in the
> > > > > > correct order.
> > > > > >
> > > > > > * If one off the new enabled input signals are evaluatet as 'enabled',
> > > > > >   and data are transmitted, then the LED should first blink 'off' and
> > > > > >   then 'on' (invert).
> > > > > > * If all the new enabled input signals are evaluatet as 'disabled',
> > > > > >   and data are transmitted, then the LED should first blink 'on' and
> > > > > >   then 'off'.
> > > > > >
> > > > > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > > > > ---
> > > > > >  .../ABI/testing/sysfs-class-led-trigger-tty   | 40 ++++++++++
> > > > > >  drivers/leds/trigger/ledtrig-tty.c            | 77 ++++++++++++++++++-
> > > > > >  2 files changed, 116 insertions(+), 1 deletion(-)
> > > >
> > > > [...]
> > > >
> > > > > Reviewed-by: Maarten Brock <m.brock@vanmierlo.com>
> > > >
> > > > Please snip your replies.
> > > 
> > > Is there anything I can do? Or do I have to do something? Please
> > > give me
> > > more detailed instructions
> > 
> > That instruction wasn't for you.
> > 
> > This patch is still on my INCOMING list.
> > 
> > Do you have Greg's blessing yet?
> 
> The summary of my v8:
> 
> The changes for the tty layer on v5 in 'drivers/tty/tty_io.c' got an
> 'Acked-by: Greg Kroah-Hartman' [1].
> I have always added his 'Acked-by' to the following patch series.
> And I did not made changes to this. So I think I have his blessing
> for this changes in his maintained tty layer.
> 
> The Memory leak patch I send during v7 [2] got a comment
> from Greg, that I have to send this also to 'linux-kernel@vger-kernel.org'
> So this should go into the stable branch [3]. This got an
> 'Reviewed-by: Uwe Kleine-König' [4]. I add this to v8 [5].
> So far I don't know if this has already been merged into
> the master and then backported into the stable branches?.
> 
> For the changes in the ledtrig-tty driver I am still waiting for an
> complete 'ACK' or 'NOK' whether I should change something.
> I have added all of Greg's requested changes in v5 [6]:
> * split this series
> * Add the requested change
> * Switch the driver to use completion for 'sysfs'
> 
> As I understand it, he handed over the review to the LED subsystem team [7].
> 
> I then added a few more changes that came from Maarten in v7 [8].
> I got his 'Reviewed-by: Maarten Brock' for v8 on patch 6/6.
> 
> The patches 4/6 and 5/6 of the v8 still waiting for review?

Thanks for the update Florian.

Sounds like you're waiting on me and/or Pavel.

You're in the pile.  I'll get around to you shortly.

> [1]
> https://lore.kernel.org/linux-leds/2023102327-rename-kosher-bf03@gregkh/#t
> [2]
> https://lore.kernel.org/linux-leds/2023110629-scenic-rounding-905f@gregkh/
> [3]
> https://lore.kernel.org/linux-leds/20231106141205.3376954-1-fe@dev.tdt.de/
> [4] https://lore.kernel.org/linux-leds/20231106144914.bflq2jxejdxs6zjb@pengutronix.de/
> [5] https://lore.kernel.org/linux-leds/20231109085038.371977-1-fe@dev.tdt.de/T/#m1f0c4680749812f1a933667128f73995efe66bca
> [6]
> https://lore.kernel.org/linux-leds/2023102341-jogger-matching-dded@gregkh/
> [7]
> https://lore.kernel.org/linux-leds/2023102333-skewer-reclining-8d04@gregkh/
> [8] https://lore.kernel.org/linux-leds/bc94f31e965be6f640c286f8c8a2cf38@vanmierlo.com/
> [9] https://lore.kernel.org/linux-leds/39e7c892299c74821b1105a0967063ca@vanmierlo.com/

-- 
Lee Jones [李琼斯]
