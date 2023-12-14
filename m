Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79EF812F93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444211AbjLNMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444170AbjLNMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:00:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B62B7;
        Thu, 14 Dec 2023 04:00:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso1877336a12.1;
        Thu, 14 Dec 2023 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702555219; x=1703160019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAVjKqO7t1SHEAhnbN0gUIgoq1UKlAq8GC08s1NGUV8=;
        b=VMHOBKTGX2nJ/vb/pYuzizI7gNB8bCnxFUsbE+v/oFgtYDZBzFLVfs5rLuTLaZoc2h
         rqTFeUrxFXZgzxZ1A5R3nTXCq+UJmtXZOW/4jbUDaTcwL2wZrRW6izkm81JmgvYS53aT
         onlSgdVZfWMWNfrxX9BhnxLSz3m8nu/TKczDC0pIYIHynEtckssQhZSxE5zcUAi/O55W
         xaqE5yCFQW2kth6rILEkbCetazM5v6xG4jzWYa/Gy1XRuUVgUn5n1+MAIF6TNMKQ7oFw
         88jEkoRRSmG50MXAH+ng0rElcHm0dGRPPybLDd8EbD5yhxOmjkKUFgO6Ew3y8ljl7Kmu
         nlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555219; x=1703160019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAVjKqO7t1SHEAhnbN0gUIgoq1UKlAq8GC08s1NGUV8=;
        b=Vx0jNyu7MVDllNyo8ioCn9gZXHyAkDj9CSUuJVo9COOy/l6x1N8519THgRdaelxY7W
         ZNYlpgZL35plBqfbdm0g17MBC7SzopQKM8w0UGiAwAmQq/lUxRXm/Y2TMS7Y+2eA91r3
         5LotGMrCuXxfYZx2fWKsQ5h3Q5bXgqEge9j3hmwTd+NCJUkk1ZP25iwXO9EqhdzVH2Bx
         ArfY6y67oCbmYJzwa/hlzL4P5rBbljOYBF6M3pTMcE3P+WVYgcMac3aI04scaRYatWHy
         h9l8MPzdx8HmoQUV2TOc+ANmtxnIkLm2nfVrimC8ltPcuoSebyv79S0MI8lg4vjQn8vF
         hR4Q==
X-Gm-Message-State: AOJu0YzMP4Wp05uf9u+erUHhRN3m/rxyMhl8iwKGTJVjOP7PW0XoDXnB
        Xk5eI8W3+Bfwq3nZuQGlmpjZA5dTBMCvBg==
X-Google-Smtp-Source: AGHT+IFkAF8xyyVRvjbkhV0Imar1p4RnoaCvAzq2XlE+nsr9Wcq6xdWObgKdx8piQfIZ52SF7bMauQ==
X-Received: by 2002:a17:906:74d6:b0:a23:fb2:e6c4 with SMTP id z22-20020a17090674d600b00a230fb2e6c4mr186158ejl.233.1702555219291;
        Thu, 14 Dec 2023 04:00:19 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ss27-20020a170907c01b00b00a1d9afe42f0sm9248350ejc.35.2023.12.14.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:00:19 -0800 (PST)
Date:   Thu, 14 Dec 2023 14:00:16 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS
 MDIO-device support
Message-ID: <20231214120016.wgeip3mdro5ihnxe@skbuf>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-11-fancer.lancer@gmail.com>
 <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
 <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
 <20231205122316.ihhpklv222f5giz3@skbuf>
 <nflj4ajgx3byqhwna2eslldwulbbafmcwba4dwgxo65o5c7pmj@zbgqt2zje4ix>
 <20231208163343.5s74bmirfna3o7yw@skbuf>
 <xhj7jchcv63y2bmnedxqffnmh3fvdxirccdugnnljruemuiurz@ceafs7mivbqp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhj7jchcv63y2bmnedxqffnmh3fvdxirccdugnnljruemuiurz@ceafs7mivbqp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 02:54:00PM +0300, Serge Semin wrote:
> > > > The pcs-rzn1-miic.c driver puts a device_link to the MAC to at least
> > > > tear down the whole thing when the PCS is unbound, which is saner than
> > > > crashing the kernel. I don't see the equivalent protection mechanism here?
> > > 
> > > You are right. I don't have any equivalent protection here. Thanks for
> > > suggesting a solution.
> > 
> > I think that a device link between the "ethernet" device and the "mdio"
> > device (controller, parent of the PHY or PCS), if the Ethernet is not a
> > parent of the MDIO controller, could also solve that. But it would also
> > require ACK from PHY maintainers, who may have grander plans to address
> > this snag.
> 
> Ok. I'll add it in v2. Let's see what the maintainers think about
> that.

Are you not following the parallel discussion on the topic of PCS
devices having bound drivers?
https://lore.kernel.org/netdev/ZXnV%2FPk1PYxAm%2FjS@shell.armlinux.org.uk/

Sadly I don't have much spare time to join that discussion, but it looks
like you could.
