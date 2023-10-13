Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA37C859F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJMMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjJMMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:22:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B3C2;
        Fri, 13 Oct 2023 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=LEtAjodcJ/masj4kckhIy1BBA7kQ7KM+p/SAstlOZeY=; b=GvuyTF2s1HPxK3pUf3vFwyREcJ
        6CKRRLiOx5WLrj5GspnoE2MgyzYNBpEAlC11DxfSp3Ge+UNcFw1eBL6xD7AA8rHaSyMNtbC8MYrC8
        iEoMZ9N8OuocNeeCa4h+pTaks3uJ6xBOfH73KYadD5Nzk+xk1Hco7N2pUWXqykUu0jMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrHBs-0025VY-7b; Fri, 13 Oct 2023 14:22:52 +0200
Date:   Fri, 13 Oct 2023 14:22:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> -		strncpy(data + i * ETH_GSTRING_LEN,
> -			tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> -	}
> +	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> +		ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
>  }

I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
be trusted as a format string? Is this indicating we need an
ethtool_puts() ?

	Andrew
