Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F848085DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378800AbjLGKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378862AbjLGKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:09:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49644A4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:09:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24870C433C8;
        Thu,  7 Dec 2023 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701943786;
        bh=mlf+E9uAxcA9DH2IJGNsrr3vRH7MvPzIWWShzXKzrW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ge6SijUtS4LpfTcbDkYt4hdfhyhH6LxLfzLBBGN0w130qSSsTAyIk+lLkVfpKJdLw
         Jl/xlWAzKIxRe0GBt4HKzG6tnRFm3IgO+WxIlcR1dFcL2dIxOk7DwH344DOAve4MWB
         w7tonU+Nf7szhNxH2YJytPPdlrEIPr0ExzRZhA/Y=
Date:   Thu, 7 Dec 2023 11:09:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Message-ID: <2023120709-revise-retaliate-3796@gregkh>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-24-jirislaby@kernel.org>
 <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
 <2023120736-bullpen-edgy-3c02@gregkh>
 <ZXGAEThOendGmjb4@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXGAEThOendGmjb4@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:19:29AM +0100, Johan Hovold wrote:
> On Thu, Dec 07, 2023 at 10:47:18AM +0900, Greg Kroah-Hartman wrote:
> > On Wed, Dec 06, 2023 at 09:09:46AM +0100, Johan Hovold wrote:
> > > On Wed, Dec 06, 2023 at 08:37:08AM +0100, Jiri Slaby wrote:
> 
> > > > diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> > > > index 5d8e9bfb24d0..baa956494e79 100644
> > > > --- a/drivers/gnss/serial.c
> > > > +++ b/drivers/gnss/serial.c
> > > > @@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
> > > >  	.write_raw	= gnss_serial_write_raw,
> > > >  };
> > > >  
> > > > -static int gnss_serial_receive_buf(struct serdev_device *serdev,
> > > > -					const unsigned char *buf, size_t count)
> > > > +static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
> > > > +				       const u8 *buf, size_t count)
> 
> > > The gnss subsystem consistently use tabs-only for indentation of
> > > continuation lines so please don't change the indentation for these
> > > files.
> > 
> > That's going to drive checkpatch.pl crazy, please don't inist on it as
> > that is not going to work well over time as we would all have to
> > remember that just for this one subsystem :(
> 
> Open-parenthesis alignment is not part of the coding standard and is
> hidden behind the checkpatch.pl --strict option along with other (often
> excessive) checks that are not generally agreed upon.
> 
> Only staging and networking enable that option by default and I think
> checkpatch.pl handles that transparently.

Ah, didn't realize this was a staging-only thing, sorry.  As that's what
I get loads of checkpatch fixes for, I figured it was what everyone
should be using :)

thanks,

greg k-h
