Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AC7B3EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjI3HBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3HBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:01:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE0AC5;
        Sat, 30 Sep 2023 00:01:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF0FC433C7;
        Sat, 30 Sep 2023 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696057273;
        bh=aH5DifR1+J1vJdlt0HdKBLUJn1v/XbPJouikZChEZlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+gwLL3DtZ6fdEbiMlKWdDAslWvJnAtuWXp52nw1rU2c2LU+QkKt7rUIr1o9ly0jU
         rVBkKKyoB31D8MJEmrAgy717YH3yTN0APjd4dYAUD2UZb6H0sFfM23QhY2iKc2aj2G
         qccOAwvjavs9nGtVRzBK6/Lg/WzjnWTflT2bnjsM=
Date:   Sat, 30 Sep 2023 09:01:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
Message-ID: <2023093029-primary-likewise-9579@gregkh>
References: <ZRbwU8Qnx28gpbuO@work>
 <CAG48ez2SJMJSYrJQ9RVC44hbj3uNYBZeN0yfxWa7pqX9Fp2L7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2SJMJSYrJQ9RVC44hbj3uNYBZeN0yfxWa7pqX9Fp2L7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 06:20:10PM +0200, Jann Horn wrote:
> On Fri, Sep 29, 2023 at 5:42 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> > `struct urb` is a flexible structure, which means that it contains a
> > flexible-array member at the bottom. This could potentially lead to an
> > overwrite of the object `wq` at run-time with the contents of `urb`.
> >
> > Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.
> 
> Does this really change the situation? "struct smsusb_device_t"
> contains an array of "struct smsusb_urb_t", so it seems to be like
> you're just shifting the "VLA inside a non-final member of a struct"
> thing around so that there is one more layer of abstraction in
> between.
> 
> Comments on "struct urb" say:
> 
>  * Isochronous URBs have a different data transfer model, in part because
>  * the quality of service is only "best effort".  Callers provide specially
>  * allocated URBs, with number_of_packets worth of iso_frame_desc structures
>  * at the end.
> 
> and:
> 
> /* (in) ISO ONLY */
> 
> And it looks like smsusb only uses that URB as a bulk URB, so the flex
> array is unused and we can't have an overflow here?
> 
> If this is intended to make it possible to enable some kinda compiler
> warning, it might be worth talking to the USB folks to figure out the
> right approach here.
> 
> > Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/media/usb/siano/smsusb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
> > index 9d9e14c858e6..2c048f8e8371 100644
> > --- a/drivers/media/usb/siano/smsusb.c
> > +++ b/drivers/media/usb/siano/smsusb.c
> > @@ -40,10 +40,10 @@ struct smsusb_urb_t {
> >         struct smscore_buffer_t *cb;
> >         struct smsusb_device_t *dev;
> >
> > -       struct urb urb;
> > -
> >         /* For the bottom half */
> >         struct work_struct wq;
> > +
> > +       struct urb urb;
> >  };

Yeah, this is going to get messy.  Ideally, just dynamically create the
urb and change this to a "struct urb *urb;" instead.

thanks,

greg k-h
