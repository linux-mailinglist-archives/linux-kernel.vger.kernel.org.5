Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F5784987
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHVSqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHVSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B610B;
        Tue, 22 Aug 2023 11:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E4463F56;
        Tue, 22 Aug 2023 18:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC552C433C8;
        Tue, 22 Aug 2023 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692729969;
        bh=gcxI4uPRYqFNvEIHxSDvAhCX1x97ZeXzfeii3ZUp8VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6/8TVkRuTgfk7aBdMDkCFirnjQKmn6VXFyAGv1F6sD+PcdoeUG/RqfZCPz8csJGT
         O5HHhRmB+BIjWRugC2x+PLFQSbqDjj26bseCBPuKP+PKZVXXl8oN2g05G2ZLi4Afv9
         NnqexUA8S1CFDFD3PYmjWTLaLXS/3wefxZXHLM48=
Date:   Tue, 22 Aug 2023 20:46:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Grant Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: musb: dsps: Fix vbus vs tps65217-charger irq
 conflict
Message-ID: <2023082228-usable-strike-7f73@gregkh>
References: <20230822132202.19659-1-nemith592@gmail.com>
 <2023082256-judiciary-udder-6d06@gregkh>
 <CAMg76N62CQq=VJ7jXHN4UnAv0NKo89VYnEJmVMXGPLzg8nvyag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMg76N62CQq=VJ7jXHN4UnAv0NKo89VYnEJmVMXGPLzg8nvyag@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 08:20:56PM +0200, Grant Adams wrote:
> On Tue, Aug 22, 2023 at 4:42 PM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Aug 22, 2023 at 03:22:02PM +0200, Grant B Adams wrote:
> > > Enabling the tps65217-charger driver/module causes an interrupt conflict
> > > with the vbus driver resulting in a probe failure.
> > > The conflict is resolved by changing both driver's threaded interrupt
> > > request function from IRQF_ONESHOT to IRQF_SHARED.
> > >
> > > Signed-off-by: Grant B Adams <nemith592@gmail.com>
> > > ---
> > >  drivers/usb/musb/musb_dsps.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> > > index 9119b1d51370..cbb45de5a76f 100644
> > > --- a/drivers/usb/musb/musb_dsps.c
> > > +++ b/drivers/usb/musb/musb_dsps.c
> > > @@ -851,7 +851,7 @@ static int dsps_setup_optional_vbus_irq(struct
> > platform_device *pdev,
> > >
> > >       error = devm_request_threaded_irq(glue->dev, glue->vbus_irq,
> > >                                         NULL, dsps_vbus_threaded_irq,
> > > -                                       IRQF_ONESHOT,
> > > +                                       IRQF_SHARED,
> > >                                         "vbus", glue);
> > >       if (error) {
> > >               glue->vbus_irq = 0;
> > > --
> > > 2.34.1
> > >
> >
> > Why is the patch here talking about the tps65217-charger driver?  That's
> > totally independent.
> >
> > Also, your patches are not threaded, how did you send them?  Are they
> > related in some way or not?
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Apologies Greg,
> 
> This is my first patch and did not know about creating email threads for
> multiple patches. I'll create an email thread for the patches and will
> provide
> an overview and better context in [PATCH 0/2].

That would be great, be sure to number this a v2 patch series as the
documentation asks for as well :)

good luck!

greg k-h
