Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979417BD84A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjJIKN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346124AbjJIKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B9AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:13:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96312C433C7;
        Mon,  9 Oct 2023 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696846403;
        bh=YfNHX7fOB23fzO4vlatr2RpIOyGVl9c/BlM3RYmxUM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGWbOp4LMq2AOqyx8nvBJlRVXSrYX1alxYqDB91I7RieM5AMKmxjbZUBTBa1ftxlJ
         LcD9S5f7WlyNl5tiag2LOvW7MSBrXq2P6sao/q4PnxKlAvjbiXwCq/0PRsok2hjQiA
         kp3zvHLhD3O8ofKdIV91NEFLPPhCSwGy4lvsqzEY=
Date:   Mon, 9 Oct 2023 12:13:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH] tee: make tee_class constant
Message-ID: <2023100952-yapping-rockiness-f1e3@gregkh>
References: <2023100613-lustiness-affiliate-7dcb@gregkh>
 <CAFA6WYNbMsEE7OF0SpLN5gQx5-TNPXD7Zm+2tVu21xdpzKU=Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNbMsEE7OF0SpLN5gQx5-TNPXD7Zm+2tVu21xdpzKU=Xg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:04:33AM +0530, Sumit Garg wrote:
> On Fri, 6 Oct 2023 at 19:30, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tee/tee_core.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> 
> Apart from nit below, feel free to add:
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> 
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 0eb342de0b00..5ddfd5d9ac7f 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -40,7 +40,10 @@ static const uuid_t tee_client_uuid_ns = UUID_INIT(0x58ac9ca0, 0x2086, 0x4683,
> >  static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
> >  static DEFINE_SPINLOCK(driver_lock);
> >
> > -static struct class *tee_class;
> > +static const struct class tee_class = {
> > +       .name = "tee",
> > +};
> > +
> >  static dev_t tee_devt;
> >
> >  struct tee_context *teedev_open(struct tee_device *teedev)
> > @@ -919,7 +922,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
> >                  teedesc->flags & TEE_DESC_PRIVILEGED ? "priv" : "",
> >                  teedev->id - offs);
> >
> > -       teedev->dev.class = tee_class;
> > +       teedev->dev.class = &tee_class;
> >         teedev->dev.release = tee_release_device;
> >         teedev->dev.parent = dev;
> >
> > @@ -1112,7 +1115,7 @@ tee_client_open_context(struct tee_context *start,
> >                 dev = &start->teedev->dev;
> >
> >         do {
> > -               dev = class_find_device(tee_class, dev, &match_data, match_dev);
> > +               dev = class_find_device(&tee_class, dev, &match_data, match_dev);
> >                 if (!dev) {
> >                         ctx = ERR_PTR(-ENOENT);
> >                         break;
> > @@ -1226,10 +1229,10 @@ static int __init tee_init(void)
> >  {
> >         int rc;
> >
> > -       tee_class = class_create("tee");
> > -       if (IS_ERR(tee_class)) {
> > +       rc = class_register(&tee_class);
> > +       if (rc) {
> >                 pr_err("couldn't create class\n");
> 
> nit: this error message should be updated as well.

Ah, missed that, thanks!  Will send a follow-up patch for that.

greg k-h
