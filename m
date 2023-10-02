Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1B7B5958
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbjJBRUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjJBRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:20:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F0B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:20:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21855C433C7;
        Mon,  2 Oct 2023 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696267211;
        bh=SLgvctAoGEpa0Dcyn2+NQ5w/1PZ3Zu/4iXSrOVqEPCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnDzPwntJSzRxoK+QbW0s2Oo3Mrul/EyxvpchFeubFgW8ihyytBxTiqRDMhntzNGX
         fvGN1EcFvonBwEORXT6RpZR3RoczTVwYmHEdLdmy0MNerqDxXZPHfseB/vjCAPmHJI
         Asg3y5/ftypnvJ80OB3drCP4pZe2XMkCz3017NuSCBxXUoXINvhhkJEDFfszc38qf0
         4xLja3cdx84i9zdaznQZsDBY5x+rnKmHokyEDfIrSydyzUPmx84oaLdBFjWNgxDJDB
         qJof9G0qAE/VJeegTs61SLsbQm5qUn2ZmgaYgzD3/5zxdWWAuJA+hyxYZxvAIaEo0H
         Es52BPm5mH/mQ==
Date:   Mon, 2 Oct 2023 19:20:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 03/15] phy: ethernet: add configuration
 interface for copper backplane Ethernet PHYs
Message-ID: <20231002172005.GC92317@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-4-vladimir.oltean@nxp.com>
 <20230928190536.GO24230@kernel.org>
 <20231002131110.4kjkinc2xyxtdwbv@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002131110.4kjkinc2xyxtdwbv@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:11:10PM +0300, Vladimir Oltean wrote:
> Hi Simon,
> 
> On Thu, Sep 28, 2023 at 09:05:36PM +0200, Simon Horman wrote:
> > On Sat, Sep 23, 2023 at 04:48:52PM +0300, Vladimir Oltean wrote:
> > 
> > ...
> > 
> > > +/**
> > > + * coef_update_opposite - return the opposite of one C72 coefficient update
> > > + *			  request
> > > + *
> > > + * @update:	original coefficient update
> > > + *
> > > + * Helper to transform the update request of one equalization tap into a
> > > + * request of the same tap in the opposite direction. May be used by C72
> > > + * phy remote TX link training algorithms.
> > > + */
> > > +static inline enum coef_update coef_update_opposite(enum coef_update update)
> > 
> > Hi Vladimir,
> > 
> > another nit from me.
> > 
> > Please put the inline keyword first.
> > Likewise elsewhere in this patch.
> > 
> > Tooling, including gcc-13 with W=1, complains about this.
> 
> Thanks for pointing this out. I guess you are talking about the c72_coef_update_print()
> function, whose prototype is mistakenly "static void inline" instead of
> "static inline void". I cannot find the problem with the quoted coef_update_opposite().

Yes, you are right.
Sorry for my error.

