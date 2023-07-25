Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA3762479
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGYVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGYVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:30:49 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2248B1FEF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:26 -0700 (PDT)
Received: (qmail 1901038 invoked by uid 1000); 25 Jul 2023 17:30:26 -0400
Date:   Tue, 25 Jul 2023 17:30:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
Message-ID: <248d9759-aef7-45ce-b0a4-6c1cafee76c9@rowland.harvard.edu>
References: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
 <0000000000007fc04d06011e274f@google.com>
 <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
 <CACGdZYL_dPFp-yHWHGC3vxyv4R4dYtSJe5GPcN0NjG2qaz+xmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGdZYL_dPFp-yHWHGC3vxyv4R4dYtSJe5GPcN0NjG2qaz+xmg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:42:01PM -0700, Khazhy Kumykov wrote:
> On Tue, Jul 25, 2023 at 12:26 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > @@ -2671,12 +2671,17 @@ int usb_authorize_device(struct usb_devi
> >         }
> >
> >         if (usb_dev->wusb) {
> > -               result = usb_get_device_descriptor(usb_dev, sizeof(usb_dev->descriptor));
> > -               if (result < 0) {
> > +               struct usb_device_descriptor *descr;
> > +
> > +               descr = usb_get_device_descriptor(usb_dev);
> > +               if (IS_ERR(descr)) {
> > +                       result = PTR_ERR(descr);
> >                         dev_err(&usb_dev->dev, "can't re-read device descriptor for "
> >                                 "authorization: %d\n", result);
> >                         goto error_device_descriptor;
> >                 }
> > +               usb_dev->descriptor = *descr;
> Hmm, in your first patch you rejected diffs to the descriptor here,
> which might be necessary - since we don't re-initialize the device so
> can get a similar issue if the bad usb device decides to change
> bNumConfigurations to cause a buffer overrun. (This also stuck out to
> me as an exception to the "descriptors should be immutable" comment
> later in the patch.

I removed that part of the previous patch because there's no point to 
it.  None of this code ever gets executed; the usb_dev->wusb test can 
never succeed because the kernel doesn't support wireless USB any more.  
(I asked Greg KH about that in a separate email thread: 
<https://lore.kernel.org/linux-usb/2a21cefa-99a7-497c-901f-3ea097361a80@rowland.harvard.edu/#r>.)

A later patch will remove all of the wireless USB stuff.  The only real 
reason for leaving this much of the code there now is to prevent 
compilation errors and keep the form looking right.

> > @@ -6018,7 +6064,7 @@ static int usb_reset_and_verify_device(s
> >                 /* ep0 maxpacket size may change; let the HCD know about it.
> >                  * Other endpoints will be handled by re-enumeration. */
> >                 usb_ep0_reinit(udev);
> > -               ret = hub_port_init(parent_hub, udev, port1, i);
> > +               ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
> Looks like this is the only caller that passes &descriptor, and it
> just checks that it didn't change. Would it make sense to put the
> enitre descriptors_changed stanza in hub_port_init, for the re-init
> case?

The descriptors_changed check has to be _somewhere_, either here or 
there.  I don't see what difference it makes whether the check is done 
in this routine or in hub_port_init.  Since it doesn't matter, why 
change the existing code?

Alan Stern
