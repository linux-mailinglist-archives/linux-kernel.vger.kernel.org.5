Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DDA7CACB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjJPO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjJPO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:59:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714FD9;
        Mon, 16 Oct 2023 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gFkyCE/j/0e60Ku5yaM3jpzV/F/AliraLulOb+V5xGM=; b=0IU62ziG5rmbcHYvQNBXR4+5w3
        eO35Slox2MlPmqT4idJQZEKEIcbLe5yENIBmvkueQAijLh/NvKWhyynjLi8yh+bwqi1bJ+r1R5teh
        InQcEAqCY2vKKkV+KtnEMrQLxlyJB6Fwn0l2XT0PsDNrmRdQzPGJJUseK8M5MIXJyXzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qsP40-002Lxl-PK; Mon, 16 Oct 2023 16:59:24 +0200
Date:   Mon, 16 Oct 2023 16:59:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/9] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <18c20ed3-c117-4124-af3c-33df562b7f02@lunn.ch>
References: <20231016141256.2011861-1-o.rempel@pengutronix.de>
 <20231016141256.2011861-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016141256.2011861-5-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int ksz9477_set_wol(struct ksz_device *dev, int port,
> +		    struct ethtool_wolinfo *wol)
> +{
> +	u8 pme_conf, pme_ctrl = 0;
> +	int ret;
> +
> +	if (wol->wolopts & ~WAKE_PHY)
> +		return -EINVAL;

EOPNOTSUPP might be better here. I'm assuming there is no other way
WoL can be supported, since this is a combined MAC/PHY device. 

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
