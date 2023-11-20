Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B733A7F19F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjKTRbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKTRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:30:58 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1402EE8;
        Mon, 20 Nov 2023 09:30:54 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b0683ff3c8so147707939f.0;
        Mon, 20 Nov 2023 09:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501453; x=1701106253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSW3E3xtPlVB/b2ss56BvmwvXcGMmo75cWYtJjq8ld8=;
        b=hnqjB8JZDlkWyl7IL9xqgZVU723YQqOxBV0MkPEjQ0yhB1hs+VPT1i4bfkvw4oWj0y
         kxMNSOCR3oDddDRXnchXRC2+bbVjSmp5WZcycyaC4dCtpZzvGPoPMGYlVqbZUZ05XQKN
         3SQAxhzBoklsA+wklXAHUCHHpXI5aIkcGXnBwuWOU/YJP+aRr3E6Uyl0pZnaUPMPiYb+
         OgN5ZUqrO4fFALgBj4vGjsORRscT34VG5DjhUnyqm6hJBrR0o8IRBk065aXt7EMjlZH3
         LjSQ9McuLDvLKoX/xLDaHBt+bWsh3ioE7+/lKaAqbgIYdJ7H/uV6XCjwLhSsva/qPw4o
         9c+w==
X-Gm-Message-State: AOJu0YykgSq5tCAxMmka6WC7GPYjao8Khp7knQrFkFBmyy934TdvIK5z
        FjS/DsCZuLtOFfXU+K0zdQ==
X-Google-Smtp-Source: AGHT+IEqf3gdWs75Wxke7gxzZzNuRkHoVMvLJ/fF9+7hFDSkhKvpLh/DRcbrtvhjf3YBRL53EDCZ8w==
X-Received: by 2002:a5d:8199:0:b0:798:2415:1189 with SMTP id u25-20020a5d8199000000b0079824151189mr10731727ion.12.1700501453017;
        Mon, 20 Nov 2023 09:30:53 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u13-20020a056638134d00b00466593d380fsm751194jad.53.2023.11.20.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:30:52 -0800 (PST)
Received: (nullmailer pid 2441844 invoked by uid 1000);
        Mon, 20 Nov 2023 17:30:49 -0000
Date:   Mon, 20 Nov 2023 10:30:49 -0700
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 02/14] dt-bindings: net: move PHY modes to
 common PHY mode types definition
Message-ID: <20231120173049.GA2378814-robh@kernel.org>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120135041.15259-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 02:50:29PM +0100, Christian Marangi wrote:
> Move PHY modes from ethernet-controller schema to dedicated common PHY
> mode types definition. This is needed to have a centralized place to
> define PHY interface mode and permit usage and reference of these modes
> in other schemas.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/ethernet-controller.yaml     |  47 +------
>  .../bindings/net/ethernet-phy-mode-types.yaml | 132 ++++++++++++++++++
>  2 files changed, 133 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 9f6a5ccbcefe..40c1daff2a48 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -55,55 +55,10 @@ properties:
>      const: mac-address
>  
>    phy-connection-type:
> +    $ref: /schemas/net/ethernet-phy-mode-types.yaml#definitions/phy-connection-type

You need a '/' after '#' or it is not a JSON pointer.

