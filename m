Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2747F7A5EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjISJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjISJwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F75131;
        Tue, 19 Sep 2023 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Cd1Ux4djE90dqj6+aK7XqRcHlYlH0tDb31PNNhpsztI=; b=hW6R+IumLeYOQS/Txt3tMg861U
        BJ6waJVrjcxkXDpY93W0pHDiu9QeIoPUhoy2SWjOSyZ4E6n1wHUEB2uPdoYdvDn+OHV+4QqliRQ+b
        LZ2pgq0mwrexvVxV7o0zOvNSfRIBVxdPmdon03bemUi/OXXOZGzTqjEiKqBIA5YATjSJ/T7tpzRFM
        D9mz9ai1qm+jp2SEqnyQyQj0eCFpJIPi/N97C+brzC7jHydionanb4gjJYGs8ePJn0YXlWaiSrPVa
        ZS3ZwZh50kax0eesPAU6e/+qXhB5osB0NyB47E7klRu84gXyyHm9XnSdb5viR4OUzEnVIAiVAol1v
        jXVQ/NoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46096)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qiXOx-0001dt-33;
        Tue, 19 Sep 2023 10:52:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qiXOx-0001Os-5l; Tue, 19 Sep 2023 10:52:15 +0100
Date:   Tue, 19 Sep 2023 10:52:15 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com,
        Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Subject: Re: [PATCH net-next v6 2/3] net: axienet: Preparatory changes for
 dmaengine support
Message-ID: <ZQlvT7wIuxfvFLLL@shell.armlinux.org.uk>
References: <1695064615-3164315-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1695064615-3164315-3-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695064615-3164315-3-git-send-email-radhey.shyam.pandey@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:46:54AM +0530, Radhey Shyam Pandey wrote:
> +/**
> + * axienet_open - Driver open routine.
> + * @ndev:	Pointer to net_device structure
> + *
> + * Return: 0, on success.
> + *	    non-zero error value on failure
> + *
> + * This is the driver open routine. It calls phylink_start to start the
> + * PHY device.
> + * It also allocates interrupt service routines, enables the interrupt lines
> + * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
> + * descriptors are initialized.
> + */
> +static int axienet_open(struct net_device *ndev)
> +{
> +	int ret;
> +	struct axienet_local *lp = netdev_priv(ndev);
> +
> +	dev_dbg(&ndev->dev, "%s\n", __func__);
> +
> +	/* When we do an Axi Ethernet reset, it resets the complete core
> +	 * including the MDIO. MDIO must be disabled before resetting.
> +	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
> +	 */
> +	axienet_lock_mii(lp);
> +	ret = axienet_device_reset(ndev);
> +	axienet_unlock_mii(lp);
> +
> +	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
> +	if (ret) {
> +		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	phylink_start(lp->phylink);

... and at this point, the link can come up while phylink_start() is
completing. Could that cause a problem if this happens before:

> +
> +	if (!lp->use_dmaengine) {
> +		ret = axienet_init_legacy_dma(ndev);
> +		if (ret)
> +			goto error_code;
> +	}

?

I suppose I should add this statement to the phylink_start()
documentation so that this point is clear for everyone.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
