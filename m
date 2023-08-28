Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9599478ADC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjH1Kuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjH1Kuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:50:32 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C03E43
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:50:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38--iSWyxygOI6g1c9-2UbRyw-1; Mon, 28 Aug 2023 06:43:37 -0400
X-MC-Unique: -iSWyxygOI6g1c9-2UbRyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A8828D40A3;
        Mon, 28 Aug 2023 10:43:37 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41855568FF;
        Mon, 28 Aug 2023 10:43:35 +0000 (UTC)
Date:   Mon, 28 Aug 2023 12:43:34 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sebastian.tobuschat@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <ZOx6Vu7MG9Y4Uv6y@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog>
 <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-25, 15:29:30 +0200, Andrew Lunn wrote:
> On Fri, Aug 25, 2023 at 02:52:57PM +0200, Sabrina Dubroca wrote:
> > 2023-08-24, 12:16:13 +0300, Radu Pirea (NXP OSS) wrote:
> > > +static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg, u32 val)
> > > +{
> > > +	WARN_ON_ONCE(reg % 4);
> > > +
> > > +	reg = reg / 2;
> > > +	phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > > +		      VEND1_MACSEC_BASE + reg, val);
> > > +	phy_write_mmd(phydev, MDIO_MMD_VEND2,
> > > +		      VEND1_MACSEC_BASE + reg + 1, val >> 16);
> > 
> > Can these calls fail? ie, do you need to handle errors like in
> > nxp_c45_macsec_read (and then in callers of nxp_c45_macsec_write)?
> 
> Access to PHY devices can fail, but if it does, such failures are
> generally fatal and there is no real recovery, also the next read/
> write is also likely to fail. So we do recommend checking return codes
> and just return the error up the stack. That failure might get trapped
> up the stack, and turned into a phy_error() call which will disable
> the PHY.

Ok, thanks. A lot of the calls to nxp_c45_macsec_write come from the
core macsec code (via mdo_*), so at least this part of the stack isn't
going to catch them. Either these errors can be caught directly in the
driver, or we'll have to ignore them (once we return from the driver
to the macsec core, we can't know if the error was fatal so we have to
assume it's not).  And phy_error's doc says it can't be called under
phydev->lock, which we're holding in all those mdo_* functions (called
from macsec_offload()).

-- 
Sabrina

