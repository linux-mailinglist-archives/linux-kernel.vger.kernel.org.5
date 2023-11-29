Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2177FDF10
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjK2SGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2SGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:06:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34AA8;
        Wed, 29 Nov 2023 10:06:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-409299277bbso135015e9.2;
        Wed, 29 Nov 2023 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701281210; x=1701886010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WP/VskNJd0LA4E1Mk07bsXVasJaRqm4qXuSnlHideFE=;
        b=Viv2jJJ14cnHsSiQMdm1UCPNoju6w1pIshvNP6BEWSaN3RSOoa9mQyjakwA4bgBSyg
         6Mg4K1CS6Y/D/g3yaNS4mm+yFkCzz79WdiFAex+Dl8mgLPL5voskWEbOlQTDfkld2+oe
         0Edxx+M/3b9f1twkAJCtMcNfiavOOI1y+sl0cGTY8hHeoNT405g8Z2xBPGIucs6nPgsK
         9Y0IRnKlFVatmU3WncOStZK7KonitVI6hdDKL0X+F80yxO1Fv2s77Efk7a95/c1PM5vq
         uVx7EtYL5QIcx4TkqlZXodnp5DlXsJKSTqKqzVIXDL9vrDzpKfoHYy5HILkF0WDNY4if
         TybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281210; x=1701886010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP/VskNJd0LA4E1Mk07bsXVasJaRqm4qXuSnlHideFE=;
        b=sA04V7+YxfPptJlgNhhAxtcjMv/7Ylz3v7WfPsUhb4zyfHuLttBfPt5NjkBf+Qkdng
         UYKmr8LDC1O+Q4MP2RtG2xwHSzo8aJMfbDaFj6oG/JEERK+F/bLMuUoXl0T8RpZJIqZ+
         6eSEV0KV9Apyrh7kIYdxXMtwfdroJzHrDVMozyaCkkCe08a0PQPnBN+L87DjSuxeWRd9
         Epa9nd03t5f19RE6vgUIU9sfDnCcl/988fZkVoZMCIiYfr7kVNE7+MWKkn9tnBZjQJm5
         Co7B0E7erGJ/LnDG0VM1mWiIn3O+bajIPUhtNk6X9Q9GLHxI8KnNBaIWo2sN0IN0KoX/
         tXcA==
X-Gm-Message-State: AOJu0YyDfuMMclNTgB1tcUsE6MoPlk1kmEDHEyAEmLPD+buJFEY6w6AY
        ztj+gh0UYTXm1iggP8JMpLI=
X-Google-Smtp-Source: AGHT+IGCqKmEQmXCHAhNv3R9Y7f8whXFQ6c5b+m19lU3XNKj7aXxtJJZw2vSzghtWrgTqB2kFIERSg==
X-Received: by 2002:a05:600c:188a:b0:40b:5021:f057 with SMTP id x10-20020a05600c188a00b0040b5021f057mr3307729wmp.11.1701281209422;
        Wed, 29 Nov 2023 10:06:49 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0040b2b38a1fasm3101035wmq.4.2023.11.29.10.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:06:45 -0800 (PST)
Date:   Wed, 29 Nov 2023 20:06:42 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH net-next v9 3/5] dt-bindings: net: ethernet-switch:
 Accept special variants
Message-ID: <20231129180642.q5ybndg5fp5c4udg@skbuf>
References: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:43:06PM +0100, Linus Walleij wrote:
> Accept special node naming variants for Marvell switches with
> special node names as ABI.
> 
> This is maybe not the prettiest but it avoids special-casing
> the Marvell MV88E6xxx bindings by copying a lot of generic
> binding code down into that one binding just to special-case
> these unfixable nodes.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Not great, not terrible.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
