Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279BE7629AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGZEBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGZEAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94C2695;
        Tue, 25 Jul 2023 21:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24EA0611C5;
        Wed, 26 Jul 2023 04:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32012C433C7;
        Wed, 26 Jul 2023 04:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690344042;
        bh=nJyQNPWmwhk6sKMUVQGcLNtqflIMJz6GUInerB3U6N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ymSWm1UbOP/FMZ0v3tQmAldKICJ+tgmsE9EE7Jlwc893uBtrPwblBLUPPSk3LoFbe
         4Hy0SmiV2ewFitkVmrx5ymvx/Q/6FnSww0oRGDWbDtDx2/b4nZQo4HSrvIw0uZXnWq
         jDIo5LeaJkM9Wz+Yv6c/aJXrqhBaF7mslTO/LUhM=
Date:   Wed, 26 Jul 2023 06:00:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
Message-ID: <2023072648-exclaim-crisply-9d8a@gregkh>
References: <e5a6c3be-6dd3-4c85-9c5b-f9fb7aca0b36@rowland.harvard.edu>
 <0000000000007fc04d06011e274f@google.com>
 <c9bb72e0-8e02-4568-bd43-6897f9c94d12@rowland.harvard.edu>
 <CACGdZYL_dPFp-yHWHGC3vxyv4R4dYtSJe5GPcN0NjG2qaz+xmg@mail.gmail.com>
 <248d9759-aef7-45ce-b0a4-6c1cafee76c9@rowland.harvard.edu>
 <CACGdZY+qJ7P8FZj6ZGmcDkf2YH7LRBnfvuwiro4ZF37+owHo9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGdZY+qJ7P8FZj6ZGmcDkf2YH7LRBnfvuwiro4ZF37+owHo9g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:46:37PM -0700, Khazhy Kumykov wrote:
> On Tue, Jul 25, 2023 at 2:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Jul 25, 2023 at 01:42:01PM -0700, Khazhy Kumykov wrote:
> > > On Tue, Jul 25, 2023 at 12:26 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > > @@ -2671,12 +2671,17 @@ int usb_authorize_device(struct usb_devi
> > > >         }
> > > >
> > > >         if (usb_dev->wusb) {
> > > > -               result = usb_get_device_descriptor(usb_dev, sizeof(usb_dev->descriptor));
> > > > -               if (result < 0) {
> > > > +               struct usb_device_descriptor *descr;
> > > > +
> > > > +               descr = usb_get_device_descriptor(usb_dev);
> > > > +               if (IS_ERR(descr)) {
> > > > +                       result = PTR_ERR(descr);
> > > >                         dev_err(&usb_dev->dev, "can't re-read device descriptor for "
> > > >                                 "authorization: %d\n", result);
> > > >                         goto error_device_descriptor;
> > > >                 }
> > > > +               usb_dev->descriptor = *descr;
> > > Hmm, in your first patch you rejected diffs to the descriptor here,
> > > which might be necessary - since we don't re-initialize the device so
> > > can get a similar issue if the bad usb device decides to change
> > > bNumConfigurations to cause a buffer overrun. (This also stuck out to
> > > me as an exception to the "descriptors should be immutable" comment
> > > later in the patch.
> >
> > I removed that part of the previous patch because there's no point to
> > it.  None of this code ever gets executed; the usb_dev->wusb test can
> > never succeed because the kernel doesn't support wireless USB any more.
> > (I asked Greg KH about that in a separate email thread:
> > <https://lore.kernel.org/linux-usb/2a21cefa-99a7-497c-901f-3ea097361a80@rowland.harvard.edu/#r>.)
> >
> > A later patch will remove all of the wireless USB stuff.  The only real
> > reason for leaving this much of the code there now is to prevent
> > compilation errors and keep the form looking right.
> Ah ok, cool.
> 
> >
> > > > @@ -6018,7 +6064,7 @@ static int usb_reset_and_verify_device(s
> > > >                 /* ep0 maxpacket size may change; let the HCD know about it.
> > > >                  * Other endpoints will be handled by re-enumeration. */
> > > >                 usb_ep0_reinit(udev);
> > > > -               ret = hub_port_init(parent_hub, udev, port1, i);
> > > > +               ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
> > > Looks like this is the only caller that passes &descriptor, and it
> > > just checks that it didn't change. Would it make sense to put the
> > > enitre descriptors_changed stanza in hub_port_init, for the re-init
> > > case?
> >
> > The descriptors_changed check has to be _somewhere_, either here or
> > there.  I don't see what difference it makes whether the check is done
> > in this routine or in hub_port_init.  Since it doesn't matter, why
> > change the existing code?
> No strong feelings, but it lets us remove the variable in
> usb_reset_and_verify_device() and directly check on the malloc'd copy,
> instead of copying back up to here.
> 
> Overall, looks good to my naive eyes.
> 
> CVE-2023-37453 was filed for this syzbot report, I'm not sure how that
> system gets tracked, but might be good to mention for folks looking
> for a fix.

Who filed CVEs for random syzbot reports?  That's crazy, and no, we
aren't going to track it as CVEs mean nothing for the kernel as I've
said many times.

thanks,

greg k-h
