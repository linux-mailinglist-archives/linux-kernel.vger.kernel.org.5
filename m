Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F37F79BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjKXQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjKXQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:59:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3A10E7;
        Fri, 24 Nov 2023 08:59:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50ba73196b1so275870e87.0;
        Fri, 24 Nov 2023 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700845167; x=1701449967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iy9DkvTUULFctuQ4J2jQdgB4mi9Zm+S/Is3pyIli3pE=;
        b=AXjy95SVx7PLOLq8FQTOjKJTCdCiIyebpw3ebpkNz6Pk/JJcC1TdwE+LcYq+b/wbr4
         kTxChwc7TRsWisEaH/gbiWBn3+nNrSZTirX2JcI9XIjNtwwBC7BcLXRP0YLbQ01zVikE
         rUK9MikK7UFWWA6mnFpK4fwkyaT4k3bGY/dCrpBRR9kOhqe1cr8WlgAMnzFdFEdMYeB+
         mb4mfOrbCBupZzhjLQ9CG0wJyU30TQa10vO0kcgI2KCA/93QzoFj+9W4PhAK4DXfghF8
         45q+3OR9+XOf7RWBrd8pSTTmM5CqNXdy35DE+zi0K1RWmQeWxqmQZ7c1DLdJM2dKtaqO
         GznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845167; x=1701449967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy9DkvTUULFctuQ4J2jQdgB4mi9Zm+S/Is3pyIli3pE=;
        b=BSfH883EGVwkjAiM0rfypUIBjM4ZFGfCekbQauU0eXcqP8SlAQWWHL0qEdimMzgZlq
         yLe3WsxApmSu96SdhuHpMFCAtSBM6osGpkjKSs9dJnNL97LY9s9zQDqEsk3uh9lzNyVK
         FWq2xl7Idb2bYSaz6pzytFTzBSKAUSyerUNxHfeKnewv85XoBS1D2L7CqMhhKEy5SHok
         XFNUbTJQ9iPGAT1erkkOPGUUjgvRdq0kkylyzMp4oprl6r6TTeUeLnBhuRO28DIeFiqh
         KBR3p9wbNOgkRV+MvPxbqDYHH5pdXtF0QnrMDPDxznWyAAHIalAlVxtRiOLSV/1n+/5n
         Rnwg==
X-Gm-Message-State: AOJu0YwruzT4Za72jEyDhfjrHgQrj7LZRBgoNZT31nmB9rSGHlh0ewF0
        T4yo3KEBf2mWNlJJx3okdd4=
X-Google-Smtp-Source: AGHT+IFTZsO8j04BNlT9aZP8j1EV20GYlvavfH+NA2vrjMwE44V/a5r9I8YYhnUfcmph4nIUYbEn1g==
X-Received: by 2002:a05:6512:ba1:b0:503:221:6b1a with SMTP id b33-20020a0565120ba100b0050302216b1amr3522725lfv.0.1700845167083;
        Fri, 24 Nov 2023 08:59:27 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id gx26-20020a170906f1da00b009ad89697c86sm2296113ejb.144.2023.11.24.08.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:59:26 -0800 (PST)
Date:   Fri, 24 Nov 2023 18:59:23 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet
 PHY package nodes
Message-ID: <20231124165923.p2iozsrnwlogjzua@skbuf>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
 <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
 <20231121144244.GA1682395-robh@kernel.org>
 <a85d6d0a-1fc9-4c8e-9f91-5054ca902cd1@lunn.ch>
 <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:32:22PM +0100, Christian Marangi wrote:
> Sooooo.... Sorry if I insist but I would really love to have something
> ""stable"" to move this further. (the changes are easy enough so it's
> really a matter of finding a good DT structure)
> 
> Maybe a good idea would be summarize the concern and see what solution
> was proposed:

Sorry, I didn't follow the entire discussion. I hope I'm not too far off
with my understanding of your problems.

I think you are hitting some of the same points I have hit with DSA.
The PHY package could be considered an SoC with lots of peripherals on
it, for which you'd want separate drivers. Just like a DSA switch would.
I don't think it's exactly phylib's place to deal with that, just like
it's not DSA's place to deal with complex SoCs, just with the switching
IP (like the Ethernet PHY IP for phylib).
https://lore.kernel.org/lkml/20221222134844.lbzyx5hz7z5n763n@skbuf/

Why does the ethernet-phy-package DT binding attempt to be so grand and
generic? I would expect the 180 degree opposite. Make it have a _single_
compatible of "qcom,qca807x" (but don't use an "x" wildcard, do specify
the full package name).

Make it have a "reg" property which is the base MDIO address of the package.

Write an mdio_device driver that probes on that. The PHY core already
knows that if a child on the MDIO bus has a compatible string of the
normal form (not like "ethernet-phy-id004d.d0b2"), then it's looking at
an mdio_device.

Make the OF node of the package have an "mdio" child with its own
compatible string, which represents the place where PHYs are. The driver
for the "mdio" child has a very simple implementation of the mii_bus
ops, which just calls into the device parent (it can assume a certain
parent implementation and private data structures).

Lateral to the "mdio" child node of the "qcom,qca807x" package node, you
could put any other device tree properties that you want.

Make the mdio_device driver for "qcom,qca807x" use shared code if you
want - but keep the device tree structure hardware-specific. Look at the
compatible strings that e.g. the drivers/mfd/simple-mfd-i2c.c driver
probes on. You could always change the driver implementation for a
certain compatible string, but you'll be stuck with the ultra-generic
compatible = "ethernet-phy-package", which has the problems that you
mention.

> 
> Concern list:
> 1. ethernet-phy-package MUST be placed in mdio node (not in ethernet,
>    the example was wrong anyway) and MUST have an addr
> 
>    Current example doesn't have an addr. I would prefer this way but
>    no problem in changing this.
> 
>    Solution:
>      - Add reg to the ethernet-phy-package node with the base address of
>        the PHY package (base address = the first PHY address of the
>        package)

Correct, what I'm saying is compatible with this.

> 
>        We will have a PHY node with the same address of the PHY package
>        node. Each PHY node in the PHY package node will have reg set to
>        the REAL address in the mdio bus.

If the real PHY IPs are children of the package rather than on the same
level with it, I don't think this will be a problem. I wonder if some
address translation could be done with the "ranges" device tree property.
I've never seen this with MDIO though.

> 4. Not finding a correct place to put PHY package info.
> 
>    I'm still convinced the mdio node is the correct place.
>    - PHY package are PHY in bundle so they are actual PHY
>    - We already have in the mdio node special handling (every DSA switch
>      use custom compatible and PHY ID is not used to probe them
>      normally)
>    - Node this way won't be treated as PHY as they won't match the PHY
>      node name pattern and also won't have the compatible pattern for
>      PHY.
> 
>    Solution:
>     - ethernet-phy-package node is OK given a reg is defined.

I agree that it should sit under the MDIO node. I disagree with the idea
of a standardized binding for PHY packages.
