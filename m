Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630B752F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjGNCuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGNCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315730C4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B0AC61793
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE102C433C7;
        Fri, 14 Jul 2023 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689303040;
        bh=2Op+uXao1BbAqsYxyDGL7x1AspWkNmMOL52H6O8XlrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgXytrA5xctbXjnmKoyAio6gnsSaqZ1ilmeF5UOrm8ZyS9SJkBWB0OD73V8oBfKS4
         LT7K79XTgwvCsSvTJ7qwcYZZ1c88OjOoPLZSNNymE9wd7QkucyWkXXbgePE/QeqmU0
         4hy3IJRRyBWKSMXsYQ+cYv04mk0+K36hK1VHeHFNHRo9npBQEUr+SepA46756m3jja
         RT9l2c9Rt0hmRLjxFzwIH4nviMnbqAtyzpSahOI53kLaCk4/OSeCkBbcnuLPNY5jvj
         11G9hol5O4Tco7KHtx2J3pGiYmLRhZ0v/jSME55360ZSAcklyWRVJE7cs4dquGpsod
         /hrVlu4Zz6yRg==
Date:   Thu, 13 Jul 2023 19:50:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 net-next 10/10] net: remove phy_has_hwtstamp() ->
 phy_mii_ioctl() decision from converted drivers
Message-ID: <20230713195037.34444454@kernel.org>
In-Reply-To: <20230713121907.3249291-11-vladimir.oltean@nxp.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
        <20230713121907.3249291-11-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 15:19:07 +0300 Vladimir Oltean wrote:
>  /**
>   * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
>   *
> @@ -26,6 +31,7 @@ struct kernel_hwtstamp_config {
>  	int rx_filter;
>  	struct ifreq *ifr;
>  	bool copied_to_user;
> +	enum hwtstamp_source source;
>  };

source is missing from the kdoc

phy_mii_ioctl() can be in a module so we need a stub / indirection
-- 
pw-bot: cr