>      description:
>        Specifies interface type between the Ethernet device and a physical
>        layer (PHY) device.
> -    enum:
> -      # There is not a standard bus between the MAC and the PHY,
> -      # something proprietary is being used to embed the PHY in the
> -      # MAC.
> -      - internal
> -      - mii
> -      - gmii
> -      - sgmii
> -      - psgmii
> -      - qsgmii
> -      - qusgmii
> -      - tbi
> -      - rev-mii
> -      - rmii
> -      - rev-rmii
> -      - moca
> -
> -      # RX and TX delays are added by the MAC when required
> -      - rgmii
> -
> -      # RGMII with internal RX and TX delays provided by the PHY,
> -      # the MAC should not add the RX or TX delays in this case
> -      - rgmii-id
> -
> -      # RGMII with internal RX delay provided by the PHY, the MAC
> -      # should not add an RX delay in this case
> -      - rgmii-rxid
> -
> -      # RGMII with internal TX delay provided by the PHY, the MAC
> -      # should not add an TX delay in this case
> -      - rgmii-txid
> -      - rtbi
> -      - smii
> -      - xgmii
> -      - trgmii
> -      - 1000base-x
> -      - 2500base-x
> -      - 5gbase-r
> -      - rxaui
> -      - xaui
> -
> -      # 10GBASE-KR, XFI, SFI
> -      - 10gbase-kr
> -      - usxgmii
> -      - 10gbase-r
> -      - 25gbase-r
>  
>    phy-mode:
>      $ref: "#/properties/phy-connection-type"
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml
> new file mode 100644
> index 000000000000..6d15743b4ffa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ethernet-phy-mode-types.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ethernet PHY Common Mode Types
> +
> +maintainers:
> +  - David S. Miller <davem@davemloft.net>
> +
> +definitions:

Use '$defs'

'definitions' is special in that we don't process it at all. That's 
probably why you ended up with this overly complicated schema below.

But really, there's no need to use $defs or definitions at all here. 
Just put it under 'properties' And move the references up a level (i.e. 
to the node, not a property).

> +  phy-connection-type:
> +    # const: "internal"
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/string
> +      - oneOf:
> +        # There is not a standard bus between the MAC and the PHY,
> +        # something proprietary is being used to embed the PHY in the
> +        # MAC.
> +        - items:

'items' is for arrays, but you just said this is a 'string', not 
'string-array'. 

> +            - type: string

Already covered by the type $ref.

This can all be expressed with just 1 'enum' as it was before.

> +              const: internal
> +        - items:
> +            - type: string
> +              const: mii
> +        - items:
> +            - type: string
> +              const: gmii
> +        - items:
> +            - type: string
> +              const: sgmii
> +        - items:
> +            - type: string
> +              const: psgmii
> +        - items:
> +            - type: string
> +              const: qsgmii
> +        - items:
> +            - type: string
> +              const: qusgmii
> +        - items:
> +            - type: string
> +              const: tbi
> +        - items:
> +            - type: string
> +              const: rev-mii
> +        - items:
> +            - type: string
> +              const: rmii
> +        - items:
> +            - type: string
> +              const: rev-rmii
> +        - items:
> +            - type: string
> +              const: moca
> +
> +        # RX and TX delays are added by the MAC when required
> +        - items:
> +            - type: string
> +              const: rgmii
> +
> +        # RGMII with internal RX and TX delays provided by the PHY,
> +        # the MAC should not add the RX or TX delays in this case
> +        - items:
> +            - type: string
> +              const: rgmii-id
> +
> +        # RGMII with internal RX delay provided by the PHY, the MAC
> +        # should not add an RX delay in this case
> +        - items:
> +            - type: string
> +              const: rgmii-rxid
> +
> +        # RGMII with internal TX delay provided by the PHY, the MAC
> +        # should not add an TX delay in this case
> +        - items:
> +            - type: string
> +              const: rgmii-txid
> +
> +        - items:
> +            - type: string
> +              const: rtbi
> +
> +        - items:
> +            - type: string
> +              const: smii
> +
> +        - items:
> +            - type: string
> +              const: xgmii
> +
> +        - items:
> +            - type: string
> +              const: trgmii
> +
> +        - items:
> +            - type: string
> +              const: 1000base-x
> +
> +        - items:
> +            - type: string
> +              const: 2500base-x
> +
> +        - items:
> +            - type: string
> +              const: 5gbase-r
> +
> +        - items:
> +            - type: string
> +              const: rxaui
> +
> +        - items:
> +            - type: string
> +              const: xaui
> +
> +        # 10GBASE-KR, XFI, SFI
> +        - items:
> +            - type: string
> +              const: 10gbase-kr
> +
> +        - items:
> +            - type: string
> +              const: usxgmii
> +
> +        - items:
> +            - type: string
> +              const: 10gbase-r
> +
> +        - items:
> +            - type: string
> +              const: 25gbase-r
> -- 
> 2.40.1
> 
