Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BAE763BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjGZP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGZP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:56:23 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079E100;
        Wed, 26 Jul 2023 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7UDgfaBKbDx6HXbNdob8rAF7nTMRLH3Ebyzm12lV4pQ=; b=nyD1WleQwZllG/YbayTavTKoHL
        vWq30msw3K3zW2SynqSS0cEvRP4X5NrtrKIlZtOhkI9n8m84bt/U68ob57/c+OffL0asV1YdYzXBP
        EvbKartx1Y9G7J9lSG/tuNUaE6eBZJicKxZhl2AqoS10NjDbDnxw1n3wEpN/+kfDv3Lg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qOgrs-002NEQ-8B; Wed, 26 Jul 2023 17:56:04 +0200
Date:   Wed, 26 Jul 2023 17:56:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <c69866c3-aa90-45bc-8dd6-556f474bb693@lunn.ch>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-4-nick.hawkins@hpe.com>
 <57d882ed-82e5-4584-8126-ca2007064126@lunn.ch>
 <DM4PR84MB192785EC6F2B8A76FF9E5E3F8803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <4c19532d-a909-4ca6-a0a7-d4cd9cc828b0@lunn.ch>
 <DM4PR84MB19274F3AA411D4CAE7EE84D88803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB19274F3AA411D4CAE7EE84D88803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:35:48PM +0000, Hawkins, Nick wrote:
> > > > Do both ports get the sane MAC address?
> > >
> > > No they do not. The first one will get the MAC address, the second
> > > will be an external phy we are managing via the MDIO path.
> 
> > Then please put the mac-address property in the correct place, inside
> port@0.
> 
> Greetings Andrew,
> 
> I was mistaken, the Mac address belongs with UMAC,
> not the phys. The reason ports are listed here is
> because having two separate phy-handles
> in one node is not allowed. The layout of the
> hardware inside the GXP is unconventional.

It is not that unconventional. See

Documentation/devicetree/bindings/net/marvell-orion-net.txt

This is an Ethernet block, with two MACs inside it. Each MAC gets its
own subblock containing MAC specific properties like the MAC address,
phy-handle, etc.

	    Andrew
