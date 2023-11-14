Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD897EB6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjKNTK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKNTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:10:54 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF7F4;
        Tue, 14 Nov 2023 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JNLArOzkNx8faUQdzL9sGLoJY9ZsQNr6hJmyeuSCIjs=; b=aIxpFehFBgHsJiDqKEQaZW/qA9
        ASVTxqLZ1v/IOlscBs5X7ED5dczyvRV7bg8AwSpDB/gEGCzYNtz3s2huaE0xPeMqznS8uj+rgJv+9
        xKlKeH6gkvBRL0BQZIy6pFeDjKXHeQtQFfJ793tyxkjTnF062VnJU03+19qcuY5NGf7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r2yo8-000BUO-Dm; Tue, 14 Nov 2023 20:10:44 +0100
Date:   Tue, 14 Nov 2023 20:10:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Romain Gantois <romain.gantois@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
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
Message-ID: <f6ce0c15-8b72-4568-8ba2-f0216db84ffd@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-4-romain.gantois@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void ipqess_port_stp_state_set(struct ipqess_port *port,
> +				      u8 state)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 stp_state;
> +	int err;
> +
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
> +		break;
> +	case BR_STATE_BLOCKING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
> +		break;
> +	case BR_STATE_LISTENING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
> +		break;
> +	case BR_STATE_LEARNING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
> +		break;
> +	case BR_STATE_FORWARDING:
> +	default:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
> +		break;
> +	}
> +
> +	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
> +			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);

When i compare this to qca8k_port_stp_state_set() it is 90% identical.
What differs is how you get to struct qca8k_priv *priv. What you need
to do is refactor the existing functions to separate the DSA parts out
and have a core function which takes qca8k_priv and in port. The DSA
core can then call it, and this function can call it, after extracting
qca8k_priv and index from port.

> +static int ipqess_port_enable_rt(struct ipqess_port *port,
> +				 struct phy_device *phy)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	qca8k_port_set_status(priv, port->index, 1);
> +	priv->port_enabled_map |= BIT(port->index);
> +
> +	phy_support_asym_pause(phy);
> +
> +	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
> +
> +	if (port->pl)
> +		phylink_start(port->pl);

That looks odd. You unconditionally call phy_support_asym_pause() yet
conditionally call phylink_start(). I would expect there to always be
a phylink instance.

Also, you should be telling phylink about the pause capabilities in
config->mac_capabilities. It is then phylinks problem to tell the PHY,
or the PCS driving the SFP etc about pause.


> +static int
> +ipqess_port_fdb_do_dump(const unsigned char *addr, u16 vid,
> +			bool is_static, void *data)
> +{
> +	struct ipqess_port_dump_ctx *dump = data;
> +	u32 portid = NETLINK_CB(dump->cb->skb).portid;
> +	u32 seq = dump->cb->nlh->nlmsg_seq;
> +	struct nlmsghdr *nlh;
> +	struct ndmsg *ndm;
> +
> +	if (dump->idx < dump->cb->args[2])
> +		goto skip;
> +
> +	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
> +			sizeof(*ndm), NLM_F_MULTI);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ndm = nlmsg_data(nlh);
> +	ndm->ndm_family  = AF_BRIDGE;
> +	ndm->ndm_pad1    = 0;
> +	ndm->ndm_pad2    = 0;
> +	ndm->ndm_flags   = NTF_SELF;
> +	ndm->ndm_type    = 0;
> +	ndm->ndm_ifindex = dump->dev->ifindex;
> +	ndm->ndm_state   = is_static ? NUD_NOARP : NUD_REACHABLE;
> +
> +	if (nla_put(dump->skb, NDA_LLADDR, ETH_ALEN, addr))
> +		goto nla_put_failure;
> +
> +	if (vid && nla_put_u16(dump->skb, NDA_VLAN, vid))
> +		goto nla_put_failure;
> +
> +	nlmsg_end(dump->skb, nlh);
> +
> +skip:
> +	dump->idx++;
> +	return 0;
> +
> +nla_put_failure:
> +	nlmsg_cancel(dump->skb, nlh);
> +	return -EMSGSIZE;
> +}

This looks identical to dsa_slave_port_fdb_do_dump(). Please export
and reuse it.

> +
> +static int
> +ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
> +		     struct net_device *dev, struct net_device *filter_dev,
> +		     int *idx)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	struct ipqess_port_dump_ctx dump = {
> +		.dev = dev,
> +		.skb = skb,
> +		.cb = cb,
> +		.idx = *idx,
> +	};
> +	int cnt = QCA8K_NUM_FDB_RECORDS;
> +	struct qca8k_fdb _fdb = { 0 };
> +	bool is_static;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port->index)) {
> +		if (!_fdb.aging)
> +			break;
> +		is_static = (_fdb.aging == QCA8K_ATU_STATUS_STATIC);
> +		ret = ipqess_port_fdb_do_dump(_fdb.mac, _fdb.vid, is_static, &dump);
> +		if (ret)
> +			break;
> +	}
> +	mutex_unlock(&priv->reg_mutex);
> +
> +	*idx = dump.idx;
> +
> +	return ret;
> +}

And with a little bit of refactoring you can reuse the core of
qca8k_port_fdb_dump.

> +static void ipqess_phylink_mac_link_up(struct phylink_config *config,
> +				       struct phy_device *phydev,
> +				       unsigned int mode,
> +				       phy_interface_t interface,
> +				       int speed, int duplex,
> +				       bool tx_pause, bool rx_pause)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 reg;
> +
> +	if (phylink_autoneg_inband(mode)) {
> +		reg = QCA8K_PORT_STATUS_LINK_AUTO;
> +	} else {
> +		switch (speed) {
> +		case SPEED_10:
> +			reg = QCA8K_PORT_STATUS_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			reg = QCA8K_PORT_STATUS_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			reg = QCA8K_PORT_STATUS_SPEED_1000;
> +			break;
> +		default:
> +			reg = QCA8K_PORT_STATUS_LINK_AUTO;
> +			break;
> +		}
> +
> +		if (duplex == DUPLEX_FULL)
> +			reg |= QCA8K_PORT_STATUS_DUPLEX;
> +
> +		if (rx_pause || port->index == 0)
> +			reg |= QCA8K_PORT_STATUS_RXFLOW;
> +
> +		if (tx_pause || port->index == 0)
> +			reg |= QCA8K_PORT_STATUS_TXFLOW;
> +	}
> +
> +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> +
> +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), reg);
> +}

qca8k_phylink_mac_link_up() with some refactoring can be
reused. Please look through the driver and find other instances like
this where you can reuse more code.

     Andrew
