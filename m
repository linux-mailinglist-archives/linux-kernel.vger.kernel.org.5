Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A09878F244
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbjHaSDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbjHaSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:03:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABEE45;
        Thu, 31 Aug 2023 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693505018;
        bh=bPA4ClrlMQANXr+Freikpg2xbHc7Gg1HKd1kLS21duw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIqYDXHQL9s2/HqZbokHGNrK8ZSm9hf3CW3tJOSex7H+op1PWZIcYW6HmO9V8kLmy
         VhQsUEcS5qEm+KetAet1Zn1jthq66K7I8WGR/RJUcdBIjGhXXzE2xXCS4yHA8v7O5A
         YJi4FEghJM3jKuBKIKT0yL8YdQO2i4S5/pCbX3nA=
Date:   Thu, 31 Aug 2023 20:03:37 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add POWER-Z driver
Message-ID: <ecb91dd0-1b0e-4227-b4ab-79f85a93f43a@t-8ch.de>
References: <20230831-powerz-v2-1-5c62c53debd4@weissschuh.net>
 <ca72a21b-af05-c754-99a0-34d913edf304@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca72a21b-af05-c754-99a0-34d913edf304@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

thanks for your review!

Ack to most of your points.

> [..]

> > +
> > +#define DRIVER_NAME	"powerz"
> > +#define POWERZ_EP_CMD_OUT	0x01
> > +#define POWERZ_EP_DATA_IN	0x81
> > +
> > +struct powerz_sensor_data {
> > +	u8 _unknown_1[8];
> > +	__le32 Vbus;
> 
> CHECK: Avoid CamelCase: <Vbus>
> #160: FILE: drivers/hwmon/powerz.c:18:
> +	__le32 Vbus;
> 
> Please run your patches through checkpatch --strict.

I did. Weird that it didn't show. I'll investigate.
(And fix it)

> 
> > +	__le32 Ibus;
> > +	__le32 Vbus_avg;
> > +	__le32 Ibus_avg;
> > +	u8 _unknown_2[8];
> > +	u8 temp[2];
> > +	__le16 cc1;
> > +	__le16 cc2;
> > +	__le16 dp;
> > +	__le16 dm;
> > +	u8 _unknown_3[6];
> > +} __packed;
> > +

> [..]

> > +static int powerz_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> > +		       int channel, long *val)
> > +{
> > +	struct usb_interface *intf = to_usb_interface(dev->parent);
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> > +	struct powerz_sensor_data *data;
> > +	struct powerz_usb_ctx *ctx;
> > +
> > +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> 
> I think it would be much better to allocate ctx once as part of
> struct powerz_priv and keep it around. Sure, that means that this
> function requires a lock, but I don't see that as problem (and who
> knows how the device reacts to multiple pending usb transactions).
> 
> You'd need to allocate transfer_buffer separately because it needs to be
> dma aligned, but that should not be a problem either.

What is your opinion on making the transfer buffer the first member of
struct powerz_priv? It would simplify the code and still provide a
DMA-capable buffer.

> [..]

> > +static int powerz_probe(struct usb_interface *intf, const struct usb_device_id *id)
> > +{
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> > +	struct powerz_priv *priv;
> > +	struct device *parent;
> > +	const char *name;
> > +	int ret;
> > +
> > +	parent = &intf->dev;
> > +
> > +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	name = devm_hwmon_sanitize_name(parent, udev->product ?: DRIVER_NAME);
> 
> Why not just use DRIVER_NAME ? This would be much more consistent.

I liked the more detailed name better.
But if you prefer otherwise I'll simplify it.

