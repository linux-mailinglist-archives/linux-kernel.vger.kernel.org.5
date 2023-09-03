Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF86F790F50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348800AbjIDAAL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Sep 2023 20:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjIDAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:00:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4B21C4;
        Sun,  3 Sep 2023 17:00:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF8CE165C;
        Sun,  3 Sep 2023 17:00:43 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 072F13F766;
        Sun,  3 Sep 2023 17:00:03 -0700 (PDT)
Date:   Mon, 4 Sep 2023 00:58:55 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Message-ID: <20230904005855.658819b3@slackpad.lan>
In-Reply-To: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
References: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Sep 2023 12:11:06 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> With gcc 12.3.0, when this file is built, we get errors such as:
> 
> drivers/phy/allwinner/phy-sun4i-usb.c: In function ‘sun4i_usb_phy_probe’:
> drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: ‘_vbus’ directive output may be truncated writing 5 bytes into a region of size between 2 and 12 [-Werror=format-truncation=]
>   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
>       |                                                    ^~~~~
> drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: ‘snprintf’ output between 10 and 20 bytes into a destination of size 16
>   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Because of the possible value of 'i', this can't be an issue in real world

Would using "u8 i;" help? After all currently there are only 4 PHYs
max, and in general this isn't expected to be more than a "handful", so
8 bits should be plenty. An unsigned is better anyway.
It leaves a bit of a bitter taste, though, as we shouldn't do this kind
type tweaking, especially not to work around the compiler trying to be
clever, but then not seeing the whole picture (that "i" is bounded by
compile time constants not exceeding "4").

Cheers,
Andre

> application, but in order to have "make W=1" work correctly, give more
> space for 'name'.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index ec551464dd4f..e53a9a9317bc 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -782,7 +782,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < data->cfg->num_phys; i++) {
>  		struct sun4i_usb_phy *phy = data->phys + i;
> -		char name[16];
> +		char name[32];
>  
>  		if (data->cfg->missing_phys & BIT(i))
>  			continue;

