Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB8808137
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377967AbjLGGvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377830AbjLGGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:51:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8291706
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:51:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A65CC433CB;
        Thu,  7 Dec 2023 06:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701931860;
        bh=oc2cpH+WqLqG0cbZP0JpCz4crm5mTOCZxYrQjBHv1Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXUTXGVwaB50gZJbzGdiUiKpfRUpT5nOLgNBT5c1XzJwOuQod0wW5v79gkuqYTL0L
         4F5Vza4Ka+RsCAAivzay2a76lPNv1qOl1ot5wZyR++L8Khsmk0Gy4NUVxNZTXv+20m
         Jzao1+zYqXEQuUwHuJmMnbfey6WrxSviY+BbHoWg=
Date:   Thu, 7 Dec 2023 10:47:18 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Message-ID: <2023120736-bullpen-edgy-3c02@gregkh>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-24-jirislaby@kernel.org>
 <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:09:46AM +0100, Johan Hovold wrote:
> On Wed, Dec 06, 2023 at 08:37:08AM +0100, Jiri Slaby wrote:
> > Switch character types to u8 and sizes to size_t. To conform to
> > characters/sizes in the rest of the tty layer.
> >
> > This patch converts struct serdev_device_ops hooks and its
> > instantiations.
> > 
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
>   
> > diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> > index 5d8e9bfb24d0..baa956494e79 100644
> > --- a/drivers/gnss/serial.c
> > +++ b/drivers/gnss/serial.c
> > @@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
> >  	.write_raw	= gnss_serial_write_raw,
> >  };
> >  
> > -static int gnss_serial_receive_buf(struct serdev_device *serdev,
> > -					const unsigned char *buf, size_t count)
> > +static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
> > +				       const u8 *buf, size_t count)
> >  {
> >  	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
> >  	struct gnss_device *gdev = gserial->gdev;
> > diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> > index bcb53ccfee4d..6801a8fb2040 100644
> > --- a/drivers/gnss/sirf.c
> > +++ b/drivers/gnss/sirf.c
> > @@ -160,8 +160,8 @@ static const struct gnss_operations sirf_gnss_ops = {
> >  	.write_raw	= sirf_write_raw,
> >  };
> >  
> > -static int sirf_receive_buf(struct serdev_device *serdev,
> > -				const unsigned char *buf, size_t count)
> > +static ssize_t sirf_receive_buf(struct serdev_device *serdev,
> > +				const u8 *buf, size_t count)
> >  {
> 
> The gnss subsystem consistently use tabs-only for indentation of
> continuation lines so please don't change the indentation for these
> files.

That's going to drive checkpatch.pl crazy, please don't inist on it as
that is not going to work well over time as we would all have to
remember that just for this one subsystem :(

thanks,

greg k-h
