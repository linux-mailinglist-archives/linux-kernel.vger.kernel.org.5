Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8767B1D24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjI1M5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjI1M5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:57:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B11B180;
        Thu, 28 Sep 2023 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/gAK+0HU4BRJbpDbE0lx3+xHhzKN8MJD+iMJ8Z2LG5c=; b=6YfhPlsRClQsXgn5a+7EhGiYL0
        rgJ66LHggseErlxf/K8GhMXe6ioHrM10HSWjXgR/gcwhFrEZcicF6lyOEoacQvPLGXoHtzecVDmZ3
        kxuNJVwfiu/96/A5Ne/4JJdIAAYHOMwVkwqx87ZIaQhiNhRmor9XxUYeljFSPjW0b1QQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qlqZt-007k9v-14; Thu, 28 Sep 2023 14:57:13 +0200
Date:   Thu, 28 Sep 2023 14:57:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v9 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Message-ID: <714dbb7d-3fb8-481e-aba1-01a1be992950@lunn.ch>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-3-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928104920.113511-3-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> index bae04cfea060..5314fceb72a2 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -51,8 +51,6 @@
>  
>  #define RX_BUF_SIZE (1522 + 1)
>  
> -#define IVEC_NAME_SIZE IFNAMSIZ + 10
> -
>  /*****************************************************************************/
>  enum rtase_registers {
>  	RTASE_MAC0   = 0x0000,
> @@ -261,6 +259,8 @@ union rx_desc {
>  #define RTASE_IDLESLOPE_INT_SHIFT 25
>  #define RTASE_IDLESLOPE_INT_MASK  GENMASK(31, 25)
>  
> +#define IVEC_NAME_SIZE IFNAMSIZ + 10
> +

Please try to avoid moving things around which you just added in the
previous patch.

> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	const struct pci_dev *pdev = tp->pdev;
> +	int ret;
> +	u16 i;
> +

> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +	netdev_info(dev, "link up\n");

No need to spam the log with this. Given the hardware architecture,
the link is always going to be up.

    Andrew
