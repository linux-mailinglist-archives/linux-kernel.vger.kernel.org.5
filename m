Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740E680432A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbjLEAON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLEAOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:14:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81E120
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:14:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC5C433C8;
        Tue,  5 Dec 2023 00:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701735256;
        bh=fUrk4RiGbZxusBO78Ffl1INnFFomDcxaJChxDkyTxsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDzOv3n3qO2RWlXnBgEoNPZsMxpFJYweRElhiGiR1Pe7EBY8SF3GF/XQX60KZpHBy
         yylKnunnvUteLRqUe/7YRhSW3/g437KDhnDn3Gc68uOpo/a1zAPoeg/z5HKZjnYn+t
         MoPmGVB9A5409whVcoDoFIVc9fJqP2jCfDHRX7v0=
Date:   Tue, 5 Dec 2023 09:14:12 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Singh <ayushdevel1325@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        elder@kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
Message-ID: <2023120515-mongrel-undertook-6e5a@gregkh>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
 <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
 <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:58:55PM +0530, Ayush Singh wrote:
> 
> On 12/4/23 19:42, Johan Hovold wrote:
> > On Mon, Dec 04, 2023 at 06:40:06PM +0530, Ayush Singh wrote:
> > > Ensure that the following values are little-endian:
> > > - header->pad (which is used for cport_id)
> > > - header->size
> > > 
> > > Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> > > Reported-by: kernel test robot <yujie.liu@intel.com>
> > > Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
> > > Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> > > ---
> > > V3:
> > > - Fix endiness while sending.
> > > V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/L53UN5ROSG4M6OE7CU5Y3L5F44T6ZPCC/
> > > - Ensure endianess for header->pad
> > > V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/
> > > 
> > >   drivers/greybus/gb-beagleplay.c | 9 +++++----
> > >   1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> > > index 43318c1993ba..8b21c3e1e612 100644
> > > --- a/drivers/greybus/gb-beagleplay.c
> > > +++ b/drivers/greybus/gb-beagleplay.c
> > > @@ -93,9 +93,9 @@ static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
> > >   	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
> > >   	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
> > > -		hdr->operation_id, hdr->type, cport_id, hdr->result);
> > > +		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
> > > -	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
> > > +	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
> > This looks broken; a quick against mainline (and linux-next) check shows
> > cport_id to be u16.
> > 
> > I think you want get_unaligned_le16() or something instead of that
> > memcpy() above.
> Thanks, will do.
> > 
> > But that just begs the question: why has this driver repurposed the pad
> > bytes like this? The header still says that these shall be set to zero.
> 
> So, the reason is multiplexing. The original gbridge setup used to do this,
> so I followed it when I moved gbridge to the coprocessor (during GSoC).
> 
> Using the padding for storing cport information allows not having to wrap
> the message in some other format at the two transport layers (UART and TCP
> sockets) beagle connect is using.This also seems better than trying to do
> something bespoke, especially since the padding bytes are not being used for
> anything else.
> 
> The initial spec was for project Ara (modular smartphone), so the current
> use for IoT is significantly different from the initial goals of the
> protocol. Maybe a future version of the spec can be more focused on IoT, but
> that will probably only happen once it has proven somewhat useful in this
> space.

Please don't violate the spec today this way, I missed that previously,
that's not ok.  We can change the spec for new things if you need it,
but to not follow it, and still say it is "greybus" isn't going to work
and will cause problems in the long-run.

Should I just disable the driver for now until this is fixed up?

thanks,

greg k-h
