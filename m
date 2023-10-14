Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CAD7C955D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjJNQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjJNQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:26:53 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706BFAB;
        Sat, 14 Oct 2023 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=m+eYhnlsWW3tRR7KfXjnN2nxeoc3/iQb0fw4Feji7t0=; b=xj1yq9Iznwrt6gJL/rfxOyAXUJ
        BfGAiOO/IIyn/IEY+Opgpqtevmu3V+0NJtECPFSJOTB7sdHtXLPYofuI7OAP/atfXO/wPX31WZxAO
        wJHmu4/qYrXx9QPk0NvwnOk0N1Szwsyi8NurihsKO6+Yut3XYGENbefon/po0ZuBbnZ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrhTP-002BcC-5l; Sat, 14 Oct 2023 18:26:43 +0200
Date:   Sat, 14 Oct 2023 18:26:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: netcp: replace deprecated strncpy with strscpy
Message-ID: <327af7c3-3a5f-4c0c-b3f7-81ceef14226b@lunn.ch>
References: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:05:40PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Other implementations of .*get_drvinfo also use strscpy so this patch
> brings keystone_get_drvinfo() in line as well:
> 
> igb/igb_ethtool.c +851
> static void igb_get_drvinfo(struct net_device *netdev,
> 
> igbvf/ethtool.c
> 167:static void igbvf_get_drvinfo(struct net_device *netdev,
> 
> i40e/i40e_ethtool.c
> 1999:static void i40e_get_drvinfo(struct net_device *netdev,
> 
> e1000/e1000_ethtool.c
> 529:static void e1000_get_drvinfo(struct net_device *netdev,
> 
> ixgbevf/ethtool.c
> 211:static void ixgbevf_get_drvinfo(struct net_device *netdev,
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/ethernet/ti/netcp_ethss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
> index 2adf82a32bf6..02cb6474f6dc 100644
> --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -1735,8 +1735,8 @@ static const struct netcp_ethtool_stat xgbe10_et_stats[] = {
>  static void keystone_get_drvinfo(struct net_device *ndev,
>  				 struct ethtool_drvinfo *info)
>  {
> -	strncpy(info->driver, NETCP_DRIVER_NAME, sizeof(info->driver));
> -	strncpy(info->version, NETCP_DRIVER_VERSION, sizeof(info->version));
> +	strscpy(info->driver, NETCP_DRIVER_NAME, sizeof(info->driver));
> +	strscpy(info->version, NETCP_DRIVER_VERSION, sizeof(info->version));
>  }

Hi Justin

We have been deprecating setting info->version in drivers, because it
is mostly useless. The core now puts in the kernel git hash, which
does actually represent something useful.

So feel free to just remove it, rather than figure out if its safe to
convert to strscpy.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

