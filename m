Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B079D64F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjILQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjILQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:29:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC33137;
        Tue, 12 Sep 2023 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mtkXtIv3OUtKqJKyazqR9g5lFZj/7Eeun1nxUSl1J7Y=; b=iCv/aWLXL5VPfYV2B2qrnGPIYU
        zYLjJvgBWf+losG8UneSRGCfycDkV6omw+JbZCsxZMhnIWVl7euKI6oKyZQb0hhAOmnYxk4TDDpvV
        QpFasjd1rhRueVvv/EOwSVJOuAdDFqsuPyiininZK9zKDMyd2DAB92KbmPadKRI1N1sU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qg6Gi-006FSj-N1; Tue, 12 Sep 2023 18:29:40 +0200
Date:   Tue, 12 Sep 2023 18:29:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 4/7] net: ethtool: add a netlink command to
 list PHYs
Message-ID: <df90eb1f-fab1-408d-af8d-fc620f505522@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-5-maxime.chevallier@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int phy_list_fill_reply(struct sk_buff *skb,
> +			       const struct ethnl_req_info *req_base,
> +			       const struct ethnl_reply_data *reply_base)
> +{
> +	const struct phy_list_reply_data *data = PHY_LIST_REPDATA(reply_base);
> +
> +	if (nla_put_u8(skb, ETHTOOL_A_PHY_LIST_COUNT, data->n_phys))
> +		return -EMSGSIZE;
> +
> +	if (!data->n_phys)
> +		return 0;
> +
> +	if (nla_put(skb, ETHTOOL_A_PHY_LIST_INDEX, sizeof(u32) * data->n_phys,
> +		    data->phy_indices))
> +		return -EMSGSIZE;
> +

Can we add additional information here to allow mapping to what is
under /sys ? A PHY has an struct device, so has a name. So maybe that
can be included?

	Andrew
