Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D187D0A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjJTIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjJTIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:24:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF724C0;
        Fri, 20 Oct 2023 01:23:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f61312eso4375525e9.3;
        Fri, 20 Oct 2023 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697790233; x=1698395033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CpDwt0mIHXa5SjKWHCoaE9qIzOGUHJct+s3WKSwVDU=;
        b=YZZcR/b2XLpmxvb+WnuIB1QiG1U+1anE36FLntSWz6M0gqKat5x3e/3rFzX7Ax3GXW
         CXbGChWGTvkttaGb0GdGFIM6c59IMVsk1ZqvN+AYzf+35MxJt2W8C1od6jK3i46YyNRe
         dkdNL3axJ/EVTSY+WbWk4PyjgtYyb6dxA8mXliXrTVFnhsiIEYEr2FebUnexiqLjz2NZ
         10YncTYJBRSfr2yeOOyF9Pf0HsIRsV50me7y1G85ADvqdvK86mlmox5d27/P3qL3hpqT
         z66++UPgnpg07vNqM5FSF8dlEwqWWwxQrOaieC9cD+GZuPYUjVAtB0YphY0UKOrbVVCv
         LrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697790233; x=1698395033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CpDwt0mIHXa5SjKWHCoaE9qIzOGUHJct+s3WKSwVDU=;
        b=NHVvk39VEbPoobmRwbGzWIztUVjDdiN71JPkyytTZ/zWfOgJotzNpzxM8tLz1QAFp+
         IV5QxbXqOSy6C5Hh3t9Svxd8xKNG4zQmVpggbrQOTDEwtMdULHNz3Q4k1S259y+FZ39V
         xOZULtW66eUi5GsNqlfBZfTXc4Ul3I2bgFgOR3/1450sp77Rd5WgWdLj4ws8ywZcxCKP
         9bPPwuL4cZKqcr61QsIskfDB6ZAEpZ4XR2oZs4TV5UYYe0IqjG6JxJ5Rc/RUsWUHaAxU
         84+bp7iyTx42C3IByG3efeKD+zUsTEhgI9yWKnSgWv0Xr6lGzOvQbn9C0Ie9yTGk8Yjv
         I0Sg==
X-Gm-Message-State: AOJu0Yz9h1gX5qPZ1Fw3ma0/n6dphD4uZZhwEyWcWTm8qJedZgfTorLq
        KBfPNoMtJvA2P95YUStDqwYgug6bDZyTKQ==
X-Google-Smtp-Source: AGHT+IHnnC4mklZfLAW60TnEnNxQtbqdf2yOeDlAPmk6S0FQh1TCdkL68HteMTGmVS8PkBhdfMIxRg==
X-Received: by 2002:a05:600c:3147:b0:405:4a78:a892 with SMTP id h7-20020a05600c314700b004054a78a892mr806944wmo.9.1697790232887;
        Fri, 20 Oct 2023 01:23:52 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b004063ea92492sm1607389wmb.22.2023.10.20.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:23:52 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:23:50 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231020082350.f3ttjnn6qfcmskno@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019172953.ajqtmnnthohnlek7@skbuf>
 <20231020050856.GB3637381@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020050856.GB3637381@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 07:08:56AM +0200, Oleksij Rempel wrote:
> On Thu, Oct 19, 2023 at 08:29:53PM +0300, Vladimir Oltean wrote:
> > I don't get it, why do you release the reference on the MAC address as
> > soon as you successfully get it? Without a reference held, the
> > programmed address still lingers on, but the HSR offload code, on a
> > different port with a different MAC address, can change it and break WoL.
> 
> It is ksz9477_get_wol() function. We do not actually need to program
> here the MAC address, we only need to test if we would be able to get
> it. To show the use more or less correct information on WoL
> capabilities. For example, instead showing the user that Wake on Magic
> is supported, where we already know that is not the case, we can already
> show correct information. May be it will be better to have
> extra option for ksz_switch_macaddr_get() to not allocate and do the
> refcounting or have a separate function.

Ah, yes, it is from get_wol(). Maybe a ksz_switch_macaddr_tryget(ds, port)
which returns bool (true if dev->switch_macaddr is NULL, or if non-NULL
and ether_addr_equal(dev->switch_macaddr->addr, port addr))?
