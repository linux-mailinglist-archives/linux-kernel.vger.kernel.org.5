Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4347F8939
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKYI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjKYI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996E4D41
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:28:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AB4C433C8;
        Sat, 25 Nov 2023 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700900925;
        bh=Ttd2JPImbaXNmJFp7qDlKcqm2O5oVQSU4Y49sjSoDBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0PMKZlnJ0LjUF/WkotChtMS9ENEkoogCTXi80f3DWkWsXfurS0ZoGk2/laLRrCipP
         t3lnasxfSuNOifKsLs2pelA7v409D/3AkwvDNz4AyxU3aDKxui11JxIsWElsg5jUKC
         u2IG4oE3H+GmQwtwMe34Sr5JpgG7Mh/GJiGvFBVY=
Date:   Sat, 25 Nov 2023 08:28:42 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH V3] media: stk1160: Fixed high volume of stk1160_dbg
 messages
Message-ID: <2023112508-clothing-twirl-fe40@gregkh>
References: <20231125073738.649948-1-ghanshyam1898@gmail.com>
 <2023112554-bagginess-banker-089e@gregkh>
 <CAG-BmocpXo5GY7KSh-nnw7Z6ExkMGKxetoeSdbyNjrqFCGJLQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG-BmocpXo5GY7KSh-nnw7Z6ExkMGKxetoeSdbyNjrqFCGJLQA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:51:35PM +0530, Ghanshyam Agrawal wrote:
> On Sat, Nov 25, 2023 at 1:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 25, 2023 at 01:07:38PM +0530, Ghanshyam Agrawal wrote:
> > > The function stk1160_dbg gets called too many times, which causes
> > > the output to get flooded with messages. Since stk1160_dbg uses
> > > printk, it is now replaced with printk_ratelimited directly.
> > >
> > > Suggested-by: Phillip Potter <phil@philpotter.co.uk>
> > > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > > ---
> > > V3:
> > > Fixed the issue with my patch needing previous versions being applied
> > > first.
> > >
> > > Used printk_ratelimited instead of dev_warn_ratelimited because
> > > of compiler error "incompatible pointer type".
> > >
> > > V2:
> > > To add KERN_WARNING in printk_ratelimited, and later as per warning by
> > > the checkpatch script, replaced  printk_ratelimited with
> > > dev_warn_ratelimited.
> > >
> > > V1:
> > > The function stk1160_dbg gets called too many times, which causes
> > > the output to get flooded with messages. Since stk1160_dbg uses
> > > printk, it is now replaced with dev_warn_ratelimited.
> > >
> > >  drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> > > index 4e966f6bf608..98417fa31d70 100644
> > > --- a/drivers/media/usb/stk1160/stk1160-video.c
> > > +++ b/drivers/media/usb/stk1160/stk1160-video.c
> > > @@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
> > >
> > >       /*
> > >        * TODO: These stk1160_dbg are very spammy!
> > > -      * We should 1) check why we are getting them
> > > -      * and 2) add ratelimit.
> > > +      * We should check why we are getting them.
> > >        *
> > >        * UPDATE: One of the reasons (the only one?) for getting these
> > >        * is incorrect standard (mismatch between expected and configured).
> > > @@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
> > >
> > >       /* Let the bug hunt begin! sanity checks! */
> > >       if (lencopy < 0) {
> > > -             stk1160_dbg("copy skipped: negative lencopy\n");
> > > +             printk_ratelimited(KERN_WARNING "copy skipped: negative lencopy\n");
> >
> > You changed a debug message level to a KERN_WARNING level?  That feels
> > like a step backwards.
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for your response. The log level should indeed be DEBUG
> as it was earlier.
> 
> I only wanted to add a rate limit there because it was printing too
> many log messages as mentioned in the todo. Shall I update the
> log level  to DEBUG and resend the patch? Thank you very much
> again.

If it's spamming the logs, why print anything at all as obviously
everyone is ignoring it?  But I do not really know, the final decision
should be up to the developer and maintainer of this subsystem.

thanks,

greg k-h
