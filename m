Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D57F8BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjKYOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjKYOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:35:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B9ED7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:35:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F66C433C7;
        Sat, 25 Nov 2023 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700922945;
        bh=hb/vmc7tcmttzFGRfTFzeR0zkwiIlk2FgNpJkaTKNOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHdseylWp7Owy3GnfubHDSnudn6G4b9KR/0sS58VAlsnhnPzcdprc2hvc2VM4cn4/
         toOb7b8rM2VIax7W9Smxw9CEPfcXRuMYbXrZmNUjHTaHdcOGnhLtDGXABJvGCgoFD1
         47qgVxvHvoJOa/rkWI8ZSt1yVOiqaExVo59l+A0A=
Date:   Sat, 25 Nov 2023 14:35:41 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112541-uptown-tripping-05f3@gregkh>
References: <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 10:30:42AM +0000, Mark Brown wrote:
> On Sat, Nov 25, 2023 at 09:09:01AM +0000, Greg Kroah-Hartman wrote:
> > On Sat, Nov 25, 2023 at 09:50:38AM +0100, Oleksij Rempel wrote:
> 
> > > It prevents HW damage. In a typical automotive under-voltage labor it is
> > > usually possible to reproduce X amount of bricked eMMCs or NANDs on Y
> > > amount of under-voltage cycles (I do not have exact numbers right now).
> > > Even if the numbers not so high in the labor tests (sometimes something
> > > like one bricked device in a month of tests), the field returns are
> > > significant enough to care about software solution for this problem.
> 
> > So hardware is attempting to rely on software in order to prevent the
> > destruction of that same hardware?  Surely hardware designers aren't
> > that crazy, right?  (rhetorical question, I know...)
> 
> Surely software people aren't going to make no effort to integrate with
> the notification features that the hardware engineers have so helpfully
> provided us with?

That would be great, but I don't see that here, do you?  All I see is
the shutdown sequence changing because someone wants it to go "faster"
with the threat of hardware breaking if we don't meet that "faster"
number, yet no knowledge or guarantee that this number can ever be known
or happen.

> > > Same problem was seen not only in automotive devices, but also in
> > > industrial or agricultural. With other words, it is important enough to bring
> > > some kind of solution mainline.
> 
> > But you are not providing a real solution here, only a "I am going to
> > attempt to shut down a specific type of device before the others, there
> > are no time or ordering guarantees here, so good luck!" solution.
> 
> I'm not sure there are great solutions here, the system integrators are
> constrained by the what the application appropriate silicon that's on
> the market is capable of, the siicon is constrained by the area costs of
> dealing with corner cases for system robustness and how much of the
> market cares about fixing these issues and software is constrained by
> what hardware ends up being built.  Everyone's just got to try their
> best with the reality they're confronted with, hopefully what's possible
> will improve with time.

Agreed, but I don't think this patch is going to actually work properly
over time as there is no time values involved :)

> > And again, how are you going to prevent the in-fighting of all device
> > types to be "first" in the list?
> 
> It doesn't seem like the most complex integration challenge we've ever
> had to deal with TBH.

True, but we all know how this grows and thinking about how to handle it
now is key for this to be acceptable.

thanks,

greg k-h
