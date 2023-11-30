Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024717FF37B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbjK3PWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346327AbjK3PV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:21:56 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4C10FE;
        Thu, 30 Nov 2023 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=+YOgP5+zO/Xow7+mzpfCfU7R635Z1roqLn/BuaW+ZFM=; b=Ry6PWNiBej04RlW4GoLjqg0VGv
        F9b05uv/VWYnmPr4988jICSkzGjpk3r6dtz0/hklmtnWzcgZxrpVt3ZDLceVpKmghaI24ws16SfMj
        ZL1x6OHD4St5A/8hOIvcisViE0ZzVUs+cqVpkCxwOiiNm5Ip/t98zVkwi8rVKeJI2JGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r8irO-001fzA-2N; Thu, 30 Nov 2023 16:21:50 +0100
Date:   Thu, 30 Nov 2023 16:21:50 +0100
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
Subject: Re: [net-next PATCH 06/14] net: phy: at803x: move at8031 specific
 data out of generic at803x_priv
Message-ID: <47df2f0d-3410-43c2-96d3-87af47cfdcce@lunn.ch>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-7-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct at8031_data {
> +	bool is_fiber;
> +	bool is_1000basex;
> +	struct regulator_dev *vddio_rdev;
> +	struct regulator_dev *vddh_rdev;
> +};
> +
>  struct at803x_priv {
>  	int flags;
>  	u16 clk_25m_reg;
>  	u16 clk_25m_mask;
>  	u8 smarteee_lpi_tw_1g;
>  	u8 smarteee_lpi_tw_100m;
> -	bool is_fiber;
> -	bool is_1000basex;
> -	struct regulator_dev *vddio_rdev;
> -	struct regulator_dev *vddh_rdev;
> +
> +	/* Specific data for at8031 PHYs */
> +	void *data;
>  };

I don't really like this void *

Go through at803x_priv and find out what is common to them all, and
keep that in one structure. Add per family private structures which
include the common as a member.

By having real types everywhere you get the compiler doing checks for
you.

As Russell pointed out, this patch series is going to be too big. So
break it up. We can move fast on patches which are simple and
obviously correct.

	  Andrew
