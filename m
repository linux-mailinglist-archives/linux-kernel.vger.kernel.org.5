Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69AD7AFA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjI0Fcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjI0Fbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:31:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFD16627;
        Tue, 26 Sep 2023 16:03:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so11908501a12.1;
        Tue, 26 Sep 2023 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695769429; x=1696374229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EwQWLVmf1ooAJ5jlKTNlvd+gS1fha7ZhTlSXaw/z40w=;
        b=CxGaMYfhoebj3qNtBq/2tB/9g40QDxmcMb3Cg+LOVdTK7xGSqBvycfMOtYQF+MQ2b2
         XDLT5ax5LBHBqLBjovk+ZOK7tdNokh2gru4AhcI2rUuBMuh2Y4yEuDlOljj2jpb7ke4c
         lfQLyRrYJNutCOub9wzkWk66fnN0I9PWDJoSazpWF75HrfKteRezQLccVK+NvHNBTDxe
         0zEOH9ulP5DzaXIG+F7ODMmrA1Vi6E1d8DVpqUrBJgChkBZIiKx00k0JFZttYZRyrW7Q
         i7YR3vSAAFeSaSxGQs8fc9aAFKoDsRj3tGFk0S3P4Pl97KeH+Y/zh3bazsdScBHrI/8F
         fbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695769429; x=1696374229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwQWLVmf1ooAJ5jlKTNlvd+gS1fha7ZhTlSXaw/z40w=;
        b=BfvVND+4EVJTx6kZTk1ey1+O0EP5HA5qdDY/kfFnXuRGEGRTLYhiOJWGug/N+TNVJp
         VjGVlueCvrXjXoj4dj+ZTRXhCUqp1PP8GBTbNZMHgOjdTeOm4WPXfwDCiWMYF8GrH44U
         MeuH1vkcX06KGVLOpeqTe9oGq4kjuhqsill+uq3P+LlwlfKskwtlD5RxqnZbWcPoq4N1
         RBJelsrQd8AwozP+owGwT6KZkVBF4f9ivUMwE9KLSfudG4ezlaS77tGcAe5IrbjBMatE
         EjP7RrhECOFrIo8O5WJ8OHBa4fzrDpJJnYHNBwYICGCSHKHVoGuSxHUFNmzwdQrMcrcy
         0pfw==
X-Gm-Message-State: AOJu0Yw5aLamuEJ5i2yGA8NKyECIxdVf/HstlaT9AtSrfrvSG6yFDUdz
        OLEjUsQKTQfxbf+Yjy27ORE=
X-Google-Smtp-Source: AGHT+IEeFtF26Ih0iBnW5RZFc9NAgshFdUwRK2WoSgNeMG8CWPe0AwywGGaeZkg3VJ+9xzSPl6I6gg==
X-Received: by 2002:a17:906:ce:b0:9ad:ae3a:ed01 with SMTP id 14-20020a17090600ce00b009adae3aed01mr99651eji.2.1695769428900;
        Tue, 26 Sep 2023 16:03:48 -0700 (PDT)
Received: from skbuf ([188.25.161.12])
        by smtp.gmail.com with ESMTPSA id gu20-20020a170906f29400b009ad8796a6aesm8312608ejb.56.2023.09.26.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 16:03:48 -0700 (PDT)
Date:   Wed, 27 Sep 2023 02:03:46 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <20230926230346.xgdsifdnka2iawiz@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-3-paweldembicki@gmail.com>
 <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:49:36PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 12, 2023 at 02:21:56PM +0200, Pawel Dembicki wrote:
> > +static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
> > +					unsigned int mode,
> > +					phy_interface_t interface,
> > +					struct phy_device *phydev,
> > +					int speed, int duplex,
> > +					bool tx_pause, bool rx_pause)
> > +{
> > +	struct vsc73xx *vsc = ds->priv;
> > +	u32 val;
> > +
> > +	if (speed == SPEED_1000)
> > +		val = VSC73XX_MAC_CFG_GIGA_MODE | VSC73XX_MAC_CFG_TX_IPG_1000M;
> > +	else
> > +		val = VSC73XX_MAC_CFG_TX_IPG_100_10M;
> > +
> > +	if (interface == PHY_INTERFACE_MODE_RGMII)
> > +		val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
> > +	else
> > +		val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
> 
> I know the original code tested against PHY_INTERFACE_MODE_RGMII, but
> is this correct, or should it be:
> 
> 	if (phy_interface_is_rgmii(interface))
> 
> since the various RGMII* modes are used to determine the delay on the
> PHY side.
> 
> Even so, I don't think that is a matter for this patch, but a future
> (or maybe a preceeding patch) to address.
> 
> Other than that, I think it looks okay.
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I also agree with adding one more patch to this which converts to
phy_interface_is_rgmii(). Paweł: there was a recent discussion about
the (ir)relevance of the specific rgmii phy-mode in fixed-link here.
https://lore.kernel.org/netdev/ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk/
