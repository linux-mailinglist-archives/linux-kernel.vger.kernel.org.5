Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B0805EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjLETpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjLETpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:45:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954CC183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:45:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F4C433C7;
        Tue,  5 Dec 2023 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701805516;
        bh=2Pc1SUSOg33xNmlAlMr3NhuJ02ZZaNiPd6NG+yOqZnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCozMJ3YI18rqWdF4BLcgJdxVToMXDJ4sQXO6U1BhJFjEbZ0kEbZM9DE03aOZ2wG4
         n+hCxNdziZm3MaVfCZkYMuGr/VXGPXPvYEWZVza+VEfjcNJ9pc4vin+S/bpcdpEFiq
         hwiz/PCNf2gY9SHIHtoBxjkIiytMrL8QEga3zx30=
Date:   Wed, 6 Dec 2023 04:45:14 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        elder@kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
Message-ID: <2023120616-rely-naturist-01db@gregkh>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
 <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
 <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
 <2023120515-mongrel-undertook-6e5a@gregkh>
 <4cafbb5a-8ecd-407e-81a0-76d6505d013b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cafbb5a-8ecd-407e-81a0-76d6505d013b@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:15:33PM +0530, Ayush Singh wrote:
> 
> On 12/5/23 05:44, Greg KH wrote:
> > On Mon, Dec 04, 2023 at 09:58:55PM +0530, Ayush Singh wrote:
> > > On 12/4/23 19:42, Johan Hovold wrote:
> > > > On Mon, Dec 04, 2023 at 06:40:06PM +0530, Ayush Singh wrote:
> > > > > Ensure that the following values are little-endian:
> > > > > - header->pad (which is used for cport_id)
> > > > > - header->size
> > > > > 
> > > > > Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> > > > > Reported-by: kernel test robot <yujie.liu@intel.com>
> > > > > Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
> > > > > Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> > > > > ---
> > > > > V3:
> > > > > - Fix endiness while sending.
> > > > > V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/L53UN5ROSG4M6OE7CU5Y3L5F44T6ZPCC/
> > > > > - Ensure endianess for header->pad
> > > > > V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/
> > > > > 
> > > > >    drivers/greybus/gb-beagleplay.c | 9 +++++----
> > > > >    1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> > > > > index 43318c1993ba..8b21c3e1e612 100644
> > > > > --- a/drivers/greybus/gb-beagleplay.c
> > > > > +++ b/drivers/greybus/gb-beagleplay.c
> > > > > @@ -93,9 +93,9 @@ static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
> > > > >    	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
> > > > >    	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
> > > > > -		hdr->operation_id, hdr->type, cport_id, hdr->result);
> > > > > +		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
> > > > > -	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
> > > > > +	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
> > > > This looks broken; a quick against mainline (and linux-next) check shows
> > > > cport_id to be u16.
> > > > 
> > > > I think you want get_unaligned_le16() or something instead of that
> > > > memcpy() above.
> > > Thanks, will do.
> > > > But that just begs the question: why has this driver repurposed the pad
> > > > bytes like this? The header still says that these shall be set to zero.
> > > So, the reason is multiplexing. The original gbridge setup used to do this,
> > > so I followed it when I moved gbridge to the coprocessor (during GSoC).
> > > 
> > > Using the padding for storing cport information allows not having to wrap
> > > the message in some other format at the two transport layers (UART and TCP
> > > sockets) beagle connect is using.This also seems better than trying to do
> > > something bespoke, especially since the padding bytes are not being used for
> > > anything else.
> > > 
> > > The initial spec was for project Ara (modular smartphone), so the current
> > > use for IoT is significantly different from the initial goals of the
> > > protocol. Maybe a future version of the spec can be more focused on IoT, but
> > > that will probably only happen once it has proven somewhat useful in this
> > > space.
> > Please don't violate the spec today this way, I missed that previously,
> > that's not ok.  We can change the spec for new things if you need it,
> > but to not follow it, and still say it is "greybus" isn't going to work
> > and will cause problems in the long-run.
> > 
> > Should I just disable the driver for now until this is fixed up?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Well, I will look into some ways to pass along the cport information (maybe
> using a wrapper over greybus message) for now. However, I would prefer
> having some bytes in greybus messages reserved for passing around this
> information in a transport agnostic way.

I'm confused, what exactly is needed here to be sent that isn't in the
existing message definition.

And as to your original statement, the protocol definition was not
designed for any specific use case that would make IoT "special" here
that I can see.  It was designed to provide a discoverable way to
describe and control hardware on an unknown transport layer for devices
that are not discoverable by definition (serial, i2c, etc.)

The fact that we implemented this on both USB and unipro successfully
provided that the transport layer for the data should be working and
agnositic.

thanks,

greg k-h
