Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B777672EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjG1RIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjG1RIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:08:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7804208;
        Fri, 28 Jul 2023 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qSUnnCZQMRkMrm5j848oE/p8R8PLMnPTw/F+iTVJ2Gc=; b=l1IdxACZogE3IHjDAXh2Q6RSi8
        0UZlCAHyzL6VuBAIFg6RwshYfN/7oR1JkKrg5m1hpJ6KaHFR0PEaX7m9yw+Li6qYqU++slgxErj1U
        fWfAmbUNmnyLlxny38j68C51wgD8kOFjQietbGMu+FQfE6OJlt3FvJ9Sl0wNmmuncpYQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qPQwC-002Y4t-Lg; Fri, 28 Jul 2023 19:07:36 +0200
Date:   Fri, 28 Jul 2023 19:07:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <7f21c1d3-331d-4bff-8a4c-f6e235a3dd6a@lunn.ch>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch>
 <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
 <CADQ0-X_pXKvUxLW23vEyH=9aZ6iLA2jOKz8QX6aqwQmxFcPY8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ0-X_pXKvUxLW23vEyH=9aZ6iLA2jOKz8QX6aqwQmxFcPY8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:35:00PM +0900, Masahisa Kojima wrote:
> On Fri, 28 Jul 2023 at 20:43, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Jul 28, 2023 at 10:41:40AM +0200, Andrew Lunn wrote:
> > > > Wouldn't this break SynQuacers booting with firmware that lacks a
> > > > network driver? (I.e., u-boot?)
> >
> > > > I am not sure why, but quite some effort has gone into porting u-boot
> > > > to this SoC as well.
> >
> > > Agreed, Rather than PHY_INTERFACE_MODE_NA, please use the correct
> > > value.
> >
> > Does anyone know off hand what the correct value is?  I only have access
> > to one of these in a remote test lab which makes everything more
> > painful.
> 
> "rgmii-id" is correct, configured by board level.
> The latest EDK2 firmware was already modified to use the correct value
> for DT(Thank you, Ard).
> http://snapshots.linaro.org/components/kernel/leg-96boards-developerbox-edk2/100/

Yes, anything other than rgmii-id is generally wrong. That maps to
PHY_INTERFACE_MODE_RGMII_ID.

If the firmware has been fixed, i would actually do something like:

	err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
	if (err)
		return err;

	if (of_machine_is_compatible("socionext,developer-box") &&
	    priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
	    	pr_warn(FW_WARN, "Working around broken firmware. Please upgrade your firmware");
		priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
	}

	Andrew
