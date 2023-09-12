Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C879C723
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjILGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjILGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:47:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC90E75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:47:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qfxB3-0007Ur-9J; Tue, 12 Sep 2023 08:47:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qfxB2-005ibv-6e; Tue, 12 Sep 2023 08:47:12 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qfxB1-005VFP-Ih; Tue, 12 Sep 2023 08:47:11 +0200
Date:   Tue, 12 Sep 2023 08:47:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add drive strength
 configuration
Message-ID: <20230912064711.GE780075@pengutronix.de>
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <ea39dded-7017-b6ba-8814-4722d65ba050@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea39dded-7017-b6ba-8814-4722d65ba050@wanadoo.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:22:21AM +0200, Christophe JAILLET wrote:
...
> > +static void ksz_drive_strength_error(struct ksz_device *dev,
> > +				     const struct ksz_drive_strength *array,
> > +				     size_t array_size, int milliamp)
> > +{
> > +	char supported_values[100];
> > +	size_t remaining_size;
> > +	int added_len;
> > +	char *ptr;
> > +	int i;
> > +
> > +	remaining_size = sizeof(supported_values);
> > +	ptr = supported_values;
> > +
> > +	for (i = 0; i < array_size; i++) {
> > +		added_len = snprintf(ptr, remaining_size,
> > +				     i == 0 ? "%d" : ", %d", array[i].milliamp);
> > +
> > +		if (added_len < 0 || added_len >= remaining_size)
> 
> Nit: snprintf() does not return negatives value.

thx! will fix it

...
> > +static int ksz_parse_drive_strength(struct ksz_device *dev)
> > +{
> > +	struct ksz_driver_strength_prop of_props[] = {
> > +		[KSZ_DRIVER_STRENGTH_HI] = {
> > +			.name = "microchip,hi-drive-strength-microamp",
> > +			.offset = SW_HI_SPEED_DRIVE_STRENGTH_S,
> > +			.value = -1
> > +		},
> > +		[KSZ_DRIVER_STRENGTH_LO] = {
> > +			.name = "microchip,lo-drive-strength-microamp",
> > +			.offset = SW_LO_SPEED_DRIVE_STRENGTH_S,
> > +			.value = -1
> > +		},
> > +		[KSZ_DRIVER_STRENGTH_IO] = {
> > +			.name = "microchip,io-drive-strength-microamp",
> > +			.offset = 0, /* don't care */
> > +			.value = -1
> > +		},
> > +	};
> > +	struct device_node *np = dev->dev->of_node;
> > +	bool found = false;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(of_props); i++) {
> > +		ret = of_property_read_u32(np, of_props[i].name,
> > +					   &of_props[i].value);
> > +		if (ret && ret != -EINVAL)
> > +			dev_warn(dev->dev, "Failed to read %s\n",
> > +				 of_props[i].name);
> > +		if (ret)
> > +			continue;
> > +
> > +		found = true;
> 
> Nit: break?

No, we may have more then one property.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
