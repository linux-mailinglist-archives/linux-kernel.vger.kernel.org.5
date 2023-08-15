Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAF77C954
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjHOIYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjHOIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32914127
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B529163E0D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A76AC433C8;
        Tue, 15 Aug 2023 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692087887;
        bh=yrszbqjTM+0WGVAMjT8K+IaCN7rxeNZNHl4UW/CvJT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gpe6BuGve3J4AFU2IiHU/6XMwVSt1CtRJa7RprHB8Jq1YfxN/63exTNKnuWoSHrU6
         DLfkFGYNDt7lFGRdfNj2UIEu/MtE2LE20Wd5D9YfloXjqQ4JuwUhgtPctOlnXEZF24
         XqRAYEnOTuxYEiyBPu2wOXzuTk1+MAJQPPxNxg6o26UQm8B1KbOtUQ9Om0SOMHBX+S
         xG06llXCFRKqUxetESdbtXKrLC+Z0UeSt+VeLX7SRCfj/oClNDu4QoIqk0pHxd7sH6
         3Ib+oEKijLG8dH6lwm7ek7V+X1uy9WDWPJZMLf99PfclyY/EYoEy9Q6KBU+kBcum1V
         fv7r2f2fOPu+w==
Date:   Tue, 15 Aug 2023 10:24:43 +0200
From:   Simon Horman <horms@kernel.org>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Message-ID: <ZNs2Sz6iBMnxshKO@vergenet.net>
References: <20230814141739.25552-1-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814141739.25552-1-josua@solid-run.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:17:39PM +0200, Josua Mayer wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.
> 
> The 100G speed is irrelevant because it would require multiple fibers /
> multiple SFP28 modules combined under one netdev.
> sfp-bus.c only handles a single module per netdev, so only 25Gbps modes
> are selected.
> 
> sfp_parse_support already handles SFF8024_ECC_100GBASE_SR4_25GBASE_SR
> with compatible properties, however that entry is a contradiction in
> itself since with SFP(28) 100GBASE_SR4 is impossible - that would likely
> be a mode for qsfp modules only.
> 
> Add a case for SFF8024_ECC_100G_25GAUI_C2M_AOC selecting 25gbase-r
> interface mode and 25000baseSR link mode.
> Also enforce SFP28 bitrate limits on the values read from sfp eeprom as
> requested by Russell King.
> 
> Tested with fs.com S28-AO02 AOC SFP28 module.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> V1 -> V2: added separate case SFF8024_ECC_100G_25GAUI_C2M_AOC
> V1 -> V2: added bitrate check for eeprom values
> 
>  drivers/net/phy/sfp-bus.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index e8dd47bffe43..a4b0bb50e2eb 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -258,6 +258,17 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
>  	switch (id->base.extended_cc) {
>  	case SFF8024_ECC_UNSPEC:
>  		break;
> +	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
> +		if (br_min <= 28000 && br_max >= 25000) {
> +			/* 25GBASE-R, possibly with FEC */
> +			__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
> +			/*
> +			 * There is currently no link mode for 25000base
> +			 * with unspecified range, reuse SR.
> +			 */

Hi Josua,

a minor nit from my side: : if you have to re-spin for some other reason,
the multi-line comment style for Networking code is:

	/* This is
	 * something.
	 */

> +			phylink_set(modes, 25000baseSR_Full);
> +		}
> +		break;
>  	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
>  		phylink_set(modes, 100000baseSR4_Full);
>  		phylink_set(modes, 25000baseSR_Full);
> -- 
> 2.35.3
> 
> 
