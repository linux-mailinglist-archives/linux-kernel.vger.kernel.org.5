Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586277E3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjHPOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbjHPOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41D268F;
        Wed, 16 Aug 2023 07:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C339669E3;
        Wed, 16 Aug 2023 14:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3937C433C7;
        Wed, 16 Aug 2023 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692196964;
        bh=Onf8GBQ42sfUuG/X+JQV54DEIRlWJ+k2bjhvUDfua9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhbKHsh29N+CyM6scVJy+tK2FuiWOpM6D/FhGzi9Jl4I/e/Pz8WqmnRj6uPprhyGi
         68prQxeoAvMRfIex1nJuOcLD/5fkIQk1Hz57+Zfl0whWIGk9VYLVSk1kvOL/F3xUuI
         2lfkKC2/50dyHyf5pbdScxcWE9u4EbN17HSkCMuc=
Date:   Wed, 16 Aug 2023 16:42:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     richard.leitner@linux.dev, wsa+renesas@sang-engineering.com,
        mhocko@suse.com, surenb@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] drivers: usb: Removes use of assignment in if
 condition
Message-ID: <2023081606-geology-purging-8ff1@gregkh>
References: <20230815204141.51972-1-atulpant.linux@gmail.com>
 <2023081550-absurd-sprint-65e5@gregkh>
 <20230816034313.GA57824@atom0118>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816034313.GA57824@atom0118>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:13:13AM +0530, Atul Kumar Pant wrote:
> On Tue, Aug 15, 2023 at 11:07:02PM +0200, Greg KH wrote:
> > On Wed, Aug 16, 2023 at 02:11:41AM +0530, Atul Kumar Pant wrote:
> > > This patch fixes following checkpatch.pl issue:
> > > ERROR: do not use assignment in if condition
> > > 
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  drivers/usb/core/devio.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > index e501a03d6c70..56899fed6bd4 100644
> > > --- a/drivers/usb/core/devio.c
> > > +++ b/drivers/usb/core/devio.c
> > > @@ -2333,9 +2333,10 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
> > >  		}
> > >  	}
> > >  
> > > +	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
> > >  	if (ps->dev->state != USB_STATE_CONFIGURED)
> > >  		retval = -EHOSTUNREACH;
> > > -	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
> > > +	else if (!intf)
> > 
> > Did you mean to change the logic here by doing the calculation always?
> > Does that change functionality?
> > 
> 	Now the calculation of interface will be done always, which can be
> 	redundant. But this would not change the functionality.

Yes, but it is now redundant, so this change isn't really needed, the
original code is "more correct", please leave it as-is.

thanks,

greg k-h
