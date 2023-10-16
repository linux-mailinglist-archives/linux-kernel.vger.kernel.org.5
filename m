Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AE7CA56D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJPKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjJPKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:32:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB2FAC;
        Mon, 16 Oct 2023 03:32:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c3aec5f326so194441766b.1;
        Mon, 16 Oct 2023 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452336; x=1698057136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y21BLo6GxvvTucZUxMoXeh+PM3v9sp2+9sBYuxtUsU8=;
        b=cXZkqlo664VvCiDZnasa6fzyshtTFoZEDICo36OF7rpQ2qBWjh3454VYZH8S8ESlA1
         7b8CIRwYZtznrdmbsZDjsrydy44d6JEQjNboUiysbnz+1wY0iLCDUsxBIilyKRnod66j
         4QJbqxEedfTP76TYgd2dHZiQJvIf+qBA36Wq3yWJHtWAa3VUy1dtBy64DSk1ynDj/kUr
         o4Lj6gxNyYjN61WgHI4joafCkrtuE0E5xaZ4pSMDN35X7oIWJNIaMVA/lg0i/8zE8JnO
         U7eYBSKTLawmuT9y45r6qgjRMv+3cjN0ahnY00wugyhG22TH2L5w4oa8BaPk10F3m4IM
         cVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452336; x=1698057136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y21BLo6GxvvTucZUxMoXeh+PM3v9sp2+9sBYuxtUsU8=;
        b=GEARrA+ZOE9ouTmD72BUnDcD5wrVKmIHD9h77TQfREP/fffwMaTj8hQWAUTB5jL2Jy
         t97h7Mih3sEVsSBg0qQIM+VV17uDTEWeBntzEW2+kMFSo840npa9Ws2ceUtFkKz49CXG
         flnf02gfUJjapm3zY7MX/jnreAKFwAiIFj01R/igr4wWw4hEngjKO70H2cRwvmxncOIA
         lEJt7DYrs+mXPQ/7Zm0iRHkNcHUSAoCyFcA7oKpZUdfHj9MEDmKnNz1VN15USTaRKVVj
         /i9bHKCteYNczdQr79nKhuj7bJfxKmXWm0vNY8dwFchD8vUGtNF3wy94Xdw00bSKughk
         NUTw==
X-Gm-Message-State: AOJu0YzipZX9ehkvC35VJsWcIBzYgrglWobzjow3PP3X0G+iS8aL700M
        hPTqVG9FU4PrYCdAZmfpdiI=
X-Google-Smtp-Source: AGHT+IE53bLZD6T3ir5GF90pvg5jjiWFAXSdkbehJZTtccharwoE2eJQ4/dd4r3RCNcmmtEjjL78kw==
X-Received: by 2002:a17:907:9303:b0:9b2:bdbb:f145 with SMTP id bu3-20020a170907930300b009b2bdbbf145mr6216924ejc.34.1697452335848;
        Mon, 16 Oct 2023 03:32:15 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709064e0400b00982a352f078sm3813603eju.124.2023.10.16.03.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:32:15 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:32:13 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231016103213.uqnc2pjehsz6iy5b@skbuf>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
 <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:55:56PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 41014f5c01c4..eaa347b04db1 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -72,6 +72,25 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock is provided internally. Otherwise
> +      reference clock should be provided externally.
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        enum:
> +          - microchip,ksz8863
> +          - microchip,ksz8873
> +then:
> +  not:
> +    required:
> +      - microchip,rmii-clk-internal

I think that what you want to express is that microchip,rmii-clk-internal
is only defined for microchip,ksz8863 and microchip,ksz8873.
Can't you describe that as "if: properties: compatible: (...) then:
properties: microchip,rmii-clk-internal"?

Also, this is a port interface property, so I would like to see it in
the xMII port and not global to the switch. The KSZ8873/KSZ8863 is
somewhat special in that it only contains a single xMII port, but that
doesn't mean that RMII settings are switch-wide.

> +
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.11.0
> 
