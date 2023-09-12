Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4279DBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjILWcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILWcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:32:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5D10C8;
        Tue, 12 Sep 2023 15:32:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso818214866b.1;
        Tue, 12 Sep 2023 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694557935; x=1695162735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHGhnV3TjdN0FnFldEVPz9KrEFKfvPykYPDqTHVGIBs=;
        b=Trr1Il/48N2AqFH7HSNkZXISlg/q0dXCkK8hscNnv2XEnDQYx9w3kFAdKWPFr642jr
         BTl78G87AdIDFdH7LesPfoN9YviNjzOJYO4Iz9NPG3j8G23GW1dQazQesJqeGnsymbr6
         mHbt0V64m2Pw58gRvB0OG7r91ZuSW/2aixJqXst9TiMAAW1skJsSekSCVSUvh2/qe9Oo
         Ji+L43q+kYrueX2rHCR1XANaK+sSpZmzpORhO40MCBym7IDM4MhPDHaBOBbVWWLFRiBL
         oSrOMI99dpIe/RcPEYxz24F38rUuNFkmciUjITx7WAfE29tIHGWDqjQAiWvt8Au8ixmz
         DIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557935; x=1695162735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHGhnV3TjdN0FnFldEVPz9KrEFKfvPykYPDqTHVGIBs=;
        b=lL6TKoBXmX6YBRgw8fovimVZPs9E7KnzgtnzlP0kwxNB/RmExxo6512v5CJ79pFMPj
         91I7Xeb+QVunkKJ0r0ElJqr+JFWoICt5qaLy/PqnSgQ9uZqyOVjtu1UyORdkFv5gQq8l
         j/KGfZ9fA8s/z8/mp/XNqLunz7SjSt1W2eUZpDWmGdvAx8azUY91uVaVtFtrLZ8s8gsS
         gOZ7G+y2tkKEisz4QLl0Hw1q1jn5Vz6+bo8xZ87gZy6bGtIMAiZgjn3oUEIpJ6ubnzkn
         b+Bur8Lhd4vRSphTumagnOLUFOAm5mQWVprgjVFH0UNJbgdAE+rN3k1d9DWTC6XILlrw
         dOZw==
X-Gm-Message-State: AOJu0YyGY1/F5SyIhZR/FPNQsV6GIK9pS75/LFWZI1NXCUPlvvO0OROv
        9TA1qhEQ7znXDbzp0bpKQ4Q=
X-Google-Smtp-Source: AGHT+IFoFjvI5+2n0TYglHgn435yeXiMScCnLmeQ+gvlW6z4mDjsLd0Mij4yOQbqByz17gmPvANBNA==
X-Received: by 2002:a17:907:763c:b0:9a9:e5bb:eddc with SMTP id jy28-20020a170907763c00b009a9e5bbeddcmr472712ejc.16.1694557935294;
        Tue, 12 Sep 2023 15:32:15 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090695cc00b00993928e4d1bsm7405814ejy.24.2023.09.12.15.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:32:15 -0700 (PDT)
Date:   Wed, 13 Sep 2023 01:32:12 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: microchip: Add drive strength
 configuration
Message-ID: <20230912223212.5allvc62okewwcym@skbuf>
References: <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-1-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912045459.1864085-3-o.rempel@pengutronix.de>
 <20230912113553.fselyj2v5ynddme2@skbuf>
 <35c1c9ee-357f-4ba5-dd47-95d4c064e69b@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35c1c9ee-357f-4ba5-dd47-95d4c064e69b@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:38:05PM +0200, Christophe JAILLET wrote:
> Le 12/09/2023 à 13:35, Vladimir Oltean a écrit :
> > > +	if (!found)
> > > +		return 0;
> > 
> > Maybe "have_any_prop" would be a better name to avoid Christophe's confusion?
> 
> Not sure it worth it.
> 
> Christophe should learn to read code or avoid some quick feed-back before
> morning coffee :)
> 
> 'found' looks good enough.

Maybe I should have said "Christophe's (expressed) and my (unexpressed) confusion"?
Actually I had no time to be confused because I saw your comment first,
but I would have likely made the same suggestion regardless.
