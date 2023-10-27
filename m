Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982FE7D8D46
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjJ0CyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0CyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:54:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE986129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:53:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80473C433C7;
        Fri, 27 Oct 2023 02:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698375238;
        bh=EyXeSNLa7tK0DV/fDsJKBnuzy0cW8YEfE0jxXnhc4Yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k89mxws/0RO+ZLD6H8KeP5mmMgdoGmsjPkWWYQfmTVQmSXwV11VtY906pAvyGUexf
         bOxqu6NuKwlxJ5a7vmMJLAMGSfLYjXGLwjD2Dw9SL1x8sTFjsfh6ZiTx+MWXOao04E
         BmOQOKpubtgnNw4YQljcoB7xSHplTxAdDzIbC1TZfQmnjZWMe0W6nQBsYHSj5YkNF/
         pBcG7+k1zq/KyImq222S7AuLN/EUA+KtH9eUUN0Kl1dTDOc+F30r6ipyQPq3TVDJPY
         y+iCJrSAbbhrPmWlG9L+nrVd0dXEJMlXWu0xtfMCHkxm9L3p+Zv6DJ6LxEQDKJzE73
         uxekNKAfjdIfg==
Date:   Thu, 26 Oct 2023 19:53:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Simon Horman <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2 3/5] net: phy: Add pluming for
 ethtool_{get,set}_rxnfc
Message-ID: <20231026195356.7624669e@kernel.org>
In-Reply-To: <20231026224509.112353-4-florian.fainelli@broadcom.com>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
        <20231026224509.112353-4-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 15:45:07 -0700 Florian Fainelli wrote:
> Ethernet MAC drivers supporting Wake-on-LAN using programmable filters
> (WAKE_FILTER) typically configure such programmable filters using the
> ethtool::set_rxnfc API and with a sepcial RX_CLS_FLOW_WAKE to indicate
> the filter is also wake-up capable.

Should we explicitly check for WAKE? WAKE, and DISC are probably the
only values that make sense for PHY nfc?
