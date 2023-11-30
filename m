Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12DA7FF336
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbjK3PJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:09:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC21B4;
        Thu, 30 Nov 2023 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=D+LmC+1/RYTLpkFTwI8yb/n8Ew6AV+Cl7nqaIiFwlPs=; b=Yn/Jk19thhlWMIUF0bplu8nx6s
        4dc/ABz2PL5pQvTaKMGJP1xvVlD4KvnF7JdUyWac08oNceGczk3W2qFILgO/KM7Nv0cYtdeERRG62
        Xkd+8k6dlp12GXHbG+EN2bUzGEV3XuaYgkP0bYypD/sc9F7gdvZLyeZJSxTBQnf26qMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r8iez-001fvP-Fe; Thu, 30 Nov 2023 16:09:01 +0100
Date:   Thu, 30 Nov 2023 16:09:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 04/14] net: phy: at803x: move qca83xx stats out
 of generic at803x_priv struct
Message-ID: <987fe800-ea6c-44a0-9895-57feb6731b08@lunn.ch>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-5-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:12:09AM +0100, Christian Marangi wrote:
> Introduce a specific priv struct for qca83xx PHYs to store hw stats
> data and a specific probe to allocate this alternative priv struct.
> 
> This also have the benefits of reducing memory allocated for every other
> at803x PHY since only qca83xx currently supports storing hw stats.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 4ff41d70fc47..3b7baa4bb637 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -301,6 +301,10 @@ static struct at803x_hw_stat qca83xx_hw_stats[] = {
>  	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
>  };
>  
> +struct qca83xx_priv {
> +	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
> +};
> +
>  struct at803x_priv {
>  	int flags;
>  	u16 clk_25m_reg;
> @@ -311,7 +315,6 @@ struct at803x_priv {
>  	bool is_1000basex;
>  	struct regulator_dev *vddio_rdev;
>  	struct regulator_dev *vddh_rdev;
> -	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
>  };

I agree with Russell here, this is the wrong way to go.

Maybe keep at803x_priv for all the common private members which are
shared by all variants. Add a qca83xx_priv which includes this:

struct qca83xx_priv {
	struct at803x_priv at803_priv;
	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
};

	Andrew
