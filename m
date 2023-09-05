Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91537931FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbjIEW3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjIEW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:29:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C472C1;
        Tue,  5 Sep 2023 15:29:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so4451848a12.0;
        Tue, 05 Sep 2023 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693952989; x=1694557789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4kI0vCYh22AUz7pwGwsZuGiIBkiy8O/f0wOKLk4wnQ=;
        b=eUMCP0KJw03G4hCImbLu86XwyE927cMrkOWNoCqBSj2TpEE+078Wpc8hs+9/+khWiX
         3RSyJ4JkvD4AlCXC5lp7IMZVHe08fiax//eFlP1IQi0JEJ8r468YxumZfmUAHWHntFlr
         UBfSUuEJ5ZOKGvWuNwo3GXeBtEADG6w7wFq5c0l6zYuGu8MNck271DCima8uokmsT7P9
         Ad29uJz96UVVdklreQGxR3mkixpWlf4Ab21oGB0U/syQjy6RYJafUjBNvZtGGdPSvb0R
         Pxd+8Ef7zgITBZEx0H31jOOIjyDcOFMvMWpqAA36JKg6fFRcoWKcMPY9eRITAjmdHHBS
         w/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693952989; x=1694557789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4kI0vCYh22AUz7pwGwsZuGiIBkiy8O/f0wOKLk4wnQ=;
        b=JRrHL982XGibHGva7NzhQhInCGUu0BB3Jr37DU5uf4yaqvz6oO2FxHRbSAr7UjVRPH
         dBUp56eyQBJoHj2tGGMCgTBjEorUIozJ4FYqg9+8m+qwkJ0FE5fhgk5JvoA1H+hjhAzb
         HFAUASQ4JH/zLQYiyXEK6pZs4FDwaHiSFbKQlaeYmtai6NFzQtg5xoIP3q3ovDIAE7+/
         nTSuokt7nF4HtNfWAJokH00/QzWk8t4nQd9PCgmdhufpn/wCtK6fyiQrBM1Rz74e6t1z
         fjviZG+z9VmV4MFxERuV9hCEnYMqjK81YTRTtiWkSpd5ueHgitmxGXeqUjOgplcAK8yK
         mcFw==
X-Gm-Message-State: AOJu0YwQ3uheiA0M3EgGWG6pedjurmZm37JejNAgk2oG2J69fp4muAEh
        QkQrcc1Q3Ib8O/fZYPljYks=
X-Google-Smtp-Source: AGHT+IGCGgYbC8m6sN9Mz7TprCiFy60xJUeFOyQSd6R/Md3u5DOgefUjY7SeNU6q4IuJQdeZKr48DQ==
X-Received: by 2002:a17:906:739e:b0:99b:dd1d:bc58 with SMTP id f30-20020a170906739e00b0099bdd1dbc58mr872893ejl.41.1693952988751;
        Tue, 05 Sep 2023 15:29:48 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090635d300b0099c971ba285sm8060447ejb.5.2023.09.05.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 15:29:48 -0700 (PDT)
Date:   Wed, 6 Sep 2023 01:29:45 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
Message-ID: <20230905222945.h7tuzlraxdp5imbh@skbuf>
References: <20230905093315.784052-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905093315.784052-1-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 11:33:15AM +0200, Lukasz Majewski wrote:
> @@ -1847,6 +1844,12 @@ static int ksz9477_config_init(struct phy_device *phydev)
>  			return err;
>  	}
>  
> +	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
> +	 * in this switch shall be regarded as broken.
> +	 */
> +	if (phydev->dev_flags & MICREL_NO_EEE)
> +		phydev->eee_broken_modes = -1;

I know this is just another quick'n'dirty code snippet exchanged over
email which turned into a proper patch, but wouldn't it be more
civilized to use "MDIO_EEE_100TX | MDIO_EEE_1000T" here, than to declare
EEE broken for link modes which aren't even supported by the internal
switch PHYs?

It's probably not causing practical harm, but currently, we tell
genphy_config_eee_advert() to include reserved bits of the MMD EEE
Advertising Register (MMD 0x07 : 0x3C) into its modification mask.
