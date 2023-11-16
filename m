Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB27EE986
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbjKPWyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKPWyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:54:14 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC375131;
        Thu, 16 Nov 2023 14:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=AB/zOObnjmn6/qxfJ4axAvR6RytRyEYQfSsVYOf8oNs=; b=gjgZDIObtC9FIFb+VX0j7YnCoa
        QNvxS3QscbVJIPn2MhcRk7ms12nzkAJWjWIZ+DCbFToa6JO89EQD2VNciFMWoHb4+0JK20v3spZzq
        ErXKXUj4/KaKfsYbzpHAU4dJ9t+2M0TiXo92+iKDV4GSkhaETAAD0d3l8xQRA6PsHnmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3lFL-000OWE-0U; Thu, 16 Nov 2023 23:54:03 +0100
Date:   Thu, 16 Nov 2023 23:54:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <2ff8bea5-5972-4d1a-a692-34ad27b05446@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reading this patch first, so this might be a dumb question...

> +static int pd692x0_recv_msg(struct pd692x0_priv *priv,
> +			    struct pd692x0_msg *msg,
> +			    struct pd692x0_msg_content *buf)
> +{

...

> +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> +	if (buf->key)
> +		goto out;
> +
> +	msleep(10000);

That is 10 seconds, right?

> +static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
> +				struct pd692x0_msg *msg,
> +				struct pd692x0_msg_content *buf)
> +{
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	ret = pd692x0_send_msg(priv, msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_recv_msg(priv, msg, buf);

So this function takes at least 10 seconds?

> +static int pd692x0_ethtool_set_config(struct pse_controller_dev *pcdev,
> +				      unsigned long id,
> +				      struct netlink_ext_ack *extack,
> +				      const struct pse_control_config *config)
> +{

....

> +	switch (config->admin_control) {
> +	case ETHTOOL_PSE_ADMIN_STATE_ENABLED:
> +		msg.content.data[0] = 0x1;
> +		break;
> +	case ETHTOOL_PSE_ADMIN_STATE_DISABLED:
> +		msg.content.data[0] = 0x0;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	msg.content.sub[2] = id;
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);

So this is also 10 seconds? 

Given its name, it looks like this is called via ethtool? Is the
ethtool core holding RTNL? It is generally considered bad to hold RTNL for
that long.

     Andrew
