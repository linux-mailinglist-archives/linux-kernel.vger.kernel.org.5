Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F167F13A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjKTMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjKTMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:40:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818A107
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:40:05 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SYn5n0cNpz6JBFW;
        Mon, 20 Nov 2023 20:35:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 20 Nov
 2023 12:40:02 +0000
Date:   Mon, 20 Nov 2023 12:40:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 08/10] ipmi: kcs_bmc: Track clients in core
Message-ID: <20231120124001.00003cbc@Huawei.com>
In-Reply-To: <a015924b542fd35fe84357eebddd14cfae83dace.camel@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-9-andrew@codeconstruct.com.au>
        <20231103150522.00004539@Huawei.com>
        <a015924b542fd35fe84357eebddd14cfae83dace.camel@codeconstruct.com.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 10:26:38 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> On Fri, 2023-11-03 at 15:05 +0000, Jonathan Cameron wrote:
> > On Fri,  3 Nov 2023 16:45:20 +1030
> > Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
> >   
> > > I ran out of spoons before I could come up with a better client tracking
> > > scheme back in the original refactoring series:
> > > 
> > > https://lore.kernel.org/all/20210608104757.582199-1-andrew@aj.id.au/
> > > 
> > > Jonathan prodded Konstantin about the issue in a review of Konstantin's
> > > MCTP patches[1], prompting an attempt to clean it up.
> > > 
> > > [1]: https://lore.kernel.org/all/20230929120835.0000108e@Huawei.com/
> > > 
> > > Prevent client modules from having to track their own instances by
> > > requiring they return a pointer to a client object from their
> > > add_device() implementation. We can then track this in the core, and
> > > provide it as the argument to the remove_device() implementation to save
> > > the client module from further work. The usual container_of() pattern
> > > gets the client module access to its private data.
> > > 
> > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>  
> > 
> > Hi Andrew,
> > 
> > A few comments inline.
> > More generally, whilst this is definitely an improvement I'd have been tempted
> > to make more use of the linux device model for this with the clients added
> > as devices with a parent of the kcs_bmc_device.  That would then allow for
> > simple dependency tracking, binding of individual drivers and all that.
> > 
> > What you have here feels fine though and is a much less invasive change.  
> 
Sorry for slow reply, been traveling.

> Yeah, I had this debate with myself before posting the patches. My
> reasoning for the current approach is that the clients don't typically
> represent a device, rather a protocol implementation that is
> communicated over a KCS device (maybe more like pairing a line
> discipline with a UART). It was unclear to me whether associating a
> `struct device` with a protocol implementation was stretching the
> abstraction a bit, or whether I haven't considered some other
> perspective hard enough - maybe we treat the client as the remote
> device, similar to e.g. a `struct i2c_client`?

That was my thinking.  The protocol is used to talk to someone - the endpoint
(similar to i2c_client) so represent that. If that device is handling multiple
protocols (no idea if that is possible) - that is fine as well, it just becomes
like having multiple i2c_clients in a single package (fairly common for sensors),
or the many other cases where we use a struct device to represent just part
of a larger device that operates largely independently of other parts (or with
well defined boundaries).

Jonathan



> 
> > 
> > Jonathan
> > 
> >   
> > > diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> > > index 98f231f24c26..9fca31f8c7c2 100644
> > > --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> > > +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> > > @@ -71,8 +71,6 @@ enum kcs_ipmi_errors {  
> > 
> > 
> >   
> > > +static struct kcs_bmc_client *
> > > +kcs_bmc_ipmi_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_device *dev)
> > >  {
> > >  	struct kcs_bmc_ipmi *priv;
> > >  	int rc;
> > >  
> > >  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > >  	if (!priv)
> > > -		return -ENOMEM;
> > > +		return ERR_PTR(ENOMEM);  
> > As below. I thought it took negatives..  
> 
> I should have double checked that. It requires negatives. Thanks.
> 
> > >  
> > >  	spin_lock_init(&priv->lock);
> > >  	mutex_init(&priv->mutex);
> > >  	init_waitqueue_head(&priv->queue);
> > >  
> > > -	priv->client.dev = kcs_bmc;
> > > -	priv->client.ops = &kcs_bmc_ipmi_client_ops;
> > > +	kcs_bmc_client_init(&priv->client, &kcs_bmc_ipmi_client_ops, drv, dev);
> > >  
> > >  	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
> > > -	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, kcs_bmc->channel);
> > > +	priv->miscdev.name = kasprintf(GFP_KERNEL, "%s%u", DEVICE_NAME, dev->channel);
> > >  	if (!priv->miscdev.name) {
> > >  		rc = -ENOMEM;  
> > ERR_PTR  
> 
> I converted it to an ERR_PTR in the return after the cleanup_priv
> label. Maybe it's preferable I do the conversion immediately? Easy
> enough to change if you think so.

I'm not that fussed either way.

> 
> > >  		goto cleanup_priv;  
> > 
> > 
> > 
> > ...
> >   
> > > diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> > > index 0a68c76da955..3cfda39506f6 100644
> > > --- a/drivers/char/ipmi/kcs_bmc_serio.c
> > > +++ b/drivers/char/ipmi/kcs_bmc_serio.c  
> > 
> > ...
> > 
> >   
> > > +static struct kcs_bmc_client *
> > > +kcs_bmc_serio_add_device(struct kcs_bmc_driver *drv, struct kcs_bmc_device *dev)
> > >  {
> > >  	struct kcs_bmc_serio *priv;
> > >  	struct serio *port;
> > > @@ -75,12 +71,12 @@ static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
> > >  
> > >  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > >  	if (!priv)
> > > -		return -ENOMEM;
> > > +		return ERR_PTR(ENOMEM);
> > >  
> > >  	/* Use kzalloc() as the allocation is cleaned up with kfree() via serio_unregister_port() */
> > >  	port = kzalloc(sizeof(*port), GFP_KERNEL);
> > >  	if (!port) {
> > > -		rc = -ENOMEM;
> > > +		rc = ENOMEM;  
> > Why positive?
> > Doesn't ERR_PTR() typically get passed negatives?   
> 
> Ack, as above.
> 
> Thanks for the review,
> 
> Andrew

