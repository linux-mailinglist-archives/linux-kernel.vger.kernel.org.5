Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8125B7D7E90
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbjJZIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:34:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E11D10E;
        Thu, 26 Oct 2023 01:34:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9786BC433C7;
        Thu, 26 Oct 2023 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698309285;
        bh=FV3diMI1a5dHegpEaNtjUtGyFkoRaorH2cPnA/vaaNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKAkahQkqyu8qLGqCGffaR09FeiP3zZ6tzK5ilDK7/k3fKEe1Z7pxwRqNSVOmLNJo
         i1sjyKGrumCfVflrMHU+qWSLEqmA+9hNz4ZDmhTyjO0ZQdWdyXu1TWAVVOKu2lXRpr
         vCKGM2Zqggn89EfCpfCZBbzxzd5pWfTDvkR1phMc=
Date:   Thu, 26 Oct 2023 10:34:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: n_gsm: fix race condition in status line change
 on dead connections
Message-ID: <2023102615-psychic-manger-5c48@gregkh>
References: <20231026055844.3127-1-daniel.starke@siemens.com>
 <2023102629-onward-bust-d049@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102629-onward-bust-d049@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:27:37AM +0200, Greg KH wrote:
> On Thu, Oct 26, 2023 at 07:58:43AM +0200, D. Starke wrote:
> > From: Daniel Starke <daniel.starke@siemens.com>
> > 
> > gsm_cleanup_mux() cleans up the gsm by closing all DLCIs, stopping all
> > timers, removing the virtual tty devices and clearing the data queues.
> > This procedure, however, may cause subsequent changes of the virtual modem
> > status lines of a DLCI. More data is being added the outgoing data queue
> > and the deleted kick timer is restarted to handle this. At this point many
> > resources have already been removed by the cleanup procedure. Thus, a
> > kernel panic occurs.
> > 
> > Fix this by proving in gsm_modem_update() that the cleanup procedure has
> > not been started and the mux is still alive.
> > 
> > Note that writing to a virtual tty is already protected by checks against
> > the DLCI specific connection state.
> > 
> > Fixes: c568f7086c6e ("tty: n_gsm: fix missing timer to handle stalled links")
> > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > ---
> >  drivers/tty/n_gsm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 1f3aba607cd5..0ee7531c9201 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -4108,6 +4108,8 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
> >  
> >  static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
> >  {
> > +	if (dlci->gsm->dead)
> > +		return -EL2HLT;
> >  	if (dlci->adaption == 2) {
> >  		/* Send convergence layer type 2 empty data frame. */
> >  		gsm_modem_upd_via_data(dlci, brk);
> > -- 
> > 2.34.1
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 

Note, I'll take this now, and add the tag by hand, just try to remember
it for the future.

thanks,

greg k-h
