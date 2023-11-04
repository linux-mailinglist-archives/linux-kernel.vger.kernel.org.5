Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B37E10BE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjKDTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKDTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:35:49 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B7194;
        Sat,  4 Nov 2023 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YDdZpyV4rBTcY/SQHR710W7PYNxHIXtIFLliRXNGxTk=; b=ZqJsEIfhRjAeEcU6uK4McjbleV
        GrzIJ2KeztdvLxMqay3XLapZUbW9H2HbDQPHpgxbUs2GzK8VPBNccMQn3p6AwSoNbaf58Xlyz5jq/
        5pr4Vu2xBemAbEAPRee1atdaGJrdWRR/WjC7nZRj6tap7mHgOSWmM0uhbkAdtDWl/ayNwqGIngZwg
        bwWjt/YJwr8kCWyxUrtv3KtJp4DP4x7jdzjGP4YLqcKsPCMk2wsc6j9wtjIgjZdKdn/83ZK8Zzeke
        a8G2HMmGKRQgG/Oy0b/ZYvluLJWz0nPQSr7gSyyycWFLHIK9nAuWdvBa3dKv9ETXnrTqlHin9eRCA
        2EAjgquw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42578)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qzMQf-0006ZZ-1C;
        Sat, 04 Nov 2023 19:35:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qzMQf-00048X-5m; Sat, 04 Nov 2023 19:35:33 +0000
Date:   Sat, 4 Nov 2023 19:35:32 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZUadBJQLFA4f/gQY@shell.armlinux.org.uk>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103123538.15735-1-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 08:35:37PM +0800, Luo Jie wrote:
> Add qca8084 PHY support, which is four-port PHY with maximum
> link capability 2.5G, the features of each port is almost same
> as QCA8081 and slave seed config is not needed.
> 
> There are some initialization configurations needed.
> 1. Configuring qca8084 related initializations including
> MSE detect threshold and ADC clock edge invert.
> 2. Add the additional configurations for the CDT feature.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/phy/at803x.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 37fb033e1c29..4124eb76d835 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -176,6 +176,8 @@
>  #define AT8030_PHY_ID_MASK			0xffffffef
>  
>  #define QCA8081_PHY_ID				0x004dd101
> +#define QCA8081_PHY_MASK			0xffffff00
> +#define QCA8084_PHY_ID				0x004dd180
...
> @@ -2207,8 +2240,9 @@ static struct phy_driver at803x_driver[] = {
>  	.resume			= qca83xx_resume,
>  }, {
>  	/* Qualcomm QCA8081 */
> -	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
> -	.name			= "Qualcomm QCA8081",
> +	.phy_id			= QCA8081_PHY_ID,
> +	.phy_id_mask		= QCA8081_PHY_MASK,
> +	.name			= "Qualcomm QCA808X",
...
> @@ -2241,7 +2275,7 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
>  	{ PHY_ID_MATCH_EXACT(QCA8327_A_PHY_ID) },
>  	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
>  	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
> -	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
> +	{ QCA8081_PHY_ID, QCA8081_PHY_MASK},

So, in summary from the above, what you're doing is using the pair of
QCA8081_PHY_ID, QCA8081_PHY_MASK to match not only QCA8081 but also
QCA8084. This is confusing.

Are there any other parts that QCA808X would correspond with which
would not be compatible with the above? E.g. QCA8082, QCA8083, QCA8088
etc.

If there are, then the correct approach would be to list them
separately in atheros_tbl, and also have separate driver entries in
at803x_driver so it's unambiguous.

If we keep this approach, then I would suggest:

#define QCA808X_PHY_ID		0x004dd100
#define QCA808X_PHY_MASK	GENMASK(31, 8)

to make it explicit that this phy ID/mask pair is matching several
devices, rather than re-using the QCA8081_PHY_ID definition.


The next point - what about the revision field which occupies bits 3:0
in these:

>  static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
>  {
> +	if (phydev->phy_id == QCA8084_PHY_ID)
> +		return false;
> +
...
> @@ -1767,6 +1781,20 @@ static int qca808x_config_init(struct phy_device *phydev)
>  {
>  	int ret;
>  
> +	if (phydev->phy_id == QCA8084_PHY_ID) {
> +		/* Invert ADC clock edge */
...
> @@ -1958,6 +1986,11 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
>  	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
>  	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
>  
> +	if (phydev->phy_id == QCA8084_PHY_ID) {

Do these need to be exact matches, or should the revision field be
ignored? If so, consider using phy_id_compare(), or if you end up with
separate driver entries, consider using phydev_id_compare().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
