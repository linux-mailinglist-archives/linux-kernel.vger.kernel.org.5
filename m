Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A17795E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjHKRK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjHKRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:10:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34B35BB;
        Fri, 11 Aug 2023 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=xOLoqjxqXJGEJKgvL6baV/KdAjhnJWawjg5bJQCGfJA=; b=uX45goiuCmbmGHwtTqGkfA1Jma
        K7ivZYJCl1+3LhvfO0bwkhC8ZesmNFFj3sgSAZe5PGZ9H8n4aeq6NuJ4Dd7tnzlswiiFNSk9bX+zJ
        dpnLTwzkvxcNjrYNQeSfXhYCnMk7PDqRrcDdNgzi6wHS+DJK0KNXvOSEs+JU1Jpoltjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUVeH-003pUR-Qc; Fri, 11 Aug 2023 19:10:05 +0200
Date:   Fri, 11 Aug 2023 19:10:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v1 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <61f88d08-b741-48d0-90cb-9554907a9dec@lunn.ch>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define VEND1_MACSEC_BASE		0x9000
> +
> +#define MACSEC_CFG			0x0000
> +#define MACSEC_CFG_BYPASS		BIT(1)
> +#define MACSEC_CFG_S0I			BIT(0)
> +
> +#define MACSEC_TPNET			0x0044

> +static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg, u32 val)
> +{
> +	reg = reg / 2;

That is a bit odd. How does the data sheet describe these
registers. e.g. MACSEC_TPNET. Does it say 0x9022 and 0x9023?  It seems
it would be easy to mix this up and end up accessing 0x9011 and
0x9012.

	   Andrew
