Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E67F1BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjKTSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjKTSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:00:25 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40E92;
        Mon, 20 Nov 2023 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5wD7wBF+lHKdF+Dqen+lnC7hkw+eQyJUlyzbsg0+08c=; b=hjw7EmvbLqLK70QVQXYoHYyWgE
        RaWMzEwXzQL+xor+owvdn5Wjz6Y5h8Epeo4tVEyFU0JK/NbxjR7oNneI5ZpBkBr4sh33W1orqVd2M
        qpzH1sFnaWwBCtj6mv06ydHv1PZiHRm2u8s/SmRynOvHJesAIZyNGXRKzx5zDli7KgL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r58Z1-000g3L-Tr; Mon, 20 Nov 2023 19:00:03 +0100
Date:   Mon, 20 Nov 2023 19:00:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
 <20231120111008.GC590719@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120111008.GC590719@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >  struct pse_control_config {
> > > >  	enum ethtool_podl_pse_admin_state podl_admin_control;
> > > > +	enum ethtool_pse_admin_state admin_control;  
> > > 
> > > When i look at this, it seems to me admin_control should be generic
> > > across all schemes which put power down the cable, and
> > > podl_admin_control is specific to how PoDL puts power down the cable.
> > >
> > > Since you appear to be adding support for a second way to put power
> > > down the cable, i would expect something like poe_admin_control being
> > > added here. But maybe that is in a later patch?
> > 
> > No as said above admin_control is for PoE and podl_admin_control is for PoDL.
> > Maybe you prefer to use poe_admin_control, and add poe prefix in the poe
> > variables. It will differ a bit from the IEEE standard naming but I agreed that
> > it would be more understandable in the development part.
> 
> Official name for "PoE" is "Power via Media Dependent Interface". PoE is
> not used in the IEEE 802.3-2018. Using names not used in the specification,
> make development even harder :)
> Especially since there are even more marketing names (names not used in the
> specification) for different PoE variants:
> - 802.3af (802.3at Type 1), PoE
> - 802.3at Type 2, PoE+
> - 802.3bt Type 3, 4PPoE or PoE++
> - 802.3bt Type 4, 4PPoE or PoE++

From the 2018 standard:

  1.4.407 Power Sourcing Equipment (PSE): A DTE or midspan device that
  provides the power to a single link section. PSEs are defined for
  use with two different types of balanced twisted-pair PHYs. When
  used with 2 or 4 pair balanced twisted-pair (BASE-T) PHYs, (see IEEE
  Std 802.3, Clause 33), DTE powering is intended to provide a single
  10BASE-T, 100BASE-TX, or 1000BASE-T device with a unified interface
  for both the data it requires and the power to process these
  data. When used with single balanced twisted-pair (BASE-T1) PHYs
  (see IEEE Std 802.3, Clause 104), DTE powering is intended to
  provide a single 100BASE-T1 or 1000BASE-T1 device with a unified
  interface for both the data it requires and the power to process
  these data. A PSE used with balanced single twisted-pair PHYs is
  also referred to as a PoDL PSE.

So it seems like, anything not PoDL PSE does not have a name :-(

However, everything not PoDL PSE seems to be clause 33. So how about:

	enum ethtool_podl_pse_admin_state podl_admin_control;
	enum ethtool_c33_pse_admin_state c33_admin_control;  

At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
are visible to userspace, but if we don't have a better name, maybe we
have to use c33 in userspace as well.

I do think naming like this makes it clear we are talking about two
parallel technologies, not a generic layer and then extensions for
podl.

What do you think?

	Andrew
