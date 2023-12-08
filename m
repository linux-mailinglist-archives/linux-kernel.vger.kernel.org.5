Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87570809BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjLHFdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHFdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:33:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753D123
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:33:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3BFC433C7;
        Fri,  8 Dec 2023 05:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702013595;
        bh=c95vgIGojNc1fgzK6+ldl6rVKTigeKUbZUIuUxNNRPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMI5A72U3NgOG4NNCRLUTGvUct5N4T6H+MPoYf9m/FzzWFuZiJIza5lEZTCatJdg4
         EXTG1GtKEXSYfnuBmS3ynPe3VqMpsyrJyfhmE59ksqC92QP4FyKPPZomvzuVr3UVqQ
         b3Dd1gz7h2kxufzLDmSpQX/iU2quknyme+8D+xC4=
Date:   Fri, 8 Dec 2023 06:33:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     greybus-dev@lists.linaro.org, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
Subject: Re: [PATCH 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Message-ID: <2023120805-endocrine-conflict-b1ff@gregkh>
References: <20231206150602.176574-1-ayushdevel1325@gmail.com>
 <20231206150602.176574-2-ayushdevel1325@gmail.com>
 <2023120758-coleslaw-unstopped-530c@gregkh>
 <c0823649-8235-40d7-813e-8a4500251219@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0823649-8235-40d7-813e-8a4500251219@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 10:33:54PM +0530, Ayush Singh wrote:
> > > + *
> > > + * @cport: cport id
> > > + * @hdr: greybus operation header
> > > + * @payload: greybus message payload
> > > + */
> > > +struct hdlc_greybus_frame {
> > > +	__le16 cport;
> > > +	struct gb_operation_msg_hdr hdr;
> > > +	u8 payload[];
> > > +} __packed;
> > > +
> > >   static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
> > >   {
> > > -	u16 cport_id;
> > > -	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
> > > +	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
> > > +	u16 cport_id = le16_to_cpu(gb_frame->cport);
> > > -	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
> > > +	/* Ensure that the greybus message is valid */
> > > +	if (le16_to_cpu(gb_frame->hdr.size) > len - sizeof(cport_id)) {
> > > +		dev_warn_ratelimited(&bg->sd->dev, "Invalid/Incomplete greybus message");
> > Don't spam the kernel log for corrupted data on the line, that would be
> > a mess.  Use a tracepoint?
> > 
> > > +		return;
> > > +	}
> > >   	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
> > > -		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
> > > +		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
> > Better yet, put the error in the debug message?
> Shouldn't corrupt data be a warning rather than debug message, since it
> indicates something wrong with the transport?

Do you want messages like that spamming the kernel log all the time if a
network connection is corrupted?

Just handle the error and let the upper layers deal with it when the
problem is eventually reported to userspace, that's all that is needed.


> > > -	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
> > > +	greybus_data_rcvd(bg->gb_hd, cport_id, &buf[sizeof(cport_id)],
> > Fun with pointer math.  This feels really fragile, why not just point to
> > the field instead?
> It seems that taking address of members of packed structures is not valid.

That feels really odd.

> I get the `address-of-packed-member` warnings. Is it fine to ignore
> those in kernel?

What error exactly are you getting?  Packed or not does not mean
anything to the address of a member.  If it does, perhaps you are doing
something wrong as you are really doing the same thing here, right?
Don't ignore the warning by open-coding it.

> > >   }
> > >   static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
> > > @@ -339,7 +357,7 @@ static struct serdev_device_ops gb_beagleplay_ops = {
> > >   static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
> > >   {
> > >   	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
> > > -	struct hdlc_payload payloads[2];
> > > +	struct hdlc_payload payloads[3];
> > why 3?
> > 
> > It's ok to put this on the stack?
> 
> Well, the HDLC payload is just to store the length of the payload along with
> a pointer to its data. (kind of emulate a fat pointer). The reason for doing
> it this way is to avoid having to create a temp buffer for each message when
> sending data over UART (which was done in the initial version of the
> driver).

Be careful, are you SURE you are allowed to send stack-allocated data?
I know that many busses forbid this (like USB).  So please check to be
sure that this is ok to do, and that these are not huge structures that
you are putting on the very-limited kernel-stack.

thanks,

greg k-h
