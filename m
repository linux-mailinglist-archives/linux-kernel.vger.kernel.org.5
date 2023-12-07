Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67245808B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443435AbjLGOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443429AbjLGOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:54:23 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4DCAC;
        Thu,  7 Dec 2023 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=HZuWJZJT56neic9r6wbg2bseNLCneoOJMEj6j6nq8xM=; b=Kj5JYHCnocsxjpn10612FX5k82
        XXApSgMi9D34L1+NjQx1nN3zlGdK02Km1aTk/EkiYYLhdkgec/qv8lok6YMXxnHp4TtX8Gs6ewpJz
        OBOfjFGgABnc8jObbYw1cJmwhFhU67WIg9z21M19wwSNEFZENt9jo6NX4gsrVfw66a70=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rBFlQ-002K3T-Qc; Thu, 07 Dec 2023 15:54:08 +0100
Date:   Thu, 7 Dec 2023 15:54:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/16] net: mdio: Add Synopsys DW XPCS
 management interface support
Message-ID: <19ebc244-6d79-4e12-8ac4-fcf046106a07@lunn.ch>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-10-fancer.lancer@gmail.com>
 <20231205133205.3309ab91@device.home>
 <cv6oo27tqbfst3jrgtkg7bcxmeshadtzoomn2xgnzh2arz4nwy@wq5k7oygto6n>
 <15e6857a-b1d1-465a-945e-6f31edac62fb@lunn.ch>
 <jqwhgthwxfge6y4nv5mdnojqu76m4pi2mt2x6kwqiuqntcwj67@mewh42eey5ny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jqwhgthwxfge6y4nv5mdnojqu76m4pi2mt2x6kwqiuqntcwj67@mewh42eey5ny>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:35:47PM +0300, Serge Semin wrote:
> Hi Andrew
> 
> On Wed, Dec 06, 2023 at 06:01:30PM +0100, Andrew Lunn wrote:
> > > > You shouldn't use inline in C files, only in headers.
> > > 
> > > Could you please clarify why? I failed to find such requirement in the
> > > coding style doc. Moreover there are multiple examples of using the
> > > static-inline-ers in the C files in the kernel including the net/mdio
> > > subsystem.
> > 
> 
> > The compiler does a better job at deciding what to inline than we
> > humans do. If you can show the compiler is doing it wrong, then we
> > might accept them.
> 
> In general I would have agreed with you especially if the methods were
> heavier than what they are:
> static inline ptrdiff_t dw_xpcs_mmio_addr_format(int dev, int reg)
> {               
>         return FIELD_PREP(0x1f0000, dev) | FIELD_PREP(0xffff, reg);
> }               
>         
> static inline u16 dw_xpcs_mmio_addr_page(ptrdiff_t csr)
> {       
>         return FIELD_GET(0x1fff00, csr);
> }       
> 
> static inline ptrdiff_t dw_xpcs_mmio_addr_offset(ptrdiff_t csr)
> {
>         return FIELD_GET(0xff, csr);
> }
> 
> > But in general, netdev does not like inline in .C
> > file.
> 
> I see. I'll do as you say if you don't change your mind after my
> reasoning below.
> 
> > Also, nothing in MDIO is hot path, it spends a lot of time
> > waiting for a slow bus. So inline is likely to just bloat the code for
> > no gain.
> 
> I would have been absolutely with you in this matter, if we were talking
> about a normal MDIO bus. In this case the devices are accessed over
> the system IO-memory. So the bus isn't that slow.

O.K, so its not slow. But how often is it used? PHYs tend to get
polled once a second if interrupts are not used. But is the PCS also
polled at the same time? Does this optimisation make a noticeable
difference at once per second? Do you have a requirement that the
system boots very very fast, and this optimisation makes a difference
when there is heavier activity on the PCS at boot? Is the saving
noticeable, when auto-neg takes a little over 1 second.

The best way to make your case is show real world requirements and
benchmark results.

	  Andrew
