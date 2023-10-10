Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D487BF5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442866AbjJJIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442859AbjJJIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:32:05 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF938A4;
        Tue, 10 Oct 2023 01:31:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3529EE000B;
        Tue, 10 Oct 2023 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696926716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmxIDRlRKTNn5lgoNqp7quWga8LZsXnCoghtnU8fKPg=;
        b=jUivcLpBjmtx/6HvttOXSXtzxe7OAlZC52pvAwhhXFagP++NaZu7bvkuOFZwknmyipA52K
        7IgKerlZZkISbH7PAJtToyjScRjCZEtHs5lD6kPBSXK5eEEeJvjKFTE1JggP+uLnDvEYB6
        ++snL8erlpiMR+1Di/GG/gKf8+k6C1+B0yv8HB0wnic7oskAv8BU4tdhlD1LyX4ppni94E
        LKAzn+fwEUphZ9W6hPk2A+VNpKH2AVs80WU125ngEX7zyTH95MesbwtdKlrvi6IyOUPXrh
        kThRLv+288++4ehRKfv7HSc35iuJ9ozMsec+tWoN6DVj6TVJAIFVXYnm7i5xGQ==
Date:   Tue, 10 Oct 2023 10:31:50 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 15/16] net ethtool: net: Let the active time
 stamping layer be selectable
Message-ID: <20231010103150.4f4bc187@kmaincent-XPS-13-7390>
In-Reply-To: <ac520b3b-bf70-4643-a259-83e91dd330a6@broadcom.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-16-kory.maincent@bootlin.com>
        <ac520b3b-bf70-4643-a259-83e91dd330a6@broadcom.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 14:28:38 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> > +static int ethnl_set_ts_validate(struct ethnl_req_info *req_info,
> > +				 struct genl_info *info)
> > +{
> > +	struct nlattr **tb = info->attrs;
> > +	const struct net_device_ops *ops = req_info->dev->netdev_ops;
> > +
> > +	if (!tb[ETHTOOL_A_TS_LAYER])
> > +		return 0;
> > +
> > +	if (!ops->ndo_hwtstamp_set)
> > +		return -EOPNOTSUPP;  
> 
> I would check for this first, in all likelihood this is what most 
> drivers currently do not support, no need to event de-reference the 
> array of attributes.

Indeed seems more logical.

> > +static int ethnl_set_ts(struct ethnl_req_info *req_info, struct genl_info
> > *info) +{
> > +	struct net_device *dev = req_info->dev;
> > +	const struct ethtool_ops *ops = dev->ethtool_ops;
> > +	struct kernel_hwtstamp_config config = {0};
> > +	struct nlattr **tb = info->attrs;
> > +	bool mod = false;
> > +	u32 ts_layer;
> > +	int ret;
> > +
> > +	ts_layer = dev->ts_layer;

> > +
> > +	if (ts_layer & NETDEV_TIMESTAMPING && !ops->get_ts_info) {
> > +		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_TS_LAYER],
> > +				    "this device cannot support
> > timestamping");  
> 
> Maybe expand the extended ack with "this devices does not support 
> MAC-based timestamping"

Ok.

> > +	/* Disable time stamping in the current layer. */
> > +	if (netif_device_present(dev) &&
> > +	    dev->ts_layer & (PHYLIB_TIMESTAMPING | NETDEV_TIMESTAMPING)) {
> > +		ret = dev_set_hwtstamp_phylib(dev, &config, info->extack);
> >  
> 
> Can we still land in this function even if no changes to the 
> timestamping configuration has been made? 

We land in this function every time we change the timestamp from a valid
one.  

> If so, would suggest first 
> getting the current configuration and compare it with the user-supplied 
> configuration if there are no changes, return.

It is already done at the beginning of the function:
> > +	ethnl_update_u32(&ts_layer, tb[ETHTOOL_A_TS_LAYER], &mod);
> > +
> > +	if (!mod)
> > +		return 0;
