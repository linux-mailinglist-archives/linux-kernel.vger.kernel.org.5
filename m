Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE25790CA5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbjICPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjICPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:08:35 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCA191;
        Sun,  3 Sep 2023 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693753706;
        bh=RCuVmw2doT+mJqByggiPBISZb3OAuFmYisdF/qK8jOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlR04yTjfO6FVWRaZvHh83B68SSI1/VyjJhZg1md3eztAJUq4aMh8O6qqJAX+MTPb
         2e1cMmtBxQAaTFm4+Kp5eYluelWO7ET7W3Oga67HPL1yq/3F02b+JLWBhkQmZ3+I+M
         0gP3EZkQ28ZMqMbaNKAGrbwBxDAVzOQanUb5j6Qs=
Date:   Sun, 3 Sep 2023 17:08:25 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
Message-ID: <2743f7d5-9e8d-4a61-ba4a-d47bf26b6f62@t-8ch.de>
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
 <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
 <46d3194a-af79-4076-b0a2-561d713a406e@t-8ch.de>
 <2776f856-94e4-1481-508a-db80db573be0@roeck-us.net>
 <290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com>
 <9151ab86-305e-9bb3-ee46-bfa8fd998c12@roeck-us.net>
 <7910a5e5-04f3-f585-e42d-4a0d7aa45f9d@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7910a5e5-04f3-f585-e42d-4a0d7aa45f9d@interlog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-03 10:54:06-0400, Douglas Gilbert wrote:
> On 2023-09-03 07:46, Guenter Roeck wrote:
> > On 9/2/23 22:54, Douglas Gilbert wrote:
> > > On 2023-09-02 18:56, Guenter Roeck wrote:
> > > > On 9/2/23 15:29, Thomas Weißschuh wrote:
> > > > > Hi,
> > > > > 
> > > > > On 2023-09-02 18:36:17+0200, Christophe JAILLET wrote:
> > > > > > Le 02/09/2023 à 09:47, Thomas Weißschuh a écrit :
> > > > > > > POWER-Z is a series of devices to monitor power characteristics of
> > > > > > > USB-C connections and display those on a on-device display.
> > > > > > > Some of the devices, notably KM002C and KM003C, contain an additional
> > > > > > > port which exposes the measurements via USB.
> > > > > > > 
> > > > > > > This is a driver for this monitor port.
> > > > > > > 
> > > > > > > It was developed and tested with the KM003C.
> > > > > > > 
> > > > > > > Signed-off-by: Thomas Weißschuh
> > > > > > > <linux-9XfqOkM5JgxKQ7RDE2T8Pw@public.gmane.org>
> > > > > > > ---
> > > > > > 
> > > > > > ...
> > > > > > 
> > > > > > > +static int powerz_probe(struct usb_interface *intf,
> > > > > > > +            const struct usb_device_id *id)
> > > > > > > +{
> > > > > > > +    struct powerz_priv *priv;
> > > > > > > +    struct device *hwmon_dev;
> > > > > > > +    struct device *parent;
> > > > > > > +
> > > > > > > +    parent = &intf->dev;
> > > > > > > +
> > > > > > > +    priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
> > > > > > > +    if (!priv)
> > > > > > > +        return -ENOMEM;
> > > > > > > +
> > > > > > > +    priv->urb = usb_alloc_urb(0, GFP_KERNEL);
> > > > > > > +    if (!priv->urb)
> > > > > > > +        return -ENOMEM;
> > > > > > > +    mutex_init(&priv->mutex);
> > > > > > > +    priv->status = -ETIMEDOUT;
> > > > > > > +    init_completion(&priv->completion);
> > > > > > > +
> > > > > > > +    hwmon_dev =
> > > > > > > +        devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
> > > > > > > +                         &powerz_chip_info, NULL);
> > > > > > > +    usb_set_intfdata(intf, priv);
> > > > > > > +
> > > > > > > +    return PTR_ERR_OR_ZERO(hwmon_dev);
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > If 'hwmon_dev' is an PTR_ERR, priv->urb leaks.
> > > > > 
> > > > > Good catch, thanks!
> > > > > 
> > > > > 
> > > > > Guenter,
> > > > > 
> > > > > it seems the new hwmon-next with this driver has not yet been pushed to
> > > > > git.kernel.org, so I can't generate the Fixes tag.
> > > > > 
> > > > 
> > > > Rule is that I must not push anything into linux-next until
> > > > after v6.6-rc1 has been released.
> > > > 
> > > > > Can you modify the commit to also contain the changes below?
> > > > > Or let me know if you prefer something else.
> > > > > 
> > > > 
> > > > I'll update the patch and make the change.
> > > 
> > > Hi,
> > > While you are at it, you can make the driver detect the earlier model KM002C:
> > > 
> > 
> > Please send a separate patch to do that.
> 
> That would be easier if I could see a git repository with the powerz driver
> in it. Looking at:
>    https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/
> 
> or is there another url to use?

As mentioned by Guenter above this can only be pushed after 6.6-rc1 is
released which should be next weekend.

So let's wait until then. If you want I can take care of submitting the
KM002C patch when it's time.

Thanks for your testing!


Thomas
