Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7A75BE34
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGUGE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGUGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0022421A;
        Thu, 20 Jul 2023 23:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD54361059;
        Fri, 21 Jul 2023 06:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD97FC433C8;
        Fri, 21 Jul 2023 06:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919398;
        bh=jcNRhYDzGq5E9PufSY/Q51Vnb8yuVi3TZzsSH+XDEuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXB87UVGtmA548xIkXiNLXwytR4o3WTgxVNxscOwsnaBu51UkpLtAlfP3rawmkLzS
         quY0k2JwtMCh4IKm142kjrg8nWKyvCQcmFCPwoYGY88Yml5h8xdItyJi8IPRKwkQbw
         LO0o8a1J89p2vJHywLZrh5aq3HnZtUVKiDDs1uWc=
Date:   Fri, 21 Jul 2023 08:03:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: Fix the memory leak in raw_gadget driver
Message-ID: <2023072132-imperfect-bagel-64e1@gregkh>
References: <20230714074011.20989-1-qiang.zhang1211@gmail.com>
 <CA+fCnZfxLLLVJdPZmVKg5w4YY+i09ZRz-wu+TAXBaroRgGsAsQ@mail.gmail.com>
 <CALm+0cX5bsjP-yrCywz_Pmwr+2y5VwuSj3fBNdnZD0JLrS+AdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cX5bsjP-yrCywz_Pmwr+2y5VwuSj3fBNdnZD0JLrS+AdQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:56:35PM +0800, Z qiang wrote:
> >
> > On Fri, Jul 14, 2023 at 9:40 AM Zqiang <qiang.zhang1211@gmail.com> wrote:
> > >
> > > Currently, increasing raw_dev->count happens before invoke the
> > > raw_queue_event(), if the raw_queue_event() return error, invoke
> > > raw_release() will not trigger the dev_free() to be called.
> > >
> > > [  268.905865][ T5067] raw-gadget.0 gadget.0: failed to queue event
> > > [  268.912053][ T5067] udc dummy_udc.0: failed to start USB Raw Gadget: -12
> > > [  268.918885][ T5067] raw-gadget.0: probe of gadget.0 failed with error -12
> > > [  268.925956][ T5067] UDC core: USB Raw Gadget: couldn't find an available UDC or it's busy
> > > [  268.934657][ T5067] misc raw-gadget: fail, usb_gadget_register_driver returned -16
> > >
> > > BUG: memory leak
> > >
> > > [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > > [<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
> > > [<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
> > > [<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c:191 [inline]
> > > [<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/raw_gadget.c:385
> > > [<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165
> > >
> > > [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > > [<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
> > > [<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/legacy/raw_gadget.c:460
> > > [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1250
> > > [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >
> > > [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > > [<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
> > > [<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
> > > [<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadget/udc/dummy_hcd.c:665
> > > [<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gadget/udc/core.c:196
> > > [<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/legacy/raw_gadget.c:292
> > >
> > > This commit therefore invoke kref_get() under the condition that
> > > raw_queue_event() return success.
> > >
> > > Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=feb045d335c1fdde5bf7
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  drivers/usb/gadget/legacy/raw_gadget.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > > index 2acece16b890..e549022642e5 100644
> > > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > > @@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
> > >         dev->eps_num = i;
> > >         spin_unlock_irqrestore(&dev->lock, flags);
> > >
> > > -       /* Matches kref_put() in gadget_unbind(). */
> > > -       kref_get(&dev->count);
> > > -
> > >         ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
> > > -       if (ret < 0)
> > > +       if (ret < 0) {
> > >                 dev_err(&gadget->dev, "failed to queue event\n");
> > > +               set_gadget_data(gadget, NULL);
> > > +               return ret;
> > > +       }
> > >
> > > +       /* Matches kref_put() in gadget_unbind(). */
> > > +       kref_get(&dev->count);
> > >         return ret;
> > >  }
> > >
> > > --
> > > 2.17.1
> >
> > Indeed, if gadget_bind fails due to a raw_queue_event failure, the
> > core gadget code will never call gadget_unbind.
> >
> > Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
> >
> 
> Hi Greg
> 
> Friendly ping :)

$ mdfrm -c ~/mail/todo/
1685 messages in /home/gregkh/mail/todo/

For various reasons I am way behind in getting to review public patches
like these, sorry.  Give me a chance to catch up, should be through them
all by the end of next week.

In the meantime, to help reduce my load, you can always help review
other patches that have been sent to the list for review.

thanks,

greg k-h
