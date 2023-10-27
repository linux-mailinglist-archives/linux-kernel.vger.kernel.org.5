Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC37C7D95E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjJ0LBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjJ0LBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71452194;
        Fri, 27 Oct 2023 04:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78592C433C7;
        Fri, 27 Oct 2023 11:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698404473;
        bh=fo/rUXgDjTxBbkKJ2TCB2u4T9XooXAgroVyEUw22fOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJUXesXSq2hAhGnCykcZJshduWF/zMlmm+472mtKTo8zwcOUxJyQGAdcqk6kaS0K7
         JYWQ1nidcPg6vPggvF0TO1z6M/FGpGcMEVxu5Bm+PxgKngfzfy+Q1ylIvUCc+dUyIV
         3sac4vNlcRRvBujo3+jQxm1TqKoN8xcpsNXo2FNs=
Date:   Fri, 27 Oct 2023 13:01:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Vamshi Gajjela <vamshigajjela@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
Message-ID: <2023102738-sandpaper-renovator-3afe@gregkh>
References: <20231026135628.2800617-1-vamshigajjela@google.com>
 <2023102712-frolic-bush-3d67@gregkh>
 <f4358da2-af4-189a-eb93-3e82404c72eb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4358da2-af4-189a-eb93-3e82404c72eb@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:19:26AM +0300, Ilpo Järvinen wrote:
> On Fri, 27 Oct 2023, Greg Kroah-Hartman wrote:
> 
> > On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> > > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> > 
> > Please use lower case letters like I think you mean to?
> > 
> > Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
> > without them as well.
> > 
> > > The function uart_fifo_timeout() returns an unsigned long value, which
> > > is the number of jiffies. Therefore, change the variable timeout in the
> > > function uart_poll_timeout() from int to unsigned long.
> > > Change the return type of the function uart_poll_timeout() from int to
> > > unsigned long to be consistent with the type of timeout values.
> > > 
> > > Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> > > ---
> > > v3:
> > > - updated description
> > > v2:
> > > - unsigned long instead of unsigned int
> > > - added () after function name in short log
> > > - updated description
> > > 
> > >  include/linux/serial_core.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > > index bb6f073bc159..6916a1d7e477 100644
> > > --- a/include/linux/serial_core.h
> > > +++ b/include/linux/serial_core.h
> > > @@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
> > >  }
> > >  
> > >  /* Base timer interval for polling */
> > > -static inline int uart_poll_timeout(struct uart_port *port)
> > > +static inline unsigned long uart_poll_timeout(struct uart_port *port)
> > >  {
> > > -	int timeout = uart_fifo_timeout(port);
> > > +	unsigned long timeout = uart_fifo_timeout(port);
> > >  
> > >  	return timeout > 6 ? (timeout / 2 - 2) : 1;
> > 
> > So we are now doing 64bit math?  Did that just make things slower?
> 
> That divide with a constant 2 though so I'd expect compiler to turn it 
> into a shift.

Hopefully :)

> > What bug is this actually fixing?  How have you tested this to verify it
> > works?
> 
> AFAIK this doesn't fix anything because emptying when measured in jiffies
> isn't that big number. It's just about making the types more consistent.

Ah, ok, I'll wait for a proper version to be sent as I obviously can't
take it like-this.

thanks,

greg k-h
