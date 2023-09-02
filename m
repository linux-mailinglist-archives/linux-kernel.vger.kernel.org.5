Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8B790A2F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjIBWaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 18:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjIBWaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 18:30:02 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112BCE0;
        Sat,  2 Sep 2023 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693693795;
        bh=g0pI4BxffPv9M2w9bwb9TOe31J4wrhkQAy/5843gIp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUQSBbHGLxKN3lpbqvWLQmBxsAqdLbP62e9HSvR0dNLfYuvOzH4PSOfzIlGqHeR/i
         FXPdM+/ogAaCklpf/4ZLO+dyjS9AzxxmTKFJQmr2z1fob2p7WwEAaIKPEcJInuA7BU
         Yu4PI2QL+TBH1fJcvH42pqDgV1vfogEiSz83Kxto=
Date:   Sun, 3 Sep 2023 00:29:55 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dgilbert@interlog.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
Message-ID: <46d3194a-af79-4076-b0a2-561d713a406e@t-8ch.de>
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
 <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-09-02 18:36:17+0200, Christophe JAILLET wrote:
> Le 02/09/2023 à 09:47, Thomas Weißschuh a écrit :
> > POWER-Z is a series of devices to monitor power characteristics of
> > USB-C connections and display those on a on-device display.
> > Some of the devices, notably KM002C and KM003C, contain an additional
> > port which exposes the measurements via USB.
> > 
> > This is a driver for this monitor port.
> > 
> > It was developed and tested with the KM003C.
> > 
> > Signed-off-by: Thomas Weißschuh <linux-9XfqOkM5JgxKQ7RDE2T8Pw@public.gmane.org>
> > ---
> 
> ...
> 
> > +static int powerz_probe(struct usb_interface *intf,
> > +			const struct usb_device_id *id)
> > +{
> > +	struct powerz_priv *priv;
> > +	struct device *hwmon_dev;
> > +	struct device *parent;
> > +
> > +	parent = &intf->dev;
> > +
> > +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->urb = usb_alloc_urb(0, GFP_KERNEL);
> > +	if (!priv->urb)
> > +		return -ENOMEM;
> > +	mutex_init(&priv->mutex);
> > +	priv->status = -ETIMEDOUT;
> > +	init_completion(&priv->completion);
> > +
> > +	hwmon_dev =
> > +	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
> > +						 &powerz_chip_info, NULL);
> > +	usb_set_intfdata(intf, priv);
> > +
> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> 
> Hi,
> 
> If 'hwmon_dev' is an PTR_ERR, priv->urb leaks.

Good catch, thanks!


Guenter,

it seems the new hwmon-next with this driver has not yet been pushed to
git.kernel.org, so I can't generate the Fixes tag.

Can you modify the commit to also contain the changes below?
Or let me know if you prefer something else.

diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
index 611d04fb28db..aad585306f80 100644
--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -233,9 +233,14 @@ static int powerz_probe(struct usb_interface *intf,
 	hwmon_dev =
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
 						 &powerz_chip_info, NULL);
+	if (IS_ERR(hwmon_dev)) {
+		usb_free_urb(priv->urb);
+		return PTR_ERR(hwmon_dev);
+	}
+
 	usb_set_intfdata(intf, priv);
 
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	return 0;
 }
 
 static void powerz_disconnect(struct usb_interface *intf)
