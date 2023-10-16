Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FAC7CA7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjJPMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjJPMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:03:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D486DDC;
        Mon, 16 Oct 2023 05:03:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so7426338a12.0;
        Mon, 16 Oct 2023 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697457798; x=1698062598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjUacR5/LdrXMtLaYoD++xnhGSnh9YIzXLKxqzrbi9Q=;
        b=fag5K/ovN5h+1h2jpiZlqecxXSC17FzVe69BAxPGLTBOWdlzOChlgwSqICo5995xJC
         r7QPgGZfNko6Geh2dNgu+PepZOmVZINLJrzF9Q+3cKn6xV+uaVRIrdSApTWXhl5+A0oO
         +ryt9qKgHnW/9uHNPhoukFks7MBx9bt1bwX5cn/AUuu0x+s94wwJfvJ3p+5c2gjlFKiu
         02QiT5yrWxbxranddajXfRhClQVyxrEso3oIcyXX2O2AZwigwtr2/ZxckJpIMxXdA0sW
         xTBRxbQ1soEqZJysrI6Jfc/TB+DLmrp7VlrvhxQojSDP+HBVV8w2iCLhJbi8NVuArTVu
         99EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457798; x=1698062598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjUacR5/LdrXMtLaYoD++xnhGSnh9YIzXLKxqzrbi9Q=;
        b=bP38Y1RXMZnRPRxnzD7GUWz/UNkxojiX4aFcdiSAn021wF21DgPwMjvhUTDN1TwD4a
         5u95kZ2qQ+A4H56NcHMdHPKMjpxBMRT5zsDWYR2PfGc91g6n4wQOJO1WjZRR6vEmN1Uz
         rA/yLK2ixqiP2pH40m8BnAg3dKIW8JkBcJDfMqtEk3hzeTyXfIdnVEnlTucVWxB+qbdP
         /pmN2UX/ay4Wyu1eXLfblPXJkG2qN6sF69FXMaI+NARwM6bQL6BbvxrPo9UJnyA0Uwf+
         Fs9tzq+G7G8lMlN+icyhTKp7NIX/4F3KXkz/cd6MDqx5A28nP5tCSGJa+Vm+BO54cJPP
         d6pA==
X-Gm-Message-State: AOJu0YyQOLZJH4+LcSVaXFZBGBp/bFComHMEV1IbA58fEu00eUXCz0SS
        oK18nOkFhlRPjdGGn6bQ82U=
X-Google-Smtp-Source: AGHT+IG/Ko9BhtySUyAd73/dS5Li/71YVHmIG1DDzxo3qY5wbPYtiM5W2gXqGTMCeKeyASkqvM/FLA==
X-Received: by 2002:a05:6402:42c7:b0:53e:bc08:3bb2 with SMTP id i7-20020a05640242c700b0053ebc083bb2mr3070790edc.16.1697457798241;
        Mon, 16 Oct 2023 05:03:18 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id v3-20020a056402174300b0053e3839fc79sm5028824edx.96.2023.10.16.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:03:18 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:03:15 +0300
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
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] dt-bindings: net: mvusb: Fix up DSA
 example
Message-ID: <20231016120315.nhiz6ukzmtdnx7vc@skbuf>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-3-38cd449dfb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-3-38cd449dfb15@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:12:56AM +0200, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>   dtschema/dtc warnings/errors:
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
> index 3a3325168048..ee677cf7df4e 100644
> --- a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
> @@ -56,6 +56,12 @@ examples:
>  
>                              ports {
>                                      /* Port definitions */
> +                                    #address-cells = <1>;
> +                                    #size-cells = <0>;
> +
> +                                    port@0 {
> +                                            reg = <0>;
> +                                    };

Could you just skip defining any port, and just leave the /* Port definitions */
comment at the end (after the newly added #address-cells and #size-cells)?
This example is more about the USB adapter, not about the switch.

>                              };
>  
>                              mdio {
> 
> -- 
> 2.34.1
> 
