Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EF7EC515
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjKOOYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbjKOOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:24:32 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D636E7;
        Wed, 15 Nov 2023 06:24:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D90C1BF203;
        Wed, 15 Nov 2023 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700058264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o95CTeV4om7p3zXCFThJzE74VGhCEm09N2PyQwbv0X8=;
        b=Bn2RZwDOGrLsOcdbw80S3FjkZg7GLKrKK763aTT81E0zWNQCwiDk1Q6dKKi95CYXBXbMWe
        hQ0FICnfz/3E8jN94UUhgQBV6jlXnQCt5+Y4oH2It4S/cig9DXuM3aFZzM0C+uQ0e1aSR8
        jcGsya9AKRBnGFpFHRr2NXbO2B5cOm1/mDtFR2M81jXivDAQa6/o29BjA5RVURAL2t5i+2
        bpXS+S8XMI5gceb8FbuZIbxGiOq1U+5S9R9TYuyTAO9K5EzSYxa1GFqT/VVU38ojZiHhq2
        F5TeyBWYTyBUhjQqH8TzvjmLxcCSsu0h4mq2fyYysK9/kfJM2o1bJvGab9chdw==
Date:   Wed, 15 Nov 2023 15:24:37 +0100 (CET)
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
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
In-Reply-To: <f6ce0c15-8b72-4568-8ba2-f0216db84ffd@lunn.ch>
Message-ID: <d60c1fd1-3ee1-3c15-6072-06c70f09d6d2@bootlin.com>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com> <20231114105600.1012056-4-romain.gantois@bootlin.com> <f6ce0c15-8b72-4568-8ba2-f0216db84ffd@lunn.ch>
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

On Tue, 14 Nov 2023, Andrew Lunn wrote:
...
> > +	phy_support_asym_pause(phy);
> > +
> > +	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
> > +
> > +	if (port->pl)
> > +		phylink_start(port->pl);
> 
> That looks odd. You unconditionally call phy_support_asym_pause() yet
> conditionally call phylink_start(). I would expect there to always be
> a phylink instance.
> 
> Also, you should be telling phylink about the pause capabilities in
> config->mac_capabilities. It is then phylinks problem to tell the PHY,
> or the PCS driving the SFP etc about pause.
You are correct. I probably fumbled this when splitting the calibration code.

> > +		if (tx_pause || port->index == 0)
> > +			reg |= QCA8K_PORT_STATUS_TXFLOW;
> > +	}
> > +
> > +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> > +
> > +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), reg);
> > +}
> 
> qca8k_phylink_mac_link_up() with some refactoring can be
> reused. Please look through the driver and find other instances like
> this where you can reuse more code.
I tried to be conservative with modifying qca8k-common.c when it required 
modifying qca8k-8xxx.c. But I'll factor this code more aggressively since you 
think it is preferable.

Best,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
