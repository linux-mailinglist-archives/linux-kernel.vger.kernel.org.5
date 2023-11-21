Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C087F3241
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKUPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjKUPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:23:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC81DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:23:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F0BC433C8;
        Tue, 21 Nov 2023 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700580222;
        bh=fFJ7ZJrRFt5fAgZndYTrEnrlMNAWYHpdqnI+TcUaVK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMEbXrc1JJ1TccZBV6p7x82//pScEYR0JK366Ug6MKYZWxxjEhS73HuPd77Rj+Whp
         cE6VtgpJ/zcMxEltGH7AbrpOg72d/44GYUt4o7NWrtbva825FbE39VkFdJs7ZwWn/H
         G76EYPHgRyjCDllwL7glRh1VtgVZMzXfls+wlRm/r8D7k9+zI647IrIsjArjOzk+PR
         CbGKyD9ctfhbbVX67jenib/bHHV1Hhd3V70hWyj14IX1EOQUf40dFrl3DF1SEok6tM
         o0nQVAEdRZNZcS924rZhkWWM1kvM/mE7GoUW9xOBKYf4kWLt6gKYdLYeIRh6bQMOqr
         dMsk4dTOG+N8w==
Date:   Tue, 21 Nov 2023 15:23:36 +0000
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     m.brock@vanmierlo.com, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [Patch v8 6/6] leds: ledtrig-tty: add additional line state
 evaluation
Message-ID: <20231121152336.GC173820@google.com>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-7-fe@dev.tdt.de>
 <39e7c892299c74821b1105a0967063ca@vanmierlo.com>
 <20231117121253.GB137434@google.com>
 <bc369f8759778c2c3b8be3a5d755064a@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc369f8759778c2c3b8be3a5d755064a@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023, Florian Eckert wrote:

> 
> 
> On 2023-11-17 13:12, Lee Jones wrote:
> > On Thu, 09 Nov 2023, m.brock@vanmierlo.com wrote:
> > 
> > > Florian Eckert schreef op 2023-11-09 09:50:
> > > > The serial tty interface also supports additional input signals, that
> > > > can also be evaluated within this trigger. This change is adding the
> > > > following additional input sources, which could be controlled
> > > > via the '/sys/class/<leds>/' sysfs interface.
> > > >
> > > > Explanation:
> > > > DCE = Data Communication Equipment (Modem)
> > > > DTE = Data Terminal Equipment (Computer)
> > > >
> > > > - cts:
> > > >   DCE is ready to accept data from the DTE (CTS = Clear To Send). If
> > > >   the line state is detected, the LED is switched on.
> > > >   If set to 0 (default), the LED will not evaluate CTS.
> > > >   If set to 1, the LED will evaluate CTS.
> > > >
> > > > - dsr:
> > > >   DCE is ready to receive and send data (DSR = Data Set Ready). If the
> > > >   line state is detected, the LED is switched on.
> > > >   If set to 0 (default), the LED will not evaluate DSR.
> > > >   If set to 1, the LED will evaluate DSR.
> > > >
> > > > - dcd:
> > > >   DTE is receiving a carrier from the DCE (DCD = Data Carrier Detect).
> > > >   If the line state is detected, the LED is switched on.
> > > >   If set to 0 (default), the LED will not evaluate DCD.
> > > >   If set to 1, the LED will evaluate DCD.
> > > >
> > > > - rng:
> > > >   DCE has detected an incoming ring signal on the telephone line
> > > >   (RNG = Ring Indicator). If the line state is detected, the LED is
> > > >   switched on.
> > > >   If set to 0 (default), the LED will not evaluate RNG.
> > > >   If set to 1, the LED will evaluate RNG.
> > > >
> > > > Also add an invert flag on LED blink, so that the LED blinks in the
> > > > correct order.
> > > >
> > > > * If one off the new enabled input signals are evaluatet as 'enabled',
> > > >   and data are transmitted, then the LED should first blink 'off' and
> > > >   then 'on' (invert).
> > > > * If all the new enabled input signals are evaluatet as 'disabled',
> > > >   and data are transmitted, then the LED should first blink 'on' and
> > > >   then 'off'.
> > > >
> > > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > > ---
> > > >  .../ABI/testing/sysfs-class-led-trigger-tty   | 40 ++++++++++
> > > >  drivers/leds/trigger/ledtrig-tty.c            | 77 ++++++++++++++++++-
> > > >  2 files changed, 116 insertions(+), 1 deletion(-)
> > 
> > [...]
> > 
> > > Reviewed-by: Maarten Brock <m.brock@vanmierlo.com>
> > 
> > Please snip your replies.
> 
> Is there anything I can do? Or do I have to do something? Please give me
> more detailed instructions

That instruction wasn't for you.

This patch is still on my INCOMING list.

Do you have Greg's blessing yet?

-- 
Lee Jones [李琼斯]
