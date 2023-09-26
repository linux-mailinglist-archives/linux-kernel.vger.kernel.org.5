Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E977AF6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjIZXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjIZXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:22:02 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A119BA27A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:24:21 -0700 (PDT)
Received: (qmail 1476453 invoked by uid 1000); 26 Sep 2023 17:24:19 -0400
Date:   Tue, 26 Sep 2023 17:24:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v4] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
Message-ID: <9384ac6a-f877-4835-b1ec-0e620a5ba8ba@rowland.harvard.edu>
References: <20230926193708.22405-1-quic_kriskura@quicinc.com>
 <2178cf29-5e5c-4ed6-8d1c-916bc7036589@rowland.harvard.edu>
 <62083b55-0b78-4ebc-ab78-1c1d99f92507@quicinc.com>
 <f2bd7593-eff9-46ac-a94b-964eb4787740@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2bd7593-eff9-46ac-a94b-964eb4787740@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:54:34AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 9/27/2023 1:36 AM, Krishna Kurapati PSSNV wrote:
> > > >   drivers/usb/gadget/udc/core.c | 23 +++++++++++++++++++----
> > > >   1 file changed, 19 insertions(+), 4 deletions(-)
> > > > 
> > > >   static void vbus_event_work(struct work_struct *work)
> > > > @@ -1604,12 +1608,23 @@ static int gadget_bind_driver(struct
> > > > device *dev)
> > > >       }
> > > >       usb_gadget_enable_async_callbacks(udc);
> > > >       udc->allow_connect = true;
> > > > -    usb_udc_connect_control_locked(udc);
> > > > +    ret = usb_udc_connect_control_locked(udc);
> > > > +    if (ret) {
> > > > +        mutex_unlock(&udc->connect_lock);
> > > > +        goto err_connect_control;
> > > > +    }
> > > > +
> > > >       mutex_unlock(&udc->connect_lock);
> > > >       kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> > > >       return 0;
> > > > + err_connect_control:
> > > > +    usb_gadget_disable_async_callbacks(udc);
> > > > +    if (gadget->irq)
> > > > +        synchronize_irq(gadget->irq);
> > > > +    usb_gadget_udc_stop_locked(udc);
> > > 
> > > Not good -- usb_gadget_udc_stop_locked() expects you to be holding
> > > udc->connect_lock, but you just dropped the lock!  Also, you never set
> > > udc->allow_connect back to false.
> > > 
> > > You should move the mutex_unlock() call from inside the "if" statement
> > > to down here, and add a line for udc->allow_connect.
> > > 
> > 
> > Hi Alan,
> > 
> >   Thanks for the review. Will push v5 addressing the changes.
> > 
> > 
> Hi Alan,
> 
> I tried out the following diff:
> 
> -       usb_udc_connect_control_locked(udc);
> +       ret = usb_udc_connect_control_locked(udc);
> +       if (ret)
> +               goto err_connect_control;
> +
>         mutex_unlock(&udc->connect_lock);
> 
>         kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>         return 0;
> 
> + err_connect_control:
> +       udc->allow_connect = false;
> +       usb_gadget_disable_async_callbacks(udc);
> +       if (gadget->irq)
> +               synchronize_irq(gadget->irq);
> +       usb_gadget_udc_stop_locked(udc);
> +       mutex_unlock(&udc->connect_lock);
> +
> 
> If I clear UDC and fail dwc3 soft reset on purpose, I see UDC_store failing:
> 
> #echo a600000.usb > /sys/kernel/config/usb_gadget/g1/UDC
> [  127.394087] dwc3 a600000.usb: request 000000003f43f907 was not queued to
> ep0out
> [  127.401637] udc a600000.usb: failed to start g1: -110
> [  127.406841] configfs-gadget.g1: probe of gadget.0 failed with error -110
> [  127.413809] UDC core: g1: couldn't find an available UDC or it's busy
> 
> The same output came when I tested v4 as well. Every time soft_reset would
> fail when I try to write to UDC, UDC_store fails and above log will come up.

Isn't that what you want?  I thought the whole purpose of this patch was 
to make it so that configfs would realize when 
usb_udc_connect_control_locked() had failed.   So you should be happy 
that the log shows a failure occurred.

> Can you help confirm if the diff above is proper as I don't see any diff in
> the logs in v4 and about to push v5.

"Diff in the logs in v4"?  What does that mean?  A diff is a comparison 
between two text files (often between before-and-after versions of a 
source code file).  Why would you expect a diff to show up in the logs?

This revised patch looks okay to me.

Alan Stern
