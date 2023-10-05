Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD57BA5C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbjJEQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjJEQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34251FEE0;
        Thu,  5 Oct 2023 07:48:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED7C32796;
        Thu,  5 Oct 2023 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696508281;
        bh=aotJxKAUr5fNyYcGF3ZP9uIlZ7mocu6gSY2nlgBj31E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJeXqnVUw1BmYx8upkqSRycudLWPKn1wQrNad8ETIduOkhWs8cB6z8l8OM2YONcWq
         JLfH7bQ3zhGXFKeofSHLIvzYLLVYOeJzqPuYtcT4pZNGvXeO+ITk1/HtxptNWiMRPF
         L96l6zKccQJX/nYmCknRh6rnoC00XtEjB4+enCDnb7aNbGHjq07j8lz+4rOJKpPDf2
         Ol4v6eatnS6Y0aRNTHFemG6TL/N8NOZCf2g45G0lspraqtBgxVcOzLNIf0d5kgHIFg
         r5JEPTYfI2QzVvLlRcT4mqiI0rJuCM+Txnb3EVOjXQSRIl08YlU/zt4ai427LtgaDc
         CEYCF6UOai2wQ==
Date:   Thu, 5 Oct 2023 13:17:56 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Starke, Daniel" <daniel.starke@siemens.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <20231005121756.GB681678@google.com>
References: <2023100448-cotton-safehouse-aca2@gregkh>
 <20231004125704.GA83257@google.com>
 <2023100435-xerox-idiocy-5cf0@gregkh>
 <20231005090311.GD83257@google.com>
 <2023100528-directory-arrogant-2ca9@gregkh>
 <20231005104311.GG83257@google.com>
 <2023100512-charger-cherisher-9a3d@gregkh>
 <DB9PR10MB5881E8D3903C19EBAD9AF895E0CAA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <20231005114632.GA681678@google.com>
 <2023100507-worst-quarrel-2b97@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100507-worst-quarrel-2b97@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, Greg Kroah-Hartman wrote:

> On Thu, Oct 05, 2023 at 12:46:32PM +0100, Lee Jones wrote:
> > On Thu, 05 Oct 2023, Starke, Daniel wrote:
> > 
> > > > > Would something like this tick that box?
> > > > > 
> > > > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c index 
> > > > > 1f3aba607cd51..5c1d2fcd5d9e2 100644
> > > > > --- a/drivers/tty/n_gsm.c
> > > > > +++ b/drivers/tty/n_gsm.c
> > > > > @@ -3716,6 +3716,10 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
> > > > >         if (!gsm)
> > > > >                 return -ENODEV;
> > > > >  
> > > > > +       /* The GSM line discipline does not support binding to console */
> > > > > +       if (strncmp(tty->name, "tty", 3))
> > > > > +               return -EINVAL;
> > > > 
> > > > No, that's not going to work, some consoles do not start with "tty" :(
> > 
> > Ah, you mean there are others that we need to consider?
> > 
> > I was just covering off con_write() from drivers/tty/vt/vt.c.
> > 
> > Does anyone have a counter proposal?
> 
> consoles are dynamically assigned, the device knows if it is a console
> or not, so there is a way to determine this at runtime.  It's not a
> device naming thing at all.

It's not a device naming thing, but it is a ... :)

Okay, here's another uninformed stab in the dark:

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1f3aba607cd51..ddf00f6a4141d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3629,6 +3629,10 @@ static int gsmld_open(struct tty_struct *tty)
        if (tty->ops->write == NULL)
                return -EINVAL;

+       /* The GSM line discipline does not support binding to console */
+       if (tty->driver->type == TTY_DRIVER_TYPE_CONSOLE)
+               return -EINVAL;
+
        /* Attach our ldisc data */
        gsm = gsm_alloc_mux();
        if (gsm == NULL)

This seems to allow for the real serial devices (TTY_DRIVER_TYPE_SERIAL)
suggested by Daniel.

-- 
Lee Jones [李琼斯]
