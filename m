Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F607F9B42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjK0IEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0IEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:04:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332E113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:04:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C79EC433C7;
        Mon, 27 Nov 2023 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701072281;
        bh=jUFAJfcO1rkDyvEedV912gAmDtbtx04dTRR8mU+ZnnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmGsaP1of68Nju7apNbsHuuq3dGvvOU1koV4BM36yns8dZky3R9I/9HGwOZUg1xYA
         oHWTl4EZgcU0olds/EOakFKeRciLBk7Cjtckx3pg1BI+Yy+ZJTg8jyP+3ePRqiVKJw
         dFCfbSIYpnM3bx21h3d2Fdzve/6Zbts3qZTaRh1hfTpvkKOIKW8Cy7+oyWat+12tjU
         7BroTkZXXzHPgjEyxm+cyezApG3Ku1GQUubnez2yUmT6u+27JXWZtRmtmwCLAEDTwe
         q8NUIu2KQf7JV4wqlpZqoukt7M0WpGCiWjDl5zHKCClVIPqVm5jo/D0AdakiV+HLT9
         Mvg2CAibAVmmQ==
Date:   Mon, 27 Nov 2023 08:04:36 +0000
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [Patch v8 2/6] leds: ledtrig-tty: free allocated ttyname buffer
 on deactivate
Message-ID: <20231127080436.GA1470173@google.com>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <20231109085038.371977-3-fe@dev.tdt.de>
 <2023112356-amount-undertook-cdb2@gregkh>
 <71eeb0fad7c6d2c4a407df34facee232@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71eeb0fad7c6d2c4a407df34facee232@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023, Florian Eckert wrote:

> 
> 
> On 2023-11-23 15:06, Greg KH wrote:
> > On Thu, Nov 09, 2023 at 09:50:34AM +0100, Florian Eckert wrote:
> > > The ttyname buffer for the ledtrig_tty_data struct is allocated in the
> > > sysfs ttyname_store() function. This buffer must be released on
> > > trigger
> > > deactivation. This was missing and is thus a memory leak.
> > > 
> > > While we are at it, the tty handler in the ledtrig_tty_data struct
> > > should
> > > also be returned in case of the trigger deactivation call.
> > > 
> > > Fixes: fd4a641ac88f ("leds: trigger: implement a tty trigger")
> > > Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > ---
> > >  drivers/leds/trigger/ledtrig-tty.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/leds/trigger/ledtrig-tty.c
> > > b/drivers/leds/trigger/ledtrig-tty.c
> > > index 8ae0d2d284af..3e69a7bde928 100644
> > > --- a/drivers/leds/trigger/ledtrig-tty.c
> > > +++ b/drivers/leds/trigger/ledtrig-tty.c
> > > @@ -168,6 +168,10 @@ static void ledtrig_tty_deactivate(struct
> > > led_classdev *led_cdev)
> > > 
> > >  	cancel_delayed_work_sync(&trigger_data->dwork);
> > > 
> > > +	kfree(trigger_data->ttyname);
> > > +	tty_kref_put(trigger_data->tty);
> > > +	trigger_data->tty = NULL;
> > > +
> > 
> > This should be a stand-alone patch with a proper cc: stable tag added as
> > well so that it can be accepted now, as it is independent of this new
> > feature you are adding.
> 
> I already send this to stable@vger.kernel.org [1].
> The patch already got an 'Reviewed-by:' from Uwe [2].

But then you posted this submission which superseded it in my inbox.

Only the latest patch will be processed when this happens.

> I hope I did everything right and it only slipped through?
> 
> I will omit the patch from the v9 patchset of 'ledtrig-tty'.
> This patch set will come later today with your requested changes.
> 
> Links;
> [1] https://lore.kernel.org/stable/20231106141205.3376954-1-fe@dev.tdt.de/
> [2] https://lore.kernel.org/stable/20231106144914.bflq2jxejdxs6zjb@pengutronix.de/
> 
> Best regards
> 
> Florian

-- 
Lee Jones [李琼斯]
