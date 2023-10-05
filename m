Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5527BA09E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbjJEOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjJEOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E240FA7;
        Thu,  5 Oct 2023 06:59:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39EEC3279B;
        Thu,  5 Oct 2023 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696509461;
        bh=yPssmHk+h0I732PLM72/lK/bohTqVJvSoMLO4hpb3D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0wxIPavtBAUyeJXufOCmBYrGsalBt0X+Y/fZ+1f7IbmQtmxkzMsmJbQAqTKWiU3P9
         awgP8FnfwpkOZvIUnLAjHJS3EYKj6L83fSwtnRA2Bp/g3xRN8TlfGg+k8wjSIzqa9c
         3NQ/IXPowUMQ4UWRhCIA1yWbvAPUawd1Ro6Ck9cQ=
Date:   Thu, 5 Oct 2023 14:37:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     "Starke, Daniel" <daniel.starke@siemens.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <2023100524-obituary-scoundrel-971d@gregkh>
References: <20231004125704.GA83257@google.com>
 <2023100435-xerox-idiocy-5cf0@gregkh>
 <20231005090311.GD83257@google.com>
 <2023100528-directory-arrogant-2ca9@gregkh>
 <20231005104311.GG83257@google.com>
 <2023100512-charger-cherisher-9a3d@gregkh>
 <DB9PR10MB5881E8D3903C19EBAD9AF895E0CAA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <20231005114632.GA681678@google.com>
 <2023100507-worst-quarrel-2b97@gregkh>
 <20231005121756.GB681678@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005121756.GB681678@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:17:56PM +0100, Lee Jones wrote:
> On Thu, 05 Oct 2023, Greg Kroah-Hartman wrote:
> 
> > On Thu, Oct 05, 2023 at 12:46:32PM +0100, Lee Jones wrote:
> > > On Thu, 05 Oct 2023, Starke, Daniel wrote:
> > > 
> > > > > > Would something like this tick that box?
> > > > > > 
> > > > > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c index 
> > > > > > 1f3aba607cd51..5c1d2fcd5d9e2 100644
> > > > > > --- a/drivers/tty/n_gsm.c
> > > > > > +++ b/drivers/tty/n_gsm.c
> > > > > > @@ -3716,6 +3716,10 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
> > > > > >         if (!gsm)
> > > > > >                 return -ENODEV;
> > > > > >  
> > > > > > +       /* The GSM line discipline does not support binding to console */
> > > > > > +       if (strncmp(tty->name, "tty", 3))
> > > > > > +               return -EINVAL;
> > > > > 
> > > > > No, that's not going to work, some consoles do not start with "tty" :(
> > > 
> > > Ah, you mean there are others that we need to consider?
> > > 
> > > I was just covering off con_write() from drivers/tty/vt/vt.c.
> > > 
> > > Does anyone have a counter proposal?
> > 
> > consoles are dynamically assigned, the device knows if it is a console
> > or not, so there is a way to determine this at runtime.  It's not a
> > device naming thing at all.
> 
> It's not a device naming thing, but it is a ... :)
> 
> Okay, here's another uninformed stab in the dark:
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 1f3aba607cd51..ddf00f6a4141d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3629,6 +3629,10 @@ static int gsmld_open(struct tty_struct *tty)
>         if (tty->ops->write == NULL)
>                 return -EINVAL;
> 
> +       /* The GSM line discipline does not support binding to console */
> +       if (tty->driver->type == TTY_DRIVER_TYPE_CONSOLE)
> +               return -EINVAL;
> +
>         /* Attach our ldisc data */
>         gsm = gsm_alloc_mux();
>         if (gsm == NULL)
> 
> This seems to allow for the real serial devices (TTY_DRIVER_TYPE_SERIAL)
> suggested by Daniel.

Close, but not quite.

Driver "types" can say if they are a console or not, but that doesn't
mean you can't run the console over a serial port as well, right?

Sorry, I don't have a real solution right now, and wouldn't wish the
phrase "just dig through the tty console code!" on anyone, but that's
what it is going to take to figure it out somehow, I can't remember the
exact way consoles are hooked up at the moment (I conviently skipped
that portion of the tty layer in my Embedded Recipies talk last week,
saying "it's magic...")

thanks,

greg k-h
