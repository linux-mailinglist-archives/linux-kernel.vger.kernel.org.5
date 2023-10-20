Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6997A7D0A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjJTIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJTIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:18:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1D1A8;
        Fri, 20 Oct 2023 01:18:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dd70c5401so391764f8f.0;
        Fri, 20 Oct 2023 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697789931; x=1698394731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrKgnqGNwj+/qxrUkjrulP5wLbH/xyHD5bMTIeNaIw0=;
        b=bSsQLGhCDhxxA68JFxsZGtEqE7UJdFwW92HwNxuegJPgIf+kl8I9lB5Rlj1bGRUbbJ
         aQzu/GJ9tQ+GKYF+qefGKhOgoi0PC2zu9HbuqIOKTk/9NKe+hjidH+2d9ECjvAQLhHJv
         RLAAhcVPAcAAAfy3pPMs3NzBg/u4i2WpWTWoJ25xhHPlgGpEF+jF/vyVw0IDRq7YUglZ
         suW6JlDu883UC7Y9cOUPNtZuUW5vnc2HBAtOn80qsTt+CwI6HY7QF9oAxAJ93wILhG8W
         6H4FRMQqy5GDa1DAPkN1P8lkj+f3sCYOtEscy2kKgx4rSLDejmgNuPwgbZF8lUuByNsh
         Yc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697789931; x=1698394731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrKgnqGNwj+/qxrUkjrulP5wLbH/xyHD5bMTIeNaIw0=;
        b=KDhTJqSFxXFFxPJKJolcVQxPnLzSuitccsix87Z04WzFUCufX/gK3wnLYpYaVGEKKX
         PFJAayrHi5DJ5Z0ibygkNw77+MIzcmdA8kw6LEMfbV9+Hvan0gKLiwT1d42WUocjmROy
         u4eydO1uBAbYztkXbcR1vGuY+JMGoQbhNEiqQDzIp7pQjN7ej/gxrPLGZHHwGctdHaLP
         52be32/EsdQDF6rCGon/mcxL2uCdbzawd/wJG8MfArz9UD9HDUquAekZy1drVDw8adjF
         POnYMdonB/36zlU5BCnHTOCFdbKu5FCHowLRz0IiROKjy45isSyjN++ZZAJP23cpSiV4
         N1sQ==
X-Gm-Message-State: AOJu0YyJcJoBwTSuvLcFMr1riHMsLKvz+6TTm9VxGjyX3/GzG6Yf9zHR
        cI2PBEUQ0rM5GCu0E0XZ/5xvHZzSkS4AAg==
X-Google-Smtp-Source: AGHT+IHKE022uP5a8lmmI2AX68/8E672f6bDfCiBbCME8ylDeDmgCERyfffyWw/eUNmfld4uuwQB2g==
X-Received: by 2002:a5d:6e06:0:b0:32d:a2bb:c996 with SMTP id h6-20020a5d6e06000000b0032da2bbc996mr795933wrz.69.1697789930390;
        Fri, 20 Oct 2023 01:18:50 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b0032d9a1f2ec3sm1147613wru.27.2023.10.20.01.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:18:50 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:18:47 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231020081847.zgpez76utrexix24@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019172953.ajqtmnnthohnlek7@skbuf>
 <ZTFyvDLgmaTy2Csx@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFyvDLgmaTy2Csx@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:17:32PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 19, 2023 at 08:29:53PM +0300, Vladimir Oltean wrote:
> > > -	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s\n", port,
> > > +	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s %s\n", port,
> > > +		pme_status & PME_WOL_MAGICPKT ? "\"Magic Packet\"" : "",
> > >  		pme_status & PME_WOL_LINKUP ? "\"Link Up\"" : "",
> > >  		pme_status & PME_WOL_ENERGY ? "\"Enery detect\"" : "");
> > 
> > Trivial: if you format the printf string as %s%s%s and the arguments as
> > "\"Magic Packet\" " : "", then the printed line won't have a trailing
> > space at the end.
> 
> Sadly, it still will. The best solution is to prepend the space
> character to each entry in the "list" and remove the space characters
> after the : in the format string thusly:
> 
> 	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s%s\n", port,
> 		pme_status & PME_WOL_MAGICPKT ? " \"Magic Packet\"" : "",
> 		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
> 		pme_status & PME_WOL_ENERGY ? " \"Enery detect\"" : "");

Thanks for correcting me.
