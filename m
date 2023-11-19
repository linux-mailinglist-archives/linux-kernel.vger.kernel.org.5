Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB6D7F0402
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKSCYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:24:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D4E0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:24:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F09C433C7;
        Sun, 19 Nov 2023 02:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700360667;
        bh=A2sG4uv4+t+pd/QTCq6/w/UMh/HCjsCsXOA1t1utJSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q+vryw9990zzwBqHZgv79fhAJVTNX1wE0d3+ewk51TTAkW8JAw74nhzfFPp1cY/tW
         YI4qGgTOYknTa3PShs1j1tsOgYHi7zsOJTdOzTM8twiyPVITMDj8sc4MVb2z5nJAPW
         gm5NlwZjk7mqdE9kRxgNgomJLbu6LENSeYOgycntSLuaPCQTcMB1FWZ2tVnkSAC6Ye
         8Urz1CWf+XbcRMa6zuGCwBMaaXP0GiKXPIT/1+aIFm8GPTJACR4IRbnO5uDndSX+8+
         BtjAFDs7ab6mtw/g/w0O+rg86Jw8oqpj489Nbg+YldE/k06vRuxAhBekuACzrvPb1p
         yrZJ4cVrOPhCg==
Date:   Sat, 18 Nov 2023 18:24:24 -0800
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
Subject: Re: [PATCH net-next v7 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231118182424.2d569940@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
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

On Tue, 14 Nov 2023 12:28:36 +0100 Kory Maincent wrote:
> +		ops->get_ts_info(dev, &ts_info);
> +		if (ts_info.so_timestamping &
> +		    SOF_TIMESTAMPING_HARDWARE_MASK)
> +			data->ts_layer = MAC_TIMESTAMPING;
> +
> +		if (ts_info.so_timestamping &
> +		    SOF_TIMESTAMPING_SOFTWARE_MASK)
> +			data->ts_layer = SOFTWARE_TIMESTAMPING;

How does this work? so_timestamping is capabilities, not what's
enabled now. So if driver supports SW stamping we always return
SOFTWARE?
