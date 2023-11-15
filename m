Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4B7EC6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbjKOPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbjKOPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:07:27 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65605125;
        Wed, 15 Nov 2023 07:07:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12BBC24000C;
        Wed, 15 Nov 2023 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700060840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dy5Pt08X+zZERsZIfegEmYR9OttXODBuhXhRa0MCI8=;
        b=jcZbQDDDhYGFHk72VXnxdjYiNDUyrCQ/WJb2qldiqupZ+jnENFi6d7pXZXPO7zaOXqZN3n
        Z4UOhaIhkVC0nXMh7vH5oTL0/A06nc1Txuz7OmqMXjFECAuutFDIXTdSMJnAfYB8UnmMZe
        ttvMHMAJWf0cvaeB8X0L6KngKx0ZRIaZk9xXtWdkDQfUBJhitM4g2/Jbs8COQHx07UPjoo
        xfezyffYVPzr6Mtk1f7i/r+PEdAxk8EAWmkanywsqEyVwyx3fvhrbNXW76JSBg6B4Z+dM6
        nC9XZV4NrBVjciM+ew12qhG8KmvR/dsxMEt7PvLivSOyDLVDu/zKCnN3L15jSA==
Date:   Wed, 15 Nov 2023 16:07:32 +0100 (CET)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Wojciech Drewek <wojciech.drewek@intel.com>
cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
In-Reply-To: <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
Message-ID: <d52d766f-11a5-494a-63cc-cbffd2945069@bootlin.com>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com> <20231114105600.1012056-4-romain.gantois@bootlin.com> <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023, Wojciech Drewek wrote:
...
> > +static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
> > +				       u16 vid)
> > +{
> > +	struct ipqess_port *port = netdev_priv(dev);
> > +	struct switchdev_obj_port_vlan vlan = {
> > +		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
> > +		.vid = vid,
> > +		/* This API only allows programming tagged, non-PVID VIDs */
> > +		.flags = 0,
> > +	};
> > +	struct netlink_ext_ack extack = {0};
> > +	int ret;
> > +
> > +	/* User port... */
> > +	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
> > +	if (ret) {
> > +		if (extack._msg)
> > +			netdev_err(dev, "%s\n", extack._msg);
> > +		return ret;
> > +	}
> > +
> > +	/* And CPU port... */
> > +	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
> > +	if (ret) {
> 
> Should we delete vlan from user port if this fails?
I'll have to look into how and when this API is called in more detail but I 
think this would indeed make sense.

> > +
> > +	/* Flush the FDB table */
> > +	qca8k_fdb_flush(priv);
> > +
> > +	if (ret < 0)
> > +		goto devlink_free;
> > +
> > +	/* set Port0 status */
> > +	reg  = QCA8K_PORT_STATUS_LINK_AUTO;
> > +	reg |= QCA8K_PORT_STATUS_DUPLEX;
> > +	reg |= QCA8K_PORT_STATUS_SPEED_1000;
> > +	reg |= QCA8K_PORT_STATUS_RXFLOW;
> > +	reg |= QCA8K_PORT_STATUS_TXFLOW;
> > +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> > +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(0), reg);
> > +	sw->port0_enabled = true;
> > +
> > +	return 0;
> > +
> > +devlink_free:
> 
> Why is it called devlink_free, I don't see any connection to devlink.
I think this is leftover from a previous version of this function, where it 
interacted with devlink. I'll rename it to error.

Best,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
