Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F857FDF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjK2SEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2SEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:04:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4CCAF;
        Wed, 29 Nov 2023 10:04:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so112505e9.2;
        Wed, 29 Nov 2023 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701281097; x=1701885897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4jESqZmpMEPxH+fuQOnMVYUEdrJMqMVfKBMqgWEv/A=;
        b=RlikZ1NKQOUHfhO4FvxmJPFCBoClwaV/5E1rnnzrJTT92aT+8bJdaE71xffxRpL0O9
         Z2PrIi6dIyIUW9Gg4Bk7yigYEMy+SS7u7F5sjOpCOuQbO65RCpp0njHRP2ywUltAMJyn
         z+9ypAlWYshgWz1y7uHm52NyvNNXpwdXqGoZMVTR1OZOyolXZtRA6Bhtu5ckiOJg34In
         fZ8ghtC4ETA+sQ+p9Mr5p2tfvfrrBtJBclHAJXI/ZHupjlAf8uejGXsWnqES7gtjzvg3
         dD1JXUrdWau46Xda0aYLLU2oEcvZGTxeRMwofYfE92bCjBiLm35ydZY7W+xxHrKEyiPz
         rRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281097; x=1701885897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4jESqZmpMEPxH+fuQOnMVYUEdrJMqMVfKBMqgWEv/A=;
        b=wobf5WiCmaa1Hg6A1oyEOzVdXvU6E5zyeu3Kur8x9O5xq0RBSb0oNQFrirvI6zoGQp
         ZXu3rZjqeGsJmjczXbzUNf9zIaLatFSG7uP2ywo3HJqhFNXu8KBzZc1+UyVuBxLkPokI
         qgGfccxEZ9iPKqIYBOitxU4jSCFgf3o2VUSlL1CEBeMYdqdtVQb6fM52fErJsXeRP0dT
         java1npC2aP2mQwq7q28EBaDnPcucn8J6Meb9KaqPCdqpyW3zuUgkfqMdzy9EJ0IBgOI
         1SkuqF0dXO5m1UuREFB6Iss6XU6cZGdMZ19R+BkGV5iwL90GOgLb273AAhdLs9GJJxRG
         VWtg==
X-Gm-Message-State: AOJu0YxJ2Yyt/3BH9nw312GKzWkXGABnk0QZNO4Goji+1tdMg1UISO/L
        NrNbaZizYFtWn8wIHUMiwuo=
X-Google-Smtp-Source: AGHT+IFLTA4R08YIGhe/kznCDigznewvoiILsXBmrSH8RS0rlFq3qOqKk2onvEvKnhtWK2lDpBB5QQ==
X-Received: by 2002:a05:600c:1c9d:b0:40b:3933:f994 with SMTP id k29-20020a05600c1c9d00b0040b3933f994mr15197936wms.25.1701281096993;
        Wed, 29 Nov 2023 10:04:56 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b003fc0505be19sm3054640wmb.37.2023.11.29.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:04:56 -0800 (PST)
Date:   Wed, 29 Nov 2023 20:04:53 +0200
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
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v9 4/5] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231129180453.2bkmvuxihtp3yeyz@skbuf>
References: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
 <20231127-marvell-88e6152-wan-led-v9-4-272934e04681@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-marvell-88e6152-wan-led-v9-4-272934e04681@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:43:07PM +0100, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
