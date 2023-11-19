Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35307F0417
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjKSCek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSCej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:34:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E538DD5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:34:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A473C433C7;
        Sun, 19 Nov 2023 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700361275;
        bh=FAVgax6ky7lNhr5MHl33fP4AwGQUXVpEfHK1wlpTUv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bEg8ibbjBFn2NnXoJ9zd8AE9hC41myx+Lc5TVW79GVE8GWEoDk+Mkh2tKgqBV/9of
         DxFA87szlMVAGuvc5SuDhmmPiHlpHJUI8z/Hhak2LCzJYdTWf7ViLEJv2ffiszJEN+
         tOqWDPWXqLVDYAd8i11Ui0fGthRbr5VUVSHCNzyxgmx+cbpmlJKhEQQ8SnAUP+PWGt
         da1O3tVnKH5Uh7H+bDhYhkNHRkUXu0WC4zrjg790wt1Wf7nnllmOWXXiwLfiu/j0Mu
         +KanU8++AcTWORufVzxrbj9gy2jH3MuxTi2D6cHGJSNrdAXMPiu56NDRC994JRI8mC
         bkvbjqP+SSuDw==
Date:   Sat, 18 Nov 2023 18:34:33 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231118183433.30ca1d1a@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 12:28:43 +0100 Kory Maincent wrote:
> +	if (!tb[ETHTOOL_A_TS_LAYER])
> +		return 0;

GENL_REQ_ATTR_CHECK(), not sure why anyone would issue this command
without any useful attr.

> +	/* Disable time stamping in the current layer. */
> +	if (netif_device_present(dev) &&
> +	    (dev->ts_layer == PHY_TIMESTAMPING ||
> +	    dev->ts_layer == MAC_TIMESTAMPING)) {
> +		ret = dev_set_hwtstamp_phylib(dev, &config, info->extack);
> +		if (ret < 0)
> +			return ret;

So you only support PHYLIB?

The semantics need to be better documented :(
